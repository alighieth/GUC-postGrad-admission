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
    public partial class Supervisor : System.Web.UI.Page
    {

        DataTable table = new DataTable();
        DataRow dr;

        DataTable table1 = new DataTable();
        DataRow dr1;
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ViewPublications(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["DBServer"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            string StudentID = ID.Text;
            if (ID.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;
            }
            SqlCommand ViewSprofile = new SqlCommand("ViewAStudentPublications", conn);
            ViewSprofile.CommandType = CommandType.StoredProcedure;
            ViewSprofile.Parameters.Add(new SqlParameter("@StudentID", SqlDbType.Int)).Value = StudentID;
            SqlParameter success = ViewSprofile.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;
            conn.Open();
            ViewSprofile.ExecuteNonQuery();
            SqlDataReader rdr = ViewSprofile.ExecuteReader(CommandBehavior.CloseConnection);
            table1.Columns.Add("id", typeof(Int32));
            table1.Columns.Add("title", typeof(string));
            table1.Columns.Add("dateOfPublication", typeof(DateTime));
            table1.Columns.Add("place", typeof(string));
            table1.Columns.Add("accepted", typeof(Boolean));
            table1.Columns.Add("host", typeof(string));
            if (rdr.HasRows)
            {
                Response.Write("success");
                while (rdr.Read())
                {
                    int id = rdr.GetInt32(0);
                    string title = rdr.GetString(1);
                    DateTime dateOfPublication = rdr.GetDateTime(2);
                    string place = rdr.GetString(3);
                    Boolean accepted = rdr.GetBoolean(4);
                    string host = rdr.GetString(5);

                    dr1 = table1.NewRow();
                    dr1["id"] = id;
                    dr1["title"] = title;
                    dr1["dateOfPublication"] = dateOfPublication;
                    dr1["place"] = place;
                    dr1["accepted"] = accepted;
                    dr1["host"] = host;
                    table1.Rows.Add(dr1);
                    Gv2.DataSource = table1;
                    Gv2.DataBind();
                    ViewState["table1"] = table1;
                }
            }
            else
            {
                Response.Write("error, no publications to view");
            }
            conn.Close();

        }


        protected void Button2_Click(object sender, EventArgs e) //GUCIAN
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBServer"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string SerialNo = ThesisSerialNo.Text;
            string DefenseDay = DefenseDate.Text;
            string DefensePlace = DefenseLocation.Text;
            if (ThesisSerialNo.Text == "" || DefenseDate.Text == "" || DefenseLocation.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;
            }
            SqlCommand AddDefenseGUCIAN = new SqlCommand("AddDefenseGucian", conn);
            AddDefenseGUCIAN.CommandType = CommandType.StoredProcedure;
            AddDefenseGUCIAN.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = SerialNo;
            AddDefenseGUCIAN.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = DefenseDay;
            AddDefenseGUCIAN.Parameters.Add(new SqlParameter("@DefenseLocation", SqlDbType.VarChar)).Value = DefensePlace;
            conn.Open();
            AddDefenseGUCIAN.ExecuteNonQuery();
            Response.Write("Success");
            conn.Close();
        }

        protected void Button3_Click(object sender, EventArgs e) //NONGUCIAN
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBServer"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string SerialNo = ThesisSerialNo.Text;
            string DefenseDay = DefenseDate.Text;
            string DefensePlace = DefenseLocation.Text;
            SqlCommand AddDefenseNonGUCIAN = new SqlCommand("AddDefenseNonGucian", conn);
            AddDefenseNonGUCIAN.CommandType = CommandType.StoredProcedure;
            AddDefenseNonGUCIAN.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = SerialNo;
            AddDefenseNonGUCIAN.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = DefenseDay;
            AddDefenseNonGUCIAN.Parameters.Add(new SqlParameter("@DefenseLocation", SqlDbType.VarChar)).Value = DefensePlace;
            conn.Open();
            AddDefenseNonGUCIAN.ExecuteNonQuery();
            Response.Write("Success");
            conn.Close();
        }

        protected void AddExaminer_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBServer"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string SerialNo = ThesisSerialNo0.Text;
            string DefenseDay = DefenseDate0.Text;
            string NameExaminer = ExaminerName.Text;
            string Pass = Password.Text;
            Boolean Local = National.Checked;
            string FOW = fieldOfWork.Text;
            if (ThesisSerialNo0.Text == "" || DefenseDate0.Text == "" || ExaminerName.Text == "" || Password.Text == "" || fieldOfWork.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;
            }
            SqlCommand AddExaminer = new SqlCommand("AddExaminer", conn);
            AddExaminer.CommandType = CommandType.StoredProcedure;
            AddExaminer.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = SerialNo;
            AddExaminer.Parameters.Add(new SqlParameter("@DefenseDate", SqlDbType.DateTime)).Value = DefenseDay;
            AddExaminer.Parameters.Add(new SqlParameter("@ExaminerName", SqlDbType.VarChar)).Value = NameExaminer;
            AddExaminer.Parameters.Add(new SqlParameter("@Password", SqlDbType.VarChar)).Value = Pass;
            AddExaminer.Parameters.Add(new SqlParameter("@National", SqlDbType.Bit)).Value = Local;
            AddExaminer.Parameters.Add(new SqlParameter("@fieldOfWork", SqlDbType.VarChar)).Value = FOW;
            conn.Open();
            AddExaminer.ExecuteNonQuery();
            Response.Write("Success");
            conn.Close();
        }

        protected void Button2_Click1(object sender, EventArgs e) //Evaluate
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBServer"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string SupID = (string)Session["User"];
            string SerialNo = ThesisSerialNo1.Text;
            string ProgressReport = ProgressReportNo.Text;
            string Eval = Evaluation.Text;
            if (ThesisSerialNo1.Text == "" || ProgressReportNo.Text == "" || Evaluation.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;
            }
            SqlCommand EvaluateProgressReport = new SqlCommand("EvaluateProgressReport", conn);
            EvaluateProgressReport.CommandType = CommandType.StoredProcedure;
            EvaluateProgressReport.Parameters.Add(new SqlParameter("@supervisorID", SqlDbType.Int)).Value = SupID;
            EvaluateProgressReport.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = SerialNo;
            EvaluateProgressReport.Parameters.Add(new SqlParameter("@ProgressReportNo", SqlDbType.Int)).Value = ProgressReport;
            EvaluateProgressReport.Parameters.Add(new SqlParameter("@Evaluation", SqlDbType.Int)).Value = Eval;
            conn.Open();
            EvaluateProgressReport.ExecuteNonQuery();
            Response.Write("Success");
            conn.Close();
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBServer"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string SerialNo = ThesisSerialNo2.Text;
            if (ThesisSerialNo2.Text == "")
            {
                Label error = new Label();
                error.Text = "Fill all blanks";
                form1.Controls.Add(error);

                return;
            }
            SqlCommand CancelThesis = new SqlCommand("CancelThesis", conn);
            CancelThesis.CommandType = CommandType.StoredProcedure;
            CancelThesis.Parameters.Add(new SqlParameter("@ThesisSerialNo", SqlDbType.Int)).Value = SerialNo;
            conn.Open();
            CancelThesis.ExecuteNonQuery();
            Response.Write("Success");
            conn.Close();
        }

        protected void MyStudents_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["DBServer"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand ViewSupStudentsYears = new SqlCommand("ViewSupStudentsYears", conn);
            ViewSupStudentsYears.CommandType = CommandType.StoredProcedure;

            ViewSupStudentsYears.Parameters.Add(new SqlParameter("@supervisorID", SqlDbType.VarChar)).Value = Session["user"];

            conn.Open();
            SqlDataReader rdr = ViewSupStudentsYears.ExecuteReader(CommandBehavior.CloseConnection);
            table.Columns.Add("first_name", typeof(string));
            table.Columns.Add("last_name", typeof(string));
            table.Columns.Add("years", typeof(Int32));
            if (rdr.HasRows)
            {
                Response.Write("success");
                while (rdr.Read())
                {
                    string firstName = rdr.GetString(0);
                    string lastName = rdr.GetString(1);
                    int years = rdr.GetInt32(2);

                    dr = table.NewRow();
                    dr["first_Name"] = firstName;
                    dr["last_Name"] = lastName;
                    dr["years"] = years;
                    table.Rows.Add(dr);
                    Gv1.DataSource = table;
                    Gv1.DataBind();
                    ViewState["table1"] = table;
                }
            }
            else
            {
                Response.Write("error");
            }

            conn.Close();
        }

    }
}
