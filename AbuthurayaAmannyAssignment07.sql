--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #7              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field.
--You are required to use OUTER JOINSs to solve each problem. Even if you know another method that will produce 
--the result, this module is practice in OUTER JOINs.

-- Submit your .sql file named with your last name, first name and assignment # (i.e. CharleneChengAssignment8.sql). 
-- Submit your file to the instructor using through the course site. 

-- Ideas for consideration: Run the statement in stages: Write the SELECT and FROM clauses first and run the 
-- statement. Add the ORDER BY clause. Then add the WHERE clause; if it is a compound WHERE clause, add piece 
-- at a time. Remember that the order in which the joins are processed does make a difference with OUTER JOINs.
-- You will NOT use Cross-Joins, Full Outer Joins, or Unions in the required exercises. All are to be 
-- accomplished with outer joins or a combination of outer and inner joins using standard ANSI join syntax.

-- In OUTER JOINS, when checking for NULL values in the WHERE clause, use the joining field of the table where you
-- expect to see the NULLs. The joining field is what you used in the ON clause. 
-- For example:

--		LEFT OUTER JOIN [dbo].[DimOrganization] AS ORG
--		ON ORG.CurrencyKey = CURR.CurrencyKey
--	WHERE ORG.CurrencyKey IS NULL 
--
-- When there are multiple versions of a field, such as EnglishCountryRegionName, SpanishCountryRegionName, 
-- FrenchCountryRegionName, use the English version of the field. When asked to show 'only once', 'unique', 
-- or 'one time only', use the DISTINCT keyword. Recall that it is the row that is unique in the result set.  

-- If no sort order is specified, assume it is in ascending order. 
-------------------------------------------------------------------------------------------------------------------
-- Answer Summary:
-- Question 		Points 			YOUR ANSWER
-- 	1. 				4			Australian Dollar
-- 	2. 				4			Azerbaijanian Manat
-- 	3. 				4			Sponsorship
-- 	4. 				4			SO57424
-- 	5. 				4			Edmonton
-- 	6. 				4			Goulburn
-- 	7. 				4			LL Road Frame Sale
-- 	8. 				4			Mountain Tire Sale
-- 	9a. 			4			Central Discount Store
-- 	9b.  			2			Central Discount Store
-- 	9c. 			5			Null
--  10.				4			Half-Price Pedal Sale
--  11a.			4			Mountain-300 Black, 38
--  11b.			2			95.40
--  12				2			Cone-Shaped Race


USE AdventureWorksDW2014; 

--1.	List the name of all currencies and the name of each organization that uses that currency. 
--		You will use an Outer Join to list the name of each currency in the Currency table regardless if 
--		it has a matching value in the Organization table. You will see NULL in many rows. Sort ascending on currency name. 
--      Hint: Use DimCurrency and DimOrganization. 
--      4 points
--      I got 115 rows
--		QUESTION:		What is the currency name in row 6?
--		YOUR ANSWER==>	Australian Dollar

select dc.CurrencyName, do.OrganizationName
from DimCurrency as dc
left outer join DimOrganization as do on do.CurrencyKey=dc.CurrencyKey
order by dc.CurrencyName asc






--2.	List the name of all currencies that are NOT used by any organization. In this situation 
--		we are using the statement from 1.a. and making a few modifications. We want to find the 
--		currencies that do not have a match in the common field in the Organization table. We do 
--		that by filtering for NULL in the matching field. Sort ascending on currency name. 
--      4 points
--		QUESTION:		What is the currency name in row 6?
--		YOUR ANSWER==>	Azerbaijanian Manat

select dc.CurrencyName, do.OrganizationName
from DimCurrency as dc
left outer join DimOrganization as do on do.CurrencyKey=dc.CurrencyKey
where do.OrganizationName is null
order by dc.CurrencyName asc




--3.	List the name of all Sales Reasons that have not been associated with a sale. Sort ascending on sales reason name. 
--		Hint:  Use DimSalesReason and FactInternetSalesReason.
--      4 points
--      I got 3 rows.
--		QUESTION:		What is the sales reason name in row 3?
--		YOUR ANSWER==>	Sponsorship
select sr.SalesReasonName
from dimsalesreason as sr
left join FactInternetSalesReason as fisr on sr.SalesReasonKey= fisr.SalesReasonKey
where fisr.SalesReasonKey is null
order by sr.SalesReasonName asc






--4.	List all internet sales that do not have a sales reason associated. List SalesOrderNumber, SalesOrderLineNumber 
--		and the order date. Do not show the time with the order date. Sort by sales order number ascending 
--      and sales order line number ascending. 
--		Now we are looking at which sales do not have a reason associated with the sale. Since we are looking at the sales, 
--		we don't need the reason name and the corresponding link to that table. 
--		Hint: Use FactInternetSales and FactInternetSalesReason. 
--      4 points
--      I got 6429 rows.
--		QUESTION:		What is the sales order number in row 3?
--		YOUR ANSWER==>	SO57424

select fis.SalesOrderNumber, fis.SalesOrderLineNumber, CAST(orderdate as date)as orderdate
from FactInternetSales as fis
left join FactInternetSalesReason as fisr on fisr.SalesOrderNumber=fis.SalesOrderNumber
where fisr.SalesReasonKey is null
order by fisr.SalesOrderLineNumber asc, fisr.SalesOrderNumber asc






/* AdventureWorks is looking to expand its market share. AdventureWorks has a list of target locations stored 
in the Geography table. In the next set of questions you want to find locations in which there are no Internet 
customers (individuals) and no business customers (resellers).  */

--5.	Find any locations in which AdventureWorks has no internet customers. List the English country/region 
--		name, state/province, city, and postal code. List each location only one time. Sort by country, state, 
--		and city.
--      4 points
--      I got 319 rows.
--		QUESTION:		What is the city in row 2?
--		YOUR ANSWER==>	Edmonton
select distinct g.EnglishCountryRegionName,g.StateProvinceName, g.City,g.PostalCode
from dimgeography as g
left join DimCustomer as c on c.GeographyKey=g.GeographyKey
where c.CustomerKey is null
order by g.EnglishCountryRegionName asc, g.StateProvinceName asc, g.City asc





--6. 	Find any locations in which AdventureWorks has no resellers. List the English country/region 
--		name, state/province, city, and postal code. List each location only one time. Sort by country, 
--		state, and city.
--      4 points
--      I got 145 rows.
--		QUESTION:		What is the city in row 2?
--		YOUR ANSWER==>	Goulburn

select distinct g.EnglishCountryRegionName,g.StateProvinceName, g.City,g.PostalCode
from dimgeography as g
left join DimReseller as c on c.GeographyKey=g.GeographyKey
where c.ResellerKey is null
order by g.EnglishCountryRegionName asc, g.StateProvinceName asc, g.City asc






--7.	List all promotions that have not been associated with a reseller sale. Show only the English 
--		promotion name in alphabetical order. 
--		Hint: Recall that details about sales to resellers are recorded in the FactResellerSales table.
--      4 points
--      I got 4 rows.
--		QUESTION:		What is the promotion in row 2?
--		YOUR ANSWER==>	LL Road Frame Sale
select p.EnglishPromotionName
from DimPromotion as p
left join FactResellerSales as s on p.PromotionKey=s.PromotionKey
where s.PromotionKey is null
order by p.EnglishPromotionName asc






--8.	List all promotions that have not been associated with an Internet sale. Show only the 
--		English promotion name in alphabetical order. 
--		Hint: Recall that details about sales to customers are recorded in the FactInternetSales table.
--      4 points
--      I got 12 rows.
--		QUESTION:		What is the promotion in row 3?
--		YOUR ANSWER==>	Mountain Tire Sale
select p.EnglishPromotionName
from DimPromotion as p
left join FactInternetSales as s on p.PromotionKey=s.PromotionKey
where s.SalesOrderNumber is null
order by p.EnglishPromotionName asc





--		Read 9.a. and 9.b. before beginning the syntax. There are several ways to write this statement. 
--		One method is to refer to the Outer Joins Demo and look at the example where a query is used in place 
--		of table for one possible method of answering these two questions. Another way is to write a series of 
--		outer!!! joins. You will need three tables to create the lists requested. 

--9.a.	Find all promotions and any related sales to resellers. List unique instances of the 
--		English promotion name, reseller name, and the order date.
--		Sort by the promotion name and reseller name in alphabetical order. 
--      Be sure to list all promotions even if there is no related sale.
--      4 points
--      I got 5174 rows.
--		QUESTION:		What is the reseller name in row 4?
--		YOUR ANSWER==>	Central Discount Store

select distinct dp.EnglishPromotionName, dr.ResellerName,frs.OrderDate
from DimPromotion as dp
left join FactResellerSales as frs on dp.PromotionKey = frs.PromotionKey
left join DimReseller as dr on dr.ResellerKey= frs.ResellerKey
order by dp.EnglishPromotionName asc, dr.ResellerName asc




--9.b.	Copy, paste, and modify 9.a. "No Discount" is not a promotion, so eliminate those sales 
--		without a promotion from your results set. Show the OrderDate as mm/dd/yyyy (CONVERT(nvarchar,OrderDate,101)). 
--		Look for ways to double-check your results.
--      2 points
--      I got 1408 rows.
--		QUESTION:		What is the reseller name in row 4?
--		YOUR ANSWER==>	Central Discount Store

select distinct dp.EnglishPromotionName, dr.ResellerName, convert (nvarchar, frs.OrderDate, 101) as orderdate
from DimPromotion as dp
left join FactResellerSales as frs on dp.PromotionKey = frs.PromotionKey
left join DimReseller as dr on dr.ResellerKey= frs.ResellerKey
where dp.EnglishPromotionName != 'No Discount'
order by dp.EnglishPromotionName asc, dr.ResellerName asc






--9.c.	(Bonus +5) In 9b. You used CONVERT(nvarchar,OrderDate,101) to change a date field to mm/dd/yyyy.
--		Find the CONVERT style code for a date format of mm-dd-yy. Search the web for the syntax.
--      Copy and paste your 9b answer and change the style code.
--      Bonus 5 points
--      I got 1404 rows.
--		QUESTION:		What is the date in row 1?
--		YOUR ANSWER==>	Null

select distinct dp.EnglishPromotionName, dr.ResellerName, convert (nvarchar, frs.OrderDate, 10) as orderdate
from DimPromotion as dp
left join FactResellerSales as frs on dp.PromotionKey = frs.PromotionKey
left join DimReseller as dr on dr.ResellerKey= frs.ResellerKey
where dp.EnglishPromotionName != 'No Discount'
order by dp.EnglishPromotionName asc, dr.ResellerName asc






--10.	Find all promotions and any related customer sales over the Internet. List unique instances 
--		of the English promotion name, customer first name, customer last name, and the order date. Eliminate 
--		sales that show No Discount. Sort by the promotion name. Be sure to list all promotions even if there 
--		is no related sale. Show the OrderDate as mm/dd/yyyy. You just did this in 9b. Now you are investigating 
--		Internet customers. Use similar syntax and different tables. 
--      4 points
--      I got 2120 rows.
--		QUESTION:		What is the promotion name in row 1?
--		YOUR ANSWER==>	Half-Price Pedal Sale

select Distinct p.EnglishPromotionName,c.FirstName,c.LastName, CONVERT(varchar, OrderDate, 101) as orderdate
from DimPromotion as p
left join FactInternetSales as fis on p.PromotionKey=fis.PromotionKey
left join DimCustomer as c on c.CustomerKey=fis.CustomerKey
where p.EnglishPromotionName != 'No Discount'
order by p.EnglishPromotionName asc






/* AdventureWorks wants to know if there are any particular bikes that are not selling. It is important that we 
look at both types of buyers (individual and reseller) to see if there are bikes that should be promoted or 
discontinued. We will look at each type separately. You will need four tables to create the lists requested. */

--11.a.	List the product category name, product subcategory name, class, product name, and list price for all bikes that have NOT 
--		been purchased by individual customers over the Internet. Sort by category name, subcategory name and product name. 
--      4 points
--      I got 9 rows.
--		QUESTION:		What is the product name in row 1?
--		YOUR ANSWER==>	Mountain-300 Black, 38
select c.EnglishProductCategoryName, sc.EnglishProductSubcategoryName, p.Class, p.EnglishProductName, p.ListPrice
from DimProduct as p
left join DimProductSubcategory as sc on sc.ProductSubcategoryKey=p.ProductSubcategoryKey
left join DimProductCategory as c on c.ProductCategoryKey=sc.ProductCategoryKey
left join FactInternetSales as fis on fis.ProductKey=p.ProductKey
where c.EnglishProductCategoryName= 'Bikes' and fis.SalesOrderNumber is null
order by c.EnglishProductCategoryName asc, sc.EnglishProductSubcategoryName asc, p.EnglishProductName asc






--11.b.	List the product category name,product subcategory name, class, product name, 
--		and dealer price (!!!different from last question)
--		for all Accessories (!!!different from last question) that have not been purchased by resellers. 
--		Sort by category name, subcategory name and product name. 
--      2 points
--      I got 19 rows.
--		QUESTION:		What is the dealer price in row 1?
--		YOUR ANSWER==>	95.40
select pc.EnglishProductCategoryName,  psc.EnglishProductSubcategoryName, p.class, p.EnglishProductName, p.DealerPrice
from DimProduct as p
left join DimProductSubcategory as psc on psc.ProductSubcategoryKey=p.ProductSubcategoryKey
left join DimProductCategory as pc on pc.ProductCategoryKey= psc.ProductCategoryKey
left join FactResellerSales as frs on p.ProductKey=frs.ProductKey
where pc.EnglishProductCategoryName= 'Accessories' and frs.SalesOrderNumber is null
order by pc.EnglishProductCategoryName asc, psc.EnglishProductSubcategoryName asc, p.EnglishProductName asc





--12.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an outer join.
--		Then write the SQL query that will provide the information that you are seeking.
--      2 points
-- list all products that weren't brought through reseller sales. order alphabetically.
-- what's the product that wasn't sold in row 10? 
-- my answer=> Cone-Shaped Race

select p.EnglishProductName
from DimProduct as p
left join FactResellerSales as frs on p.ProductKey=frs.ProductKey
where frs.ProductKey is null
order by p.EnglishProductName asc


