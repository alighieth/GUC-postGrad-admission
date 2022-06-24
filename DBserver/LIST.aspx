<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LIST.aspx.cs" Inherits="DBserver.LIST" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            enter your id</div>
        <asp:TextBox ID="TextBox1" runat="server" Height="31px" Width="175px"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="done" />
    <div>
        <asp:gridview runat="server" ID="Gv1" AutoGenerateColumns="true" HeaderStyle-BackColor="Red" BackColor="LightBlue"
    BorderWidth="5" BorderColor="Blue">
   </asp:gridview>
    </div>
    </form>
</body>
</html>
