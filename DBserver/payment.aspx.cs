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
    public partial class payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AdminIssueThesisPayment(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            if (ThesisSerialNo.Text == "" || amount.Text == ""
                 || noOfInstallments.Text == "" || fundPercentage.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";

                form1.Controls.Add(error);
                return;
            }

            int serialNum = Int16.Parse(ThesisSerialNo.Text);
            Decimal Amount = Decimal.Parse(amount.Text);
            int installments = Int16.Parse(noOfInstallments.Text);
            Decimal fundPercent = Decimal.Parse(fundPercentage.Text);

            SqlCommand IssueThesisPayment = new SqlCommand("AdminIssueThesisPayment", conn);
            IssueThesisPayment.CommandType = CommandType.StoredProcedure;
            IssueThesisPayment.Parameters.Add(new SqlParameter("@ThesisSerialNo", serialNum));
            IssueThesisPayment.Parameters.Add(new SqlParameter("@amount", Amount));
            IssueThesisPayment.Parameters.Add(new SqlParameter("@noOfInstallments", installments));
            IssueThesisPayment.Parameters.Add(new SqlParameter("@fundPercentage", fundPercent));

            SqlParameter success = IssueThesisPayment.Parameters.Add("@success", SqlDbType.Int);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            IssueThesisPayment.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Label s = new Label();
                s.Text = "Process executed successfully";
                form1.Controls.Add(s);
            }
            else
            {
                Response.Write("Something went wrong, Precess terminated");
            }
        }
    }
}