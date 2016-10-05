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