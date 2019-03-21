CREATE PROCEDURE [Stage].[LoadApplePodcastHistory]
AS
	INSERT INTO [Stage].[ApplePodcastHistory] (
		[FeedUrl],
		[EpisodeId],
		[MarkedAsPlayedOn],
		[IsNew],
		[LastPlayedOn],
		[PlaybackPosition],
		[PlayCount],
		[HasBeenPlayed]
	) SELECT
		REPLACE([Feed URL], '"', '') AS FeedUrl,
		REPLACE([Episode ID], '"', '') AS EpisodeId,
		CONVERT(DATETIME, [Marked as played on]) AS MarkedAsPlayedOn,
		CASE [Is New?] WHEN 'Yes' THEN 1 ELSE 0 END AS IsNew,
		CONVERT(DATETIME, [Last played on]) AS LastPlayedOn,
		CONVERT(FLOAT, [Playback position]) AS PlaybackPosition,
		CONVERT(INT, [Play count]) AS PlayCount,
		CASE [Has been played?] WHEN 'Yes' THEN 1 ELSE 0 END AS HasBeenPlayed
	FROM Source.ApplePodcastHistory
	WHERE [Visible?] IS NULL 
		AND ([Marked as played on] IS NOT NULL OR [Last played on] IS NOT NULL);