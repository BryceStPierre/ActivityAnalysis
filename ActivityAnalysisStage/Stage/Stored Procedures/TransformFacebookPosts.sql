CREATE PROCEDURE [Stage].[TransformFacebookPosts]
AS
	TRUNCATE TABLE [Stage].[FacebookPosts];

	INSERT INTO [Stage].[FacebookPosts] (
		[Date],
		[Description],
		[Post],
		[Link]
	) SELECT
		[timestamp] AS Date,
		CASE [title] WHEN '' THEN NULL ELSE [title] END AS Description,
		CASE [post] WHEN '' THEN NULL ELSE [post] END AS Post,
		CASE [url] WHEN '' THEN NULL ELSE [url] END AS Link
	FROM Source.FacebookPosts;
