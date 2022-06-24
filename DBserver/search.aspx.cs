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
    public partial class search : System.Web.UI.Page
    {
        DataTable table = new DataTable();
        DataRow rdr;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr1 = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            SqlConnection con = new SqlConnection(connStr1);
            String ser = TextBox1.Text;
            SqlCommand search3 = new SqlCommand("search3", con);
            search3.CommandType = CommandType.StoredProcedure;
            search3.Parameters.Add(new SqlParameter("@keyword", SqlDbType.VarChar)).Value = ser;

            con.Open();
            search3.ExecuteNonQuery();
            SqlDataReader reader = search3.ExecuteReader(CommandBehavior.CloseConnection);

            table.Columns.Add("serialNumber", typeof(int));
            table.Columns.Add("field", typeof(string));
            table.Columns.Add("type", typeof(string));
            table.Columns.Add("title", typeof(string));
            table.Columns.Add("startDate", typeof(string));
            table.Columns.Add("endDate", typeof(string));
            table.Columns.Add("defenceDate", typeof(string));
            table.Columns.Add("years", typeof(int));
            table.Columns.Add("grade", typeof(decimal));
            table.Columns.Add("payment_id", typeof(int));
            table.Columns.Add("noOfExtensions", typeof(int));
            while (reader.Read())
            {
                int serialNumber = reader.GetInt32(0);
                string field = reader.GetString(1);
                string type = reader.GetString(2);
                string title = reader.GetString(3);
                DateTime startDate = reader.GetDateTime(4);
                DateTime endDate = reader.GetDateTime(5);
                DateTime defenceDate = reader.GetDateTime(6);
                int years = reader.GetInt32(7);
                decimal grade = reader.GetDecimal(8);
                int payment_id = reader.GetInt32(9);
                int noOfExtentions = reader.GetInt32(10);

                rdr = table.NewRow();
                rdr["serialNumber"] = serialNumber;
                rdr["field"] = field;
                rdr["type"] = type;
                rdr["title"] = title;
                rdr["startDate"] = startDate;
                rdr["endDate"] = endDate;
                rdr["defenceDate"] = defenceDate;
                rdr["years"] = years;
                rdr["grade"] = grade;
                rdr["payment_id"] = payment_id;
                rdr["noOfExtensions"] = noOfExtentions;
                table.Rows.Add(rdr);
                Gv1.DataSource = table;
                Gv1.DataBind();
                ViewState["table1"] = table;
            }
            con.Close();








        }
    }
}