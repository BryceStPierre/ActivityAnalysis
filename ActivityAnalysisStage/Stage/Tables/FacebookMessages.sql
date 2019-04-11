CREATE TABLE [Stage].[FacebookMessages]
(
	[Date] DATETIME NULL,
	[Sender] VARCHAR(100) NULL,
	[Message] VARCHAR(MAX) NULL,
	[MessageType] VARCHAR(15) NULL,
	[HasLink] BIT NULL
)
