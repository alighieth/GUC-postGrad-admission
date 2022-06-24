<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentRegister.aspx.cs" Inherits="DBserver.StudentRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Student Register"></asp:Label>
        </div>
</body>
    <p>
        <asp:TextBox ID="Stufname" runat="server" Text="First Name"></asp:TextBox>
    </p>
    <p>
        <asp:TextBox ID="Stulname" runat="server" Text="Last Name"></asp:TextBox>
    </p>
    <p>
        <asp:TextBox ID="StuEmail" runat="server" Text="Email"></asp:TextBox>
    </p>
    <p>
        <asp:TextBox ID="Stufacuilty" runat="server" Text="Facuilty"></asp:TextBox>
    </p>
    <p>
<asp:TextBox ID="StuPassword" runat="server" Text="Password"></asp:TextBox>
    </p>
    <p>
        <asp:TextBox ID="Address" runat="server" Text="Address"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="Label2" runat="server" Text="GUCIAN?"></asp:Label>
        <asp:CheckBox ID="GUCIAN" runat="server" />
    </p>
    <p>
    <asp:Button ID="Register" runat="server" Text="Register" OnClick="Register_Click" />
    </p>
    </form>
</body>
</html>
