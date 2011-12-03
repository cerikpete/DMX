
<!--
*	FileName: subGetAccountInfo.asp
*	Description:
*		Creates/Updates Account
*
-->
<%
Sub GetAccountInfo(p_intAccountID, bitApproved)

%>
<!--#include file="Connect.inc"-->
<%

	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn
	objCmd.CommandText = "{CALL qparmGetAccountInfo (" & p_intAccountID & ", " & bitApproved & ")}"
	Set objRS = Server.CreateObject("ADODB.Recordset")
	Set objRS = objCmd.Execute

	Response.Write "<input type=hidden id=intAccountID name=intAccountID value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("intAccountID")
	Response.Write "></input>"
	Response.Write "<tr>"
	Response.Write "	<td class=odd>Account Name:</td>"
	Response.Write "	<td class=odd><input type=text id=strAccountName name=strAccountName value="""
	If Not objRS.EOF Then Response.Write  objRS.Fields("strAccountName")
	Response.Write """></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=even>Contact:</td>"
	Response.Write "	<td class=even><input type=text id=strContact name=strContact value="""
	If Not objRS.EOF Then Response.Write  objRS.Fields("strContact")
	Response.Write """></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=odd>Phone No.:</td>"
	Response.Write "	<td class=odd><input type=text id=strPhone name=strPhone value="""
	If Not objRS.EOF Then Response.Write  objRS.Fields("strPhone")
	Response.Write """></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=even># of Location:</td>"
	Response.Write "	<td class=even><input type=text id=intLocationNumber name=intLocationNumber value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("intLocationNumber")
	Response.Write "></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=odd>Closed RMR:</td>"
	Response.Write "	<td class=odd><input type=text id=mnyClosedRMR name=mnyClosedRMR value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("mnyClosedRMR")
	Response.Write "></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=even>Closed RSS:</td>"
	Response.Write "	<td class=even><input type=text id=mnyCLosedRSS name=mnyCLosedRSS value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("mnyCLosedRSS")
	Response.Write "></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=odd>10% RMR:</td>"
	Response.Write "	<td class=odd><input type=text id=mnyRMR_10 name=mnyRMR_10 value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("mnyRMR_10")
	Response.Write "></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=even>10% RSS:</td>"
	Response.Write "	<td class=even><input type=text id=mnyRSS_10 name=mnyRSS_10 value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("mnyRSS_10")
	Response.Write "></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=odd>50% RMR:</td>"
	Response.Write "	<td class=odd><input type=text id=mnyRMR_50 name=mnyRMR_50 value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("mnyRMR_50")
	Response.Write "></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=even>50% RSS:</td>"
	Response.Write "	<td class=even><input type=text id=mnyRSS_50 name=mnyRSS_50 value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("mnyRSS_50")
	Response.Write "></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=odd>90% RMR:</td>"
	Response.Write "	<td class=odd><input type=text id=mnyRMR_90 name=mnyRMR_90 value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("mnyRMR_90")
	Response.Write "></input></td>"
	Response.Write "</tr>"
	Response.Write "<tr>"
	Response.Write "	<td class=even>90% RSS:</td>"
	Response.Write "	<td class=even><input type=text id=mnyRSS_90 name=mnyRSS_90 value="
	If Not objRS.EOF Then Response.Write  objRS.Fields("mnyRSS_90")
	Response.Write "></input></td>"
	Response.Write "</tr>"

%>
<!--#include file="DisConnect.inc"-->
<%
	'CheckForErrors(objConn)
End Sub
%>