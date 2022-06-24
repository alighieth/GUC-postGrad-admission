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
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            string password = String.Format("{0}", Request.Form["password"]);
            string username = String.Format("{0}", Request.Form["username"]);

            if (username == "" || password =="")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;
            }

            int id = Int16.Parse(username);
            String pass = password;

            SqlCommand loginproc = new SqlCommand("userLogin", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@id", id));
            loginproc.Parameters.Add(new SqlParameter("@password", pass));

            SqlParameter success = loginproc.Parameters.Add("@success", SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();
            Session["user"] = id;

            if(success.Value.ToString() == "1")
            {
                if (type.Value.ToString() == "0")
                {
                    Response.Redirect("Student.aspx");
                }
                else if (type.Value.ToString() == "1")//admin
                {
                    Response.Redirect("admin.aspx");
                }
                else if (type.Value.ToString() == "2")//Super
                {
                    Response.Redirect("Supervisor.aspx");
                }
                else if (type.Value.ToString() == "3")//examiner
                {
                    Response.Redirect("examinermain.aspx");
                }
            }
            else
            {
                Response.Write("Failed to find user");
            }
        }
        protected void Registration(object sender, EventArgs e)
        {
            Response.Redirect("registration.aspx");
        }
        protected void emailReg(object sender, EventArgs e)
        {
            Response.Redirect("EmailReg.aspx");
        }
        protected void Addno(object sender, EventArgs e)
        {
            Response.Redirect("addnumber.aspx");
        }

    }
}