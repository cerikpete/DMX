<SCRIPT LANGUAGE=vbscript RUNAT=server>
	If Not Session("EmployeeID") > 0 Then
		Session.abandon
		Response.Redirect("default.asp")
	End If
</SCRIPT>			
			
	