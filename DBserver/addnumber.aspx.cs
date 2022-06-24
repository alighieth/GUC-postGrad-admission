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
    public partial class addnumber : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string Id = ID.Text;
            string num = Number.Text;
            if (ID.Text == "" || Number.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;
            }
            SqlCommand addMobile = new SqlCommand("addMobile", conn);
            addMobile.CommandType = CommandType.StoredProcedure;
            addMobile.Parameters.Add(new SqlParameter("@ID", SqlDbType.VarChar)).Value = Id;
            addMobile.Parameters.Add(new SqlParameter("@mobile_number", SqlDbType.VarChar)).Value = num;
            conn.Open();
            addMobile.ExecuteNonQuery();
            conn.Close();
            Response.Redirect("login.aspx");
        }
    }
}