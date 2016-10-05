/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2012].[Sales].[SalesTerritory]

  --VIEWS (US VIEW)

CREATE VIEW MyCustomUSView
AS
SELECT * FROM [AdventureWorks2012].[Sales].[SalesTerritory]
WHERE CountryRegionCode LIKE 'US'


SELECT * FROM MyCustomUSView

-- JOIN SALES TERRITORY AND SALES PERSON TABLES INTO A VIEW
CREATE VIEW NASalesQuota
AS
SELECT [Name], [Group], [SalesQuota], [Bonus]
FROM [AdventureWorks2012].[Sales].[SalesTerritory] A INNER JOIN [Sales].[SalesPerson] B
ON A.TerritoryID = B.territoryID
WHERE [Group] LIKE 'North America'

SELECT * FROM NASalesQuota

---------------------------------------TRIGGERS---------------------------------------
--------------------------------------------------------------------------------------
SELECT * FROM HumanResources.Shift 

-- DISALLOW NEW SHIFTS BEING ADDED W/OUT MANAGERS APPROVAL
-- ROLL BACK THE SHIFT ADDED
CREATE TRIGGER Demo_Trigger
ON HumanResources.Shift
AFTER INSERT
AS
BEGIN
PRINT 'INSERT IS NOT ALLOWED.  YOU NEED APPROVAL'
ROLLBACK TRANSACTION
END
GO

-- TEST THE TRIGGER
INSERT INTO HumanResources.Shift
(
	Name,
	StartTime,
	EndTime,
	ModifiedDate
) 
VALUES
(
	'Randy',
	'07:00:00.0000000',
	'09:00:00.0000000',
	getDate()
) -- It will fire the trigger and show the message that approval is needed

SELECT * FROM HumanResources.Shift -- Won't show values you attempted to insert

-------------------------------------------------------------------------------
-------------------------------DATABASE LEVEL TRIGGER--------------------------
CREATE TRIGGER DEMO_DBLevelTrigger
ON DATABASE
AFTER CREATE_TABLE
AS
BEGIN
PRINT 'CREATION OF NEW TABLES NOT ALLOWED'
ROLLBACK TRANSACTION
END
GO

-- TEST DB LEVEL TRIGGER
CREATE TABLE MYDEMOTABLE(COL1 varchar(10))  -- DB Level Trigger should fire and show output message that new table creation is not allowed
