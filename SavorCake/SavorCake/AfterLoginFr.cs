using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SavorCake
{
    public partial class Home : Form
    {
        public Home()
        {
            InitializeComponent();
            
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox3_Click(object sender, EventArgs e)
        {
            ManagementFr managementForm = new ManagementFr();
            managementForm.StartPosition = FormStartPosition.CenterScreen; // Hiển thị giữa màn hình
            managementForm.Show();
            this.Hide(); // Ẩn AfterLoginFr nếu cần
        }

        private void pictureBox4_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
