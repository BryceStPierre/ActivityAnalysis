CREATE VIEW [Integration].[DataSetMappings] AS 
	SELECT
		Path,
		CONCAT('Source.' + DataSource, Name) AS SourceTable
	FROM Integration.DataSets;
