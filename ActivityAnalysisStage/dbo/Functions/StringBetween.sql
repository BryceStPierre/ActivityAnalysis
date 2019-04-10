CREATE FUNCTION [dbo].[STRINGBETWEEN]
(
	@string VARCHAR(MAX),
	@start VARCHAR(50),
	@end VARCHAR(50)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @index INT, @length INT;
	
	SET @index = CHARINDEX(@start, @string) + LEN(@start) + 1;
	SET @length = CHARINDEX(@end, @string) - CHARINDEX(@start, @string) - LEN(@start) - 1;

	IF @index < 0 OR @length < 0 OR (@index + @length > LEN(@string))
		RETURN NULL;

	RETURN SUBSTRING(@string, @index, @length);
END
