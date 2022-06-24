<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="extend.aspx.cs" Inherits="DBserver.extend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label4" runat="server" Text="Increment Thesis extesnion (+1)"></asp:Label>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Please Add Thesis Number"></asp:Label>
        </div>
        <asp:TextBox ID="ThesisNo" runat="server"></asp:TextBox>
        <p>
            <asp:Button OnClick="submittion" ID="Submit" runat="server" Text="Submit" />
        </p>
    </form>
</body>
</html>
