<!--
*	FileName: subInsertUpdateAccount.asp
*	Description:
*		Creates/Updates Account
*
-->
<%
Sub InsertUpdateAccount( _
	p_intEmployeeID, _
	p_strAnswerSet, _
	p_intAccountID, _
	p_strAccountName, _
	p_strContact, _
	p_strPhone, _
	p_intLocationNumber, _
	p_mnyClosedRMR, _
	p_mnyCLosedRSS, _
	p_mnyRMR_10, _
	p_mnyRSS_10, _
	p_mnyRMR_50, _
	p_mnyRSS_50, _
	p_mnyRMR_90, _
	p_mnyRSS_90)

	Dim objCmd
	Dim objRS
%>
<!--#include file="Connect.inc"-->
<%
	'Call CheckForErrors(objConn)
	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn

	objConn.beginTrans


	objCmd.CommandText = "{ CALL sp_InsertUpdateAccount (" & p_intEmployeeID & _
						", '" & Trim(p_strAnswerSet) & _
						 "', " & Cint(p_intAccountID) & _
						 ", '" & Replace(p_strAccountName, "'", "''") & _
						 "', '" & Replace(p_strContact, "'", "''") & _
						 "', '" & Replace(p_strPhone, "'", "''") & _
						 "', " & p_intLocationNumber & _
 						 ", "  & p_mnyClosedRMR & _
						 ", " & p_mnyCLosedRSS & _
						 ", " & p_mnyRMR_10 & _
						 ", " & p_mnyRSS_10 & _
						 ", " & p_mnyRMR_50 & _
						 ", " & p_mnyRSS_50 & _
						 ", " & p_mnyRMR_90 & _
						 ", " & p_mnyRSS_90 & ")}"

'	Response.Write objCmd.CommandText

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




