TRUNCATE TABLE [dbo].[Constants]
GO
SET IDENTITY_INSERT [dbo].[Constants] ON 
GO
INSERT [dbo].[Constants] ([Id], [Name], [Value], [Updated], [Created]) VALUES (1, N'DataDirectory', N'C:\Users\bryce\Data', GETDATE(), GETDATE())
GO
SET IDENTITY_INSERT [dbo].[Constants] OFF
GO