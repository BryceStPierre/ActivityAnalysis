using System;
using System.Threading;
using System.Data.SqlClient;

namespace EnvironmentManager
{
    class Program
    {
        static void Main (string[] args)
        {
            if (args.Length < 1)
            {
                Console.WriteLine("You must provide the path to the main data sources directory.");
                Thread.Sleep(5000);
                Environment.Exit(0);
            }
            //Console.WriteLine(args[0]);
            


            using (SqlConnection connection = new SqlConnection(GetConnectionString()))
            {
                SqlCommand command = new SqlCommand("SELECT * FROM dbo.Test", connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                try
                {
                    while (reader.Read())
                    {
                        Console.WriteLine(String.Format("{0}, {1}",
                            reader[0], reader[1]));
                    }
                }
                finally
                {
                    // Always call Close when done reading.
                    reader.Close();
                }
            }
            Thread.Sleep(5000);
        }

        static string GetConnectionString ()
        {
            //return "Data Source=localhost;Initial Catalog=ActivityDatabaseMeta_DEV;Trusted_Connection=True;User Id=" + Environment.UserName;
            return "Data Source=localhost;Initial Catalog=ActivityDatabaseMeta_DEV;Trusted_Connection=True";
        }
    }
}
