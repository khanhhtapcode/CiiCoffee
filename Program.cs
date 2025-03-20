using System;
using System.Configuration;
using System.Data.SqlClient;

class Program
{
    static void Main()
    {
        string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        Console.WriteLine("Chuỗi kết nối: " + connString);

        try
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                Console.WriteLine("✅ Kết nối thành công!");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("❌ Lỗi kết nối: " + ex.Message);
        }
    }
}
