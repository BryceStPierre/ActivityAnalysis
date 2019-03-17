CREATE TABLE [Source].[ApplePodcasts] (
	[Last updated] [DATETIME] NULL,
	[Added on] [DATETIME] NULL,
	[Feed URL] [VARCHAR](MAX) NULL,
	[Title] [VARCHAR](75) NULL,
	[Subscribed?] [VARCHAR](3) NULL,
	[Last touched on] [DATETIME] NULL,
	[Show type] [VARCHAR](50) NULL,
	[Sort] [VARCHAR](15) NULL,
	[Playback newest to oldest] [VARCHAR](3) NULL
)
