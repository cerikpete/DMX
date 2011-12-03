<%@ Control Language="c#" AutoEventWireup="True" Codebehind="Top25Account.ascx.cs" Inherits="dmx.Controls.Top25Account" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<asp:datagrid id="gridAccounts" runat="server" AllowSorting="True" CellPadding="2" AutoGenerateColumns="False"
	OnSortCommand="gridAccounts_Sort" HeaderStyle-CssClass="top25ColumnHeader" AlternatingItemStyle-CssClass="Top25AlternateData"
	ItemStyle-CssClass="Top25Data"  CssClass="Top25">
	<Columns>
		<asp:BoundColumn DataField="strAccountName" SortExpression="strAccountName" HeaderText="Account"
			ItemStyle-CssClass="Top25RowHeader"></asp:BoundColumn>
		<asp:BoundColumn DataField="strContact" SortExpression="strContact" HeaderText="Contact"></asp:BoundColumn>
		<asp:BoundColumn DataField="strPhone" SortExpression="strPhone" HeaderText="Phone"></asp:BoundColumn>
		<asp:BoundColumn DataField="intLocations" SortExpression="intLocations" HeaderText="# Loc"></asp:BoundColumn>
		<asp:BoundColumn DataField="ClosedRMR" SortExpression="ClosedRMR" HeaderText="Closed RMR" DataFormatString="{0:C}">
		</asp:BoundColumn>
		<asp:BoundColumn DataField="ClosedRSS" SortExpression="ClosedRSS" HeaderText="Closed RSS" DataFormatString="{0:C}">
		</asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_10" SortExpression="RMR_10" HeaderText="10% RMR" DataFormatString="{0:C}">
		</asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_10" SortExpression="RSS_10" HeaderText="10% RSS" DataFormatString="{0:C}">
		</asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_50" SortExpression="RMR_50" HeaderText="50% RMR" DataFormatString="{0:C}">
		</asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_50" SortExpression="RSS_50" HeaderText="50% RSS" DataFormatString="{0:C}">
		</asp:BoundColumn>
		<asp:BoundColumn DataField="RMR_90" SortExpression="RMR_90" HeaderText="90% RMR" DataFormatString="{0:C}">
		</asp:BoundColumn>
		<asp:BoundColumn DataField="RSS_90" SortExpression="RSS_90" HeaderText="90% RSS" DataFormatString="{0:C}">
		</asp:BoundColumn>
	</Columns>
</asp:datagrid>
