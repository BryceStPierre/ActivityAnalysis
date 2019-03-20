CREATE VIEW [Integration].[CsvDataSets] AS 
	SELECT
		Path, CONCAT('Source.' + DataSource, Name) AS SourceTable
	FROM Integration.DataSets
	WHERE Path IS NOT NULL AND Type = 'CSV';