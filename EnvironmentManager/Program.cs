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
            Console.WriteLine("----------------------------------------");
            Console.WriteLine(" Activity Analysis: Environment Manager ");
            Console.WriteLine("----------------------------------------\n");
            Thread.Sleep(1000);

            // Verify the directories are created.
            Console.WriteLine("Verifying directories are created...");
            ArrayList directories = VerifyDirectories();
            Console.WriteLine("Finished verifying directories.\n");

            // Scan the directories for dataset files.
            Console.WriteLine("Scanning directories...");
            ScanDirectories(directories);
            Console.WriteLine("Finished scanning directories.\n");

            Thread.Sleep(5000);
            Environment.Exit(0);
        }

        static ArrayList VerifyDirectories ()
        {
            using (SqlConnection connection = new SqlConnection(Resources.ConnectionString))
            {
                connection.Open();
                ArrayList directories = new ArrayList();
                SqlCommand command = new SqlCommand(Resources.UpdatePathWithDirectoryQuery, connection);
                SqlDataReader reader = command.ExecuteReader();
                try
                {
                    while (reader.Read())
                    {
                        string path = String.Format("{0}", reader[0]);

                        bool writeLine = !Directory.Exists(path);
                        DirectoryInfo d = Directory.CreateDirectory(path);

                        if (writeLine)
                            Console.WriteLine("Created directory: {0}.", d.FullName);

                        directories.Add(path);
                    }
                }
                finally
                {
                    reader.Close();
                }
                return directories;
            }
        }

        static void ScanDirectories (ArrayList directories)
        {
            using (SqlConnection connection = new SqlConnection(Resources.ConnectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand();
                command.Connection = connection;

                foreach (string path in directories)
                {
                    string[] files = Directory.GetFiles(path);

                    if (files.Length > 0)
                    {
                        string filePath = files[0];
                        DirectoryInfo info = new DirectoryInfo(path);
                        string dataSetName = info.Name;

                        string baseQuery = Resources.UpdatePathWithFileQuery;
                        string query = baseQuery.Replace("1", filePath);
                        query = query.Replace("2", dataSetName);
                        
                        command.CommandText = query;
                        command.ExecuteNonQuery();
                        Console.WriteLine("Found {0} data set: {1}.", dataSetName, filePath);
                    }
                }
            }
        }
    }
}
