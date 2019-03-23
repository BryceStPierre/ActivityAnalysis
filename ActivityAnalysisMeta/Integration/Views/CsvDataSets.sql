CREATE VIEW [Integration].[CsvDataSets] AS 
	SELECT
		PrePath, 
		PostPath,
		CONCAT(CONCAT('Source.', DataSource), Name) AS SourceTable
	FROM Integration.DataSets
	WHERE PostPath IS NOT NULL AND Type = 'CSV';