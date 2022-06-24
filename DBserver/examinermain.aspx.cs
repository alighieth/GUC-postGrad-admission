using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DBserver
{
    public partial class examinermain : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCommentForDefence.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("addgrade.aspx");

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("Examinerchangeinfo.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Redirect("LIST.aspx");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Redirect("search.aspx");
        }
    }
}