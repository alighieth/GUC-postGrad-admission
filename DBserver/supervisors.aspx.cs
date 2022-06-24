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
    public partial class supervisors : System.Web.UI.Page
    {
        DataTable table = new DataTable();
        DataRow dr;
        protected void Page_Load(object sender, EventArgs e)
        { 
            int empID;
            string email, password, Name, faculty;

            string connStr = WebConfigurationManager.ConnectionStrings["DBserver"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand courses = new SqlCommand("AdminListSup", conn);
            courses.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr = courses.ExecuteReader(CommandBehavior.CloseConnection);

            Console.WriteLine(Environment.NewLine + "Retrieving data from database..." + Environment.NewLine);
            Console.WriteLine("Retrieved records:");

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

                    /*String courseName = rdr.GetString(rdr.GetOrdinal("code"));
                    Label name = new Label();
                    name.Text = courseName;
                    form1.Controls.Add(name);*/
                }
            }
            else
            {
                Response.Write("No rows to show");
            }
            
        }
    }
}