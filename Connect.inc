<%
On Error Goto 0
Set objConn = Server.CreateObject("ADODB.Connection")
objConn.Open Application("ConnectString")

%>