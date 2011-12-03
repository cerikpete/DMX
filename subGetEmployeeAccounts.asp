<!--
*	FileName: subGetEmployeeAccounts.asp
*	Description:
*
-->
<%
Sub GetEmployeeAccounts(p_intEmployeeID, p_strAnswerSet, p_intAccountID)
	Dim objCmd
	Dim objRS
%>
<!--#include file="Connect.inc"-->
<%
	'Call CheckForErrors(objConn)
	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn
	objCmd.CommandText = "{CALL qparmGetEmployeeAccounts (" & CInt(p_intEmployeeID) & _
								", '" & p_strAnswerSet & "')}"

	'Response.Write objCmd.CommandText
	Set objRS = Server.CreateObject("ADODB.Recordset")
	Set objRS = objCmd.Execute


	Response.Write "<option value=>Choose one...</option>"
	Do While Not objRS.EOF
		If objRS.Fields("intAccountID") = intAccountID Then
			Response.Write "<option selected value='" & objRS.Fields("intAccountID") & "'>" & _
						objRS.Fields("strAccountName") & "</option>"
		Else
			Response.Write "<option value='" & objRS.Fields("intAccountID") & "'>" & _
						objRS.Fields("strAccountName") & "</option>"
		End If
		objRS.MoveNext
	Loop

%>
<!--#include file="DisConnect.inc"-->
<%
	'CheckForErrors(objConn)
End Sub

%>