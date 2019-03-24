CREATE TABLE [Stage].[NetflixViewingHistory]
(
	[Title] VARCHAR(150) NOT NULL,
	[Season] SMALLINT NULL,
	[Episode] VARCHAR(100) NULL,
	[ContentType] VARCHAR(25) NOT NULL,
	[Date] DATETIME NOT NULL
)
