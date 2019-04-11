CREATE PROCEDURE [Stage].[TransformFacebookLoginActivity]
AS
	TRUNCATE TABLE [Stage].[FacebookLoginActivity];
	
	INSERT INTO [Stage].[FacebookLoginActivity] (
		[Date],
		[Action],
		[Type],
		[IPAddress]
	) SELECT 
		[timestamp] AS Date,
		[action] AS Action,
		CASE LEFT([site], CHARINDEX('.', [site]) - 1)
			WHEN 'www' THEN 'Web'
			WHEN 'm' THEN 'Mobile'
			ELSE NULL
		END AS Type,
		[ip_address] AS IPAddress
	FROM Source.FacebookLoginActivity;