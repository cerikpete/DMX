<!-- #include file="sendEmail.asp" -->
<!--
*	FileName: subNotifyManager.asp
*	Description:
*		Sends email to manager of sales person if they make a change to an existing, approved
*		account record.
*
-->
<%
Function NotifyManager(p_intEmployeeID, p_intAccountID, p_strStatus)

	Dim strToAdrs, strFromAdrs, strSubject, strBody
	Dim objCmd
	Dim objRS
	Dim dateParts
%>
<!--#include file="Connect.inc"-->
<%


	'Call CheckForErrors(objConn)
	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn

	objCmd.CommandText = "{ CALL qparmGetNotifyManagerInfo (" & p_intEmployeeID & _
													   ", " & p_intAccountID & ")}"
	Set objRS = Server.CreateObject("ADODB.Recordset")
	Set objRS = objCmd.Execute

		
	If objRS.EOF Then 
		NotifyManager = false
	Else
		dateParts = Split(cStr(objRS("strAnswerSet")), "/")
		strBody = cStr(objRS("Name")) 

		If p_strStatus = "change" Then
			If objRS("ApprovedAccountID") > 0 Then
				strSubject = "Account Changed: " & MonthName(dateParts(0)) & " " & dateParts(1) & ": " & cStr(objRS("strAccountName")) 
				strBody = strBody & " has made changes to a previously approved Account. " & VbCrLf
			Else
				Exit Function
			End If
		ElseIf p_strStatus = "close" Then
			If objRS("ApprovedAccountID") > 0 Then
				strSubject = "Account Closed: " & MonthName(dateParts(0)) & " " & dateParts(1) & ": " & cStr(objRS("strAccountName")) 
				strBody = strBody & " has closed this Account." & VbCrLf
			Else
				Exit Function
			End If
		ElseIf p_strStatus = "delete" Then
			If objRS("ApprovedAccountID") > 0 Then
				strSubject = "Account Deleted: " & MonthName(dateParts(0)) & " " & dateParts(1) & ": " & cStr(objRS("strAccountName")) 
				strBody = strBody & " has deleted this Account." & VbCrLf
			Else
				Exit Function
			End If
		Else
			strSubject = "New Account: " & MonthName(dateParts(0)) & " " & dateParts(1) & ": " & cStr(objRS("strAccountName"))
			strBody = strBody & " has added a new Account. " & VbCrLf
		End If

		strBody = strBody & "Account: " & cStr(objRS("strAccountName")) & VbCrLf &_
				  "For: " & MonthName(dateParts(0)) & " " & dateParts(1) & VbCrLf & VbCrLf &_
				  "Please log on and verify these changes at your earliest convenience: " & VbCrLf &_
				  "http://www.dmxmusicsystems.com/dmx"
		strToAdrs = cStr(objRS("managerEmail"))

		strFromAdrs = "dmx_website@dmxmusicsystems.com"
		NotifyManager = quickSend(strToAdrs, strFromAdrs, strSubject, strBody)
	End If
		

%>
<!--#include file="DisConnect.inc"-->
<%
	'CheckForErrors(objConn)
End Function
%>

