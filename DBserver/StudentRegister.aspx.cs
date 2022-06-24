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
    public partial class StudentRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Register_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBPostGradOffice"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string Fname = Stufname.Text;
            string Lname = Stulname.Text;
            string Mail = StuEmail.Text;
            string Fac = Stufacuilty.Text;
            string Pass = StuPassword.Text;
            string address = Address.Text;
            Boolean GUC = GUCIAN.Checked;

            if (Stufname.Text == ""  || Stulname.Text == "" || StuEmail.Text == "" || Stufacuilty.Text == ""
                || StuPassword.Text == "" || Address.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;

            }
            SqlCommand studentRegister = new SqlCommand("studentRegister", conn);
            studentRegister.CommandType = CommandType.StoredProcedure;
            studentRegister.Parameters.Add(new SqlParameter("@first_name", SqlDbType.VarChar)).Value = Fname;
            studentRegister.Parameters.Add(new SqlParameter("@last_name", SqlDbType.VarChar)).Value = Lname;
            studentRegister.Parameters.Add(new SqlParameter("@faculty", SqlDbType.VarChar)).Value = Fac;
            studentRegister.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = Pass;
            studentRegister.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = Mail;
            studentRegister.Parameters.Add(new SqlParameter("@address", SqlDbType.VarChar)).Value = address;
            studentRegister.Parameters.Add(new SqlParameter("@Gucian", SqlDbType.Bit)).Value = GUC;
            conn.Open();
            studentRegister.ExecuteNonQuery();
            conn.Close();
            Response.Redirect("login.aspx");
        }
    }
}