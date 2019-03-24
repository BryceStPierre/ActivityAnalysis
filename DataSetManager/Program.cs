using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;

using DataSetManager.Properties;

namespace DataSetManager
{
    class Program
    {
        const string ACTIVE = "__ACTIVE";
        const string ARCHIVE = "__ARCHIVE";
        const string PRE = "__PRE";
        const string POST = "__POST";

        static string inputPath;
        static string processingPath;
        static string prePath; 
        static string postPath;
        static string archivePath;

        static void Main (string[] args)
        {
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            Console.WriteLine(" Activity Analysis: Data Set Manager ");
            Console.WriteLine("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

            ArrayList qPaths = ExecuteReader(Resources.PathsQuery);
            if (qPaths.Count < 2)
            {
                Console.WriteLine("Either the input or processing directory has not been configured.");
                Exit(-1);
            }

            inputPath = (string)qPaths[0];
            processingPath = (string)qPaths[1];

            prePath = Path.Join(Path.Join(processingPath, ACTIVE), PRE);
            postPath = Path.Join(Path.Join(processingPath, ACTIVE), POST);
            archivePath = Path.Join(processingPath, ARCHIVE);

            Directory.CreateDirectory(inputPath);
            Directory.CreateDirectory(prePath);
            Directory.CreateDirectory(postPath);
            Directory.CreateDirectory(archivePath);
            
            Console.WriteLine("Input data set directory: {0}", inputPath);
            Console.WriteLine("Pre-conversion data set directory: {0}", prePath);
            Console.WriteLine("Post-conversion data set directory: {0}", postPath);
            Console.WriteLine("Archive data set directory: {0}\n", archivePath);

            bool loadInputDataSets = InputYesOrNo("Would you like to load new input data sets?");
            if (loadInputDataSets)
            {
                Console.WriteLine("Archiving past data sets...");
                ArchivePastDataSets();
                Console.WriteLine("Loading new input data sets...");
                LoadInputDataSets();
                Exit(0);
            }

            bool resetInputDirectory = InputYesOrNo("Would you like to reset the input directory?");
            if (resetInputDirectory)
            {
                Console.WriteLine("Resetting input directory...");
                ResetInputDirectory();
            }
            
            Exit(0);
        }

        static void LoadInputDataSets ()
        {
            DeleteSubdirectories(prePath);
            
            List<string> dList = new List<string>(Directory.EnumerateDirectories(inputPath));
            foreach (string d in dList)
            {
                DirectoryInfo di = new DirectoryInfo(d);
                string targetDirectoryPre = Path.Join(prePath, di.Name);
                string targetDirectoryPost = Path.Join(postPath, di.Name);
                Directory.CreateDirectory(targetDirectoryPre);
                Directory.CreateDirectory(targetDirectoryPost);

                List<string> fList = new List<string>(Directory.EnumerateFiles(d));
                foreach (string f in fList)
                {
                    FileInfo fi = new FileInfo(f);
                    string targetPathPre = Path.Join(targetDirectoryPre, fi.Name);
                    File.Copy(f, targetPathPre, true);

                    string textFile = fi.Name.Replace(fi.Extension, "") + ".txt";
                    string targetPathPost = Path.Join(targetDirectoryPost, textFile);

                    string query = Resources.UpdateDataSetPathQuery.Replace("1", fi.Directory.Name);
                    query = query.Replace("2", targetPathPre);
                    query = query.Replace("3", targetPathPost);
                    ExecuteNonQuery(query);

                    Console.WriteLine("Loaded data set: {0}", targetPathPre);
                }
            }
        }
        
        static void ArchivePastDataSets ()
        {
            List<string> dList = new List<string>(Directory.EnumerateDirectories(postPath));
            foreach (string d in dList)
            {
                // Ensure matching directory is created in ARCHIVE.
                DirectoryInfo di = new DirectoryInfo(d);
                string targetDirectory = Path.Join(archivePath, di.Name);
                Directory.CreateDirectory(targetDirectory);

                // Copy each file to each matching directory, adding the date to the filename.
                List<string> fList = new List<string>(Directory.EnumerateFiles(d));
                foreach (string f in fList)
                {
                    FileInfo fi = new FileInfo(f);
                    string targetFileName = fi.Name.Replace(fi.Extension, "") + "_" + DateTime.Now.ToShortDateString() + fi.Extension;
                    string targetPath = Path.Join(targetDirectory, targetFileName);

                    File.Copy(f, targetPath, true);
                    Console.WriteLine("Archived file: {0}", targetPath);
                }
                
                Directory.Delete(d, true);
                Console.WriteLine("Deleted directory: {0}", d);
            }
            Console.WriteLine("Past data sets have been archived.\n");
        }
        
        static void ResetInputDirectory()
        {
            DeleteSubdirectories(inputPath);

            ArrayList qDirectories = ExecuteReader(Resources.DirectoriesQuery);
            foreach (string d in qDirectories)
            {
                string path = Path.Join(inputPath, d);
                Directory.CreateDirectory(path);
                Console.WriteLine("Created input data set directory: {0}", path);
            }
            Console.WriteLine("Reset input directory.\n");
        }

        static void DeleteSubdirectories (string path)
        {
            List<string> dList = new List<string>(Directory.EnumerateDirectories(path));
            foreach (string d in dList)
            {
                Directory.Delete(d, true);
                Console.WriteLine("Deleted directory: {0}", d);
            }
        }

        static bool InputYesOrNo (string message)
        {
            string r = "";
            while (!r.Equals("y") && !r.Equals("Y") && !r.Equals("n") && !r.Equals("N"))
            {
                Console.Write("{0} (y/n): ", message);
                r = Console.ReadLine();
            }
            return r.Equals("y") || r.Equals("Y");
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
            Console.Write("Press any key to exit... ");
            Console.ReadLine();
            Environment.Exit(code);
        }
    }
}
