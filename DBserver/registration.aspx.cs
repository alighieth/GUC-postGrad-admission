using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DBserver
{
    public partial class registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASnon(object sender, EventArgs e)
        {
            Response.Redirect("StudentRegister.aspx");
        }
        protected void ASsup(object sender, EventArgs e)
        {
            Response.Redirect("supReg.aspx");
        }
        protected void ASadmin(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerReg.aspx");
        }
        protected void ASgucian(object sender, EventArgs e)
        {
            Response.Redirect("StudentRegister.aspx");
        }
    }
}