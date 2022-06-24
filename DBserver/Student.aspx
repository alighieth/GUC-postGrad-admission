<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="DBserver.Student" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
           
        <asp:gridview runat="server" ID="Gv1" AutoGenerateColumns="true" HeaderStyle-BackColor="Red" BackColor="LightBlue"
    BorderWidth="5" BorderColor="Blue">
   </asp:gridview>
    
            <br />
        </div>
        <asp:Button ID="Button2" runat="server" Text="My profile" OnClick="Button2_Click" />
        <br />
        <br />
    
            <asp:Button ID="Button1" runat="server" OnClick="theses" Text="My Theses" />
            <br />
        <br />
        <asp:Button ID="Button3" runat="server" Text="My grades" OnClick="Button3_Click" />
        <br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button4" runat="server" Text="Add publication" OnClick="Button4_Click" />
        <br />
        <br />
        <br />
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button5" runat="server" Text="PubID" OnClick="Button5_Click" Height="16px" />
        <br />
        <br />
        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
        <asp:Button ID="Button6" runat="server" Text="AddProgressReport" OnClick="Button6_Click" />
        &nbsp;
        <br />
        <br />
        <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="TextBox11" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:TextBox ID="TextBox12" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button7" runat="server" Text="FillProgressReport" OnClick="Button7_Click" />
        <br />
        <br />
    </form>
</body>
</html>
