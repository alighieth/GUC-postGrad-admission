<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registration.aspx.cs" Inherits="DBserver.registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PostGradOffice Registration</title>
    <style>
        .top{
            color:white;
            background-color:black;
            width: 100%;
            height:50px;
            text-align:center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top">
            <span>PostGradOffice Registration</span>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Which faculty member are you?"></asp:Label>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="ASgucian" Text="GUCIAN" />
        </p>
        <p>
            <asp:Button ID="Button2" runat="server" OnClick="ASnon" Text="NONGUCIAN" />
        </p>
        <asp:Button ID="Button3" runat="server" OnClick="ASsup" Text="SUPERVISOR" />
        <p>
            <asp:Button ID="Button4" runat="server" OnClick="ASadmin" Text="EXAMINER" />
        </p>
    </form>
</body>
</html>
