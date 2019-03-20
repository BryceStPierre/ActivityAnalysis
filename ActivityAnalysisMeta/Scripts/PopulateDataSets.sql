TRUNCATE TABLE [Integration].[DataSets]
GO
SET IDENTITY_INSERT [Integration].[DataSets] ON 
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [Description], [Path], [Updated], [Created]) VALUES (1, N'Apple', N'Podcasts', N'Podcasts', N'CSV', N'My podcast subscriptions.', NULL, GETDATE(), GETDATE())
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Type], [Description], [Path], [Updated], [Created]) VALUES (2, N'Apple', N'PodcastHistory', N'Podcast History', N'CSV', N'My podcast playstate history.', NULL, GETDATE(), GETDATE())
GO
SET IDENTITY_INSERT [Integration].[DataSets] OFF
GO