CREATE PROCEDURE [Stage].[TransformTekSavvyInternetUsage]
AS
	TRUNCATE TABLE [Stage].[TekSavvyInternetUsage];

	INSERT INTO [Stage].[TekSavvyInternetUsage] (
		[Date],
		[OnPeakDownloads],
		[OnPeakUploads],
		[OnPeakTotal],
		[OffPeakDownloads],
		[OffPeakUploads],	
		[OffPeakTotal]
	) SELECT
		CONVERT(DATETIME, Date) AS Date,
		[On Peak Downloads GB] AS OnPeakDownloads,
		[On Peak Uploads GB] AS OnPeakUploads,
		[On Peak Total GB] AS OnPeakTotal,
		[Off Peak Downloads GB] AS OffPeakDownloads,
		[Off Peak Uploads GB] AS OffPeakUploads,
		[Off Peak Total GB] AS OffPeakTotal
	FROM Source.TekSavvyInternetUsage
	WHERE [On Peak Downloads GB] IS NOT NULL;