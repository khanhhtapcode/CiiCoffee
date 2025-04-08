using DuAnQuanLyQuancafe.function;
using DuAnQuanLyQuancafe.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Windows.Forms;

namespace DuAnQuanLyQuancafe.Controller
{
    internal class NhanVienController
    {

        // Phương thức lấy danh sách nhân viên từ cơ sở dữ liệu
        public List<NhanVienModel> LaydanhsachNhanVien()
        {
            List<NhanVienModel> NhanVien = new List<NhanVienModel>();

            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                string query = "SELECT * FROM NhanVien";

                SqlCommand cmd = new SqlCommand(query, conn);
                using (SqlDataReader reader = cmd.ExecuteReader())

                {
                    while (reader.Read())
                    {
                        NhanVien.Add(new NhanVienModel
                        {
                            MaNV = Convert.ToInt32(reader["MaNV"]),
                            TenNV = reader["TenNV"].ToString(),
                            DiaChi = reader["DiaChi"] as string,  // Nếu NULL sẽ trả về null thay vì lỗi
                            GioiTinh = reader["GioiTinh"] as string,
                            NgaySinh = reader["NgaySinh"] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(reader["NgaySinh"]),
                            SDT = reader["SDT"] as string,
                            MaQue = reader["MaQue"] == DBNull.Value ? (int?)null : Convert.ToInt32(reader["MaQue"]),
                            Anh = reader["Anh"] == DBNull.Value ? null : (byte[])reader["Anh"]
                        });
                    }
                }
            }

            return NhanVien;
        }
        public static List<QueModel> LayMaQue()
        {
            List<QueModel> queList = new List<QueModel>();
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();

                string query = "SELECT MaQue, TenQue FROM Que";
                SqlCommand cmd = new SqlCommand(query, conn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        queList.Add(new QueModel
                        {
                            MaQue = reader["MaQue"].ToString(),
                            TenQue = reader["TenQue"].ToString()
                        });
                    }
                }
            }
            return queList;
        }
        public static void ThemNhanVien(Hashtable parameter)
        {
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {

                try
                {
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    string querry = "INSERT INTO NhanVien (TenNV, DiaChi, GioiTinh, NgaySinh, SDT, MaQue, Anh) VALUES (@TenNV, @DiaChi, @GioiTinh, @NgaySinh, @SDT, @MaQue, @Anh)";
                    using (SqlCommand cmd = new SqlCommand(querry, conn))
                    {
                        cmd.Parameters.AddWithValue("@TenNV", parameter["TenNV"]);
                        cmd.Parameters.AddWithValue("@DiaChi", parameter["DiaChi"]);
                        cmd.Parameters.AddWithValue("@GioiTinh", parameter["GioiTinh"]);
                        cmd.Parameters.AddWithValue("@NgaySinh", parameter["NgaySinh"]);
                        cmd.Parameters.AddWithValue("@SDT", parameter["SDT"]);
                        cmd.Parameters.AddWithValue("@MaQue", parameter["MaQue"]);
                        cmd.Parameters.AddWithValue("@Anh", parameter["Anh"] ?? DBNull.Value); // Nếu ảnh là null thì truyền DBNull.Value
                        cmd.ExecuteNonQuery();
                    }

                }
                catch (Exception ex)
                {
                    MessageBox.Show("Lỗi khi thêm nhân viên: " + ex.Message);
                }
                finally
                {
                    if (conn.State == ConnectionState.Open)
                    {
                        conn.Close();
                    }
                }
            }
        }
        public void XoaNhanVien(int maNV)
        {
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                string query = "DELETE FROM NhanVien WHERE MaNV = @MaNV";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaNV", maNV);
                cmd.ExecuteNonQuery();
            }
        }

        public void SuaNhanVien(Hashtable parameter)
        {
            using (SqlConnection conn = DatabaseHelper.GetConnection())
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }

                try
                {
                    string query = @"UPDATE NhanVien 
                             SET TenNV = @TenNV, DiaChi = @DiaChi, GioiTinh = @GioiTinh, 
                                 NgaySinh = @NgaySinh, SDT = @SDT, MaQue = @MaQue, Anh = @Anh 
                             WHERE MaNV = @MaNV";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TenNV", parameter["TenNV"]);
                        cmd.Parameters.AddWithValue("@DiaChi", parameter["DiaChi"]);
                        cmd.Parameters.AddWithValue("@GioiTinh", parameter["GioiTinh"]);
                        cmd.Parameters.AddWithValue("@NgaySinh", parameter["NgaySinh"]);
                        cmd.Parameters.AddWithValue("@SDT", parameter["SDT"]);
                        cmd.Parameters.AddWithValue("@MaQue", parameter["MaQue"]);
                        cmd.Parameters.AddWithValue("@Anh", parameter["Anh"] ?? DBNull.Value); // Nếu ảnh null thì dùng DBNull
                        cmd.Parameters.AddWithValue("@MaNV", parameter["MaNV"]);

                        // THỰC THI câu lệnh cập nhật
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            MessageBox.Show("Cập nhật nhân viên thành công.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                        else
                        {
                            MessageBox.Show("Không tìm thấy nhân viên để cập nhật.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                        }
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Lỗi khi sửa nhân viên: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                finally
                {
                    if (conn.State == ConnectionState.Open)
                    {
                        conn.Close();
                    }
                }
            }
        }

        public List<NhanVienModel> TimKiemNhanVien(string tuKhoa)
        {
            List<NhanVienModel> danhSachNhanVien = LaydanhsachNhanVien();
            return danhSachNhanVien
                   .Where(nv => nv.TenNV.ToLower().Contains(tuKhoa.ToLower()))
                   .ToList();
        }

    }
}