using System;
using System.IO;
using System.Threading;
using System.Collections;
using System.Data.SqlClient;

using EnvironmentManager.Properties;

namespace EnvironmentManager
{
    class Program
    {
        static void Main (string[] args)
        {
            //if (args.Length < 1)
            //{
            //    Console.WriteLine("You must provide the name of the meta database.");
            //    Thread.Sleep(5000);
            //    Environment.Exit(-1);
            //}

            ArrayList directoryList = GetDirectoryList();
            //CreateDirectories(directoryList);

            ScanDirectories(directoryList);

            Thread.Sleep(5000);
            Environment.Exit(0);
        }

        static ArrayList GetDirectoryList ()
        {
            using (SqlConnection connection = new SqlConnection(Resources.ConnectionString))
            {
                connection.Open();
                ArrayList directoryList = new ArrayList();
                SqlCommand command = new SqlCommand(Resources.DirectoriesQuery, connection);
                SqlDataReader reader = command.ExecuteReader();
                try
                {
                    while (reader.Read())
                    {
                        string path = String.Format("{0}", reader[0]);
                        string year = String.Format("{0}", reader[1]);
                        string month = String.Format("{0}", reader[2]);
                        string name = String.Format("{0}", reader[3]);

                        path = Path.Join(path, year);
                        path = Path.Join(path, month);
                        path = Path.Join(path, name);

                        directoryList.Add(path);
                    }
                }
                finally
                {
                    reader.Close();
                }
                return directoryList;
            }
        }

        static void CreateDirectories (ArrayList directoryList)
        {
            foreach(string path in directoryList)
            {
                bool writeLine = !Directory.Exists(path);
                DirectoryInfo d = Directory.CreateDirectory(path);

                if (writeLine)
                    Console.WriteLine("Created {0}.", d.FullName);
            }
        }

        static void ScanDirectories (ArrayList directoryList)
        {
            using (SqlConnection connection = new SqlConnection(Resources.ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand();
                command.Connection = connection;

                foreach (string path in directoryList)
                {
                    string[] files = Directory.GetFiles(path);
                    if (files.Length > 0)
                    {
                        DirectoryInfo d = new DirectoryInfo(path);
                        string updateQuery = $"UPDATE Integration.DataSets SET Path = '{files[0]}' WHERE Name = '{d.Name}'";

                        Console.WriteLine("Found file {0}.", files[0]);

                        command.CommandText = updateQuery;
                        command.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}
