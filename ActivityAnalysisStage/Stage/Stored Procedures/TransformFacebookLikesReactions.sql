CREATE PROCEDURE [Stage].[TransformFacebookLikesReactions]
AS
	TRUNCATE TABLE [Stage].[FacebookLikesReactions]

	INSERT INTO [Stage].[FacebookLikesReactions] (
		[Date],
		[Description],
		[Reaction],
		[ContentType],
		[ContentSource]
	) SELECT 
		[timestamp] AS Date,
		[title] AS Description,
		[reaction] AS Reaction,
		CASE
			WHEN CHARINDEX(':', dbo.STRINGBETWEEN([title], '''s ', '.')) <> 0
				THEN dbo.STRINGBETWEEN([title], '''s ', ':')
			WHEN CHARINDEX(' ', dbo.STRINGBETWEEN([title], '''s ', '.')) <> 0
				THEN dbo.STRINGBETWEEN([title], '''s ', ' ')
			ELSE
				dbo.STRINGBETWEEN([title], '''s ', '.')
		END AS ContentType,
		CASE 
			WHEN CHARINDEX('liked ', [title]) <> 0 
				THEN dbo.STRINGBETWEEN([title], 'liked ', '''')
			WHEN CHARINDEX('likes ', [title]) <> 0  
				THEN dbo.STRINGBETWEEN([title], 'likes ', '''')
			WHEN CHARINDEX('reacted to ', [title]) <> 0  
				THEN dbo.STRINGBETWEEN([title], 'reacted to ', '''')
			ELSE NULL
		END AS ContentSource
	FROM Source.FacebookLikesReactions;
