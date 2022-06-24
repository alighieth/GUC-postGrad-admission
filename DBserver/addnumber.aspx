<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addnumber.aspx.cs" Inherits="DBserver.addnumber" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Add A phone number"></asp:Label>
        </div>
        <p>
            <asp:TextBox ID="ID" runat="server" Text="ID"></asp:TextBox>
        </p>
        <p>
            <asp:TextBox ID="Number" runat="server" Text="Phone Number"></asp:TextBox>
        </p>
        <p>
        <asp:Button ID="Button1" runat="server" Text="Add" OnClick="Button1_Click" />
        </p>
    </form>
</body>
</html>
