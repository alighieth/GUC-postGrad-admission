<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailReg.aspx.cs" Inherits="DBserver.EmailReg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Please fill the below fields"></asp:Label>
            <br />
        </div>
        <asp:Label ID="Label2" runat="server" Text="Email"></asp:Label>
        <p>
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
        <p>
            <asp:TextBox ID="pass" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="Button1" runat="server" OnClick="emailRegister" Text="Submit" />
    </form>
</body>
</html>
