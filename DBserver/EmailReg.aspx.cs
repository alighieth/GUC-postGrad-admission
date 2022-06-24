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
    public partial class EmailReg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void emailRegister(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            if (pass.Text == "" || email.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill in all blanks";
                form1.Controls.Add(error);

                return;
            }
            String password = (pass.Text);
            String em = email.Text;

            SqlCommand loginproc = new SqlCommand("emailLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value=em;
            loginproc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = password;

            
            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();
            Response.Write(type.Value.ToString());
            if (success.Value.ToString() == "1")
            {
                if(type.Value.ToString() == "0")
                {
                    Response.Redirect("student.aspx");
                }
                else if (type.Value.ToString() == "1")
                {
                    Response.Redirect("admin.aspx");
                }
                else if (type.Value.ToString() == "2")
                {
                    Response.Redirect("admin.aspx");
                }
                else if (type.Value.ToString() == "3")
                {
                    Response.Redirect("admin.aspx");
                }

            }
            else
            {
                Response.Write("Email or Password invalid");
            }
        }
    }
}