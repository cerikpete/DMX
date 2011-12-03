<!--
*	FileName: subCloseAccount.asp
*	Description:
*		Deletes Account
*
-->
<%
Sub CloseAccount( p_intAccountID )


	Dim objCmd
	Dim objRS
%>
<!--#include file="Connect.inc"-->
<%
	'Call CheckForErrors(objConn)
	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn

	objConn.beginTrans


	objCmd.CommandText = "{ CALL sp_CloseAccount (" & p_intAccountID & ")}"

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