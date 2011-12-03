<!--
*	FileName: subValidateAccount.asp
*	Description:
*		Deletes Account
*
-->
<%
Function ValidateAccount(p_intAccountID, p_strAnswerSet, p_strAccountName)

	ValidateAccount = false

	Dim strAccountName
	Dim objCmd
	Dim objRS
%>
<!--#include file="Connect.inc"-->
<%
	strAccountName = ""
	strAccountName = Replace(p_strAccountName, "'", "''")
	'Call CheckForErrors(objConn)
	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn

	objCmd.CommandText = "{ CALL qparmValidateAccount (" & p_intAccountID & _
													   ", '" & Trim(p_strAnswerSet) & _
													   "', '" & Trim(strAccountName) & "')}"
	Set objRS = Server.CreateObject("ADODB.Recordset")
	Set objRS = objCmd.Execute


	If objRS.EOF Then ValidateAccount = true

%>
<!--#include file="DisConnect.inc"-->
<%
	'CheckForErrors(objConn)
End Function
%>

