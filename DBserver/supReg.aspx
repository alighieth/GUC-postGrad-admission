<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="supReg.aspx.cs" Inherits="DBserver.supReg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .top{
            color:white;
            background-color:black;
            width:100%;
            height:50px;
            text-align:center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top">
            <span>Supervisor Regiteration</span>
        </div>
        <asp:Label ID="Label2" runat="server" Text="Please provide the below data"></asp:Label>
        <p>
            <asp:Label ID="Label3" runat="server" Text="First Name"></asp:Label>
        </p>
        <p>
            <asp:TextBox ID="fname" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label4" runat="server" Text="Last Name"></asp:Label>
        <p>
            <asp:TextBox ID="lname" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label5" runat="server" Text="Password"></asp:Label>
        <p>
            <asp:TextBox ID="pass" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label6" runat="server" Text="Faculty"></asp:Label>
        <p>
            <asp:TextBox ID="fac" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label7" runat="server" Text="Email"></asp:Label>
        <p>
            <asp:TextBox ID="email" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="Button1" OnClick="Register" runat="server" Text="Submit" />
    </form>
</body>
</html>
