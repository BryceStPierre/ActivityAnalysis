CREATE PROCEDURE [Stage].[LoadApplePodcasts]
AS
	TRUNCATE TABLE [Stage].[ApplePodcasts];

	INSERT INTO [Stage].[ApplePodcasts] (
		[LastUpdated],
		[AddedOn],
		[FeedUrl],
		[Title],
		[Subscribed],
		[LastTouchedOn],
		[ShowType]
	) SELECT 
		CONVERT(DATETIME, [Last updated]) AS LastUpdated,
		CONVERT(DATETIME, [Added on]) AS AddedOn,
		REPLACE([Feed URL], '"', '') AS FeedUrl,
		REPLACE([Title], '"', '') AS Title,
		CASE [Subscribed?] WHEN 'Yes' THEN 1 ELSE 0 END AS Subscribed,
		CONVERT(DATETIME, [Last touched on]) AS LastTouchedOn,
		[Show type] AS ShowType
	FROM Source.ApplePodcasts;
