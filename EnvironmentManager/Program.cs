using System;
using System.IO;
using System.Threading;
using System.Data.SqlClient;

using EnvironmentManager.Properties;

namespace EnvironmentManager
{
    class Program
    {
        static void Main (string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("You must provide the name of the meta database.");
                Thread.Sleep(5000);
                Environment.Exit(-1);
            }

            EnsureDirectoriesExist(args[0]);
            Thread.Sleep(5000);
            Environment.Exit(0);
        }


        static void EnsureDirectoriesExist (string metaDatabaseName)
        {
            using (SqlConnection connection = new SqlConnection(GetConnectionString(metaDatabaseName)))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(Resources.DirectoriesQuery, connection))
                {
                    SqlDataReader reader = command.ExecuteReader();
                    try
                    {
                        while (reader.Read())
                        {
                            string path = String.Format("{0}", reader[0]);
                            string yearPart = String.Format("{0}", reader[1]);
                            string monthPart = String.Format("{0}", reader[2]);
                            string namePart = String.Format("{0}", reader[3]);

                            path = Path.Join(path, yearPart);
                            path = Path.Join(path, monthPart);
                            path = Path.Join(path, namePart);

                            DirectoryInfo d = Directory.CreateDirectory(path);
                            Console.WriteLine("Created {0}.", d.FullName);
                        }
                    }
                    finally
                    {
                        reader.Close();
                    }
                }
            }
        }

        static string GetConnectionString(string database) => $"Data Source=localhost;Initial Catalog={database};Trusted_Connection=True";
    }
}
