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
    public partial class extend : System.Web.UI.Page
    {
        private object loginproc;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submittion(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            if(ThesisNo.Text=="")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";

                form1.Controls.Add(error);
                return;
            }
            int serialNum = Int16.Parse(ThesisNo.Text);


            SqlCommand courses = new SqlCommand("AdminUpdateExtension", conn);
            courses.CommandType = CommandType.StoredProcedure;

            courses.Parameters.Add(new SqlParameter("@ThesisSerialNo", serialNum));
            
            conn.Open();
            courses.ExecuteNonQuery();
            conn.Close();

            Response.Write("Done");

        }
    }
}