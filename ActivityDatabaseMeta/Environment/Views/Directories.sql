CREATE VIEW [Environment].[Directories] AS
	SELECT 
		(SELECT Path FROM Environment.Locations WHERE Name = 'Root') AS Root,
		CAST(DATEPART(YYYY, GETDATE()) AS VARCHAR(4)) AS Year,
		RIGHT('0' + CAST(DATEPART(mm, GETDATE()) AS VARCHAR(2)), 2) AS Month,
		Name
	FROM Integration.DataSets;
