<!--
*	FileName: subMoveAccount.asp
*	Description:
*		Deletes Account
*
-->
<%
Sub MoveAccount( p_intAccountID, p_strMonthYear )


	Dim objCmd
	Dim objRS
%>
<!--#include file="Connect.inc"-->
<%
	'Call CheckForErrors(objConn)
	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn

	objConn.beginTrans


	objCmd.CommandText = "{ CALL sp_MoveAccount (" & p_intAccountID & ",'" & p_strMonthYear & "')}"

	'Response.Write objCmd.CommandText

	Set objRS = Server.CreateObject("ADODB.Recordset")
	Set objRS = objCmd.Execute


	If objConn.Errors.Count > 0 Then
		objConn.rollbackTrans
	Else
		objConn.commitTrans
	End If
%>
<!--#include file="DisConnect.inc"-->
<%
	'CheckForErrors(objConn)
End Sub
%>