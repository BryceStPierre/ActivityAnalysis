CREATE VIEW [Integration].[ExtractDataSets] AS 
	SELECT
		PostPath AS FilePath,
		CONCAT(CONCAT('Source.', DataSource), Name) AS SourceTable
	FROM Integration.DataSets
	WHERE PostPath IS NOT NULL;
