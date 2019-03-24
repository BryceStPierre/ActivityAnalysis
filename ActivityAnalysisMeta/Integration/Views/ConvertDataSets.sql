CREATE VIEW [Integration].[ConvertDataSets] AS 
	SELECT
		CONCAT(DataSource, Name) AS Name,
		PrePath, 
		PostPath
	FROM Integration.DataSets
	WHERE PrePath IS NOT NULL AND PostPath IS NOT NULL;