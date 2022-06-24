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
    public partial class addgrade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr1 = WebConfigurationManager.ConnectionStrings["DBPostGradOffice"].ToString();

            SqlConnection con = new SqlConnection(connStr1);
            SqlCommand AddDefenseGrade = new SqlCommand("AddDefenseGrade", con);

            String thesisserialno = serialno.Text;
            String defedate = defencedate.Text;
            String grad = grade.Text;
            AddDefenseGrade.CommandType = CommandType.StoredProcedure;
            AddDefenseGrade.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = thesisserialno;
            AddDefenseGrade.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defedate;
            AddDefenseGrade.Parameters.Add(new SqlParameter("@grade", SqlDbType.Decimal)).Value = grad;
            SqlParameter success = AddDefenseGrade.Parameters.Add("@success", System.Data.SqlDbType.Bit);
            success.Direction = System.Data.ParameterDirection.Output;

            con.Open();
            AddDefenseGrade.ExecuteNonQuery();
            con.Close();
        }
    }
}