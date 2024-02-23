--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #9              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field.
-- Submit your .sql file named with your last name, first name and assignment # (e.g., CharleneChengAssignment9.sql). 
-- Submit your file to the instructor using through the course site.  
--
-- GUIDELINES:
-- 1. Even though a question might not ask for it, add meaningful sorts and column names.
-- 2. Unless specified that it is okay, don't hardcode values - use subqueries instead.
--    Here's an example of hardcoding:
--    List all product that have a list price less than the average list price of all products.
--    You could run this a query to find out that the averate list price is 747.6617
/*
      SELECT AVG(ListPrice) AS ListPrice
      FROM DimProduct;
*/
--    If you then plug 747.6617 into your next query, you have hardcoded. If you add more products, 
--    you will have to change your query.
/*
      SELECT *
      FROM DimProduct
      WHERE ListPrice < 747.6617;
*/
--    Instead, you should use a subquery:
/*
SELECT *
FROM DimProduct
WHERE ListPrice < 
(SELECT AVG(ListPrice)
FROM DimProduct);
*/
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--
--REFRESHER and WARM-UP
--SUMMARY        Question 			Points
--1a				1
--1b				1
--1c				1
--1d                1
--1e                1
--1f                3
--2a		        1
--2b                3
--2c                4
--3a                4
--3b                5
--4a                2
--4b                5
--5a                2
--5b                5
--6a                1
--6b                4
--6c                6

--------------------------------------------------------------------------------------------------------------------
USE AdventureWorksDW2014;

--------------------------------------------------------------------------------------------------------------------
-- 1a . Explore the Product table. 
--      1 point
--		QUESTION:		How many rows are in the table?
--		YOUR ANSWER==>	606 rows
--
select *
from DimProduct

--------------------------------------------------------------------------------------------------------------------
-- 1b.  Use an alternate way determine how many rows there are in the DimProduct table. Hint: Use an aggregate function (page 381).
--      1 point
--		QUESTION:		How many rows are in the table?
--		YOUR ANSWER==>	606
select COUNT(*) 
from DimProduct


--------------------------------------------------------------------------------------------------------------------
-- 1c.  List the product name and product key for all the products with keys of 1,2,3,4,5 or 6. You can hardcode these.
--      Sort by ProductKey in ascending order.
--      1 point
--      QUESTION:			What is the EnglishProductName in the record 6?
--      YOUR ANSWER HERE==>	LL Crankarm
--
select EnglishProductName, ProductKey
from DimProduct
where ProductKey<=6
order by ProductKey asc



--------------------------------------------------------------------------------------------------------------------
-- 1d.  List the product name and product key for all the products with keys that are not 1,2,3,4,5, or 6. You can hardcode these.
--      Sort by ProductKey in ascending order.
--      1 point
--      I got 600 rows.
--      QUESTION:			What is the EnglishProductName in the record 4?
--      YOUR ANSWER HERE==>	Chainring Nut
--
select EnglishProductName, ProductKey
from DimProduct
where ProductKey>6
order by ProductKey asc



--------------------------------------------------------------------------------------------------------------------
-- 1e.  List the productkey, product name and prodsubcategory key for all the products with subcategory keys.
--      Sort by ProductKey in ascending order.
--      1 point
--      I got 397 rows.
--      QUESTION:			What is the EnglishProductName in the record 1?
--      YOUR ANSWER HERE==>	HL Road Frame - Black, 58
select ProductKey, EnglishProductName,  ProductSubcategoryKey
from DimProduct
where ProductSubcategoryKey is not null
order by ProductKey asc





---------------------------------------------------------------------------------------------------------------------
-- 1f.  List the sales order number, sales order line number, product name, sales amount and order date 
--      for products sold over the internet during 2013. Format the date field so that only the date is displayed.
--		Remember INNER JOINs? Sort by EnglishProductName in ascending order. 
--      3 points
--      I got 52801 rows.
--      QUESTION:			What is the EnglishProductName and date in the last record?
--      YOUR ANSWER HERE==>	 name: Women's Mountain Shorts, S 
-- date: 2013-03-30
select fis.SalesOrderNumber, fis.SalesOrderLineNumber, p.EnglishProductName, fis.SalesAmount, CONVERT(date,fis.OrderDate) AS OrderDate
from
FactInternetSales as fis
inner join DimProduct as p on fis.ProductKey = p.ProductKey
where fis.OrderDate >='2013-1-1' and fis.OrderDate<='2013-12-31'
order by p.EnglishProductName asc	





--------------------------------------------------------------------------------------------------------------------
--
--MODULE 09 MATERIAL
--
--------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------
-- 2.a.	List the distinct ProductKey for products sold over the internet. Sort by ProductKey ascending.
--      1 point
--      I got 158 rows.
--      QUESTION:			What is the ProductKey in the record 2?
--      YOUR ANSWER HERE==>	217
select distinct ProductKey
from FactInternetSales
order by ProductKey asc




---------------------------------------------------------------------------------------------------------------------
-- 2.b.	Using an Outer Join find Products that have NOT been sold over the intenet. Show Product Key and 
--		the English Product Name. Sort by product key in DESCENDING order.
--      3 points
--      I got 448 rows.
--      QUESTION:			What is the EnglishProductName in the record 4?
--      YOUR ANSWER HERE==>	Chain
select dimproduct.ProductKey, EnglishProductName
from DimProduct
left join FactInternetSales as fis on fis.ProductKey=DimProduct.ProductKey
where fis.TotalProductCost is null
order by dimproduct.ProductKey desc





---------------------------------------------------------------------------------------------------------------------
-- 2.c. Rewrite the Outer Join from 2b replacing the join with a subquery.
--      4 points
--      I got 448 rows. Duh!
--      QUESTION:			What is the EnglishProductName in the record 5?
--      YOUR ANSWER HERE==>	HL Crankse t
select dimproduct.ProductKey, EnglishProductName
from DimProduct
where dimproduct.productkey not in ( select productkey from FactInternetSales as fis where fis.TotalProductCost is not null)
order by dimproduct.ProductKey desc





---------------------------------------------------------------------------------------------------------------------
--
-- The next sets of problems are all very similar. First you will write a simple query to return one value, 
-- usually an average. Then you will use that statement as a subquery in the WHERE clause in the next step. 
-- The two steps are to remind you to create the statement in steps and check your work before going on to the next 
-- step in the query. Also, you will be using the query you write in the first statement as your subquery. 
--
---------------------------------------------------------------------------------------------------------------------
-- 3.a.	List the average listprice of clothing items for sale by AdventureWorks. No sort needed. 
--		Remember to provide a column alias. 
--      Hints: Use the AVG function. To determine if a product is clothing, you have to link Product Subcategory,
--             Product Category, and Product tables.
--      4 points
--      QUESTION:			What is the average list price for clothing items?
--      YOUR ANSWER HERE==>	47.0243
select AVG(p.ListPrice) as avgprice
from DimProduct as p
inner join DimProductSubcategory as psc on psc.ProductSubcategoryKey=p.ProductSubcategoryKey
inner join DimProductCategory as pc on pc.ProductCategoryKey=psc.ProductCategoryKey
 where pc.EnglishProductCategoryName='Clothing'





		

---------------------------------------------------------------------------------------------------------------------
-- 3.b.	List all products in the Clothing category that have a listprice lower than the average 
--		listprice of Clothing items. Show product product name, and listprice in the 
--		results set. Be sure to use a subquery; do not enter the actual value from 3.a. into the statement.
--      Sort by list price in DESCENDING order.
--      5 points
--      I got 16 rows.
--      QUESTION:			What is the list price in record 4?
--      YOUR ANSWER HERE==>	24.49
select p.EnglishProductName as ProductName, p.ListPrice
from DimProduct as p
inner join DimProductSubcategory as psc on psc.ProductSubcategoryKey=p.ProductSubcategoryKey
inner join DimProductCategory as pc on pc.ProductCategoryKey=psc.ProductCategoryKey
where pc.EnglishProductCategoryName = 'Clothing' AND p.ListPrice < (select AVG(p.ListPrice) from DimProduct as p 
                                             inner join DimProductSubcategory as psc on psc.ProductSubcategoryKey=p.ProductSubcategoryKey
											inner join DimProductCategory as pc on pc.ProductCategoryKey=psc.ProductCategoryKey
                                             where pc.EnglishProductCategoryName = 'Clothing')
order by p.ListPrice Desc




		
---------------------------------------------------------------------------------------------------------------------
-- 4.a.	Find the average yearly income of all houseowners in the customer table. 
--      2 points
--      QUESTION:			What is the average yearly income for all homeowners in the customer table?
--      YOUR ANSWER HERE==>	58326.6677
select AVG(YearlyIncome) as AvgIncome 
from DimCustomer
where HouseOwnerFlag = 1






---------------------------------------------------------------------------------------------------------------------
-- 4.b.	Find houseowners in the customers table with an income less than or the same as the 
--		average income of houseowner customers. Concatenate to show last name, a comma and space, and 
--		first name in one column and yearly income in another column. There will be two columns in the 
--		Results set. Be sure to use a subquery; do not enter the actual value from 4.a. into the statement.
--      Sort by yearly income DESCENDING.
--      5 points
--      I got 5513 rows.
--      QUESTION:			What is the yearly income for in the last row?
--      YOUR ANSWER HERE==>	10000.00
select LastName + ', ' + FirstName as CustomerName, YearlyIncome
from DimCustomer
where HouseOwnerFlag = 1 AND YearlyIncome <= (select AVG(YearlyIncome) as AvgIncome from DimCustomer where HouseOwnerFlag = 1)
order by YearlyIncome desc








---------------------------------------------------------------------------------------------------------------------
-- 5.a.	List the product name and list price for the bike named Road-450 Red, 60
--      2 points
--      QUESTION:			What is the list price for the bike named Road-450 Red, 60?
--      YOUR ANSWER HERE==>	1457.99
select EnglishProductName, ListPrice
from DimProduct
where EnglishProductName = 'Road-450 Red, 60'




---------------------------------------------------------------------------------------------------------------------
-- 5.b.	List the product name and price for each BIKE that has a price less than or equal to
--		that of the Road-450 Red, 60. Be sure you are using the subquery not an actual value.
--      Sort by list price in DESCENDING order.
--      5 points
--      I got 75 rows
--      QUESTION:			What is the list price in record 6?
--      YOUR ANSWER HERE==>	1214.85
select p.EnglishProductName, p.ListPrice
from DimProduct as p
inner join DimProductSubcategory as psc on psc.ProductSubcategoryKey=p.ProductSubcategoryKey
inner join DimProductCategory as pc on pc.ProductCategoryKey=psc.ProductCategoryKey
where pc.EnglishProductCategoryName='bikes'
and ListPrice <= (select ListPrice from DimProduct where ProductKey = 318)
order by ListPrice desc;



---------------------------------------------------------------------------------------------------------------------
-- 6.a. Show all data from the Survey Response fact table. Use select all. No special predicate requested.
--      1 point
--      QUESTION:			How many records are in the table?
--      YOUR ANSWER HERE==>	2727 records
select *
from FactSurveyResponse




---------------------------------------------------------------------------------------------------------------------
-- 6.b.	Use a subquery and the EXISTS predicate to find customers that respond to surveys. List full 
--		name (first middle last) in one column and email address in a second column. Use the CONCAT() 
--		function or another option for the name to overcome the NULL issue. You will not see NULL in the full 
--		name field for any customer. Sort by name in ascending order.
--      4 points
--      I got 1656 rows
--      QUESTION:			What is the name in the record 4?
--      YOUR ANSWER HERE==>	Abigail M Williams
select CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS CustomerName, EmailAddress
from DimCustomer
where EXISTS (select * from FactSurveyResponse where FactSurveyResponse.CustomerKey = DimCustomer.CustomerKey)
order by CustomerName asc






---------------------------------------------------------------------------------------------------------------------
-- 6.c.	Copy/paste 6.b and use an additional subquery to narrow the results of 6.b. to only those customers 
--		with a yearly income that is greater than or the same as the average of all customers. Do not nest the new 
--		query. A nested subquery is a subquery inside a subquery. We want both subqueries in the outer query.
--      Sort by name in ascending order.
--      6 points
--      I got 883 rows
--      QUESTION:			What is the name in the record 4?
--      YOUR ANSWER HERE==>	Adam A Collins
--		
select CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS CustomerName, EmailAddress
from DimCustomer
where EXISTS (select * from FactSurveyResponse where FactSurveyResponse.CustomerKey = DimCustomer.CustomerKey) 
and YearlyIncome>=(select AVG(YearlyIncome) as AvgIncome from DimCustomer)
order by CustomerName asc
