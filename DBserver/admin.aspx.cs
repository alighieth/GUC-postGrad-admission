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
    
    public partial class admin : System.Web.UI.Page
    {
        DataTable table = new DataTable();
        DataRow dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void supervisors(object sender, EventArgs e)
        {
            /*Response.Redirect("supervisors.aspx");*/
            /*DONE*/

            int empID;
            string email, password, Name, faculty;

            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand courses = new SqlCommand("AdminListSup", conn);
            courses.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = courses.ExecuteReader(CommandBehavior.CloseConnection);


            if (rdr.HasRows)
            {
                table.Columns.Add("Employer_ID", typeof(Int32));
                table.Columns.Add("Name", typeof(String));
                table.Columns.Add("email", typeof(String));
                table.Columns.Add("faculty", typeof(String));
                table.Columns.Add("password", typeof(String));
                while (rdr.Read()) //whenever it is true mean that there is still a row to read
                {

                    empID = rdr.GetInt32(0);
                    Name = rdr.GetString(3);
                    email = rdr.GetString(1);
                    faculty = rdr.GetString(4);
                    password = rdr.GetString(2);

                    dr = table.NewRow();
                    dr["Employer_ID"] = empID;
                    dr["Name"] = Name;
                    dr["email"] = email;
                    dr["faculty"] = faculty;
                    dr["password"] = password;
                    table.Rows.Add(dr);
                    Gv1.DataSource = table;
                    Gv1.DataBind();
                    ViewState["table1"] = table;
                }
            }
            else
            {
                Response.Write("No rows to show");
            }
        }
        protected void ThesisList(object sender, EventArgs e)
        {
            int serialNumber, years, payment_id, noOfExtensions;
            string field, type, title ;
            DateTime startDate, endDate,
                defenseDate;
            Decimal grade;


            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand courses = new SqlCommand("AdminViewAllTheses", conn);
            courses.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = courses.ExecuteReader(CommandBehavior.CloseConnection);


            if (rdr.HasRows)
            {
                table.Columns.Add("serialNumber", typeof(Int32));
                table.Columns.Add("field", typeof(String));
                table.Columns.Add("type", typeof(String));
                table.Columns.Add("title", typeof(String));
                table.Columns.Add("startDate", typeof(DateTime));
                table.Columns.Add("endDate", typeof(DateTime));
                table.Columns.Add("defenseDate", typeof(DateTime));
                table.Columns.Add("years", typeof(Int32));
                table.Columns.Add("grade", typeof(decimal));
                table.Columns.Add("payment_id", typeof(Int32));
                table.Columns.Add("noOfExtensions", typeof(Int32));
                while (rdr.Read()) //whenever it is true mean that there is still a row to read
                {
                    serialNumber = rdr.GetInt32(0);
                    field = rdr.GetString(1);
                    type = rdr.GetString(2);
                    title = rdr.GetString(3);
                    startDate = rdr.GetDateTime(4);
                    endDate = rdr.GetDateTime(5);
                    defenseDate = rdr.GetDateTime(6);
                    years = rdr.GetInt32(7);
                    grade = rdr.GetDecimal(8);
                    payment_id = rdr.GetInt32(9);
                    noOfExtensions = rdr.GetInt32(10);


                    dr = table.NewRow();
                    dr["serialNumber"] = serialNumber;
                    dr["field"] = field;
                    dr["type"] = type;
                    dr["title"] = title;
                    dr["startDate"] = startDate;
                    dr["endDate"] = endDate;
                    dr["startDate"] = startDate;
                    dr["defenseDate"] = defenseDate;
                    dr["years"] = years;
                    dr["grade"] = grade;
                    dr["payment_id"] = payment_id;
                    dr["noOfExtensions"] = noOfExtensions;
                    table.Rows.Add(dr);
                    Gv1.DataSource = table;
                    Gv1.DataBind();
                    ViewState["table1"] = table;

                }
            }
            else
            {
                Response.Write("No rows to show");
            }
        }

        protected void ThesisCount(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand courses = new SqlCommand("AdminViewOnGoingTheses", conn);
            courses.CommandType = CommandType.StoredProcedure;

            SqlParameter count = courses.Parameters.Add("@thesesCount", SqlDbType.Int);
            count.Direction = ParameterDirection.Output;

            conn.Open();
            courses.ExecuteNonQuery();
            conn.Close();

            Gv1.Controls.Clear();
            Label name = new Label();
            name.Text = "Number of ongoing thesis:  " + count.Value.ToString();
            form1.Controls.Add(name);
        }

        protected void InstlIssue(object sender, EventArgs e)
        {
            Response.Redirect("Installments.aspx");
        }

        

        protected void PymntIssue(object sender, EventArgs e)
        {
            Response.Redirect("payment.aspx");
        }

        protected void extend(object sender, EventArgs e)
        {
            Response.Redirect("extend.aspx");
        }
        
    }
}