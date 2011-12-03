<!--
*	FileName: subExcelViewAccounts.asp
*	Description:
*
-->
<%

Sub openExcel
	Set xlApplication = Server.CreateObject("Excel.Application")
	xlApplication.DisplayAlerts = False
	Set xlWB = xlApplication.Workbooks.open(gDestination)
End Sub

Sub closeExcel

	xlWB.Save
	xlWB.Close False

	xlApplication.Quit 'Close the Workbook
	Set xlWB = Nothing
	Set xlApplication = Nothing

End Sub

Sub Top25ExcelReport(p_intEmployeeID, p_bitApproved, p_strAnswerSet1, p_strAnswerSet2, p_strAnswerSet3)
	Dim objCmd
	Dim objRS
	Dim j, intColumn
	Dim intCnt
	Dim intTotalFields
	Dim strEmployeeName
	
	If p_bitApproved <> "0" And p_bitApproved <> "1" Then
		p_bitApproved = -1
	End If 
%>
<!--#include file="Connect.inc"-->
<%

	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn
	objCmd.CommandText = "SELECT strLastName + ', ' + strFirstName as Name FROM EmployeeInfo WHERE intEmployeeID = " & p_intEmployeeID

	Set objRS = Server.CreateObject("ADODB.Recordset")
	Set objRS = objCmd.Execute
	p_strEmployeeName = objRS("Name")
	

	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn
	objCmd.CommandText = "{CALL qparmGetAccountForView (" & p_intEmployeeID & ", " & p_bitApproved & ", '" &  Trim(p_strAnswerSet1) & "', '" &  Trim(p_strAnswerSet2) & "', '" &  Trim(p_strAnswerSet3) & "')}"
	Response.write	objCmd.CommandText
	Set objRS = Server.CreateObject("ADODB.Recordset")
	Set objRS = objCmd.Execute

	'Set values for first worksheet
'	Set xlWorksheet = xlWB.WorkSheets(gWorksheet)
	xlWB.WorkSheets(gWorksheet).Copy xlWB.WorkSheets(gWorksheet)
	Set xlWorksheet = xlWB.WorkSheets(gWorksheet)
	xlWorksheet.Name = p_strEmployeeName

	i = gStartRow

	j = 2 'Start printing the Question header on the 2nd column
	i = 4 '5th Row
	intTotalFields = 0
	xlWorksheet.Cells(1, 4) = p_strEmployeeName
	xlWorksheet.Cells(2, 4) = FormatDateTime(Date(), 1)
	xlWorksheet.Cells(2, 6) = "Month: " & p_strAnswerSet1
	xlWorksheet.Cells(2, 14) = "Month: " & p_strAnswerSet2
	xlWorksheet.Cells(2, 22) = "Month: " & p_strAnswerSet3
	Do While Not objRS.EOF
		i = i + 1
		If objRS.fields("intColumn") = 1 Then
			intColumn = 0
		ElseIf objRS.fields("intColumn") = 2 Then
			intColumn = 8
		ElseIf objRS.fields("intColumn") = 3 Then
			intColumn = 16
		End If
		xlWorksheet.Cells(i, j) = objRS.fields("strAccountName")
		xlWorksheet.Cells(i, j+1 ) = objRS.fields("strContact")
		xlWorksheet.Cells(i, j+2 ) = objRS.fields("strPhone")
		xlWorksheet.Cells(i, j+3 ) = objRS.fields("intLocationNumber")
		xlWorksheet.Cells(i, j+4 + intColumn) = objRS.fields("mnyClosedRMR")
		xlWorksheet.Cells(i, j+5 + intColumn) = objRS.fields("mnyClosedRSS")
		xlWorksheet.Cells(i, j+6 + intColumn) = objRS.fields("mnyRMR_10")
		xlWorksheet.Cells(i, j+7 + intColumn) = objRS.fields("mnyRSS_10")
		xlWorksheet.Cells(i, j+8 + intColumn) = objRS.fields("mnyRMR_50")
		xlWorksheet.Cells(i, j+9 + intColumn) = objRS.fields("mnyRSS_50")
		xlWorksheet.Cells(i, j+10 + intColumn) = objRS.fields("mnyRMR_90")
		xlWorksheet.Cells(i, j+11 + intColumn) = objRS.fields("mnyRSS_90")
		objRS.MoveNext
	Loop

	i = i + 4

	arrRowTotals(jj) = i 'The row in the excel sheet where the Totals occur


	xlWorksheet.Cells( i, 2) = "Totals"
	xlWorksheet.Cells(i, 6).Formula = "=SUM(F5:F"& i-4 &")"
	xlWorksheet.Cells(i, 7).Formula = "=SUM(G5:G"& i-4 &")"
	xlWorksheet.Cells(i, 8).Formula = "=SUM(H5:H"& i-4 &")"
	xlWorksheet.Cells(i, 9).Formula = "=SUM(I5:I"& i-4 &")"
	xlWorksheet.Cells(i, 10).Formula = "=SUM(J5:J"& i-4 &")"
	xlWorksheet.Cells(i, 11).Formula = "=SUM(K5:K"& i-4 &")"
	xlWorksheet.Cells(i, 12).Formula = "=SUM(L5:L"& i-4 &")"
	xlWorksheet.Cells(i, 13).Formula = "=SUM(M5:M"& i-4 &")"
	xlWorksheet.Cells(i, 14).Formula = "=SUM(N5:N"& i-4 &")"
	xlWorksheet.Cells(i, 15).Formula = "=SUM(O5:O"& i-4 &")"
	xlWorksheet.Cells(i, 16).Formula = "=SUM(P5:P"& i-4 &")"
	xlWorksheet.Cells(i, 17).Formula = "=SUM(Q5:Q"& i-4 &")"
	xlWorksheet.Cells(i, 18).Formula = "=SUM(R5:R"& i-4 &")"
	xlWorksheet.Cells(i, 19).Formula = "=SUM(S5:S"& i-4 &")"
	xlWorksheet.Cells(i, 20).Formula = "=SUM(T5:T"& i-4 &")"
	xlWorksheet.Cells(i, 21).Formula = "=SUM(U5:U"& i-4 &")"
	xlWorksheet.Cells(i, 22).Formula = "=SUM(V5:V"& i-4 &")"
	xlWorksheet.Cells(i, 23).Formula = "=SUM(W5:W"& i-4 &")"
	xlWorksheet.Cells(i, 24).Formula = "=SUM(X5:X"& i-4 &")"
	xlWorksheet.Cells(i, 25).Formula = "=SUM(Y5:Y"& i-4 &")"
	xlWorksheet.Cells(i, 26).Formula = "=SUM(Z5:Z"& i-4 &")"
	xlWorksheet.Cells(i, 27).Formula = "=SUM(AA5:AA"& i-4 &")"
	xlWorksheet.Cells(i, 28).Formula = "=SUM(AB5:AB"& i-4 &")"
	xlWorksheet.Cells(i, 29).Formula = "=SUM(AC5:AC"& i-4 &")"

	i = i + 1
	xlWorksheet.Cells( i, 2) = "Probable Totals"
'   Probable totals not necessary on these columns
'	xlWorksheet.Cells(i, 6).Formula = "=SUM(F"& i-1 & ")"
'	xlWorksheet.Cells(i, 7).Formula = "=SUM(G"& i-1 & ")"
	xlWorksheet.Cells(i, 6).Formula = "-"
	xlWorksheet.Cells(i, 7).Formula = "-"
	xlWorksheet.Cells(i, 8).Formula = "=SUM(H"& i-1 & "*0.1)"
	xlWorksheet.Cells(i, 9).Formula = "=SUM(I"& i-1 & "*0.1)"
	xlWorksheet.Cells(i, 10).Formula = "=SUM(J"& i-1 & "*0.5)"
	xlWorksheet.Cells(i, 11).Formula = "=SUM(K"& i-1 & "*0.5)"
	xlWorksheet.Cells(i, 12).Formula = "=SUM(L"& i-1 &"*0.9)"
	xlWorksheet.Cells(i, 13).Formula = "=SUM(M"& i-1 &"*0.9)"
'   Probable totals not necessary on these columns
'	xlWorksheet.Cells(i, 14).Formula = "=SUM(N"& i-1 & ")"
'	xlWorksheet.Cells(i, 15).Formula = "=SUM(O"& i-1 & ")"
	xlWorksheet.Cells(i, 14).Formula = "-"
	xlWorksheet.Cells(i, 15).Formula = "-"
	xlWorksheet.Cells(i, 16).Formula = "=SUM(P"& i-1 & "*0.1)"
	xlWorksheet.Cells(i, 17).Formula = "=SUM(Q"& i-1 & "*0.1)"
	xlWorksheet.Cells(i, 18).Formula = "=SUM(R"& i-1 & "*0.5)"
	xlWorksheet.Cells(i, 19).Formula = "=SUM(S"& i-1 & "*0.5)"
	xlWorksheet.Cells(i, 20).Formula = "=SUM(T"& i-1 &"*0.9)"
	xlWorksheet.Cells(i, 21).Formula = "=SUM(U"& i-1 &"*0.9)"
'   Probable totals not necessary on these columns
'	xlWorksheet.Cells(i, 22).Formula = "=SUM(V"& i-1 & ")"
'	xlWorksheet.Cells(i, 23).Formula = "=SUM(W"& i-1 & ")"
	xlWorksheet.Cells(i, 22).Formula = "-"
	xlWorksheet.Cells(i, 23).Formula = "-"
	xlWorksheet.Cells(i, 24).Formula = "=SUM(X"& i-1 & "*0.1)"
	xlWorksheet.Cells(i, 25).Formula = "=SUM(Y"& i-1 & "*0.1)"
	xlWorksheet.Cells(i, 26).Formula = "=SUM(Z"& i-1 & "*0.5)"
	xlWorksheet.Cells(i, 27).Formula = "=SUM(AA"& i-1 & "*0.5)"
	xlWorksheet.Cells(i, 28).Formula = "=SUM(AB"& i-1 &"*0.9)"
	xlWorksheet.Cells(i, 29).Formula = "=SUM(AC"& i-1 &"*0.9)"

	i = i + 1
	xlWorksheet.Cells( i, 2) = "Monthly Probable Totals"
	xlWorksheet.Cells(i, 6).Formula  ="=SUM(F" & i-2 & "+H" & i-1 & "+J" & i-1 & "+L"  & i-1 & ")"
	xlWorksheet.Cells(i, 14).Formula ="=SUM(N" & i-2 & "+P" & i-1 & "+R" & i-1 & "+T"  & i-1 & ")"
	xlWorksheet.Cells(i, 22).Formula ="=SUM(V" & i-2 & "+X" & i-1 & "+Z" & i-1 & "+AB" & i-1 & ")"

	xlWorksheet.Cells(i, 7).Formula = "=SUM(G" & i-2 & "+I" & i-1 & "+K" & i-1 & "+M"  & i-1 & ")"
	xlWorksheet.Cells(i,15).Formula = "=SUM(O" & i-2 & "+Q" & i-1 & "+S" & i-1 & "+U"  & i-1 & ")"
	xlWorksheet.Cells(i,23).Formula = "=SUM(W" & i-2 & "+Y" & i-1 & "+AA"& i-1 & "+AC" & i-1 & ")"

	objRS.Close

%>
<!--#include file="DisConnect.inc"-->
<%
	'CheckForErrors(objConn)
End Sub



%>