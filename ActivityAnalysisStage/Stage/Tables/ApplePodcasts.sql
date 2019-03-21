CREATE TABLE [Stage].[ApplePodcasts]
(
	[LastUpdated] DATETIME NULL,
	[AddedOn] DATETIME NULL,
	[FeedUrl] VARCHAR(MAX) NULL,
	[Title] VARCHAR(75) NULL,
	[Subscribed] BIT NULL,
	[LastTouchedOn] DATETIME NULL,
	[ShowType] VARCHAR(50) NULL,
)
