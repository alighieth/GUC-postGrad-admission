<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="examinermain.aspx.cs" Inherits="DBserver.examinermain" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
      <form id="form1" runat="server">
        <div>
            main
            <br />
        </div>
        <asp:Button ID="Button1" runat="server" Text="Add comment" OnClick="Button1_Click" />
        <p>
            <asp:Button ID="Button2" runat="server" Text="Add grade" OnClick="Button2_Click" />
        </p>
        <p>
            <asp:Button ID="Button3" runat="server" Text="Change info." OnClick="Button3_Click" />
        </p>
        <p>
            <asp:Button ID="Button4" runat="server" Text="list thesis" OnClick="Button4_Click" />
        </p>
        <p>
            <asp:Button ID="Button5" runat="server" Text="search" OnClick="Button5_Click" />
        </p>
    </form>
</body>
</html>
