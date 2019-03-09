CREATE PROCEDURE [Environment].[UpdatePathDirectories]
AS
	UPDATE Integration.DataSets
		SET Path = (SELECT Path FROM Environment.Locations WHERE Name = 'Root')
			+ '/' + CAST(DATEPART(YYYY, GETDATE()) AS VARCHAR(4))
			+ '/' + RIGHT('0' + CAST(DATEPART(mm, GETDATE()) AS VARCHAR(2)), 2)
			+ '/' + CONCAT(DataSource, Name);

	SELECT Path FROM Integration.DataSets;
