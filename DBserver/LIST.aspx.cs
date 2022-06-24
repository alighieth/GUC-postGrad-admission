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
    public partial class LIST : System.Web.UI.Page
    {
        DataTable table = new DataTable();
        DataRow rdr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBPostGradOffice"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand examinerview = new SqlCommand("examinerview", conn);
            examinerview.CommandType = CommandType.StoredProcedure;
            string id = TextBox1.Text;
            examinerview.Parameters.Add(new SqlParameter("@examinerID", SqlDbType.Int)).Value = id;
            SqlParameter success = examinerview.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = System.Data.ParameterDirection.Output;
            conn.Open();
            examinerview.ExecuteNonQuery();
            SqlDataReader reader = examinerview.ExecuteReader(CommandBehavior.CloseConnection);
            table.Columns.Add("Supervisor name", typeof(string));
            table.Columns.Add("title", typeof(string));
            table.Columns.Add("student firstName", typeof(string));
            while (reader.Read())
            {
                string name = reader.GetString(0);
                string title = reader.GetString(1);
                string firstName = reader.GetString(2);
                rdr = table.NewRow();
                rdr["Supervisor name"] = name;
                rdr["title"] = title;
                rdr["student firstName"] = firstName;
                table.Rows.Add(rdr);
                Gv1.DataSource = table;
                Gv1.DataBind();
                ViewState["table1"] = table;
            }
            conn.Close();
        }
    }
}