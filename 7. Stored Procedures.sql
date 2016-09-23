USE eShop

--Creating simple stored procedure
CREATE PROCEDURE uspGetAllProducts
AS
SELECT iProductId,cProductName,iUnitPrice
FROM Product

/*
CREATE PROCEDURE SP_HELP
AS
SELECT iProductId,cProductName,iUnitPrice
FROM Product

SP_HELP
*/
--Calling stored procedures
EXECUTE uspGetAllProducts

--or
EXEC uspGetAllProducts

--or
uspGetAllProducts

--Creating stored procedures with input parameters
CREATE PROCEDURE uspGetProductById @ProductId INT
AS
SELECT iProductId,cProductName,iUnitPrice
FROM Product
WHERE iProductId = @ProductId

--Calling procedure by passing parameters
EXECUTE uspGetProductById 1

EXECUTE uspGetProductById 2

--Creating stored procedures using out
CREATE PROCEDURE uspGetProductPriceById @ProductId INT, 
										@UnitPrice INT OUTPUT, 
										@AveragePrice INT OUT
AS
BEGIN
--Populate the output variable @UnitPrice
SELECT @UnitPrice = iUnitPrice
FROM Product
WHERE iProductId = @ProductId
--Populate the output variable @AveragePrice
SELECT @AveragePrice = AVG(iUnitPrice)
FROM Product
END

--Using Batch to call the procedure uspGetProductPriceById
DECLARE @UnitPrice INT, @AveragePrice INT
EXECUTE uspGetProductPriceById 1, @UnitPrice OUTPUT, @AveragePrice OUT
PRINT 'The Cost of the Product is : ' + CAST(@UnitPrice AS CHAR(10))
PRINT 'The Average Cost of the Product is : ' + CAST(@AveragePrice AS CHAR(10))
IF @UnitPrice > @AveragePrice
	PRINT 'The cost of the product is more than the Average Cost'
ELSE
	PRINT 'The cost of the product is less than the average cost'
	
--Creating a procedure to call uspGetProductPriceById procedure
CREATE PROCEDURE uspDisplayAveragePrice
AS
BEGIN
DECLARE @Cost INT, @AverageCost INT
EXECUTE uspGetProductPriceById 1, @Cost OUTPUT, @AverageCost OUT
PRINT 'The Cost of the Product is : ' + CAST(@Cost AS CHAR(10))
PRINT 'The Average Cost of the Product is : ' + CAST(@AverageCost AS CHAR(10))
IF @Cost > @AverageCost
	PRINT 'The cost of the product is more than the Average Cost'
ELSE
	PRINT 'The cost of the product is less than the average cost'
END

--Calling procedure uspDisplayAveragePrice
EXECUTE uspDisplayAveragePrice

--Creating a procedure with default value for input parameters
--This prevents returning error when procedure is called without passing parameters
CREATE PROCEDURE uspGetCustomerById @CustomerId INT = NULL
AS
BEGIN
IF @CustomerId IS NULL
BEGIN
	PRINT 'Error : Please specify Customer''s Id'
	RETURN
END
SELECT iCustomerId, cFirstName, cLastName, cCity
FROM Customer
WHERE iCustomerId = @CustomerId
PRINT 'OK'
END

--Calling procedure uspGetCustomerById
EXECUTE uspGetCustomerById 1

EXECUTE uspGetCustomerById

/*
Return procedure execution status as an integer value(also called return code) using RETURN statement
Assume these return code values and their meanings
0 - Success
1 - Required Parameter value is not specified
2 - Specified Parameter value is not valid
*/ 
CREATE PROCEDURE uspGetEmployeeById @EmployeeId INT = NULL
AS
BEGIN
IF @EmployeeId IS NULL
	RETURN 1
ELSE
	IF (SELECT COUNT(*) FROM Employee WHERE iEmployeeId = @EmployeeId) = 0
		RETURN 2
	ELSE
		RETURN 0
END

--Calling procedure uspGetEmployeeById and checking return code value using a batch
DECLARE @ReturnCode INT
--Get return code
EXECUTE @ReturnCode = uspGetEmployeeById 2
--check return code
IF @Returncode = 0
	PRINT 'Procedure Executed Successfully'
ELSE IF @ReturnCode = 1
		PRINT 'Error : Required Parameter is not specified'
ELSE IF @ReturnCode = 2
	PRINT 'Error : Specified Parameter is not valid'

--Modify procedure using ALTER PROCEDURE statement
ALTER PROCEDURE uspGetEmployeeById @EmployeeId INT = NULL
AS
BEGIN
IF @EmployeeId IS NULL
	RETURN 1
ELSE
	IF (SELECT COUNT(*) FROM Employee WHERE iEmployeeId = @EmployeeId) = 0
		RETURN 2
	ELSE
		RETURN 0
END

--Delete a procedure using DROP PROCEDURE statement
DROP PROCEDURE dbo.uspDisplayAveragePrice

--Delete more than one procedure using a single DROP statement
DROP PROCEDURE dbo.uspGetEmployeeById, dbo.uspGetProductById, dbo.uspGetProductBySearchString, dbo.uspGetProductPriceById

--Error Handling using TRY..CATCH

--Creating a procedure to display error information using error functions
CREATE PROCEDURE uspShowErrorDetails
AS
SELECT  ERROR_NUMBER() AS 'Error Number',
		ERROR_SEVERITY() AS 'Error Severity',
		ERROR_STATE() AS 'Error State',
		ERROR_PROCEDURE() AS 'Error Procedure',
		ERROR_LINE() AS 'Error Line',
		ERROR_MESSAGE() AS 'Error Message'

--Writing batch to generate error and displaying error message by calling uspShowErrorDetails procedure
BEGIN TRY
	SELECT 1/0;
END TRY
BEGIN CATCH
	--calling procedure to show error details
	EXECUTE uspShowErrorDetails;
END CATCH

--Syntax error cannot be caught by TRY..CATCH because in case of syntax error the batch itself does not compile successfully
BEGIN TRY
	--generating syntax error
	SELECT # FROM Employee
END TRY
BEGIN CATCH
	--calling procedure to show error details
	EXECUTE uspShowErrorDetails;
END CATCH

--The error generated by a SELECT statement that refer an object which does not exist cannot be caught by TRY..CATCH
BEGIN TRY
	--generating an object name resolution error
	SELECT * FROM myEmployee
END TRY
BEGIN CATCH
	--calling procedure to show error details
	EXECUTE uspShowErrorDetails;
END CATCH
