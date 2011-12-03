<%@ Page language="c#" Codebehind="indivSales.aspx.cs" AutoEventWireup="True" Inherits="dmx.indivSales" %>
<%@ Register TagPrefix="uc1" TagName="indivTop25Month" Src="Controls/indivTop25Month.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Individual Sales</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<P>&nbsp;</P>
			<P align="center">
				<TABLE id="Table2" cellSpacing="0" cellPadding="20" width="100%" border="0">
					<TR>
						<TD>
							<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="300" border="0" align="center">
								<TR>
									<TD>
										<asp:button id="btnPrev" onclick="btnPrev_Click" runat="server" CausesValidation="False" Text="<<"></asp:button></TD>
									<TD align="center">
										<asp:label id="lblName" runat="server" CssClass="ReportTitle"></asp:label></TD>
									<TD align="right">
										<asp:button id="btnNext" onclick="btnNext_Click" runat="server" CausesValidation="False" Text=">>"></asp:button></TD>
								</TR>
								<TR>
									<TD colspan="3" align="center">
										[
										<asp:HyperLink id="lnkHome" runat="server">Return to </asp:HyperLink>
										]
									</TD>
								</TR>
							</TABLE>
							<BR>
							<P>
								<uc1:indivtop25month id=ucMonth1 runat="server" EmployeeID="<%# EmployeeID %>">
								</uc1:indivtop25month></P>
							<uc1:indivtop25month id=ucMonth2 runat="server" EmployeeID="<%# EmployeeID %>">
							</uc1:indivtop25month>
							<P></P>
							<uc1:indivtop25month id=ucMonth3 runat="server" EmployeeID="<%# EmployeeID %>">
							</uc1:indivtop25month></TD>
					</TR>
				</TABLE>
			</P>
		</form>
	</body>
</HTML>
