CREATE TABLE [Stage].[ApplePodcastHistory]
(
	[FeedUrl] VARCHAR(MAX) NULL,
	[EpisodeId] VARCHAR(MAX) NULL,
	[MarkedAsPlayedOn] DATETIME NULL,
	[IsNew] BIT NULL,
	[LastPlayedOn] DATETIME NULL,
	[PlaybackPosition] FLOAT NULL,
	[PlayCount] INT NULL,
	[HasBeenPlayed] BIT NULL
)
