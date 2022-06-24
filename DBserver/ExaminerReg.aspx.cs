using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace DBserver
{
    public partial class ExaminerReg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Register_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string Name = name.Text;
            string Mail = Email.Text;
            string Fow = fow.Text;
            string Pass = Password.Text;
            Boolean Nation = National.Checked;
            if (name.Text == "" || Email.Text == "" || fow.Text == "" || Password.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;
            }
            SqlCommand ExaminerRegister = new SqlCommand("RegisterExaminer", conn);
            ExaminerRegister.CommandType = CommandType.StoredProcedure;
            ExaminerRegister.Parameters.Add(new SqlParameter("@name", SqlDbType.VarChar)).Value = Name;
            ExaminerRegister.Parameters.Add(new SqlParameter("@fieldofwork", SqlDbType.VarChar)).Value = Fow;
            ExaminerRegister.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = Mail;
            ExaminerRegister.Parameters.Add(new SqlParameter("@isnational", SqlDbType.Bit)).Value = Nation;
            ExaminerRegister.Parameters.Add(new SqlParameter("@Password", SqlDbType.VarChar)).Value = Pass;
            conn.Open();
            ExaminerRegister.ExecuteNonQuery();
            conn.Close();
            Response.Redirect("login.aspx");
        }
    }
}