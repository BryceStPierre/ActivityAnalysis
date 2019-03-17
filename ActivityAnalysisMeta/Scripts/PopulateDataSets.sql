SET IDENTITY_INSERT [Integration].[DataSets] ON 
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Description], [Path], [Updated], [Created]) VALUES (1, N'Apple', N'Podcasts', N'Podcasts', N'My podcast subscriptions.', N'C:\Users\bryce\Data\2019\03\ApplePodcasts\Your Podcasts.csv', CAST(N'2019-03-09T09:39:35.967' AS DateTime), CAST(N'2019-03-09T09:39:35.967' AS DateTime))
GO
INSERT [Integration].[DataSets] ([Id], [DataSource], [Name], [Label], [Description], [Path], [Updated], [Created]) VALUES (2, N'Apple', N'PodcastHistory', N'Podcast History', N'My podcast playstate history.', N'C:\Users\bryce\Data\2019\03\ApplePodcastHistory\Podcasts Playstate.csv', CAST(N'2019-03-09T09:40:47.623' AS DateTime), CAST(N'2019-03-09T09:40:47.623' AS DateTime))
GO
SET IDENTITY_INSERT [Integration].[DataSets] OFF
GO