CREATE TABLE [Source].[ApplePodcastHistory] (
	[Feed URL] [VARCHAR](200) NULL,
	[Episode ID] [VARCHAR](200) NULL,
	[Visible?] [VARCHAR](3) NULL,
	[Marked as played on] [DATETIME] NULL,
	[Manually set] [VARCHAR](3) NULL,
	[Is New?] [VARCHAR](3) NULL,
	[Last played on] [DATETIME] NULL,
	[Playback position] [FLOAT] NULL,
	[Play count] [INT] NULL,
	[Has been played?] [VARCHAR](3) NULL
)
