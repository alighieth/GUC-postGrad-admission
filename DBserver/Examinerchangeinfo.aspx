<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Examinerchangeinfo.aspx.cs" Inherits="DBserver.Examinerchangeinfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form1" runat="server">
        <div>
        </div>
        <p>
            EDIT YOUR INFORMATION
        </p>
        <p>
            YOUR NAME
        </p>
        <asp:TextBox ID="NAME" runat="server" Height="32px" Width="191px" ></asp:TextBox>
        <p>
            FIELD OF WORK
        </p>
        <asp:TextBox ID="FIELDOFWORK" runat="server" Height="30px" Width="194px"></asp:TextBox>
        <br />
        <br />
        Your ID<br />
        <asp:TextBox ID="TextBox1" runat="server" Height="29px" OnTextChanged="TextBox1_TextChanged" Width="189px"></asp:TextBox>
        <br />
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="CHANGE" Text="CHANGE" />
        </p>
    </form>
</body>
</html>
