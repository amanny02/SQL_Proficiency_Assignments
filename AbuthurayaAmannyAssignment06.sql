--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #6              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field.
-- You are required to use INNER JOINs to solve each problem. Even if you know another method that will produce 
-- the result, this module is practice in INNER JOINs.

-- Submit your .sql file named with your last name, first name and assignment # (i.e. ChengCharleneAssignment6.sql). 
-- Submit your file to the instructor using through the course site. 
--
-- REMINDERS: Run the statement in stages-- Write the SELECT and FROM clauses first and run 
-- the statement. Add the ORDER BY clause. Then add the WHERE clause; if it is a compound WHERE clause, 
-- add a piece at a time. Lastly perform the CAST or CONVERT. When the statement is created in steps, it 
-- is easier to isolate any errors. 

-- When there are multiple versions of a field, such as EnglishCountryRegionName, SpanishCountryRegionName, 
-- FrenchCountryRegionName, use the English version of the field. When asked to show 'only once', 'unique', 
-- or 'one time only', use the DISTINCT keyword. Recall that it is the row that is unique in the result set.  

-- 'Customers' generally refers only to individuals that purchase over the Internet and are stored in the 
-- DimCustomers table. For example, if the request is for customers in the UK city of York, be sure to include 
-- the UK portion of the filter. The city of York exists in other countries.

-- If no sort order is specified, assume it is in ascending order. 

-------------------------------------------------------------------------------------------------------------------

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--NOTE: We are now using a different database. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
USE AdventureWorksDW2014; 



--1.a.	List the names and locations of AdventureWorks customers who identify as female (Gender field). 
--		Show customer key, first name, last name, state name, and country name. Order the list 
--		by country name, state name, last name, and first name in alphabetical order. 
--      4 points
--		QUESTION:		What is the first name in record 2?
--		YOUR ANSWER==>	Kaylee
--
select distinct dc.CustomerKey, dc.FirstName, dc.LastName,DG.StateProvinceName,DG.EnglishCountryRegionName
from DimCustomer As DC
inner join FactInternetSales as IntSale on DC.CustomerKey=IntSale.CustomerKey
inner join DimGeography as DG on DG.GeographyKey=DC.GeographyKey
where dc.Gender = 'F'
order by DG.EnglishCountryRegionName asc, DG.StateProvinceName asc, DC.LastName asc, dc.FirstName asc





--1.b.	Copy/paste the statement from 1.a to 1.b. Modify the WHERE clause in 1.b to show only 
--		those AdventureWorks customers who identify as  male and from the US City of Los Angeles. 
--		Show customer key, first name, last name, and city name. 
--		Change the sort order to list by last name, then first name in alphabetical order. 
--      2 points
--      I got 47 rows
--		QUESTION:		What is the last name in record 1?
--		YOUR ANSWER==>	Bell

select DISTINCT dc.CustomerKey, dc.FirstName, dc.LastName,DG.City
from DimCustomer As DC
inner join FactInternetSales as IntSale on DC.CustomerKey=IntSale.CustomerKey
inner join DimGeography as DG on DG.GeographyKey=DC.GeographyKey
where dc.Gender = 'M' and dg.City ='Los Angeles'
order by DC.LastName asc, dc.FirstName asc







--1.c.	Copy/paste statement from 1.b to 1.c. Modify the WHERE clause in 1.c to list only 
--		AdventureWorks customers from the US city of Portland who identify as male and have 1 or more cars. 
--		Show customer key, first name, last name, and total number of cars. 
--		Order the list by number of cars in descending order, then by last name and first name 
--		in alphabetical order.
--      2 points
--      I got 32 rows
--		QUESTION:		What is the first name in record 3?
--		YOUR ANSWER==>	Ethan

select distinct dc.CustomerKey, dc.FirstName, dc.LastName,Dc.NumberCarsOwned
from DimCustomer As DC
inner join FactInternetSales as IntSale on DC.CustomerKey=IntSale.CustomerKey
inner join DimGeography as DG on DG.GeographyKey=DC.GeographyKey
where dc.Gender = 'M' and dg.City ='Portland' and dc.NumberCarsOwned >=1
order by dc.NumberCarsOwned desc, dc.LastName asc,DC.FirstName asc






--2.a.	Explore the data warehouse using only the DimProduct table. No joins are required. 
--		Show the English product name, product key, product alternate key, standard cost, list price, 
--		and status. Sort on English product name. Notice that some of the products appear to be duplicates. 
--		The name and the alternate key remain the same but the product is added again with a new product 
--		key to track the history of changes to the product attributes. For example, look at AWC Logo Cap. 
--		Notice the history of changes to StandardCost and ListPrice and to the value in the Status field. 
--      2 points
--      I got 606 rows
--		QUESTION:		What is the ProductKey for the AWC Logo Cap that is currently being sold?
--		YOUR ANSWER==>	225
select EnglishProductName, ProductKey, ProductAlternateKey, StandardCost, ListPrice, Status
from DimProduct
order by EnglishProductName asc








--2.b.  Using the DimProduct table, list the product key, English product name, and product alternate key 
--      for each product only once. Sort on English product name.  
--      1 point
--		QUESTION:		How many rows did your query return?
--		YOUR ANSWER==>	606 rows
select distinct ProductKey, EnglishProductName, ProductAlternateKey
from dimproduct
order by EnglishProductName asc








--2.c.  Using the DimProduct table, list the English product name and product alternate key for each product only once. 
--      Sort on English product name. Recall terms like “only once”, “one time”, and "unique" all indicate the need for the DISTINCT keyword. 
--      1 point
--		QUESTION:		How many rows did your query return?
--		YOUR ANSWER==>	504 rows

select distinct EnglishProductName, ProductAlternateKey
from DimProduct
order by EnglishProductName asc




--2.d.	Join tables to the product table to also show the category and subcategory name for each product. 
--		Show the English category name, English subcategory name, English product name, and product alternate key 
--		only once. Sort the results by the English category name, English subcategory name, and English product 
--		name. 
--      I got 295 rows
--      4 points
--		QUESTION:		English product name in record 3?
--		YOUR ANSWER==>	Mountain Bottle Cage

select distinct EnglishProductCategoryName,EnglishProductSubcategoryName, EnglishProductName, ProductAlternateKey
from dimproduct as DP
inner join DimProductSubcategory as DPS on dps.ProductSubcategoryKey=DP.ProductSubcategoryKey
inner join DimProductCategory as DPC on DPC.ProductCategoryKey=DPS.ProductCategoryKey
order by EnglishProductCategoryName asc, EnglishProductSubcategoryName asc, EnglishProductName asc





--3.a.	List the English name for products purchased over the Internet by customers who indicate education  
--		as bachelors or graduate degree. Show Product key and English Product Name and English Education. 
--		Order the list by English Product name. Show a product only once for each education level 
--      even if it has been purchased several times. Hint 1: SELECT DISTINCT
--      Hint 2: Use FactInternetSales, DimCustomer, DimProduct tables.
--      5 points
--      I got 313 rows
--		QUESTION:		What is the ProductKey, EnglishProductName and EnglishEducation in row 5
--		YOUR ANSWER==>	484	Bike Wash - Dissolver	Bachelors

select distinct dp.ProductKey, dp.EnglishProductName, dc.EnglishEducation
from DimCustomer as DC
inner join FactInternetSales as IntSales on dc.CustomerKey= IntSales.CustomerKey
inner join dimproduct as DP on IntSales.ProductKey=dp.ProductKey
where dc.EnglishEducation= 'Bachelors' or dc.EnglishEducation='Graduate Degree'
order by dp.EnglishProductName asc



	

	

--3.b.	List the English name for products purchased over the Internet by customers who indicate 
--		partial high school or partial college. Show Product key and English Product Name 
--		and English Education. Order the list by English Product name and then by English Education. 
--		Show a product only once for each education level even if it has been purchased several times. 
--      3 points
--      I got 311 rows
--		QUESTION:		What is the product key in row 7?
--		YOUR ANSWER==>	473

select distinct dp.ProductKey, dp.EnglishProductName, dc.EnglishEducation
from DimCustomer as DC
inner join FactInternetSales as IntSales on dc.CustomerKey= IntSales.CustomerKey
inner join dimproduct as DP on IntSales.ProductKey=dp.ProductKey
where dc.EnglishEducation= 'Partial High School' or dc.EnglishEducation='Partial College'
order by dp.EnglishProductName asc, dc.EnglishEducation asc







--4.	List the English name for products purchased over the Internet by customers who list their occupation as 
--      Manual or Skilled Manual. Show Product key and English Product Name and English Occupation. 
--		Sort by English product name and occupation in alphabetical order. 
--      Show a product only once for each occupation even if it has been purchased several times.
--      5 points
--      I got 315 rows
--		QUESTION:		What is the ProductKey, EnglishProductName and EnglishOccupation in row 13?
--		YOUR ANSWER==>	485	Fender Set - Mountain	Manual

select distinct dp.ProductKey, dp.EnglishProductName, dc.EnglishOccupation
from DimCustomer as DC
inner join FactInternetSales as IntSales on dc.CustomerKey= IntSales.CustomerKey
inner join dimproduct as DP on IntSales.ProductKey=dp.ProductKey
where dc.EnglishOccupation= 'Manual' or dc.EnglishOccupation='Skilled Manual'
order by dp.EnglishProductName asc, dc.EnglishOccupation asc





/******************************************************************************************************************
Question 5 contains exploratory questions. You may wish to read all three questions before beginning. 
Seeing the purpose of the questions may help understand the requests. 
*******************************************************************************************************************/



--5.a.	List customers who have purchased bikes over the Internet.  Show customer first name, 
--		last name, and English product category. If a customer has purchased a bike more than once, 
--		show only one row for that customer. 
--      Order the list by last name, then first name. 
--      6 points
--      I got 9109 rows
--		QUESTION:		What is first name in row 5?
--		YOUR ANSWER==>	Andrea

select distinct dc.FirstName, DC.LastName, DPC.EnglishProductCategoryName
from DimCustomer as DC
inner join FactInternetSales as IntSales on dc.CustomerKey= IntSales.CustomerKey
inner join dimproduct as DP on IntSales.ProductKey=dp.ProductKey
inner join DimProductSubcategory as DPS on dp.ProductSubcategoryKey=DPS.ProductSubcategoryKey
inner join DimProductCategory as DPC on DPC.ProductCategoryKey=DPS.ProductCategoryKey
where dps.EnglishProductSubcategoryName like '%Bikes%'
order by dc.LastName asc, dc.FirstName asc




--5.b.	Copy/paste 5.a to 5.b and modify 5.b.  Show customer key, first name, last name, and English 
--		product category. If a customer has purchased bikes more than once, show only one row for that customer. 
--		Order the list by last name, then first name. 
--      2 points
--		QUESTION:		How many rows did you get?
--		YOUR ANSWER==>	9132 rows

select distinct dc.CustomerKey, dc.FirstName, DC.LastName, DPC.EnglishProductCategoryName
from DimCustomer as DC
inner join FactInternetSales as IntSales on dc.CustomerKey= IntSales.CustomerKey
inner join dimproduct as DP on IntSales.ProductKey=dp.ProductKey
inner join DimProductSubcategory as DPS on dp.ProductSubcategoryKey=DPS.ProductSubcategoryKey
inner join DimProductCategory as DPC on DPC.ProductCategoryKey=DPS.ProductCategoryKey
where dps.EnglishProductSubcategoryName like '%Bikes%' 
order by dc.LastName asc, dc.FirstName asc










--5.c.	Be brief and specific. This is actually a simple answer. 
--      2 bonus points
--		QUESTION==>		Why is there a difference between the number of records received in 5a and 5b?
--                      Be brief and specific. This is actually a simple answer. 
--		YOUR ANSWER:	Because the new column CustomerKey has unique values that weren't present in 5a



--6.	List all Internet sales for accessories that occurred during 2013 (Order Date in 2013). 
--		Show Order date, product key, product name, and sales amount for each line item sale. 
--		Show the date as mm/dd/yyyy as DateOfOrder. Show the list in oldest to newest order by date 
--      and alphabetically by product name.
--      Hint: For the date, use the syntax similar to CONVERT(nvarchar, date, style code). 
--      Look up the appropriate style code.  
--      6 points
--      I got 34409 rows
--		QUESTION:		What is the product name in record 8?
--		YOUR ANSWER==>	HL Mountain Tire

select convert (nvarchar, IntSales.OrderDate, 101) as DateOfOrder, IntSales.ProductKey,  DP.EnglishProductName, IntSales.SalesAmount
from DimCustomer as DC
inner join FactInternetSales as IntSales on dc.CustomerKey= IntSales.CustomerKey
inner join dimproduct as DP on IntSales.ProductKey=dp.ProductKey 
inner join DimProductSubcategory as DPS on dp.ProductSubcategoryKey=DPS.ProductSubcategoryKey
inner join DimProductCategory as DPC on DPC.ProductCategoryKey=DPS.ProductCategoryKey
where IntSales.OrderDate like '%2013%' and dpc.EnglishProductCategoryName like '%accessories%'
order by IntSales.OrderDate desc, dp.EnglishProductName asc






--7.	List all Internet sales of Accessories to customers in Brisbane, Australia during 2013. 
--		Show product key, product name, order date as mm/dd/yyyy, SalesAmount, and City for each line item sale. 
--		Show the list by date in ascending order and product key in ascending order. 
--      5 points
--      I got 201 rows
--		QUESTION:		What is the product name in record 3?
--		YOUR ANSWER==>	ML Road Tire

select  IntSales.ProductKey, DP.EnglishProductName, convert (nvarchar, IntSales.OrderDate, 101) as DateOfOrder, IntSales.SalesAmount,
dg.City
from DimCustomer as DC
inner join FactInternetSales as IntSales on dc.CustomerKey= IntSales.CustomerKey
inner join dimproduct as DP on IntSales.ProductKey=dp.ProductKey 
inner join DimProductSubcategory as DPS on dp.ProductSubcategoryKey=DPS.ProductSubcategoryKey
inner join DimProductCategory as DPC on DPC.ProductCategoryKey=DPS.ProductCategoryKey
inner join DimGeography as DG on dg.GeographyKey=dc.GeographyKey
where IntSales.OrderDate like '%2013%' and dpc.EnglishProductCategoryName like '%accessories%' and dg.City ='Brisbane'
order by IntSales.OrderDate asc, IntSales.ProductKey asc







--8.	In your own words, write a business question that you can answer by querying the data warehouse. 
--		Then write the SQL query using at least one INNER JOIN that will provide the information that you are 
--		seeking. Try it. You get credit for writing a question and trying to answer it. 
--      2 points
-- List all the female customers who live in Washington state with a bachelors degree and order by first name alphabetically

select distinct dc.FirstName, dc.LastName, dc.EnglishEducation,dg.StateProvinceName
from DimCustomer as DC
inner join FactInternetSales as IntSales on dc.CustomerKey= IntSales.CustomerKey
inner join dimproduct as DP on IntSales.ProductKey=dp.ProductKey
inner join DimGeography as DG on dg.GeographyKey=dc.GeographyKey
where dc.EnglishEducation= 'Bachelors' and dc.Gender='F' and dg.StateProvinceName = 'Washington'
order by dc.FirstName asc




