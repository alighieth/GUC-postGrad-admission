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
    public partial class Installments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AdminIssueInstallPayment(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            if (paymentID.Text == "" || InstallStartDate.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";

                form1.Controls.Add(error);
                return;
            }

            int id = Int16.Parse(paymentID.Text);
            DateTime date = DateTime.Parse(InstallStartDate.Text);

            SqlCommand loginproc = new SqlCommand("AdminIssueInstallPayment", conn);
            loginproc.CommandType = CommandType.StoredProcedure;
            loginproc.Parameters.Add(new SqlParameter("@paymentID", id));
            loginproc.Parameters.Add(new SqlParameter("@InstallStartDate", date));

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();
        }
    }
}