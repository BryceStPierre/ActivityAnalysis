CREATE PROCEDURE [Stage].[TransformFacebookMessages]
AS
	TRUNCATE TABLE [Stage].[FacebookMessages];

	INSERT INTO [Stage].[FacebookMessages] (
		[Date],
		[Sender],
		[Message],
		[MessageType],
		[HasLink]
	) SELECT
		[timestamp] AS Date,
		[sender_name] AS Sender,
		[content] AS Message,
		[type] AS MessageType,
		CASE [link] WHEN '' THEN 0 ELSE 1 END AS HasLink
	FROM Source.FacebookMessages;
