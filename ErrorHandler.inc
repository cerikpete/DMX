<SCRIPT LANGUAGE=vbscript RUNAT=server>
Function CheckForErrors(objConnection)
	Dim blnDisplayErrMsg
	
	If objConnection.Errors.Count > 0 Then
		'Create the FileSystemObject and open the error log
		Set objFile = Server.CreateObject("Scripting.FileSystemObject")
		Set objLog = objFile.OpenTextFile(Server.MapPath("ErrorLog.txt"), 8, True)
		
		If Err.Number > 0 Then
			Response.Write "Error opening log file<P>"
			Response.Write "Error Number: " & Err.Number & _
										 ", Error Description: " & Err.Description
		End If
		
		'Create an error object to access the ADO errors coll
		Set objErr = Server.CreateObject("ADODB.Error")
		
		For Each objErr In objConnection.Errors
			If objErr.Number = 0 then
				blnDisplayErrMsg = False
			Else 
				objLog.WriteLine(objErr.Number & "|" & _
					objErr.Description & "|" & objErr.Source & "|" & _
					objErr.SQLState & "|" & objErr.NativeError)
				blnDisplayErrMsg = True
			End If
		Next
		objLog.Close
		Set objLog = Nothing
		Set objFile = Nothing
		Set objErr = Nothing
		
		If blnDisplayErrMsg Then
			Response.Write "An unforseen error has occurred and processing " & _
				"must be stopped.  You can try your request again later or you can " & _
				"call our Help Desk at <tel number>"
			Response.End
		End If
	End If
End Function
</SCRIPT>			
			
	