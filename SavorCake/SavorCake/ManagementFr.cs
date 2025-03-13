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
    public partial class ManagementFr: Form
    {
        public ManagementFr()
        {
            InitializeComponent();
            lblTitle.Text = "Trang chủ";
            this.PnlHome.Controls.Clear();
            HomeFr home = new HomeFr() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            home.FormBorderStyle = FormBorderStyle.None;
            this.PnlHome.Controls.Add(home);
            home.Show();
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void btn_Home_Click(object sender, EventArgs e)
        {
            lblTitle.Text = "Trang chủ";
            this.PnlHome.Controls.Clear();
            HomeFr home = new HomeFr() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            home.FormBorderStyle = FormBorderStyle.None;
            this.PnlHome.Controls.Add(home);
            home.Show();

        }

        private void ManagementFr_Load(object sender, EventArgs e)
        {

        }

        private void pictureBox3_Click(object sender, EventArgs e)
        {
            Home afterlogin = new Home();
            afterlogin.StartPosition = FormStartPosition.CenterScreen; // Hiển thị giữa màn hình
            afterlogin.Show();
            this.Hide(); // Ẩn AfterLoginFr nếu cần
        }

        private void btn_Cake_Click(object sender, EventArgs e)
        {
            lblTitle.Text = "Quản lý bánh ngọt";
            this.PnlHome.Controls.Clear();
            CakeFr cakeFr = new CakeFr() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            cakeFr.FormBorderStyle = FormBorderStyle.None;
            this.PnlHome.Controls.Add(cakeFr);
            cakeFr.Show();
        }

        private void btn_ingredient_Click(object sender, EventArgs e)
        {
            lblTitle.Text = "Quản lý nguyên liệu";
            this.PnlHome.Controls.Clear();
            ingredientFr ingFr = new ingredientFr() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            ingFr.FormBorderStyle = FormBorderStyle.None;
            this.PnlHome.Controls.Add(ingFr);
            ingFr.Show();
        }

        private void btn_employees_Click(object sender, EventArgs e)
        {
            lblTitle.Text = "Quản lý nhân viên";
            this.PnlHome.Controls.Clear();
            employeesFr empFr = new employeesFr() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            empFr.FormBorderStyle = FormBorderStyle.None;
            this.PnlHome.Controls.Add(empFr);
            empFr.Show();
        }

        private void btn_finance_Click(object sender, EventArgs e)
        {
            lblTitle.Text = "Quản lý tài chính";
            this.PnlHome.Controls.Clear();
            FinanceFr finFr = new FinanceFr() { Dock = DockStyle.Fill, TopLevel = false, TopMost = true };
            finFr.FormBorderStyle = FormBorderStyle.None;
            this.PnlHome.Controls.Add(finFr);
            finFr.Show();
        }
    }
}
