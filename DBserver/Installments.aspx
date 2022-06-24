<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Installments.aspx.cs" Inherits="DBserver.Installments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Issue installments as per start date for  each 6 months"></asp:Label>
            <br />
        </div>
        <asp:Label ID="Label2" runat="server" Text="Please provide below data"></asp:Label>
        <p>
            <asp:Label ID="Label3" runat="server" Text="PaymentId"></asp:Label>
        </p>
        <asp:TextBox ID="paymentID" runat="server"></asp:TextBox>
        <p>
            <asp:Label ID="Label4" runat="server" Text="Installments Start Date"></asp:Label>
        </p>
        <asp:TextBox ID="InstallStartDate" runat="server">YYYY-MM-DD</asp:TextBox>
        <p>
            <asp:Button ID="Button1" OnClick="AdminIssueInstallPayment" runat="server" Text="Submit" />
        </p>
    </form>
</body>
</html>
