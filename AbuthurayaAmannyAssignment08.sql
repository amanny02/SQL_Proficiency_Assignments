--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #8              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field.
-- Submit your .sql file named with your last name, first name and assignment # (e.g., CharleneChengAssignment08.sql). 
-- Submit your file to the instructor using through the course site.  
--
--------------------------------------------------------------------------------------------------------------------
--
-- GUIDELINES:
-- Unless specified that it is okay, don't hardcode values - use subqueries instead.
-- 
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--
-- Recall that sales to resellers are stored in the FactResellerSales table and sales to individual customers 
-- are stored in the FactInternetSales table. When asked to find Internet sales or sales to 'customers', you 
-- will be using the FactInternetSales table. 
--
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

USE AdventureWorksDW2014;

--------------------------------------------------------------------------------------------------------------------
-- 1.a.	Find the count of customers who are married. Be sure give each derived field an 
--		appropriate alias.
--      3 points
--		QUESTION:		How many customers are there who are married?	
--		YOUR ANSWER==>	18484 customers
select count(MaritalStatus) as married_count 
from DimCustomer




--1.b.	Check your result. Write queries to determine if the answer to 1.a. is correct. 
--		You should be doing proofs for all of your statements. This is a reminder to check our work.
--      2 points
--		QUESTION:		How did you check your answer?	
--		YOUR ANSWER==>	when the code is executed, you can see the number of total rows from martial status which is 18484 rows
select MaritalStatus
from DimCustomer




--1.c.	Find the total children (sum) and the total cars owned (sum) for customers who are 
--		married and list their education level as High School (use EnglishEducation).
--      4 points
--		QUESTION:		How many children and how many cars owned did you get?	
--		YOUR ANSWER==>	children = 3817, cars = 3509
select sum([TotalChildren]) as child_count, sum([NumberCarsOwned]) as cars_count
from DimCustomer
where MaritalStatus = 'M' and EnglishEducation = 'High School'



--1.d.	Find the total children, total cars owned, and average yearly income for:
--		customers who are married AND who list their education level as Graduate Degree.
--      2 points
--		QUESTION:		How many children, how many cars owned, and what average yearly income did you get?		
--		YOUR ANSWER==>	Children= 3987, Cars=	1435, Average Yearly Income=	65041.5368
select sum([TotalChildren]) as child_count, sum([NumberCarsOwned]) as cars_count, AVG([YearlyIncome]) as avg_income
from DimCustomer
where MaritalStatus = 'M' and EnglishEducation like  '%Graduate%'

select EnglishEducation from DimCustomer



--------------------------------------------------------------------------------------------------------------------
--2.a.	List the total dollar amount (SalesAmount) for sales to Resellers. Round to two decimal places.
--      2 points
--		QUESTION:		What is the total dollar amount for sales to Resellers?	
--		YOUR ANSWER==>	80450596.98
Select CONVERT(float,ROUND(SUM(SalesAmount),2)) as TotalAmount 
from FactResellerSales




--2.b.	List the total dollar amount (SalesAmount) for 2013 sales to resellers who have an address in 
--		the state/province of Washington in the United States. Show only the total sales--one row, one column--rounded 
--		to two decimal places. Hint: Use the FactResellerSales and DimGeography tables 
--      3 points
--		QUESTION:		What is the total dollar amount for 2013 sales to resellers who have an address in 
--						the state of Washington in the United States?	
--		YOUR ANSWER==>	2971018.60
select round(sum(FactResellerSales.SalesAmount), 2) AS TotalSales
from FactResellerSales
inner join DimReseller on FactResellerSales.ResellerKey=DimReseller.ResellerKey
inner join DimGeography on DimReseller.GeographyKey=DimGeography.GeographyKey
where DimGeography.StateProvinceName = 'Washington'
and DimGeography.EnglishCountryRegionName = 'United States'
and FactResellerSales.OrderDateKey BETWEEN '20130101' AND '20131231'





--3.a.	List the total dollar amount (SalesAmount) for sales to customers. Round to two decimal places.
--		Remember that customer sales are stored in FactInternetSales.
--      2 points
--		QUESTION:		What is the total dollar amount for sales to customers?	
--		YOUR ANSWER==>	29358677.22
select round(sum(SalesAmount),2) as TotalSales 
from FactInternetSales




--3.b.	List the total dollar amount (SalesAmount) for 2013 sales to customers located in 
--		Bayern, Germany. Show only the total sales--one row, one column--rounded to two decimal places. 
--      3 points
--		QUESTION:		What is the total dollar amount for 2013 sales to customers located in Bayern, Germany?
--		YOUR ANSWER==>	233242.35
select round(sum(SalesAmount),2) as TotalSales 
from FactInternetSales as FIS
inner join DimCustomer as DC on DC.CustomerKey=FIS.customerkey
inner join DimGeography as DG on DG.GeographyKey=DC.GeographyKey
where DG.StateProvinceName like '%Bayern%' and DG.EnglishCountryRegionName = 'Germany' and FIS.OrderDateKey BETWEEN '20130101' AND '20131231'







--4.	List the average unit price for a road bike sold to customers. Round to two 
--		decimal places.
--      4 points
--		QUESTION:		What is the average unit price for a road bike sold to customers?	
--		YOUR ANSWER==>	1799.77
select round(avg(fis.UnitPrice),2) as avgprice
from FactInternetSales as fis
inner join DimProduct as dp on fis.ProductKey = dp.ProductKey
inner join DimProductSubcategory as dps on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
where dps.EnglishProductSubcategoryName= 'Road Bikes'






--5.	List bikes that have a list price less than the average list price for all bikes. Show 
--		product alternate key, English product name, and list price. Order by list price descending
--		and English product name ascending.
--      5 points
--      I got 75 rows.
--		QUESTION:		What is the name of the bike in record 2?	
--		YOUR ANSWER==>	Road-450 Red, 48
select dp.ProductAlternateKey, dp.EnglishProductName, dp.ListPrice
from dbo.DimProduct as dp
inner join dbo.DimProductSubcategory as dpsc on dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey
inner join dbo.DimProductCategory as dpc on dpsc.ProductCategoryKey = dpc.ProductCategoryKey
where dpc.EnglishProductCategoryName = 'bikes'
and dp.ListPrice <(select avg(dp.ListPrice) from dbo.DimProduct as dp
    inner join DimProductSubcategory as dpsc on dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey
    inner join DimProductCategory as dpc on dpsc.ProductCategoryKey = dpc.ProductCategoryKey
    where dpc.EnglishProductCategoryName = 'bikes')
order by dp.ListPrice desc, dp.EnglishProductName asc






--6.	List the lowest list price, the average list price, the highest list price, and product count 
--		for mountain bikes. 
--      4 points
--		QUESTION:		What is the lowest list price, the average list price, the highest list price, and product count for mountain bikes?	
--		YOUR ANSWER==>	Lowest list pricing= 539.99, average= 1742.8745, highest=3399.99, count of mountain bikes=38
select min(dp.ListPrice) as MinListPrice, avg(dp.ListPrice) as AvgListPrice, max(dp.ListPrice) as MaxListPrice, count(*) as BikesCount
from DimProduct as dp
inner join dbo.DimProductSubcategory as dpsc on dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey
where dpsc.EnglishProductSubcategoryName = 'mountain bikes'







-- 7.	List the product alternate key, product name, and list price for the product(s) 
--		with the highest List Price. There can be multiple products with the highest list price.
--      Sort by Product Alternate Key ascending. 
--		I got 5 rows.
--      4 points
--		QUESTION:		What is the English Product Name record 1?
--		YOUR ANSWER==>	Road-150 Red, 44
select ProductAlternateKey, EnglishProductName, ListPrice
from DimProduct
where ListPrice = (select max(ListPrice) from dbo.DimProduct)
order by ProductAlternateKey







-- 8.a.	List the product alternate key, product name, list price, standard cost and the 
--		difference (calculated field) between the list price and the standard cost for all product(s). 
--		Show all money values to 2 decimal places. Sort on difference from highest to lowest
--		and product alternate key in ascending order.
--      4 points
--      I got 606 rows.
--		QUESTION:		What is the difference between the list price and the standard cost in record 5?
--		YOUR ANSWER==>	1476.90
select ProductAlternateKey, EnglishProductName, round(listprice, 2) as ListPrice, round(StandardCost, 2) as StandardCost, round(ListPrice - StandardCost, 2) as Difference
from DimProduct
order by Difference desc, ProductAlternateKey asc








-- 8.b.	As we learned in prior modules, some products are not intended to be sold and some products in the 
--		table have been updated and are no longer sold. Follow the same specifications as 8.a. for this statement. 
--		Also eliminate from your list all products that are not intended for sale (i.e. not a finished good) 
--      and those no longer for sale.
--      Explore the data -- you have enough information to answer this. If you make assumptions, state them in comments.
--      3 points
--      I got 197 rows.
--		QUESTION:		Still sorting on the difference from highest to lowest, and on product alternate key ascending,
--						what is the difference between the list price and the standard cost in record 7?	
--		YOUR ANSWER==>	902.13
select ProductAlternateKey, EnglishProductName, round(ListPrice, 2) as ListPrice, round(StandardCost, 2) as StandardCost, round(ListPrice - StandardCost, 2) as Difference
from dbo.dimproduct
where finishedgoodsflag = 1 and status = 'current'
order by Difference desc, productalternatekey asc








-- 8.c.	Use the statement from 8.b. and modify to find the currently sold product(s) with the largest 
--		difference between the list price and the standard cost of all currently sold products. Show all 
--		money values to 2 decimal places. Hint: There will be records in the results set.
--      3 points
--		QUESTION:		What is the name of the product in the 1st record of the results set?
--		YOUR ANSWER==>	Mountain-200 Silver, 38
select ProductAlternateKey, EnglishProductName, round(ListPrice, 2) as ListPrice, round(StandardCost, 2) as StandardCost, round(ListPrice - StandardCost, 2) as Difference
from DimProduct
where FinishedGoodsFlag = 1 and Status = 'Current'
and round(ListPrice - StandardCost, 2) >= (select max(round(ListPrice - StandardCost, 2)) from DimProduct where FinishedGoodsFlag = 1 and Status = 'Current')







--9.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an aggregate function. Be sure to write your question as a comment. 
--		Then write the complete SQL query that will provide the information that you are seeking.
--      2 points
--		QUESTION:		to code: what's the total revenue from mountain bikes sold in washington during 2013
-- I got 20 rows
--Question: what's the total revenue in record 10?
--		YOUR ANSWER==>	6925.41
select dpsc.EnglishProductSubcategoryName AS ProductSubcategory,
    dp.EnglishProductName AS ProductName,
    dg.StateProvinceName as State,
    SUM( fis.SalesAmount) AS TotalRevenue
from FactInternetSales fis
inner join DimProduct dp ON fis.ProductKey = dp.ProductKey
inner join DimProductSubcategory dpsc ON dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey
inner join DimProductCategory dpc ON dpsc.ProductCategoryKey = dpc.ProductCategoryKey
inner join DimCustomer as dc on dc.CustomerKey=fis.CustomerKey
inner join DimGeography as dg on dg.GeographyKey=dc.GeographyKey
where dpsc.EnglishProductSubcategoryName = 'Mountain Bikes'
and dg.StateProvinceName = 'Washington'
and YEAR(fis.OrderDate) = 2013
group by dpc.EnglishProductCategoryName , dpsc.EnglishProductSubcategoryName, dp.EnglishProductName, dg.StateProvinceName
