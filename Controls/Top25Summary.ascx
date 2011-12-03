<%@ Control Language="c#" AutoEventWireup="false" Codebehind="Top25Summary.ascx.cs" Inherits="dmx.Controls.Top25Summary" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="300" border="1">
	<TR>
		<TD>Start Month:</TD>
		<TD>
			<asp:DropDownList id="lstStartMonth" runat="server"></asp:DropDownList></TD>
		<TD>Region:</TD>
		<TD>
			<asp:DropDownList id="lstRegion" runat="server"></asp:DropDownList></TD>
	</TR>
	<TR>
		<TD>End Month:</TD>
		<TD>
			<asp:DropDownList id="lstEndMonth" runat="server"></asp:DropDownList></TD>
		<TD>Area:</TD>
		<TD>
			<asp:DropDownList id="lstArea" runat="server"></asp:DropDownList></TD>
	</TR>
	<TR>
		<TD>Approval:</TD>
		<TD>
			<asp:DropDownList id="lstApproved" runat="server">
				<asp:ListItem Value="True" Selected="True">Approved Only</asp:ListItem>
				<asp:ListItem Value="False">Show All</asp:ListItem>
			</asp:DropDownList></TD>
		<TD>LSO:</TD>
		<TD>
			<asp:DropDownList id="lstLSO" runat="server"></asp:DropDownList></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD>
			<asp:Button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="Refresh"></asp:Button></TD>
		<TD></TD>
		<TD></TD>
	</TR>
</TABLE>
&nbsp;
<asp:datagrid id="grdSummary" runat="server" HeaderStyle-CssClass="top25ColumnHeader" AlternatingItemStyle-CssClass="Top25AlternateData"
	ItemStyle-CssClass="Top25Data" AllowSorting="True" OnSortCommand="grdSummary_Sort" AutoGenerateColumns="False"
	OnItemDataBound="grdSummary_AddToSum" ShowFooter="True" CssClass="Top25">
	<Columns>
		<asp:BoundColumn DataField="dtmMonth" SortExpression="dtmMonth ASC" HeaderText="Month" DataFormatString="{0:MMMM yyyy}"
			ItemStyle-CssClass="Top25RowHeader"></asp:BoundColumn>
		<asp:BoundColumn DataField="ClosedRMR" SortExpression="ClosedRMR DESC" HeaderText="Actual RMR" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="ClosedRSS" SortExpression="ClosedRSS DESC" HeaderText="Actual RMR" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_10" SortExpression="RMR_10 DESC" HeaderText="RMR 10%" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_10" SortExpression="RSS_10 DESC" HeaderText="RSS 10%" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_50" SortExpression="RMR_50 DESC" HeaderText="RMR 50%" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_50" SortExpression="RSS_50 DESC" HeaderText="RSS 50%" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_90" SortExpression="RMR_90 DESC" HeaderText="RMR 90%" DataFormatString="{0:C}"></asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_90" SortExpression="RSS_90 DESC" HeaderText="RSS 90%" DataFormatString="{0:C}"></asp:BoundColumn>
	</Columns>
</asp:datagrid>
<P>
	<asp:Table id="tblForecastSummary" runat="server" CssClass="Top25" GridLines="Both" CellSpacing="0">
		<asp:TableRow CssClass="Top25ColumnHeader">
			<asp:TableCell>Month</asp:TableCell>
			<asp:TableCell>Projected RMR</asp:TableCell>
			<asp:TableCell>Projected RSS</asp:TableCell>
			<asp:TableCell>Total Proposed</asp:TableCell>
		</asp:TableRow>
	</asp:Table></P>
<P>&nbsp;</P>
<P>
	<asp:datagrid id="grdEmployeeSummary" AutoGenerateColumns="False" OnSortCommand="grdEmployeeSummary_Sort"
		runat="server" AllowSorting="True" ItemStyle-CssClass="Top25Data" AlternatingItemStyle-CssClass="Top25AlternateData"
		HeaderStyle-CssClass="top25ColumnHeader" OnItemCommand="grdEmployeeSummary_ItemCommand">
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
	</asp:datagrid></P>
