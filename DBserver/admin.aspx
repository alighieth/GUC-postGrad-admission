<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="DBserver.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>admin component</title>
    <style>
        .container{
            display:flex;
            flex-direction:row;
            color:white;
        }
        .top {
            color:white;
            background-color:black;
            width:100%;
            height:50px;
        }
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top">
               <span>Admin Part done by Ali Hehsam 49-0605</span>
            </div>

            <div class="rightbar">
                <asp:Label ID="Label2" runat="server" Text="Admin StartUp Page"></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="Label4" runat="server" Text="Available Services"></asp:Label>
                    <br />
                    <br />
                <ul>
                    
                    <li><asp:LinkButton ID="LinkButton1" runat="server" OnClick="supervisors"> List all supervisors in the system</asp:LinkButton>
                    <br />
                    <li><asp:LinkButton OnClick="ThesisList" ID="LinkButton2" runat="server"> List all Theses in the system</asp:LinkButton>
                    <br />
                    <li><asp:LinkButton OnClick="ThesisCount" ID="LinkButton3" runat="server">Ongoing Thesis Count</asp:LinkButton>
                    <br />
                    <li><asp:LinkButton OnClick="PymntIssue" ID="LinkButton4" runat="server"> Issue a thesis payment</asp:LinkButton>
                    <br />
                    <li><asp:LinkButton OnClick="InstlIssue" ID="LinkButton5" runat="server"> Issue installments</asp:LinkButton></li>
                    <br />
                    <li><asp:LinkButton OnClick="extend" ID="LinkButton6" runat="server"> Update thesis extension</asp:LinkButton>
                </ul>

            </div>
         <div>
        <asp:gridview runat="server" ID="Gv1" AutoGenerateColumns="true" HeaderStyle-BackColor="Red" BackColor="LightBlue"  
    BorderWidth="5" BorderColor="Blue">  
   </asp:gridview>  
    </div> 

        <hr />
        <span>&COPY alighieth</span>
    </form>
</body>
</html>
