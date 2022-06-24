<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addgrade.aspx.cs" Inherits="DBserver.addgrade" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <div>
            Enter thesis serial no.
        </div>
        <asp:TextBox ID="serialno" runat="server" ></asp:TextBox>
        <p>
            Enter defence date</p>
        <p>
            <asp:TextBox ID="defencedate" runat="server" ></asp:TextBox>
        </p>
        <p>
            Grade
        </p>
        <p>
            <asp:TextBox ID="grade" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="post" runat="server" Text="Post Grade" OnClick="Button1_Click" />
        </p>
 
        </div>
    </form>
</body>
</html>
