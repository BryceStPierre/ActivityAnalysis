CREATE PROCEDURE [Stage].[TransformFacebookComments]
AS
	TRUNCATE TABLE [Stage].[FacebookComments];

	INSERT INTO [Stage].[FacebookComments] (
		[Date],
		[Description],
		[ContentAuthor],
		[ContentType],
		[CommentType],
		[Comment]
	) SELECT
		[timestamp] AS Date, 
		[title] AS Description,
		CASE 
			WHEN CHARINDEX('commented on ', [title]) <> 0 
				THEN dbo.STRINGBETWEEN([title], 'commented on ', '''')
			WHEN CHARINDEX('replied to ', [title]) <> 0  
				THEN dbo.STRINGBETWEEN([title], 'replied to ', '''')
			ELSE NULL
		END AS ContentAuthor,
		CASE
			WHEN CHARINDEX('''s ', [title]) <> 0
				THEN SUBSTRING(
					RIGHT([title], LEN([title]) - CHARINDEX('''s ', [title]) - LEN('''s ')),
					0,
					CHARINDEX('.', RIGHT([title], LEN([title]) - CHARINDEX('''s ', [title]) - LEN('''s ')))
				)
			ELSE NULL
		END AS ContentType,
		CASE 
			WHEN CHARINDEX('commented on ', [title]) <> 0 THEN 'Comment'
			WHEN CHARINDEX('replied to ', [title]) <> 0 THEN 'Reply'
			ELSE NULL
		END AS CommentType,
		[comment] AS Comment
	FROM Source.FacebookComments;
