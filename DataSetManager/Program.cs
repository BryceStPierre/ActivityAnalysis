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
        const string ACTIVE = "__Active";
        const string ARCHIVE = "__Archive";

        static string dataPath;
        static string activePath;
        static string archivePath;

        static void Main (string[] args)
        {
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            Console.WriteLine(" Activity Analysis: Data Set Manager ");
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

            // Get data directory path, and ensure it's created.
            ArrayList qDataDirectory = ExecuteReader(Resources.DataDirectoryQuery);
            
            if (qDataDirectory.Count == 0)
            {
                Console.WriteLine("No data set directory has been configured.");
                Exit(-1);
            }

            dataPath = (string)qDataDirectory[0];
            activePath = Path.Join(dataPath, ACTIVE);
            archivePath = Path.Join(dataPath, ARCHIVE);
            
            Directory.CreateDirectory(activePath);
            Directory.CreateDirectory(archivePath);
            
            Console.WriteLine("Data set directory: {0}", dataPath);
            Console.WriteLine("Active data set directory: {0}", activePath);
            Console.WriteLine("Archive data set directory: {0}\n", archivePath);

            bool loadDataSets = InputYesOrNo("Would you like to load new data sets?");
            if (loadDataSets)
            {
                ArchiveDataSets();
                LoadDataSets();
                Exit(0);
            }

            bool resetDataDirectory = InputYesOrNo("Would you like to reset the environment?");
            if (resetDataDirectory)
            {
                ResetDataDirectory();
            }

            // Exit program successfully.
            Exit(0);
        }

        static void LoadDataSets ()
        {
            List<string> allDirs = new List<string>(Directory.EnumerateDirectories(dataPath));
            allDirs.Remove(Path.Join(dataPath, ACTIVE));
            allDirs.Remove(Path.Join(dataPath, ARCHIVE));

            foreach (string d in allDirs)
            {
                DirectoryInfo di = new DirectoryInfo(d);
                string targetPath = Path.Join(activePath, di.Name);
                Directory.CreateDirectory(Path.Join(activePath, di.Name));

                List<string> allFiles = new List<string>(Directory.EnumerateFiles(d));
                foreach (string f in allFiles)
                {
                    FileInfo fi = new FileInfo(f);
                    string targetFile = Path.Join(targetPath, fi.Name);
                    File.Copy(f, targetFile, true);

                    string query = Resources.UpdateDataSetPathQuery.Replace("1", fi.Directory.Name);
                    query = query.Replace("2", targetFile);
                    ExecuteNonQuery(query);
                }
            }
        }
        
        static void ResetDataDirectory ()
        {
            // Delete folders and files in main data folder.
            List<string> allDirs = new List<string>(Directory.EnumerateDirectories(dataPath));
            allDirs.Remove(Path.Join(dataPath, ACTIVE));
            allDirs.Remove(Path.Join(dataPath, ARCHIVE));
            foreach (string d in allDirs)
            {
                Directory.Delete(d, true);
                Console.WriteLine("Deleted directory: {0}", d);
            }

            ArrayList qDirectories = ExecuteReader(Resources.DirectoriesQuery);
            foreach (string d in qDirectories)
            {
                string path = Path.Join(dataPath, d);
                Directory.CreateDirectory(path);
                Console.WriteLine("Created source directory: {0}", path);
            }
        }

        static void ArchiveDataSets ()
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
        }

        static bool InputYesOrNo (string message)
        {
            string response = "";
            while (!response.Equals("y") && !response.Equals("Y") && !response.Equals("n") && !response.Equals("N"))
            {
                Console.Write("{0} (y/n): ", message);
                response = Console.ReadLine();
            }
            return response.Equals("y") || response.Equals("Y");
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
    }
}
