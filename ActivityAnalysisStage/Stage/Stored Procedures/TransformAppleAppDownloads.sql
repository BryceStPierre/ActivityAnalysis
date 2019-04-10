CREATE PROCEDURE [Stage].[TransformAppleAppDownloads]
AS
	TRUNCATE TABLE [Stage].[AppleAppDownloads];

	INSERT INTO [Stage].[AppleAppDownloads] (
		[Date],
		[Name],
		[Version],
		[Developer],
		[DeviceIPAddress]
	) SELECT
		[Activity Date] AS Date,
		[Item Description] AS Name,
		[Version Text] AS Version,
		[Seller] AS Developer,
		[Device IP Address] AS DeviceIPAddress
	FROM Source.AppleAppDownloads
