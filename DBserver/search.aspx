<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="DBserver.search" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
      <form id="form1" runat="server">
        <p>
            &nbsp;</p>
        <p>
            Thesis Title</p>
        <p>
            <asp:TextBox ID="TextBox1" runat="server" Height="31px" Width="244px"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" Height="40px" Text="Search" Width="99px" OnClick="Button1_Click" />
        </p>
        <div>
        <asp:gridview runat="server" ID="Gv1" AutoGenerateColumns="true" HeaderStyle-BackColor="Red" BackColor="LightBlue"
    BorderWidth="5" BorderColor="Blue">
   </asp:gridview>
    </div>
    </form>
</body>
</html>
