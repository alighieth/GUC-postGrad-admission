<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="supervisors.aspx.cs" Inherits="DBserver.supervisors" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div >  
   <asp:gridview runat="server" ID="Gv1" AutoGenerateColumns="true" HeaderStyle-BackColor="Red" BackColor="LightBlue"  
    BorderWidth="5" BorderColor="Blue">  
   </asp:gridview>  
    </div> 
    </form>
</body>
</html>
