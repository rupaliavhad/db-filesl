--Select a database
USE eShop


/* Returns all columns from the table name specified in the from clause.
Using the asterisk ( * ) symbol in the SELECT statement can return all columns from a table.
Note : Avoid using * symbol, it may break your application.
*/
SELECT * FROM Employee

--Specifying each column explicitly in the select list returns only specific columns from a table.
SELECT iEmployeeId, cTitle, cFirstName, cLastName
FROM Employee

/*
Using Column Alias hides the original column name
Using a Column Alias makes a column name more readable.
By default the column name in result set is same as the column name in base table.
The “AS” clause allows to use different column name or alias in the result set.
*/
SELECT iEmployeeId, 
	   cJobTitle AS 'Designation', 
	   dBirthDate AS 'Date of Birth'
FROM Employee

/*
Character string constants are included for proper formatting or readability when character columns are concatenated.
*/
SELECT cTitle + ' ' + cFirstName + ' ' + cLastName AS 'Name'
FROM Employee

--Using expression to calculate Discount(10%) Price
--that does not exist in the base table
SELECT iProductId, 
	   iUnitPrice, 
	   (iUnitPrice - (iUnitPrice * .1)) AS 'Discounted Price'
FROM Product

select * from Product

--using DISTINCT keyword to eliminate duplicate rows
SELECT cJobTitle FROM Employee --returns duplicate values

SELECT DISTINCT cJobTitle FROM Employee --eliminates duplicate values

--using TOP clause to limit number of rows that are returned in the result set
select * from Department

SELECT TOP 2 cDepartmentName FROM Department --returns top 2 rows
SELECT TOP 26 PERCENT cDepartmentName FROM Department --assuming 25% for one row if you have 4 rows

SELECT * FROM Product

SELECT TOP 2 iUnitPrice, cProductName FROM Product
ORDER BY iUnitPrice DESC

SELECT TOP 50 PERCENT iUnitPrice, cProductName FROM Product
ORDER BY iUnitPrice DESC

--using SELECT statements that do not require FROM clause
SELECT DB_ID('eShop')--returns database id

SELECT DB_NAME(10)--returns database name

SELECT @@VERSION--returns Sql Server version

--using comparison operator
SELECT * FROM Product

SELECT iProductId, cProductName, iUnitPrice
FROM Product
WHERE iUnitPrice > 35000

--using Range search conditions
--it returns all values between two specified values
SELECT iProductId, cProductName, iUnitPrice
FROM Product
WHERE iUnitPrice BETWEEN 35000 AND 40000

SELECT iProductId, cProductName, iUnitPrice
FROM Product
WHERE iUnitPrice NOT BETWEEN 35000 AND 40000

--using List search condition
--the IN keyword allows you to select rows that match any one of a list of values
SELECT * FROM Employee

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity IN ('Pune','Ahmedabad')

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity NOT IN ('Pune','Ahmedabad')

--using pattern matching
--the LIKE keyword is used for pattern matching
--the pattern may contain character string along with 4 wildcards
/*
Enclose the wildcards and the character string in single quotation marks, for example: 

LIKE 'Mc%' searches for all strings that begin with the letters Mc (McBadden).
LIKE '%inger' searches for all strings that end with the letters inger (Ringer, Stringer).
LIKE '%en%' searches for all strings that contain the letters en anywhere in the string (Bennet, Green, McBadden).
LIKE '_heryl' searches for all six-letter names ending with the letters heryl (Cheryl, Sheryl).
LIKE '[CK]ars[eo]n' searches for Carsen, Karsen, Carson, and Karson (Carson).
LIKE '[M-Z]inger' searches for all names ending with the letters inger that begin with any single letter from M through Z (Ringer).
LIKE 'M[^c]%' searches for all names beginning with the letter M that do not have the letter c as the second letter (MacFeather).
*/

--using % wildcard which means any string of zero or more characters
SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cFirstName LIKE 'sa%'

--using _ wildcard which means any single character
SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cFirstName LIKE '_a%'

--using [] wildcard which means any single character within the specified range 
--(for example, [a-f]) or set (for example, [abcdef]).
SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity LIKE '[a-c]%'--means first character should be between a to c followed by any number of characters

--using [^] wildcard which means any single character not within the specified range 
--(for example, [^a - f]) or set (for example, [^abcdef]).
SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity LIKE '[^a-c]%'

--using NULL values
SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity IS NULL

SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity IS NOT NULL

--using logical operators
SELECT iEmployeeId, cTitle, cFirstName, cCity
FROM Employee
WHERE cCity = 'Ahmedabad' AND cState = 'Karnataka'--no result returned, since the condition does not match with existing data
--OOPs wrong query
--let's write right one
SELECT iEmployeeId, cTitle, cFirstName, cState, cCity
FROM Employee
WHERE cCity = 'Ahmedabad' OR cState = 'Karnataka'

--using Aggregate functions
SELECT * FROM Product

--count function ignore null values
select * from Employee
select count(iManagerId) as "Manager Id" from employee

SELECT COUNT(iProductId) AS "Product Count"
FROM Product

SELECT AVG(iUnitPrice) AS "Average Price"
FROM Product

SELECT MIN(iUnitPrice) AS "Minimum Price"
FROM Product

SELECT MAX(iUnitPrice) AS "Maximum Price"
FROM Product

SELECT SUM(iQuantity) AS "Total Quantity"
FROM Product

--sorting data using ORDER BY clause
SELECT * FROM Product

SELECT iProductId, cProductName, iQuantity
FROM Product
ORDER BY iQuantity ASC

SELECT iProductId, cProductName, iQuantity
FROM Product
ORDER BY iQuantity DESC

--using GROUP BY clause
SELECT * FROM Orders

SELECT iProductId, SUM(iQuantity) AS "Quantity Sold"
FROM Orders
GROUP BY iProductId
ORDER BY iProductId

--using HAVING clause
SELECT iProductId, SUM(iQuantity) AS "Quantity Sold"
FROM Orders
GROUP BY iProductId
HAVING SUM(iQuantity) > 2
ORDER BY iProductId

--using WHERE to eliminate row and HAVING clause to eliminate groups
SELECT iProductId, SUM(iQuantity) AS "Quantity Sold"
FROM Orders
WHERE iQuantity > 1
GROUP BY iProductId
HAVING SUM(iQuantity) > 3
ORDER BY iProductId

--Using UNION operator, it will return distinct rows
SELECT cState FROM Employee

SELECT cState FROM Customer


SELECT cState FROM Employee
UNION
SELECT cState FROM Customer

--Using UNION ALL, this will return duplicate rows
SELECT cState FROM Employee
UNION ALL
SELECT cState FROM Customer

--Using EXCEPT operand, it returns values from Query1 - Query2
SELECT cState FROM Employee
EXCEPT
SELECT cState FROM Customer

--Using INTERSECT operand, it returns distinct values common to both the tables
SELECT cState FROM Employee
INTERSECT
SELECT cState FROM Customer

--Using Joins
DROP TABLE table1
DROP TABLE table2

CREATE TABLE table1
(ID INT, Value VARCHAR(10))

INSERT INTO Table1 (ID, Value) values(1,'First')
INSERT INTO Table1 (ID, Value) values(2,'Second')
INSERT INTO Table1 (ID, Value) values(3,'Third')
INSERT INTO Table1 (ID, Value) values(4,'Fourth')
INSERT INTO Table1 (ID, Value) values(5,'Fifth')
 

CREATE TABLE table2
(ID INT, Value VARCHAR(10))

INSERT INTO Table2 (ID, Value) values(1,'First')
INSERT INTO Table2 (ID, Value) values(2,'Second')
INSERT INTO Table2 (ID, Value) values(3,'Third')
INSERT INTO Table2 (ID, Value) values(6,'Sixth')
INSERT INTO Table2 (ID, Value) values(7,'Seventh')
INSERT INTO Table2 (ID, Value) values(8,'Eighth')

SELECT * FROM Table1
SELECT * FROM Table2

/* INNER JOIN or JOIN returns rows when there is atleast one match in both tables.
It is default join in sql server.
INNER JOIN includes Equi Join, Non-Equi Join, Natural Join and Cross Join.
Equi Join uses the equal sign as the comparison operator.
*/
SELECT t1.*,t2.*
FROM Table1 t1 INNER JOIN Table2 t2 
ON t1.ID = t2.ID

/* CROSS JOIN is also called Cartesian Product returns 
no. of rows of left table * no. of rows of the right table*/
SELECT t1.*,t2.*
FROM Table1 t1 CROSS JOIN Table2 t2

/*Outer Joins are Left Outer, Right Outer and Full Outer joins. 
LEFT OUTER JOIN OR LEFT JOIN returns all the rows from the left table(Table1), 
even if there are no matches in the right table(table2) */
SELECT t1.*,t2.*
FROM Table1 t1 LEFT JOIN Table2 t2 
ON t1.ID = t2.ID

/* RIGHT OUTER JOIN OR RIGHT JOIN keyword returns all the rows from the right table(Table2),
even if there are no matches in the left table(Table1*/
SELECT t1.*,t2.*
FROM Table1 t1 RIGHT JOIN Table2 t2 
ON t1.ID = t2.ID

/* FULL OUTER JOIN OR Full JOIN keyword returns all the rows from the left table and
 right table*/
SELECT t1.*,t2.*
FROM Table1 t1 FULL JOIN Table2 t2 
ON t1.ID = t2.ID

/* LEFT JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1 LEFT JOIN Table2 t2 
ON t1.ID = t2.ID
WHERE t2.ID IS NULL

/* RIGHT JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1 RIGHT JOIN Table2 t2 
ON t1.ID = t2.ID
WHERE t1.ID IS NULL

/* Full JOIN - WHERE NULL */
SELECT t1.*,t2.*
FROM Table1 t1 FULL JOIN Table2 t2 
ON t1.ID = t2.ID
WHERE t1.ID IS NULL or t2.ID IS NULL

DROP TABLE table1
DROP TABLE table2

--Self Join
--It uses one row in a table to correlate another row of the same table
--An alias can be used to differentiate two copies of the same table

SELECT emp1.iEmployeeId, 
emp1.cFirstName AS "Employee", 
emp2.cFirstName AS "Manager"
FROM Employee AS emp1 INNER JOIN Employee AS emp2
ON emp1.iManagerId = emp2.iEmployeeId

select * from Employee


--If you want to display an employee who does not have any manager use outer join
SELECT emp1.iEmployeeId, emp1.cFirstName AS "Employee", emp2.cFirstName AS "Manager"
FROM Employee AS emp1 LEFT OUTER JOIN Employee AS emp2
ON emp1.iManagerId = emp2.iEmployeeId

--Using Fully Qualified Object Name(4 parts object name)
USE eShop

SELECT * FROM [sushantba].eShop.dbo.Employee

--Using Subquery
USE eShop

SELECT * FROM Customer

--This query will return orders placed by a particular customer name Anil Sharma
--The subquery will supply the Customer Id of Anil Sharma to the outer query
SELECT * FROM Orders
WHERE iCustomerId = (SELECT iCustomerId 
FROM Customer 
WHERE cFirstName = 'Anil' AND cLastName = 'Kumble')

--Same result as above can be generated using join
SELECT * FROM Orders AS od
JOIN Customer AS cust
ON od.iCustomerId = cust.iCustomerId
WHERE cust.cFirstName = 'Anil' AND cust.cLastName = 'Kumble'

--Subquery with aliases
--Display what is the manager id of employee whose id is 2 and who are the other subordinates
--working for the same manager
SELECT * FROM Employee

SELECT emp1.cFirstName AS "Employee", emp1.iManagerId AS "Manager Id"
FROM Employee AS emp1 
WHERE emp1.iManagerId IN (SELECT emp2.iManagerId FROM Employee AS emp2 WHERE emp2.iEmployeeId = 2)

--Subquery with IN
--A subquery with IN or NOT IN returns 0 or more results which are used by outer query
--to return the final result set
--Display all products which get ordered by the customers
SELECT * FROM Product
WHERE iProductId IN (SELECT iProductId FROM OrderDetail)

SELECT * FROM OrderDetail

--Subquery using ANY, ALL
/*
Comparison operators that introduce a subquery can be modified by the keywords ALL or ANY. 
SOME is an ISO standard equivalent for ANY.
Subqueries introduced with a modified comparison operator return a list of zero or more 
values and can include a GROUP BY or HAVING clause. These subqueries can be restated with EXISTS.

Using the > comparison operator as an example, 
>ALL means greater than every value. In other words, it means greater than the maximum value. 
For example, >ALL (1, 2, 3) means greater than 3. 
>ANY means greater than at least one value, that is, greater than the minimum. 
So >ANY (1, 2, 3) means greater than 1.
*/
SELECT * FROM OrderDetail

SELECT * FROM Customer
WHERE iCustomerId > ANY
(SELECT iCustomerId FROM OrderDetail WHERE iQuantity >= 4)

SELECT * FROM Customer
WHERE iCustomerId >= ALL
(SELECT iCustomerId FROM OrderDetail WHERE iQuantity >= 4)

--Subquery using EXISTS
/*
When a subquery is introduced with the keyword EXISTS, 
the subquery functions as an existence test. 
The WHERE clause of the outer query tests whether the rows 
that are returned by the subquery exist. The subquery does not 
actually produce any data; it returns a value of TRUE or FALSE.
*/
--Display name of the employees who work in HR department
SELECT * FROM Employee

SELECT cFirstName, cLastName FROM Employee
WHERE EXISTS(SELECT * FROM Department 
WHERE iDepartmentId = Employee.iDepartmentId AND cDepartmentName = 'HR')

----Display name of the employees who do not work in HR department
SELECT cFirstName, cLastName FROM Employee
WHERE NOT EXISTS(SELECT * FROM Department 
WHERE iDepartmentId = Employee.iDepartmentId AND cDepartmentName = 'HR')

--Subquery as an expression
--In Transact-SQL, a subquery can be substituted anywhere an expression can be used 
--in SELECT, UPDATE, INSERT, and DELETE statements, except in an ORDER BY list.
SELECT * FROM Product

SELECT cProductName, iUnitPrice,(SELECT AVG(iUnitPrice) FROM Product) AS Average, 
iUnitPrice - (SELECT AVG(iUnitPrice) FROM Product) AS 'Difference'
FROM Product

--Correlated Subquery
/*
In queries that include a correlated subquery (also known as a repeating subquery), 
the subquery depends on the outer query for its values. This means that the subquery 
is executed repeatedly, once for each row that might be selected by the outer query.
*/
--Display product id and quantity of those products having quantity greater than the average quantity
SELECT iProductId, iQuantity
FROM OrderDetail od1
WHERE od1.iQuantity >
    (SELECT AVG (od2.iQuantity)
     FROM OrderDetail od2
     WHERE od2.iProductId = od1.iProductId)

--Check average     
SELECT AVG(iQuantity) FROM OrderDetail
--Check quanity
SELECT iQuantity FROM OrderDetail

/*
The previous subquery in this statement cannot be evaluated independently 
of the outer query. It needs a value for od1.iProductId, but this 
value changes as SQL Server examines different rows in OrderDetail.

The outer query selects the rows of OrderDetail (that is, of od1) one by one. 
The subquery calculates the average quantity for each sale being considered for 
selection in the outer query. For each possible value of od1, Microsoft SQL Server 
evaluates the subquery and puts the record being considered in the results if the 
quantity is less than the calculated average.
*/
