<%@ Page language="c#" Codebehind="Top25Report.aspx.cs" AutoEventWireup="True" Inherits="dmx.Top25Report" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Top 25 Report</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript">

	function resetFilters(currFilter){
		var filterNames = new Array('lstRegion', 'lstArea', 'lstLSO');
		
		for (var i=0; i < filterNames.length; i++){
			if (filterNames[i] != currFilter.name){
				document.forms[0][filterNames[i]].selectedIndex = 0;
			
			}
		
		}


	}

		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<P>
				<table cellSpacing="0" cellPadding="20" border="0" width="100%">
					<tr>
						<td>
							<p align="center"><br>
								<span class="ReportTitle">Top 25 Report -
									<asp:label id="lblName" runat="server"></asp:label></span><br>
								[
								<asp:hyperlink id="lnkHome" runat="server">Home</asp:hyperlink>| <A href="default.aspx">
									Log Off</A> ]
							</p>
							<TABLE id="Table1" cellSpacing="2" cellPadding="2" width="300" align="center" border="0">
								<TR>
									<TD class="Top25ColumnHeader" noWrap align="center" colSpan="2"><strong>Date Range </strong>
									</TD>
									<TD noWrap align="right">&nbsp;</TD>
									<TD class="Top25ColumnHeader" noWrap align="center" colSpan="2"><strong>Filters</strong></TD>
								</TR>
								<TR>
									<TD class="Top25RowHeader" noWrap align="right"><strong>Start Month:</strong></TD>
									<TD><asp:dropdownlist id="lstStartMonth" runat="server"></asp:dropdownlist></TD>
									<TD noWrap align="right">&nbsp;</TD>
									<TD class="Top25RowHeader" noWrap align="right"><strong>Region:</strong></TD>
									<TD><asp:dropdownlist id="lstRegion" runat="server"></asp:dropdownlist></TD>
								</TR>
								<TR>
									<TD class="Top25RowHeader" noWrap align="right"><strong>End Month:</strong></TD>
									<TD><asp:dropdownlist id="lstEndMonth" runat="server"></asp:dropdownlist></TD>
									<TD noWrap align="right">&nbsp;</TD>
									<TD class="Top25RowHeader" noWrap align="right"><strong>Area:</strong></TD>
									<TD><asp:dropdownlist id="lstArea" runat="server"></asp:dropdownlist></TD>
								</TR>
								<TR>
									<TD noWrap align="right" runat="server"><!-- <strong>Approval:</strong> --></TD>
									<TD runat="server"><asp:dropdownlist id="lstApproved" runat="server" Visible="False">
											<asp:ListItem Value="True" Selected="True">Approved Only</asp:ListItem>
											<asp:ListItem Value="False">Show All</asp:ListItem>
										</asp:dropdownlist></TD>
									<TD noWrap align="right">&nbsp;</TD>
									<TD class="Top25RowHeader" noWrap align="right"><strong>LSO:</strong></TD>
									<TD><asp:dropdownlist id="lstLSO" runat="server"></asp:dropdownlist></TD>
								</TR>
								<TR align="center">
									<TD align="right" colSpan="2"><asp:button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="Refresh Report"></asp:button></TD>
									<TD>&nbsp;</TD>
									<TD align="left" colSpan="2"><input type="reset" value="Reset Filters" name="reset"></TD>
								</TR>
							</TABLE>
							&nbsp;
							<table cellSpacing="0" cellPadding="0" border="0">
								<tr>
									<td><strong>Monthly Forecast Totals:</strong>
										<br>
										<asp:datagrid id="grdSummary" runat="server" HeaderStyle-CssClass="top25ColumnHeader" AlternatingItemStyle-CssClass="Top25AlternateData"
											ItemStyle-CssClass="Top25Data" AllowSorting="True" OnSortCommand="grdSummary_Sort" AutoGenerateColumns="False"
											OnItemDataBound="grdSummary_AddToSum" ShowFooter="True" CssClass="Top25">
											<Columns>
												<asp:BoundColumn DataField="dtmMonth" SortExpression="dtmMonth ASC" HeaderText="Month" DataFormatString="{0:MMMM yyyy}"
													ItemStyle-CssClass="Top25RowHeader"></asp:BoundColumn>
												<asp:BoundColumn DataField="ClosedRMR" SortExpression="ClosedRMR DESC" HeaderText="Actual RMR" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="ClosedRSS" SortExpression="ClosedRSS DESC" HeaderText="Actual RSS" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RMR_10" SortExpression="RMR_10 DESC" HeaderText="RMR 10%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RSS_10" SortExpression="RSS_10 DESC" HeaderText="RSS 10%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RMR_50" SortExpression="RMR_50 DESC" HeaderText="RMR 50%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RSS_50" SortExpression="RSS_50 DESC" HeaderText="RSS 50%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RMR_90" SortExpression="RMR_90 DESC" HeaderText="RMR 90%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RSS_90" SortExpression="RSS_90 DESC" HeaderText="RSS 90%" DataFormatString="{0:C}"></asp:BoundColumn>
											</Columns>
										</asp:datagrid></td>
								</tr>
							</table>
							<p></p>
							<table cellSpacing="0" cellPadding="0" border="0">
								<tr>
									<td><strong>Projected Forecast:</strong><br>
										<asp:table id="tblForecastSummary" runat="server" CssClass="Top25" GridLines="Both" CellSpacing="0">
											<asp:TableRow CssClass="Top25ColumnHeader">
												<asp:TableCell>Month</asp:TableCell>
												<asp:TableCell>Projected RMR</asp:TableCell>
												<asp:TableCell>Projected RSS</asp:TableCell>
												<asp:TableCell>Total Proposed</asp:TableCell>
											</asp:TableRow>
										</asp:table></td>
								</tr>
							</table>
							<P></P>
							<table cellSpacing="0" cellPadding="0" border="0">
								<tr>
									<td><strong>Employee Forecast Totals:<br>
										</strong>
										<asp:datagrid id="grdEmployeeSummary" runat="server" HeaderStyle-CssClass="top25ColumnHeader"
											AlternatingItemStyle-CssClass="Top25AlternateData" ItemStyle-CssClass="Top25Data" AllowSorting="True"
											OnSortCommand="grdEmployeeSummary_Sort" AutoGenerateColumns="False" OnItemCommand="grdEmployeeSummary_ItemCommand">
											<AlternatingItemStyle CssClass="Top25AlternateData"></AlternatingItemStyle>
											<ItemStyle CssClass="Top25Data"></ItemStyle>
											<HeaderStyle CssClass="top25ColumnHeader"></HeaderStyle>
											<Columns>
												<asp:BoundColumn DataField="intEmployeeID" Visible="False" ReadOnly="True"></asp:BoundColumn>
												<asp:ButtonColumn ButtonType="LinkButton" DataTextField="EmployeeName" SortExpression="EmployeeName ASC"
													HeaderText="Sales Rep" DataTextFormatString="{0:MMMM yyyy}" CommandName="indivSales">
													<ItemStyle CssClass="Top25RowHeader"></ItemStyle>
												</asp:ButtonColumn>
												<asp:BoundColumn DataField="ClosedRMR" SortExpression="ClosedRMR DESC" HeaderText="Actual RMR" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="ClosedRSS" SortExpression="ClosedRSS DESC" HeaderText="Actual RSS" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RMR_10" SortExpression="RMR_10 DESC" HeaderText="RMR 10%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RSS_10" SortExpression="RSS_10 DESC" HeaderText="RSS 10%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RMR_50" SortExpression="RMR_50 DESC" HeaderText="RMR 50%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RSS_50" SortExpression="RSS_50 DESC" HeaderText="RSS 50%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RMR_90" SortExpression="RMR_90 DESC" HeaderText="RMR 90%" DataFormatString="{0:C}"></asp:BoundColumn>
												<asp:BoundColumn DataField="RSS_90" SortExpression="RSS_90 DESC" HeaderText="RSS 90%" DataFormatString="{0:C}"></asp:BoundColumn>
											</Columns>
										</asp:datagrid></td>
								</tr>
							</table>
							<P>&nbsp;</P>
							<P>&nbsp;</P>
						</td>
					</tr>
				</table>
			<P>&nbsp;</P>
		</form>
	</body>
</HTML>
