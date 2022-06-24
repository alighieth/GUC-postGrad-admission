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
    public partial class Student : System.Web.UI.Page
    {
        DataTable table = new DataTable();
        DataRow dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void theses(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Student"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand Mythese = new SqlCommand("allmytheses ", conn);
            Mythese.CommandType = CommandType.StoredProcedure;

            Mythese.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Session["user"];

            conn.Open();
            Mythese.ExecuteNonQuery();
            SqlDataReader rdr = Mythese.ExecuteReader(CommandBehavior.CloseConnection);
            table.Columns.Add("serialnumber", typeof(int));
            table.Columns.Add("field", typeof(String));
            table.Columns.Add("type", typeof(String));
            table.Columns.Add("title", typeof(String));
            table.Columns.Add("startDate", typeof(String));
            table.Columns.Add("endDate", typeof(String));
            table.Columns.Add("defenceDate", typeof(String));
            table.Columns.Add("years", typeof(int));
            table.Columns.Add("grade", typeof(decimal));
            table.Columns.Add("payment_id", typeof(int));
            table.Columns.Add("noOfExtentions", typeof(int));




            while (rdr.Read())
            {
                int serialnumber = rdr.GetInt32(0);
                string field = rdr.GetString(1);
                string type = rdr.GetString(2);
                string title = rdr.GetString(3);
                string startDate = rdr.GetString(4);
                string endDate = rdr.GetString(5);
                string defenceDate = rdr.GetString(6);
                int years = rdr.GetInt32(7);
                decimal grade = rdr.GetDecimal(8);
                int payment_id = rdr.GetInt32(9);
                int noOfExtentions = rdr.GetInt32(10);

                dr = table.NewRow();
                dr["serialnumber"] = serialnumber;
                dr["field"] = field;
                dr["type"] = type;
                dr["title"] = title;
                dr["startDate"] = startDate;
                dr["endDate"] = endDate;
                dr["defenceDate"] = defenceDate;
                dr["years"] = years;
                dr["grade"] = grade;
                dr["payment_id"] = payment_id;
                dr["noOfExtentions"] = noOfExtentions;



                table.Rows.Add(dr);
                Gv1.DataSource = table;
                Gv1.DataBind();
                ViewState["table1"] = table;
            }
        }
        // My profile 

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Student"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand view = new SqlCommand("viewMyProfile", conn);
            view.CommandType = CommandType.StoredProcedure;

            view.Parameters.Add(new SqlParameter("@studentId", SqlDbType.Int)).Value = Session["user"];

            conn.Open();
            view.ExecuteNonQuery();
            SqlDataReader rdr = view.ExecuteReader(CommandBehavior.CloseConnection);
            table.Columns.Add("id", typeof(int));
            table.Columns.Add("firstName", typeof(String));
            table.Columns.Add("lastName", typeof(String));
            table.Columns.Add("type", typeof(String));
            table.Columns.Add("faculty", typeof(String));
            table.Columns.Add("address", typeof(String));
            table.Columns.Add("GPA", typeof(decimal));
            table.Columns.Add("undergradeID", typeof(String));
            table.Columns.Add("email", typeof(String));


            while (rdr.Read())
            {
                int id = rdr.GetInt32(0);
                String firstName = rdr.GetString(1);
                String lastName = rdr.GetString(2);
                String type = rdr.GetString(3);
                String faculty = rdr.GetString(4);
                String address = rdr.GetString(5);
                decimal GPA = rdr.GetDecimal(6);
                String undergradeID = rdr.GetString(7);
                String email = rdr.GetString(8);

                dr = table.NewRow();
                dr["id"] = id;
                dr["firstName"] = firstName;
                dr["lastName"] = lastName;
                dr["type"] = type;
                dr["faculty"] = faculty;
                dr["address"] = address;
                dr["GPA"] = GPA;
                dr["undergradeID"] = undergradeID;
                dr["email"] = email;

                table.Rows.Add(dr);
                Gv1.DataSource = table;
                Gv1.DataBind();
                ViewState["table1"] = table;

            }
        }
        // list grades and courses 
        protected void Button3_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Student"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand viewgrades = new SqlCommand("ViewCoursesGrades", conn);
            viewgrades.CommandType = CommandType.StoredProcedure;

            viewgrades.Parameters.Add(new SqlParameter("@studentId", SqlDbType.Int)).Value = 9;

            conn.Open();
            viewgrades.ExecuteNonQuery();
            SqlDataReader rdr = viewgrades.ExecuteReader(CommandBehavior.CloseConnection);
            table.Columns.Add("grade", typeof(decimal));

            while (rdr.Read())
            {
                decimal grade = rdr.GetDecimal(0);

                dr = table.NewRow();
                dr["grade"] = grade;

                table.Rows.Add(dr);
                Gv1.DataSource = table;
                Gv1.DataBind();
                ViewState["table1"] = table;
            }

        }

        protected void Button4_Click(object sender, EventArgs e)
        {

            string connStr = WebConfigurationManager.ConnectionStrings["Student"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand addpub = new SqlCommand("addPublication", conn);

            String x = TextBox1.Text;

            addpub.CommandType = CommandType.StoredProcedure;

            addpub.Parameters.Add(new SqlParameter("@title", SqlDbType.VarChar)).Value = x;

            conn.Open();
            addpub.ExecuteNonQuery();
            conn.Close();
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Student"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand linkpub1 = new SqlCommand("linkPubThesis", conn);

            String x1 = TextBox2.Text;
            String x2 = TextBox3.Text;

            linkpub1.CommandType = CommandType.StoredProcedure;

            linkpub1.Parameters.Add(new SqlParameter("@PubID", SqlDbType.Int)).Value = x1;

            linkpub1.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = x2;

            conn.Open();
            linkpub1.ExecuteNonQuery();
            conn.Close();

        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Student"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand Addreport = new SqlCommand("AddProgressReport", conn);

            String x3 = TextBox4.Text;
            String x4 = TextBox5.Text;
            String x5 = TextBox6.Text;
            String x6 = TextBox7.Text;

            Addreport.CommandType = CommandType.StoredProcedure;

            Addreport.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = x3;

            Addreport.Parameters.Add(new SqlParameter("@progressReportDate", SqlDbType.DateTime)).Value = x4;

            Addreport.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = x5;

            Addreport.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = x6;

            conn.Open();
            Addreport.ExecuteNonQuery();
            conn.Close();
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Student"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand Fillreport = new SqlCommand("FillProgressReport", conn);

            String x7 = TextBox8.Text;
            String x8 = TextBox9.Text;
            String x9 = TextBox10.Text;
            String x10 = TextBox11.Text;
            String x11 = TextBox12.Text;

            Fillreport.CommandType = CommandType.StoredProcedure;

            Fillreport.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = x7;

            Fillreport.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = x8;

            Fillreport.Parameters.Add(new SqlParameter("@state", SqlDbType.Int)).Value = x9;

            Fillreport.Parameters.Add(new SqlParameter("@description", SqlDbType.VarChar)).Value = x10;

            Fillreport.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = x11;

            conn.Open();
            Fillreport.ExecuteNonQuery();
            conn.Close();
        }
    }
}