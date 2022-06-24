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
    public partial class Examinerchangeinfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void CHANGE(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBPostGradOffice"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand updatenamefield = new SqlCommand("updatenamefield", conn);
            updatenamefield.CommandType = CommandType.StoredProcedure;
            String name = NAME.Text;
            String fieldOfWork = FIELDOFWORK.Text;
            String id = TextBox1.Text;

            updatenamefield.Parameters.Add(new SqlParameter("@name", SqlDbType.VarChar)).Value = name;
            updatenamefield.Parameters.Add(new SqlParameter("@fieldOfWork", SqlDbType.VarChar)).Value = fieldOfWork;
            updatenamefield.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = id;
            SqlParameter success = updatenamefield.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            updatenamefield.ExecuteNonQuery();
            conn.Close();
        }
    }
}