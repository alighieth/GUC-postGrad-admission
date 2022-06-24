<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminerReg.aspx.cs" Inherits="DBserver.ExaminerReg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Examiner Register"></asp:Label>
        </div>

    <p>
        <asp:TextBox ID="name" runat="server" Text="Name"></asp:TextBox>
    </p>
    <p>
        <asp:TextBox ID="fow" runat="server" Text="Field Of Work"></asp:TextBox>
    </p>
    <p>
        <asp:TextBox ID="Email" runat="server" Text="Email"></asp:TextBox>
    </p>
    <p>
<asp:TextBox ID="Password" runat="server" Text="Password"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="Label2" runat="server" Text="National?"></asp:Label>
        <asp:CheckBox ID="National" runat="server" />
    </p>
    <p>
    <asp:Button ID="Register" runat="server" Text="Register" OnClick="Register_Click" />
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    </form>
</body>
</html>
