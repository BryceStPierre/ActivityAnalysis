CREATE PROCEDURE [Stage].[TransformNetflixViewingHistory]
AS
	TRUNCATE TABLE [Stage].[NetflixViewingHistory];

	INSERT INTO [Stage].[NetflixViewingHistory] (
		[Title],
		[Season],
		[Episode],
		[ContentType],
		[Date]
	) SELECT
		CASE WHEN CHARINDEX('Season', [Title]) > 0 
			THEN LEFT([Title], CHARINDEX('Season', [Title]) - 3)
			ELSE [Title] 
		END AS Title,
		CASE WHEN CHARINDEX('Season', [Title]) > 0 
			THEN CONVERT(SMALLINT, RIGHT(LEFT(RIGHT([Title], LEN([Title]) - CHARINDEX('Season', [Title]) + 1), 8), 1))
			ELSE NULL 
		END AS Season,
		CASE WHEN CHARINDEX('Season', [Title]) > 0 
			THEN RIGHT([Title], LEN([Title]) - CHARINDEX('Season', [Title]) - 9)
			ELSE NULL
		END AS Episode,
		CASE WHEN CHARINDEX('Season', [Title]) > 0 THEN 'Series' ELSE 'Film/Documentary' END AS ContentType,
		[Date] AS Date
	FROM Source.NetflixViewingHistory;