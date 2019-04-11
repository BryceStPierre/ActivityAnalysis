CREATE PROCEDURE [Stage].[TransformGoogleBrowserHistory]
AS
	TRUNCATE TABLE [Stage].[GoogleBrowserHistory];
	
	INSERT INTO [Stage].[GoogleBrowserHistory] (
		[Date],
		[Title],
		[Website],
		[URL]
	) SELECT
		[date] AS Date,
		[title] AS Title,
		CASE WHEN CHARINDEX('www.', dbo.STRINGBETWEEN([url], '://', '/')) <> 0
			THEN SUBSTRING(dbo.STRINGBETWEEN([url], '://', '/'), 5, LEN(dbo.STRINGBETWEEN([url], '://', '/')) - 4)
			ELSE dbo.STRINGBETWEEN([url], '://', '/')
		END AS Website,
		[url] AS URL
	FROM Source.GoogleBrowserHistory
	WHERE [url] <> 'chrome://newtab/' AND [url] <> 'about:blank#blocked';