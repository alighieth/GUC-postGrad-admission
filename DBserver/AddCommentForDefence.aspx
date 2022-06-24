<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCommentForDefence.aspx.cs" Inherits="DBserver.AddCommentForDefence" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
      <form id="form1" runat="server">
        <div>
            Enter thesis serial no.
        </div>
        <asp:TextBox ID="serialno" runat="server" ></asp:TextBox>
        <p>
            Enter defence date</p>
        <p>
            <asp:TextBox ID="defencedate" runat="server"></asp:TextBox>
        </p>
        <p>
            Comment
        </p>
        <p>
            <asp:TextBox ID="comment" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="post" runat="server" Text="Post Comment" OnClick="Button1_Click" />
        </p>
    </form>
</body>
</html>
