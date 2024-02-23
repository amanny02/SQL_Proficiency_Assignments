/*
Assignment 5 - Joining Tables, Inner Joins

PURPOSE:

Knowledge:

    o Describe an INNER JOIN
    o Explain how an INNER JOIN is used to connect tables within a database

Skills:

    o Write SQL syntax to join two or more table

TASK:

    1. Download the following SQL file and rename it Xxxxx-SQL-Assignment-05, where Xxxxx is your last and first name. 
	For example, I would rename this file ChengCharlene-SQL-Assignment-05.sql.

		Xxxxx-SQL-Assignment-06.sql

    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    5. Return to this assignment page, attach your completed file, and submit.

 

CRITERIA:

    o Answer all the questions
    o If you do not understand a question, did you ask for help from the teacher, a classmate, the Discussion board, or a tutor?
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas
    o If you cannot complete the assignment, did you communicate with the teacher (before the due date) so that he/she/they understands your situation?

*/
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field.
--You are required to use INNER JOINs to solve each problem. Even if you know another method that will produce 
--the result, this module is practice in INNER JOINs.

-- If no sort order is specified, assume it is in ascending order. 
--
--************************************************************************************************************************
--NOTE: We are now using a different database. 


-- Answer Summary:
-- Question 	Points 			YOUR ANSWER
--  1a. 		4					jill@margiestravel.com
--  1b.			2					798
--  2a.			5					6, HL Road Frame
--  2b.			2					Road-750 Black, 52
--  2c.			2					739
--  3a.			6					All-Purpose Bike Stand
--  3b.			3					Bike Stands
--	3c.			2					No, bike is only found in the SubCategoryName field
--	4a.			5					Bike Wash - Dissolver
-- 	4b.			3					Mountain-200 Silver, 42
--  5a.			4					HL Mountain Frame - Black, 42
--  5b.			4					45783, 5
--	6.			6					45266
--	7.			2

USE AdventureWorks2014;


--1.a.	List any products that have product reviews.  Show product name, product ID, comments, 
--		email address. Sort alphabetically on the product name. Don’t over complicate this. 
--		A correctly written INNER JOIN will return only those products that have product 
--		reviews; i.e., matching values in the linking field. Hint:  Use the Production.Product 
--		and Production.ProductReview tables.
--      2 points
--      I got 4 rows.
--		QUESTION:		What is the EmailAddress in row 3?
--		YOUR ANSWER:	jill@margiestravel.com
--
select name, productreview.ProductID, Comments,EmailAddress
from [Production].[Product]
inner join [Production].[ProductReview] ON ProductReview.ProductID=Product.ProductID





--1.b.	Copy 1.a. and paste below. Modify the pasted statement to show only records in which 
--		the word 'mountain' is found in the Comments field. Show product ID, product name, and comments. 
--		Sort on ProductID. 
--      1 points
--      I got 2 rows.
--		QUESTION:		What is the product id in the row 1?
--		YOUR ANSWER:	798
--
select name, productreview.ProductID, Comments
from [Production].[Product]
inner join [Production].[ProductReview] ON ProductReview.ProductID=Product.ProductID
where Comments like '%mountain%'
order by productid asc





--2.a.	List product models with products. Show the product model ID, model name, product ID, 
--		product name, standard cost, and class. Round all money values to exactly two decimal places. 
--		Be sure to give any derived fields an alias. Sort by ProductID from lowest to highest.
--		Hint: You know you need to use the Product table. Now look for a related table that contains 
--		the information about the product model and inner join it to Product on the linking field.  
--      2 points
--      I got 295 rows.
--		QUESTION:		What is the ProductModelID and Name in row 1?
--		YOUR ANSWER:		6, HL Road Frame
--
select production.product.ProductModelID, Production.ProductModel.Name as ModelName,ProductID,Product.Name as ProductName, ROUND (StandardCost,2) as ApproxStandardCost, Class 
from [Production].Product
inner join [Production].ProductModel ON ProductModel.ProductModelID=product.ProductModelID
order by ProductID asc




--2.b.	Copy/paste 2.a. to 2.b. then modify 2.b. to list only products with a value in the  
--		class field. Do this using NULL appropriately in the WHERE clause. Hint: Remember 
--		that nothing is ever equal (or not equal) to NULL; it either IS NULL or it IS NOT NULL.
--      1 points
--      I got 229 rows.
--		QUESTION:		What is the Product Name in the last row?
--		YOUR ANSWER:	 Road-750 Black, 52

select production.product.ProductModelID, Production.ProductModel.Name as ModelName,ProductID,Product.Name as ProductName, ROUND (StandardCost,2) as ApproxStandardCost, Class 
from [Production].Product
inner join [Production].ProductModel ON ProductModel.ProductModelID=product.ProductModelID
where class is not null
order by ProductID asc






--2.c.	Copy/paste 2.b. to 2.c. then modify 2.c. to list only products that contain a value in 
--		the class field AND contain 'mountain' in the product model name. Be sure that NULL 
--		does not appear in the Class field by using parentheses appropriately. 
--      1 points
--      I got 78 rows.
--		QUESTION:		What is the ProductID in row 1?
--		YOUR ANSWER:	739

select production.product.ProductModelID, Production.ProductModel.Name as ModelName,ProductID,Product.Name as ProductName, ROUND (StandardCost,2) as ApproxStandardCost, Class 
from [Production].Product
inner join [Production].ProductModel ON ProductModel.ProductModelID=product.ProductModelID
where class is not null and Production.ProductModel.Name like '%mountain%'
order by ProductID asc





--3.a.	List Product categories, their subcategories and their products.  Show the category name, 
--		subcategory name, product ID, and product name, in this order. Sort in alphabetical order on 
---		category name, then subcategory name, and then product name. Give each Name field a descriptive 
--		alias. For example, the Name field in the Product table will have the alias ProductName. 
--		Hint:  To understand the relationships, create a database diagram with the following tables: 
--		Production.ProductCategory
--		Production.ProductSubCategory
--		Production.Product
--      3 points
--      I got 295 rows.
--		QUESTION:		What is the product name in row 2?
--		YOUR ANSWER:	All-Purpose Bike Stand
select production.ProductCategory.Name as CategoryName,production.ProductSubcategory.Name as SubCategoryName, product.ProductID, Product.Name as ProductName
from Production.Product
inner join Production.ProductSubcategory on production.ProductSubcategory.ProductSubcategoryID=production.Product.ProductSubcategoryID
inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID=production.ProductSubcategory.ProductCategoryID
order by ProductCategory.Name asc ,ProductSubcategory.Name asc,product.Name asc






--3.b.	Copy 3.a. and paste below. Modify to list only Products in product category 4.  
--		Show the category name, subcategory name, product ID, and product name, in this order. 
--		Sort in alphabetical order on product name, then subcategory name, and then by category name. 
--		Hint: Add product category id field to SELECT clause, make sure your results are correct, then 
--		remove or comment out the field.  		
--      2 points
--      I got 29 rows.
--		QUESTION:		What is the product subcategory name in row 1?
--		YOUR ANSWER:	Bike Stands

select production.ProductCategory.Name as CategoryName,production.ProductSubcategory.Name as SubCategoryName, product.ProductID, Product.Name as ProductName
from Production.Product
inner join Production.ProductSubcategory on production.ProductSubcategory.ProductSubcategoryID=production.Product.ProductSubcategoryID
inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID=production.ProductSubcategory.ProductCategoryID
where production.ProductCategory.ProductCategoryID = '4'
order by product.Name asc,ProductCategory.Name asc,ProductSubcategory.Name asc





--3.c.	Copy 3.b. and paste below. Modify the pasted statement to list Products in product category 1. 
--		Make no other changes to the statement. 
--		Hint: Add product category id field to SELECT clause, make sure your results are correct, then 
--		remove or comment out the field.  Something to consider: Look at the data in the ProductName field. 
--      1 points
--      I got 97 rows.
--		QUESTION:		Could we find bikes by searching for 'bike' in the ProductName field?
--		YOUR ANSWER:	No, bike is only found in the SubCategoryName field

select production.ProductCategory.Name as CategoryName,production.ProductSubcategory.Name as SubCategoryName, product.ProductID, Product.Name as ProductName
from Production.Product
inner join Production.ProductSubcategory on production.ProductSubcategory.ProductSubcategoryID=production.Product.ProductSubcategoryID
inner join Production.ProductCategory on Production.ProductCategory.ProductCategoryID=production.ProductSubcategory.ProductCategoryID
where production.ProductCategory.ProductCategoryID = '1'
order by ProductCategory.Name asc,ProductSubcategory.Name asc,product.Name asc




--4.a.	List Product models, the categories, the subcategories, and the products.  Show the model name, 
--		category name, subcategory name, product ID, and product name in this order. Give each Name field a  
--		descriptive alias. For example, the Name field in the ProductModel table will have the alias ModelName. 
--		Sort in alphabetical order by model name. 
--		Hint:  To understand the relationships, refer to a database diagram and the following tables:
--		Production.ProductCategory
--		Production.ProductSubCategory
--		Production.Product
--		Production.ProductModel
--		Choose a path from one table to the next and follow it in a logical order to create the inner joins.
--      2 points
--      I got 295 rows.
--		QUESTION:		What is the product name in the record 2?
--		YOUR ANSWER:	Bike Wash - Dissolver
select Production.productmodel.Name as ModelName, Production.ProductCategory.Name as CategoryName, Production.ProductSubCategory.Name as SubCategoryName,
Production.Product.ProductID as ProductID, Production.Product.Name as ProductName
from Production.ProductModel
inner join Production.Product on Production.Product.ProductModelID=Production.ProductModel.ProductModelID
inner join Production.ProductSubcategory on Production.ProductSubcategory.ProductSubcategoryID=Production.product.ProductSubcategoryID
inner join production.ProductCategory on Production.ProductCategory.ProductCategoryID=Production.ProductSubcategory.ProductCategoryID
order by Production.ProductModel.Name asc





--4.b.	Copy 4.a. and paste below. Modify the pasted statement to list those products in model ID 20 that 
--		contain silver in the product name. Modify the sort to order only on Product ID. Hint: Add the 
--		product model id field to the select clause to check your results and then remove or comment it out.
--      2 points
--      I got 4 rows.
--		QUESTION:		What is the product name in record 2?
--		YOUR ANSWER:	Mountain-200 Silver, 42

select production.productmodel.ProductModelID,Production.productmodel.Name as ModelName, Production.ProductCategory.Name as CategoryName, Production.ProductSubCategory.Name as SubCategoryName,
Production.Product.ProductID as ProductID, Production.Product.Name as ProductName
from Production.ProductModel
inner join Production.Product on Production.Product.ProductModelID=Production.ProductModel.ProductModelID
inner join Production.ProductSubcategory on Production.ProductSubcategory.ProductSubcategoryID=Production.product.ProductSubcategoryID
inner join production.ProductCategory on Production.ProductCategory.ProductCategoryID=Production.ProductSubcategory.ProductCategoryID
where production.ProductModel.ProductModelID like 20 and production.product.Name like '%silver%'
order by production.Product.ProductID asc




--5.a.	List products ordered by customer id 29898.  Show product name, product number, order quantity, 
--		and sales order id.  Sort on product name and sales order id.  If you add customer id to check your results, 
--		be sure to remove or comment it out. Hint:  First create a database diagram with the following tables: 
--		Production.Product
--		Sales.SalesOrderHeader
--		Sales.SalesOrderDetail
--      2 points
--      I got 37 rows.
--		QUESTION:		What is the product name in record 1?
--		YOUR ANSWER:	HL Mountain Frame - Black, 42
select Production.Product.Name, Production.Product.ProductNumber, Sales.SalesOrderDetail.OrderQty, Sales.SalesOrderDetail.SalesOrderID
from Production.Product
inner join Sales.SalesOrderDetail on Sales.SalesOrderDetail.ProductID=production.Product.ProductID
inner join Sales.SalesOrderHeader on sales.SalesOrderDetail.SalesOrderID= sales.SalesOrderHeader.SalesOrderID
where sales.SalesOrderHeader.CustomerID = 29898
order by production.product.name asc, Sales.SalesOrderDetail.SalesOrderID asc






--5.b.  List the orders and the shipping method for customer id 29898. Show product name, product number, 
--		order quantity, sales order id, and the name of the shipping method. Sort on product name and sales 
--		order id. Hint:  You will need to join an additional table. Add it to your database diagram first. 
--      2 points
--      I got 37 rows.
--		QUESTION:		What is the SalesOrderID and ShipMethod in row 2?
--		YOUR ANSWER:	45783, 5

select Production.Product.Name, Production.Product.ProductNumber, Sales.SalesOrderDetail.OrderQty, Sales.SalesOrderDetail.SalesOrderID,Purchasing.ShipMethod.ShipMethodID
from Production.Product
inner join Sales.SalesOrderDetail on Sales.SalesOrderDetail.ProductID=production.Product.ProductID
inner join Sales.SalesOrderHeader on sales.SalesOrderDetail.SalesOrderID= sales.SalesOrderHeader.SalesOrderID
inner join Purchasing.ShipMethod on Sales.SalesOrderHeader.ShipMethodID=Purchasing.ShipMethod.ShipMethodID
where sales.SalesOrderHeader.CustomerID = 29898
order by production.product.name asc, Sales.SalesOrderDetail.SalesOrderID asc





--6.	List all sales for components that were ordered during 2012.  Show sales order id, product ID, 
--		product name, order quantity, and line total for each line item sale. Make certain you are retrieving 
--		only components. There are multiple ways to find components items. Sort the list by sales order id in ascending order. 
--      Hints: Create a database diagram before beginning the statement. Consider using the YEAR(date) function.
--      3 points
--      I got 5529 rows.
--		QUESTION:		What IS THE SalesOrderID in row 1?
--		YOUR ANSWER:	45266

select Sales.SalesOrderHeader.SalesOrderID, Production.product.ProductID, Production.product.Name, Sales.SalesOrderDetail.OrderQty, Sales.SalesOrderDetail.LineTotal,Sales.SalesOrderDetail.ModifiedDate as orderyear
from Production.Product
inner join Sales.SalesOrderDetail on Sales.SalesOrderDetail.ProductID=production.Product.ProductID
inner join Sales.SalesOrderHeader on sales.SalesOrderDetail.SalesOrderID= sales.SalesOrderHeader.SalesOrderID
where year (Sales.SalesOrderDetail.ModifiedDate ) = 2012
order by Sales.SalesOrderHeader.SalesOrderID asc








/* You will see this last question appear in different forms in many assignments. You have had the opportunity to 
explore the data. Now, what would you like to know about it? You are required to use a concept that was introduced 
in the module. In this case, you are to create a statement that requires at least one inner join. */

--7.	In your own words, write a business question for AdventureWorks that you will try to answer with a SQL query. 
--		Then try to develop the SQL to answer the question using at least one INNER JOIN. 
--		Just show your question and as much SQL as you were able to figure out. 
--      1 points








