<%@ Control Language="c#" AutoEventWireup="True" Codebehind="indivTop25Month.ascx.cs" Inherits="dmx.Controls.indivTop25Month" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<P align="center"><asp:label id="lblMonth" Font-Bold="True" runat="server" CssClass="ReportTitle"></asp:label></P>
<P align="center">
	<TABLE id="Table2" cellSpacing="0" cellPadding="0" border="0">
		<TR>
			<TD align="center"><STRONG>Projected Forecast:</STRONG><BR>
				<asp:table id="tblForecastSummary" runat="server" CssClass="Top25" CellSpacing="0" cellpadding="4" GridLines="Both">
					<asp:TableRow CssClass="Top25ColumnHeader">
						<asp:TableCell>Projected RMR</asp:TableCell>
						<asp:TableCell>Projected RSS</asp:TableCell>
						<asp:TableCell>Total Proposed</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow CssClass="Top25ColumnFooter">
						<asp:TableCell></asp:TableCell>
						<asp:TableCell></asp:TableCell>
						<asp:TableCell></asp:TableCell>
					</asp:TableRow>
				</asp:table></TD>
		</TR>
	</TABLE>
</P>
<P align="center"><STRONG>Quotas/Funnels:</STRONG><br>
	<asp:table id="tblQuotaFunnels" runat="server" CssClass="Top25" CellSpacing="0" cellpadding="4" GridLines="Both">
		<asp:TableRow CssClass="Top25ColumnHeader">
			<asp:TableCell></asp:TableCell>
			<asp:TableCell>Closed</asp:TableCell>
			<asp:TableCell>Quota</asp:TableCell>
			<asp:TableCell>Delta</asp:TableCell>
			<asp:TableCell>Proposed</asp:TableCell>
			<asp:TableCell>Funnel</asp:TableCell>
			<asp:TableCell>Delta</asp:TableCell>
		</asp:TableRow>
		<asp:TableRow CssClass="Top25ColumnFooter">
			<asp:TableCell CssClass="Top25RowHeader">RMR</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
		</asp:TableRow>
		<asp:TableRow CssClass="Top25ColumnFooter">
			<asp:TableCell CssClass="Top25RowHeader">RSS</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
			<asp:TableCell>0</asp:TableCell>
		</asp:TableRow>
	</asp:table></P>
<asp:datagrid id="gridAccounts" runat="server" CssClass="Top25" ShowFooter="True" OnItemDataBound="gridAccounts_AddToForecast"
	CellPadding="2" HeaderStyle-CssClass="top25ColumnHeader" AlternatingItemStyle-CssClass="Top25AlternateData"
	ItemStyle-CssClass="Top25Data" AllowSorting="True" OnSortCommand="gridAccounts_Sort" AutoGenerateColumns="False">
	<Columns>
		<asp:BoundColumn DataField="strAccountName" SortExpression="strAccountName" HeaderText="Account"
			ItemStyle-CssClass="Top25RowHeader"></asp:BoundColumn>
		<asp:BoundColumn DataField="strContact" SortExpression="strContact" HeaderText="Contact"></asp:BoundColumn>
		<asp:BoundColumn DataField="strPhone" SortExpression="strPhone" HeaderText="Phone"></asp:BoundColumn>
		<asp:BoundColumn DataField="intLocations" SortExpression="intLocations DESC" HeaderText="# Loc"></asp:BoundColumn>
		<asp:BoundColumn DataField="ClosedRMR" SortExpression="ClosedRMR DESC" HeaderText="Closed RMR" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="ClosedRSS" SortExpression="ClosedRSS DESC" HeaderText="Closed RSS" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_10" SortExpression="RMR_10 DESC" HeaderText="10% RMR" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_10" SortExpression="RSS_10 DESC" HeaderText="10% RSS" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_50" SortExpression="RMR_50 DESC" HeaderText="50% RMR" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_50" SortExpression="RSS_50 DESC" HeaderText="50% RSS" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_90" SortExpression="RMR_90 DESC" HeaderText="90% RMR" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_90" SortExpression="RSS_90 DESC" HeaderText="90% RSS" DataFormatString="{0:C}"></asp:BoundColumn>
	</Columns>
</asp:datagrid></FORM>
<P>&nbsp;</P>
