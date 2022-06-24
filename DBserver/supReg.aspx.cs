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
    public partial class supReg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            if (pass.Text == "" || fac.Text == "" || email.Text == "" ||
                lname.Text == "" || fname.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill in all blanks";
                form1.Controls.Add(error);

                return;
            }

            String fn = fname.Text;
            String ln = lname.Text;
            String password = pass.Text;
            String faculty = fac.Text;
            String em = email.Text;

            SqlCommand loginproc = new SqlCommand("supervisorRegister", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@first_name", fn));
            loginproc.Parameters.Add(new SqlParameter("@last_name", ln));
            loginproc.Parameters.Add(new SqlParameter("@password", password));
            loginproc.Parameters.Add(new SqlParameter("@faculty", faculty));
            loginproc.Parameters.Add(new SqlParameter("@email", em));

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("login.aspx");

        }
    }
}