using System;
using System.IO;
using System.Threading;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;

using DataSetManager.Properties;

namespace DataSetManager
{
    class Program
    {
        static void Main (string[] args)
        {
            const string ACTIVE = "__Active";
            const string ARCHIVE = "__Archive";

            string dataPath;
            string activePath;
            string archivePath;

            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            Console.WriteLine("Activity Analysis: Data Set Manager");
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

            // Get data directory path, and ensure it's created.
            ArrayList qDataDirectory = ExecuteReader(Resources.DataDirectoryQuery);
            
            if (qDataDirectory.Count == 0)
            {
                Console.WriteLine("No data set directory has been configured.");
                Exit(-1);
            }

            dataPath = (string)qDataDirectory[0];
            Console.WriteLine("Data set directory: {0}", dataPath);

            activePath = Path.Join(dataPath, ACTIVE);
            archivePath = Path.Join(dataPath, ARCHIVE);

            Directory.CreateDirectory(activePath);
            Console.WriteLine("Active data set directory: {0}", activePath);
            Directory.CreateDirectory(archivePath);
            Console.WriteLine("Archive data set directory: {0}\n", archivePath);

            string YN = "";
            while (!YN.Equals("y") && !YN.Equals("Y") && !YN.Equals("n") && !YN.Equals("N"))
            {
                Console.Write("Would you like to archive the active data sets, and reset? (y/n): ");
                YN = Console.ReadLine();
            }

            bool archiveDataSets = YN.Equals("y") || YN.Equals("Y");
            // Archive current data sets in active directory, then clear it.
            if (archiveDataSets)
            {
                List<string> allDirs = new List<string>(Directory.EnumerateDirectories(activePath));
                foreach (string d in allDirs)
                {
                    DirectoryInfo di = new DirectoryInfo(d);
                    string targetDirectory = Path.Join(archivePath, di.Name);
                    //Console.WriteLine(targetDirectory);
                    Directory.CreateDirectory(targetDirectory);

                    List<string> allFiles = new List<string>(Directory.EnumerateFiles(d));
                    foreach (string f in allFiles)
                    {
                        FileInfo fi = new FileInfo(f);
                        string targetFileName = fi.Name.Replace(fi.Extension, "") + "_" + DateTime.Now.ToShortDateString() + fi.Extension;
                        string targetPath = Path.Join(targetDirectory, targetFileName);

                        File.Copy(f, targetPath, true);
                        Console.WriteLine("Archived file: {0}", targetPath);
                    }

                    Console.WriteLine("To be deleted: {0}", d);
                    Directory.Delete(d, true);
                }
                Console.WriteLine("Data has been archived.");

                // Delete folders and files in main data folder.
                allDirs = new List<string>(Directory.EnumerateDirectories(dataPath));
                foreach (string d in allDirs)
                {
                    DirectoryInfo di = new DirectoryInfo(d);
                    if (!di.Name.Equals(ACTIVE) && !di.Name.Equals(ARCHIVE))
                    {
                        Directory.Delete(d, true);
                    }
                }

                ArrayList qDirectories = ExecuteReader(Resources.DirectoriesQuery);
            }

            YN = "";
            while (!YN.Equals("y") && !YN.Equals("Y") && !YN.Equals("n") && !YN.Equals("N"))
            {
                Console.Write("Would you like to load new data sets? (y/n): ");
                YN = Console.ReadLine();
            }

            bool loadNewDataSets = YN.Equals("y") || YN.Equals("Y");
            //
            if (loadNewDataSets)
            {

            }

            // Exit program successfully.
            Exit(0);
        }

        static ArrayList ExecuteReader (string query)
        {
            ArrayList results = new ArrayList();

            using (SqlConnection connection = new SqlConnection(Resources.ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                try
                {
                    while (reader.Read())
                    {
                        results.Add(reader[0]);
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("SQLDataReader exception: {0}.", e.Message);
                }
                finally
                {
                    reader.Close();
                }
            }
            return results;
        }

        static int ExecuteNonQuery(string query)
        {
            int rowsAffected = -1;

            using (SqlConnection connection = new SqlConnection(Resources.ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();

                try
                {
                    rowsAffected = command.ExecuteNonQuery();
                }
                catch (Exception e)
                {
                    Console.WriteLine("SQLCommand exception: {0}.", e.Message); 

                }
            }
            return rowsAffected;
        }

        static void Exit(int code)
        {
            Console.WriteLine("\nExiting...");
            Thread.Sleep(5000);
            Environment.Exit(code);
        }

        /*
         * static ArrayList VerifyDirectories ()
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
         * 
         * */
    }
}
