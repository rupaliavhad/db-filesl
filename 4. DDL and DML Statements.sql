/*
Creating a database using the default parameters is very simple. 
The following data definition language (DDL) command will create a database name MyDB:
The CREATE command will create a data file with the name provided and a .mdf file extension, 
as well as a transaction log with an .ldf extension.

By default, the database is created with initial of data file of 3 MB, and a transaction log of 1 MB in the default location.
*/
--creating database
CREATE DATABASE MyDB

--see list of all databases
SELECT * FROM sys.databases

--Returns details of all databases using system stored procedure
SP_HELPDB

--creating database with file size and autogrowth
CREATE DATABASE MyDB2
ON PRIMARY
(NAME=MyDB, FILENAME='D:\MyDB.mdf', SIZE=5MB, MAXSIZE=1GB,FILEGROWTH=10%)
LOG ON
(NAME=MyDBLog, FILENAME='D:\MyDBLog.ldf',SIZE=2MB, MAXSIZE=50MB,FILEGROWTH=1MB)

--ALTER DATABASE Statements to modify database
--Using modify file option to change file size and to set autogrowth manual
ALTER DATABASE MyDB
modify file
(name=MyDB, size=10MB, maxsize=100MB, filegrowth=0)

--Changing the name of the database
ALTER DATABASE MyDB MODIFY NAME = YourDB

ALTER DATABASE YourDB MODIFY NAME = MyDB

--Changing name of the database using system stored procedure
SP_RENAMEDB MyDB, YourDB

SP_RENAMEDB YourDB, MyDB

--Removing database from the server
DROP DATABASE MyDB2

--Creating table
USE MyDB

CREATE TABLE Employee
(
	Employee_ID int not null,
	First_Name char(15) not null,
	Last_Name char(15),
	City char(20),
	Emp_Address varchar(50)
)

--list only user defined tables from the current database
select * from sys.objects
where type_desc = 'user_table'

--View Structure of a Table
sp_help employee

--Rename Table
sp_rename Employee, Emp
sp_rename Emp, Employee

--Drop Table
drop table Employee

--Drop multiple table in one statement
drop table Employee, Department

--Create table with Select Into
Select * into Employee2
from Employee

SP_HELP Employee2
SELECT * FROM Employee2

--Modify table structure
--Alter nullability of a column
alter table Employee
alter column cLastName char(35) not null

sp_help employee

--Alter data type and size of a column
alter table Employee
alter column Last_Name varchar(50)

sp_help employee

--Rename a column
sp_rename 'Employee.Last_Name', 'LName'

--Add new column to already existing table
alter table Employee
add Phone BIGINT

--Delete an existing column
alter table Employee
drop column Phone

--Create Temporary table
--Local Temporary table
create table #Local_Temp
(
	id int,
	name char(10)
)

--Global Temporary table
create table ##Global_Temp
(
	id int,
	name char(10)
)

--User defined data type or UDDT or Alias data type
drop table Emp

sp_addtype uddt_Address,'varchar(150)','not null'

create table Emp
(
	Emp_ID int identity,
	Name char(10),
	[Address] uddt_Address
)

SP_HELP Emp

--Applying Constraints
DROP DATABASE eShop

CREATE DATABASE eShop

Use eShop

--Creating Department table with NOT NULL and PRIMARY KEY constraints
DROP TABLE Department

CREATE TABLE Department
(
	iDepartmentId INT IDENTITY(1,1),
	cDepartmentName CHAR(30) NOT NULL,
	CONSTRAINT pkDeptId PRIMARY KEY (iDepartmentId)
)

SP_HELP Department

--Creating Employee table with FOREIGN KEY constraint with options CASCADE which enables autometic updates to related table data
--Creating Identity, it can only be defined only on columns with numeric data type and not null column
DROP TABLE Employee

CREATE TABLE Employee
(
	iEmployeeId INT IDENTITY(1,1) NOT NULL,
	cTitle CHAR(4),
	cFirstName CHAR(30) NOT NULL,
	cLastName CHAR(30) NOT NULL,
	cJobTitle CHAR(30),
	iManagerId INT,
	dBirthDate DATE,
	dDateOfJoining DATE,
	iPhone BIGINT UNIQUE,--Adding unique constraint allows single NULL
	vEmail VARCHAR(100),
	vAddress VARCHAR(200),
	cCounty CHAR(30),
	cState CHAR(30),
	cCity CHAR(30) DEFAULT 'Ahmedabad', --Adding DEFAULT definition, only one DEFAULT constraint allowed per column
	iDepartmentId INT,
	CONSTRAINT pkEmpId PRIMARY KEY(iEmployeeId),
	CONSTRAINT fkDeptId FOREIGN KEY(iDepartmentId) REFERENCES Department(iDepartmentId)ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT chk_city CHECK(cCity in('Gandhinagar','Ahmedabad','Surat','Baroda','Rajkot'))--multiple CHECK constraint allowed per column
)

SP_HELP Employee

--Creating Product without any constraints
create table Product
(
	ProductID int,
	Name char(10)
)

--Adding NOT NULL constraint to an existing table
alter table Product
alter column ProductID int not null

--Add PRIMARY KEY constraint to already existing table
alter table Product
add constraint pk_prodid primary key(ProductID)

--Drop constraint
alter table Product
drop constraint pk_prodid

sp_help Product

--Drop constraint-same as above without constraint keyword
alter table Product
drop pk_prodid

--Creating Composite Primary Key
create table Orders
(
	OrderID int not null,
	ProductID int not null,
	Quantity int,
	constraint pk_OrderProductID primary key(OrderID,ProductID)
)

sp_help Orders

--add foreign key to an existing table
alter table Employee
add constraint fk_deptid foreign key(DeptID) references Department(DeptID)

--Adding check constraint to already existing table
--prevent validation of existing values using with nocheck, it will ignore if any existing value violates the constraint
alter table emp2 with nocheck
add constraint chk_age1 check(Age between 20 and 30)

--Create Rules(This feature will be removed from future version of SQL Server, do not use in new development)
--Only one rule per column is allowed.
--One rule and multiple check constraints are allowed in one column
create rule city_rule
as
@city in ('Bangalore','Chennai','Hyderabad','Kolkata','Mumbai')

exec sp_bindrule 'city_rule','Customers.City'

sp_help customers

create table Suppliers
(
	id int,
	city char(20)
)

sp_bindrule 'city_rule','Suppliers.city'

sp_help suppliers

drop rule city_rule

exec sp_unbindrule 'Suppliers.City'

--DML Statements
--Inserting data into all columns
--Inserting data into Department table
INSERT INTO Department VALUES('HR')
INSERT INTO Department VALUES('IT')
INSERT INTO Department VALUES('Sales')
INSERT INTO Department VALUES('Training')

INSERT INTO Employee
VALUES('Mr.','Sachin','Patel','Software Engineer',NULL,'1990-09-29',GETDATE(),9526541524,'abc@gmail.com','29/1 M.G.Road','India','Gujarat','Ahmedabad',1)

--Inserting data into specific columns(remaining columns must support NULL)
INSERT INTO Employee(cTitle,cFirstName,cLastName)
VALUES('Mr.','Sachin','Patel')

SELECT * FROM Employee

--Update all rows
update Employee
set cCity = 'Gandhinagar'

--Update specific row
update Employee
set cCity = 'Ahmedabad'
where iEmployeeId=1

--update multiple column values as well as multiple row values at a time
update Employee
set cJobTitle='Manager', cCity='Surat'
where iEmployeeId=3 or iEmployeeId=2

--Delete data from a table
delete from Employee
where iEmployeeId = 4

--Delete all data
delete from Employee

--Truncate data--it is faster than delete command and will not make an entry into 
--transaction log file, So data cannot be recovered in this case
truncate table table1
--It does not eccept where clause i.e. where id = 1
