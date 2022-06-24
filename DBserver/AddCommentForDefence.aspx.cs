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
    public partial class AddCommentForDefence : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr1 = WebConfigurationManager.ConnectionStrings["DBPostGradOffice"].ToString();
            SqlConnection con = new SqlConnection(connStr1);
            SqlCommand AddCommentsGrade = new SqlCommand("AddCommentsGrade", con);
            String x1 = serialno.Text;
            String defedate = defencedate.Text;
            String comm = comment.Text;

            AddCommentsGrade.CommandType = CommandType.StoredProcedure;
            AddCommentsGrade.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = x1;
            AddCommentsGrade.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = defedate;
            AddCommentsGrade.Parameters.Add(new SqlParameter("@comments", SqlDbType.VarChar)).Value = comm;
            SqlParameter success = AddCommentsGrade.Parameters.Add("@success", System.Data.SqlDbType.Bit);
            success.Direction = System.Data.ParameterDirection.Output;


            con.Open();
            AddCommentsGrade.ExecuteNonQuery();
            con.Close();
        }
    }
}
