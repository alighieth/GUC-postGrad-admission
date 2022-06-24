<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="DBserver.payment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Issue a thesis payment"></asp:Label>
        <div>
            <br />
            <asp:Label ID="Label2" runat="server" Text="PLease provide below data "></asp:Label>
        </div>
        <asp:Label ID="Label3" runat="server" Text="Thesis SerialNumber"></asp:Label>
        <p>
            <asp:TextBox ID="ThesisSerialNo" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label4" runat="server" Text="Amount"></asp:Label>
        <p>
            <asp:TextBox ID="amount" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label5" runat="server" Text="Number of Installments"></asp:Label>
        <p>
            <asp:TextBox ID="noOfInstallments" runat="server"></asp:TextBox>
        </p>
        <asp:Label ID="Label6" runat="server" Text="Fund percentage"></asp:Label>
        <p>
            <asp:TextBox ID="fundPercentage" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="Button1" OnClick="AdminIssueThesisPayment" runat="server" Text="Submit" />
    </form>
</body>
</html>
