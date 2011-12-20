<%@ Control Language="c#" AutoEventWireup="True" Codebehind="UserMenu.ascx.cs" Inherits="dmx.Controls.UserMenu" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<asp:table id="tblMenu" runat="server" CellPadding="0" CellSpacing="0" Width="100%">
	<asp:TableRow>
		<asp:TableCell>&nbsp;</asp:TableCell>
		<asp:TableCell>
			<asp:HyperLink id="lnkHome" runat="server">Home</asp:HyperLink>
		</asp:TableCell>
		<asp:TableCell>&nbsp;</asp:TableCell>
	</asp:TableRow>	
	<asp:TableRow>
		<asp:TableCell>&nbsp;</asp:TableCell>
		<asp:TableCell>
			<a href="<%# Request.ApplicationPath %>/default.aspx">Log Off</a></asp:TableCell>
		<asp:TableCell>&nbsp;</asp:TableCell>
	</asp:TableRow>
</asp:table>
