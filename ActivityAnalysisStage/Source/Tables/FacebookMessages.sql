CREATE TABLE [Source].[FacebookMessages]
(
	[timestamp] DATETIME NULL,
	[sender_name] VARCHAR(75) NULL,
	[content] VARCHAR(MAX) NULL,
	[link] VARCHAR(MAX) NULL,
	[type] VARCHAR(15) NULL
)
