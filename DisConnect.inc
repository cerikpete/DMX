<%
On Error Resume Next

If IsObject(objCmd) Then
	objCmd.Close
	Set objCmd = Nothing
End If
If IsObject(objRS) Then
	objRS.Close
	Set objRS = Nothing
End If
objConn.Close
Set objConn = Nothing
%>