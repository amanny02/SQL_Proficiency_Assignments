--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #10                 DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field.
-- Submit your .sql file named with your last name, first name and assignment # (e.g. CharleneChengAssignment10.sql). 
-- Submit your file to the instructor using through the course site.  
-- Summary Area
-- Question 			Points 				Answer
-- 1a					2				0
-- 1b					4				114
-- 1c  					4				Surprise
-- 2a					2				zero
-- 2b					2				Guardian Bank
-- 2c					2				25
-- 2d					2				Value Added Reseller
-- 2e					4				62815.126
-- 3a					3				Bike Universe
-- 3b					4				Excellent Riding Supplies
-- 3c					3				465.90
-- 3d					5				Twin Cycles
-- 4a					2				5064
-- 4b					3				66095.95
-- 5					6			Amanda  Sanders
-- 6					2

USE AdventureWorksDW2014;


--------------------------------------------------------------------------------------------------------------------
-- AdventureWorks wants to improve its marketing strategies. Management is interested in learning more about the 
-- company's reseller base. Management wants to know such things as where resellers are located, which banks 
-- resellers use, how often resellers order, and about the ordering patterns. */
--------------------------------------------------------------------------------------------------------------------


-- 1.	AdventureWorks management wants geographic information about their resellers. 
--		Be sure to add a meaningful sort as appropriate and give each derived column an alias.

-- 1.a.	First check to determine if there are resellers without geography info.
--      2 points
--		QUESTION:	How many resellers are there with no geography info?	
--		YOUR ANSWER: 0
SELECT ResellerName
FROM DimReseller
WHERE GeographyKey is null;





-- 1b.	Display a count of resellers in each country.
--		Show country name and the count of resellers. Sort by country name in ascending order.
--      4 points
--		I got 6 rows
--		QUESTION:	How many resellers are there in record 2?	
--		YOUR ANSWER==>	114
select CountryRegionCode, COUNT(*) AS 'Resellers Count'
from DimReseller as dr
inner join DimGeography as dg on dr.GeographyKey = dg.GeographyKey
group by [CountryRegionCode]
order by[CountryRegionCode] asc




-- 1c.	Display a count of resellers in each City. 
--		Show count of resellers, City name, State name, and Country name. Sort by EnglishCountryRegionaName DESC, StateProvince ASC, and City ASC.
--      4 points
--		I got 468 rows
--		QUESTION:	What is the city name in record 11?	
--		YOUR ANSWER==>	Surprise

select COUNT(*) as 'Resellers Count',City, StateProvinceName, StateProvinceName
from DimReseller as r
inner join DimGeography as g on r.GeographyKey = g.GeographyKey
group by g.EnglishCountryRegionName, g.StateProvinceName, g.City
order by g.EnglishCountryRegionName desc, g.StateProvinceName asc, g.City asc





-- 2a. 	Check to see if there are any resellers without a value in the bank name field. 
--      2 points
--		QUESTION:	How many resellers are without a value in the bank name field?
--		YOUR ANSWER==> 0
select ResellerName
from DimReseller
where BankName is NULL;




-- 2b.	List the name of each bank and the number of resellers using that bank.
--		Sort by bank name in ascending order. 
--      2 points
--      I got 7 rows
--		QUESTION:	How many resellers use the bank identified in record 1?	
--		YOUR ANSWER==> Guardian Bank
select BankName, COUNT(*) AS 'Resellers Count'
from DimReseller
group by BankName
order by BankName asc





--2c.	List the year opened and the number of resellers opening in that year. 
--      2 points
--      I got 32 rows
--		QUESTION:	How many resellers opened in 1978?
--		YOUR ANSWER==> 25
select YearOpened, COUNT(*) AS 'Resellers Count'
from DimReseller
group by YearOpened







-- 2d.	List the average number of employees in each of the three business types. Sort by business type in ascending order.
--      2 points
--      I got 3 rows
--		QUESTION:	What is the Business Type in record 2?
--		YOUR ANSWER==> Value Added Reseller
select BusinessType, AVG(NumberEmployees) AS 'Average Employees'
from DimReseller
group by BusinessType
order by BusinessType asc






-- 2e.	List business type, the count of resellers in that type, and average of Annual Revenue 
--		in that business type. Sort by business type in ascending order.
--      4 points
--      I got 3 rows
--		QUESTION:	What is the average average annual revenue in record 2?
--		YOUR ANSWER==> 62815.126
select BusinessType,COUNT(BusinessType) AS 'Resellers Count', AVG(AnnualRevenue) AS 'Average Annual Revenue'
from DimReseller
group by BusinessType
order by BusinessType asc





-- 3.	AdventureWorks wants information about sales to its resellers. Remember that Annual Revenue 
--		is a measure of the size of the business and is NOT the total of the AdventureWorks 
--		products sold to the reseller. Be sure to use SalesAmount when total sales are 
--		requested.

-- 3a. 	List the name of ANY reseller to which AdventureWorks has not sold a product. Sort by reseller name in ascending order.
--		Hint: Use a join.
--      3 points
--      I got 66 rows
--		QUESTION:	What is the name of the reseller in record 4?	
--		YOUR ANSWER==> Bike Universe
select ResellerName
from DimReseller as dr
LEFT OUTER JOIN FactResellerSales as frs on dr.[ResellerKey] = frs.[ResellerKey]
group by ResellerName
having COUNT(ProductKey) = 0
order by [ResellerName] asc




-- 3b.	List ALL resellers and total of sales amount to each reseller. Show Reseller 
--		name, business type, and total sales with the sales showing two decimal places. 
--		Be sure to include resellers for which there were no sales. Sort by the total 
--		of sales amount in DESCENDING order. NULL will appear. 
--      4 points
--      I got 701 rows
--		QUESTION:	What is the ResellerName in record 2?		
--		YOUR ANSWER==> Excellent Riding Supplies
select ResellerName, BusinessType, ROUND(SUM(SalesAmount),2) AS 'Total Sales'
from DimReseller as dr
LEFT OUTER JOIN FactResellerSales as frs on dr.ResellerKey = frs.ResellerKey
group by ResellerName, BusinessType
order by 'Total Sales' desc







-- 3c.	List resellers and total sales to each.  Show reseller name, business type, and total sales 
--		with the sales showing two decimal places. Limit the list to only those resellers to which 
--		total sales are less than $500 or more than $500,000. Sort by total sales in descending order.
--      3 points
--      I got 58 rows
--		QUESTION:	What is the dollar amount in the record 32?	
--		YOUR ANSWER==> 465.90
select ResellerName, BusinessType, ROUND(SUM(SalesAmount),2) as 'Total Sales'
from DimReseller as dr
left outer join FactResellerSales as frs on dr.ResellerKey = frs.ResellerKey
group by ResellerName, BusinessType
having SUM(SalesAmount) < 500.00 or SUM(SalesAmount) > 500000.00
order by 'Total Sales' desc






-- 3d.	List resellers and total sales to each for 2013. Show Reseller name, business type, 
--		and total sales with the sales showing two decimal places. Limit the results to resellers to 
--		which the total sales are between $5,000 and $7,500 or between $40,000 and $75,000.
--		Sort by total sales in descending order.
--      5 points
--      I got 48 rows
--		QUESTION:	What is the name of the reseller in record 17?
--		YOUR ANSWER==> Twin Cycles
select ResellerName, BusinessType, ROUND(SUM(SalesAmount),2) AS 'Total Sales'
from DimReseller as dr
left outer join FactResellerSales as frs on dr.ResellerKey = frs.ResellerKey
group by ResellerName, BusinessType, YEAR(OrderDate)
Having ((SUM(SalesAmount) > 5000.00 AND SUM(SalesAmount) < 7500.00) OR (SUM(SalesAmount) > 40000.00 
AND SUM(SalesAmount) < 75000.00)) AND  year (OrderDate) = 2013
order by 'Total Sales' desc





--4a.	List customer education level (use EnglishEducation) and the number of customers reporting 
--		each level of education. Sort by EnglishEducation in ascending order.
--      2 points
--      I got 5 rows
--		QUESTION:	What is the customer count in record 4?
--		YOUR ANSWER==> 5064
select EnglishEducation, COUNT(*) as 'Number of Customers'
from DimCustomer
group by EnglishEducation
order by EnglishEducation asc






-- 4b.	List customer education level (use EnglishEducation), the number of customers reporting 
--		each level of education, and the average yearly income for each level of education. 
--		Show the average income rounded to two (2) decimal places. Sort by EnglishEducation in ascending order.
--      3 points
--      I got 5 rows
--		QUESTION:	What is the average yearly income of the customers who have completed a Graduate degree?	
--		YOUR ANSWER==> 66095.95
select EnglishEducation, COUNT(*) as 'Number of Customers', ROUND(AVG(YearlyIncome),2) as 'Average Yearly Income'
from DimCustomer
group by EnglishEducation
order by EnglishEducation asc







-- 5.	List all customers and the most recent date on which they placed an order (2 fields). Show the 
--		customer's first name and middle name and last name in one column with a space between each part of the 
--		name. NULL should not appear in the FullName field. That does not mean that you should filter it 
--		out; that means that your concatenation should not result in NULL. Show the date of the most recent 
--		order as mm/dd/yyyy. It is your responsibility to make sure you do not miss any customers. Sort by 
--		order date in ascending order.
--      6 points
--      I got 18,470 rows
--		QUESTION:	What is the name in record 1?
--		YOUR ANSWER==> Amanda  Sanders
select CONCAT(FirstName,' ',MiddleName,' ', LastName) as 'Customer Name', MAX(CONVERT (varchar(10),OrderDate,101)) 'Most Recent Order Date'
from DimCustomer as dc
inner join FactInternetSales as fis on dc.CustomerKey = fis.CustomerKey
group by CONCAT(FirstName,' ',MiddleName,' ', LastName)
order by MAX(CONVERT (varchar(10),OrderDate,101)) asc







--6.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an aggregate function with the having clause. 
--		Then write the complete SQL query that will provide the information that you are seeking.
--      2 points



