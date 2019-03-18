CREATE PROCEDURE [Integration].[UpdateDataSetPath]
	@DataSetName VARCHAR(95),
	@Path VARCHAR(250)
AS
	UPDATE Integration.DataSets SET 
		Path = @Path,
		Updated = GETDATE()
	WHERE @DataSetName = CONCAT(DataSource, Name);
