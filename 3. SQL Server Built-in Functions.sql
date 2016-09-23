USE eShop

/*
SQL Server built-in functions that can be used to perform certain operations.
System Functions: Returns information from system tables
*/
--Returns currently selected database id and name
SELECT DB_ID()

SELECT DB_NAME()

--Returns host(machine name) id and name that is currently connected to SQL Server
SELECT HOST_ID()

SELECT HOST_NAME()

--Returns specified object id and name from SYSOBJECTS table
SELECT OBJECT_ID('CUSTOMER')

--same as above
SELECT id FROM SYSOBJECTS WHERE NAME = 'CUSTOMER'

SELECT OBJECT_NAME(37575172)

--Returns current user id and name of the host(machine) used to login to SQL Server
SELECT SUSER_ID()

SELECT SUSER_NAME()

--Returns system user id and username in SQL Server
SELECT USER_ID()

SELECT USER_NAME()

--Same as above
SELECT * FROM SYSUSERS where NAME = 'dbo'

/*
Using String Functions
These functions perform an operation on character string input value and return a string or numeric value.
Most string functions are used on char and varchar data types
*/
--ASCII(s): Returns the ASCII code value of the leftmost character of the expression.
SELECT ASCII('A')

SELECT ASCII('BCD')    

--CHAR(n): Converts the given ASCII code to a character.
SELECT CHAR(97)     
 
--CHARINDEX(search exp, string exp [ , start_location ] ): Returns the starting position of the search exp in the string exp which can also be a column name.
SELECT CHARINDEX('O', 'HELLO WORLD')  

/*
In the above case it returns 5 as output because it starts its search from the beginning of the string.
we can change the default start location by using the start location optional parameter.
*/
SELECT CHARINDEX('O', 'HELLO WORLD', 6)  
 
--LEFT(s, n): Returns the left part of the string with the specified number of characters.
 SELECT LEFT('HELLO', 4)    
 
--RIGHT(s, n): Returns the right part of the string with the specified number of characters.
SELECT RIGHT('HELLO', 4)   
 
--SUBSTRING(s, start, length): Returns a part of a string from a string input s starting 
--from a position specified in start(first character 1 not 0), where length is the no of chars to be picked.
 SELECT SUBSTRING('HELLO', 1, 4)  
 SELECT SUBSTRING('HELLO', 4, 2) 
  

--LEN(s): Returns the number of characters of the specified string expression, 
--This function includes leading space but excludes trailing white spaces.
 SELECT LEN('HELLO')    
 SELECT LEN(' HELLO')    
 SELECT LEN('HELLO ')   
 
--LOWER(s): Returns a character expression after converting the given character data to lowercase.
 SELECT LOWER('HELLO')   
 
--UPPER(s): Returns a character expression after converting the given character data to uppercase.
 SELECT UPPER('hello') 
 
--LTRIM(s): Returns a character expression after it removes leading blanks.
 SELECT LEN(' HELLO')  
 SELECT LEN(LTRIM(' HELLO'))  
 SELECT 'HELLO ' + LTRIM(' WORLD')  
 
--RTRIM(s): Returns a character expression after it removes trailing blanks.
 SELECT RTRIM('HELLO ') + 'WORLD'  
 
--REPLACE(s1, s2, s3): Replaces all occurrences of the s2 in s1 with s3.
 SELECT REPLACE('HELLO', 'ELLO', 'I') 
 
--REPLICATE(s, n): Repeats the expression 's' for specified 'n' number of times.
 SELECT REPLICATE('HA..', 3)  
 
--REVERSE(s): Returns the reverse of the given string 's'.
 SELECT REVERSE('C++')  

--SPACE(n): Returns a string with specified 'n' number of repeated spaces.
 SELECT 'HELLO' + SPACE(1) + 'WORLD' 
 
--STUFF(s, start, length, replace_str): Replaces specified length of 
--characters from specified starting point with replace_str in the string 's'
 SELECT STUFF('GANDHINAGAR', 1, 1, 'A') 

/*
Date and Time Functions
---------------------------
The following functions perform an operation on a date and time input value 
and return a string, numeric, or date and time value.
*/
--Returns the current date and time of the server
SELECT GETDATE()

--DAY(date): Returns an integer representing the DAY of the specified date, 
SELECT DAY(GETDATE())
 
SELECT DAY('10/24/78')                                        


--MONTH(date): Returns an integer representing the MONTH of the specified date, 
SELECT MONTH(GETDATE())
 
SELECT MONTH('10/24/78')

 
--YEAR(date): Returns an integer representing the YEAR of the specified date.
SELECT YEAR(GETDATE())

SELECT YEAR('10/24/78') 

 
--DATENAME(datepart, date): Returns a character string representing the 
--specified datepart of the specified date, datepart is the parameter that 
--specifies the part of the date to return. 
--The following list describes dateparts and abbreviations recognized by Sql Server:
/*
Datepart--Abbreviations
year=yy, yyyy
quarter=qq, q
month=mm, m
dayofyear=dy, y
day=dd, d
week=wk, ww
weekday=dw
hour=hh
minute=mi, n
second=ss, s
millisecond=ms
*/
SELECT DATEPART(YEAR,GETDATE())
SELECT DATEPART(MONTH, GETDATE())
SELECT DATEPART(WEEKDAY, GETDATE())

SELECT DATENAME(MM, '10/24/78')

SELECT DATENAME(ms, GETDATE())
 
SELECT DATENAME(dd, '10/24/78')

 
--DATEADD(datepart, number, date): Returns a new datetime value based on 
--adding an interval to the specified date, datepart is the value that has 
--to be added and number is the interval.

--Adds 30 days to GETDATE(). 
SELECT DATEADD(dd, 30, GETDATE()) 

--–Adds 12 months to GETDATE().
SELECT DATEADD(mm, 12, GETDATE()) 
 
--DATEDIFF(datepart, startdate, enddate): Returns the difference between 
--the start and end dates in the give datepart format.
 
SELECT DATEDIFF(yy, '10/24/95', GETDATE())

/*
Conversion Functions
*/
SELECT GETDATE()

--Error, Conversion failed
SELECT 'Current Date and Time : ' + GETDATE()

--Convert using CONVERT() function
SELECT 'Current Date and Time : ' + CONVERT(CHAR(30), GETDATE())

--Convert using CAST() function
SELECT 'Current Date and Time : ' + CAST(GETDATE() AS CHAR(30))
