<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Supervisor.aspx.cs" Inherits="DBserver.Supervisor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    
        <div>          
            <asp:Button ID="MyStudents" runat="server" Text="View My Students" OnClick="MyStudents_Click" />
        <asp:gridview runat="server" ID="Gv1" AutoGenerateColumns="true" HeaderStyle-BackColor="Red" BackColor="LightBlue"
    BorderWidth="5" BorderColor="Blue">
   </asp:gridview>  
        </div>
        <p>
            <asp:TextBox ID="ID" runat="server" Text="Enter a student ID"></asp:TextBox>
        </p>
        <asp:Button ID="Button1" runat="server" OnClick="ViewPublications" Text="View Publications"/>
        <div>          
        <asp:gridview runat="server" ID="Gv2" AutoGenerateColumns="true" HeaderStyle-BackColor="Red" BackColor="LightBlue"
    BorderWidth="5" BorderColor="Blue">
   </asp:gridview>  
        </div>
        <p>
            <asp:TextBox ID="ThesisSerialNo" runat="server" Text="Thesis Serial No"></asp:TextBox>
            </p>
        <p>
            <asp:TextBox ID="DefenseDate" runat="server" Text="Defense Date"></asp:TextBox>
            </p>
        <p>
            <asp:TextBox ID="DefenseLocation" runat="server" Text="Defense Location"></asp:TextBox>
        </p>
        <asp:Button ID="GUCIANDEFENSE" runat="server" Text="Add Defense GUCIAN" OnClick="Button2_Click" />
        <asp:Button ID="NONGUCIANDEFENSE" runat="server" Text="Add Defense NON-GUCIAN" OnClick="Button3_Click" />
        <p>
            <asp:TextBox ID="ThesisSerialNo0" runat="server" Text="Thesis Serial No"></asp:TextBox>
            </p>
        <p>
            <asp:TextBox ID="DefenseDate0" runat="server" Text="Defense Date"></asp:TextBox>
            </p>
        <asp:TextBox ID="ExaminerName" runat="server" Text="Examiner Name"></asp:TextBox>
        <p>
            <asp:TextBox ID="Password" runat="server" Text="Password"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label1" runat="server" Text="National? "></asp:Label>
            <asp:CheckBox ID="National" runat="server" />
        </p>
        <p>
            <asp:TextBox ID="fieldOfWork" runat="server" Text="Field Of Work"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="AddExaminer" runat="server" Text="Add Examiner" OnClick="AddExaminer_Click" />
        </p>
        <p>
            <asp:TextBox ID="ThesisSerialNo1" runat="server" Text="Thesis Serial No"></asp:TextBox>
        </p>
        <asp:TextBox ID="ProgressReportNo" runat="server" Text="Progress Report No"></asp:TextBox>
        <p>
            <asp:TextBox ID="Evaluation" runat="server" Text="Evaluation (0-3)"></asp:TextBox>
        </p>
        <asp:Button ID="Button2" runat="server" Text="Evaluate" OnClick="Button2_Click1" />
        <p>
            <asp:TextBox ID="ThesisSerialNo2" runat="server" Text="Thesis Serial No"></asp:TextBox>
        </p>
        <asp:Button ID="Cancel" runat="server" Text="Cancel Thesis" OnClick="Cancel_Click" />
    </form>
</body>
</html>
