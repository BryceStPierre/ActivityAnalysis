CREATE PROCEDURE [Environment].[UpdateDataSetPath]
	@DataSetName VARCHAR(95),
	@PrePath VARCHAR(250),
	@PostPath VARCHAR(250)
AS
	UPDATE Integration.DataSets SET 
		PrePath = @PrePath,
		PostPath = @PostPath,
		Updated = GETDATE()
	WHERE @DataSetName = CONCAT(DataSource, Name);
