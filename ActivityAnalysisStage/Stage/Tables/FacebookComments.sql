CREATE TABLE [Stage].[FacebookComments]
(
	[Date] DATETIME NULL,
	[Description] VARCHAR(200) NULL,
	[ContentAuthor] VARCHAR(100) NULL,
	[ContentType] VARCHAR(25) NULL,
	[CommentType] VARCHAR(25) NULL,
	[Comment] VARCHAR(MAX) NULL
)
