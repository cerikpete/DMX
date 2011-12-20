<%@ Language=VBScript %>
<% Response.Buffer = True %>
<!-- #include file="adovbs.inc" -->
<!-- #include file="ErrorHandler.inc" -->
<!-- #include file="subGetEmployeeAccounts.asp" -->
<!-- #include file="subCreateNewAccount.asp" -->
<!-- #include file="subInsertUpdateAccount.asp" -->
<!-- #include file="subGetAccountInfo.asp" -->
<!-- #include file="subDeleteAccount.asp" -->
<!-- #include file="subExcelViewAccounts.asp" -->
<!-- #include file="subValidateAccount.asp" -->
<!-- #include file="subMoveAccount.asp" -->
<!-- #include file="subCloseAccount.asp" -->
<!-- #include file="subNotifyManager.asp" -->
<%

Dim dtmDate
Dim intCnt
Dim Number_Of_Records
Dim i, jj
Dim dtDate
Dim intEmpID, strFName, strLName
Dim dtAnswerSet, stAnswerSetDate
Dim intAccountID, intEmployeeID, strAnswerSet, strAnswerSet1, strAnswerSet2, strAnswerSet3
Dim strAccountName, strContact, strPhone, intLocationNumber
Dim mnyClosedRMR, mnyClosedRSS, mnyRMR_10, mnyRSS_10, mnyRMR_50
Dim mnyRSS_50, mnyRMR_90, mnyRSS_90
Dim bValid
Dim xlApplication, xlWB, strMessage
Dim dtMoveToMonth, strMoveToMonth
ReDim arrRowTotals(1)
Dim strAnswerSetDate

intAccountID = 0
mnyClosedRMR = 0
mnyClosedRSS = 0
mnyRMR_10 = 0
mnyRSS_10 = 0
mnyRMR_50 = 0
mnyRSS_50 = 0
mnyRMR_90 = 0
mnyRSS_90 = 0

intEmpID = Request("intEmpID")
strFName = Request("strFName")
strLName = Request("strLName")
intAccountID = Trim(Request.Form("intAccountID"))


strAnswerSet = Request("AnswerSet")
If Trim(strAnswerSet) = "" Then
	dtAnswerSet = Date()
Else
	dtAnswerSet = CDate(strAnswerSet)
End If
If intAccountID = "" Then
	intAccountID = 0
Else
	intAccountID = CInt(intAccountID)
End If

strMessage = ""

If Request.Form("FormAction") = "Save" Then
	intEmployeeID = CInt(Request("intEmpID"))
	strAccountName = Request.Form("strAccountName")
	strContact = Request.Form("strContact")
	strPhone = Request.Form("strPhone")
	intLocationNumber = Trim(Request.Form("intLocationNumber"))
	If intLocationNumber = "" Then intLocationNumber = 0
	mnyClosedRMR = Trim(Request.Form("mnyClosedRMR"))
	If mnyClosedRMR = "" THen mnyClosedRMR = 0
	mnyClosedRSS = Trim(Request.Form("mnyClosedRSS"))
	If mnyClosedRSS = "" Then mnyClosedRSS = 0
	mnyRMR_10 = Trim(Request.Form("mnyRMR_10"))
	If mnyRMR_10 = "" Then mnyRMR_10 = 0
	mnyRSS_10 = Trim(Request.Form("mnyRSS_10"))
	If mnyRSS_10 = "" Then mnyRSS_10 = 0
	mnyRMR_50 = Trim(Request.Form("mnyRMR_50"))
	If mnyRMR_50 = "" Then mnyRMR_50 = 0
	mnyRSS_50 = Trim(Request.Form("mnyRSS_50"))
	If mnyRSS_50 = "" Then mnyRSS_50 = 0
	mnyRMR_90 = Trim(Request.Form("mnyRMR_90"))
	If mnyRMR_90 = "" Then mnyRMR_90 = 0
	mnyRSS_90 = Trim(Request.Form("mnyRSS_90"))
	If mnyRSS_90 = "" Then mnyRSS_90 = 0


	bValid = true
	Dim strStatus
	If intAccountID = 0 Then
		'This is a new record.  Validate if Account Name is unique for that month
		bValid = ValidateAccount(intEmployeeID, strAnswerSet, strAccountName)
		strStatus=  "new"
	Else
		strStatus=  "change"
	End If

	If bValid = true Then
		InsertUpdateAccount intEmployeeID, strAnswerSet, intAccountID, _
				strAccountName, strContact, strPhone, intLocationNumber, _
				mnyClosedRMR, mnyClosedRSS, mnyRMR_10, mnyRSS_10, mnyRMR_50, _
				mnyRSS_50, mnyRMR_90, mnyRSS_90
		strMessage = NotifyManager(cStr(intEmployeeID), cStr(intAccountID), strStatus)
		strMessage = ""  'we don't really want a msg :)
	Else
		strMessage = "Account Name already exists for this period.  Please enter a new name."
	End If

ElseIf Request.Form("FormAction") = "Move" Then
	strMoveToMonth = Request.Form("MonthMoved")
	intAccountID = CInt(Request.Form("AccountID"))
	MoveAccount intAccountID, strMoveToMonth
	intAccountID = 0

ElseIf Request.Form("FormAction") = "Close" Then
	intAccountID = CInt(Request.Form("AccountID"))
	intEmployeeID = CInt(Request("intEmpID"))
	CloseAccount intAccountID
	strStatus=  "close"
	strMessage = NotifyManager(cStr(intEmployeeID), cStr(intAccountID), strStatus)
	strMessage = "Account Closed."
	intAccountID = 0

ElseIf Request.Form("FormAction") = "Delete" Then
	intAccountID = CInt(Request.Form("AccountID"))
	intEmployeeID = CInt(Request("intEmpID"))
	strStatus=  "delete"
	strMessage = NotifyManager(cStr(intEmployeeID), cStr(intAccountID), strStatus)
	DeleteAccount intAccountID
	strMessage = "Account Deleted."

ElseIf Request.Form("FormAction") = "New" Then
	intAccountID = 0

ElseIf Request.Form("FormAction") = "Next" Then
		dtDate = DateAdd("m", 1, CDate(Request.Form("AnswerSet")))
		strAnswerSet = Month(dtDate) & "/" & Year(dtDate)
		dtAnswerSet = cDate(strAnswerSet)
		intAccountID = 0

ElseIf Request.Form("FormAction") = "Reload" Then
	intAccountID = CInt(Request.Form("AccountID"))

ElseIf Request.Form("FormAction") = "Previous" Then
	dtDate = DateAdd("m", -1, CDate(Request.Form("AnswerSet")))
	strAnswerSet = Month(dtDate) & "/" & Year(dtDate)
	dtAnswerSet = cDate(strAnswerSet)
	intAccountID = 0

ElseIf Request.Form("FormAction") = "Report" Then

	jj = 0
	strAnswerSetDate = CDate(Request.Form("AnswerSet"))
	strAnswerSet1 = Month(strAnswerSetDate) & "/" & Year(strAnswerSetDate)
	strAnswerSet2 = Month(DateAdd("m", 1, strAnswerSetDate)) & "/" & Year(DateAdd("m", 1, strAnswerSetDate))
	strAnswerSet3 = Month(DateAdd("m", 2, strAnswerSetDate)) & "/" & Year(DateAdd("m", 2, strAnswerSetDate))

	intEmployeeID = CInt(Request("intEmpID"))
	'Create file system object
	Set fs = CreateObject("Scripting.FileSystemObject")
	Randomize
	currentPath = Left(Request.ServerVariables("PATH_TRANSLATED"), InStrRev(Request.ServerVariables("PATH_TRANSLATED"), "\"))
	randomTempFilename = CLng(Rnd * 1000000) & ".xls"
	reportTemplate = "dmx_top25forecast.xls"

	'create the temporary file in the directory
	fs.CopyFile currentPath  & "temp\" & reportTemplate, currentPath & "temp\" & randomTempFilename

	gDestination = currentPath & "temp\" & randomTempFilename

	gWorksheet = 1
	gStartRow = 4
	Call openExcel
	Top25ExcelReport intEmployeeID, -1, strAnswerSet1, strAnswerSet2, strAnswerSet3
	Call closeExcel
	Response.Redirect("temp/" & randomTempFilename)
End If
%>
<HTML>
<head>
	<title>DMX Music - Top 25 Forecast</title>
	<style>
			span.options {
				display:none;
			}
		</style>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body background="images/tile.jpg">
<form ACTION=Top25Forecast.asp?intEmpID=<%=Request("intEmpID")%>&strFName=<%=Request("strFName")%>&strLName=<%=Request("strLName")%> METHOD=post NAME=frmSalesHome>
<input type=hidden name=FormAction value=>
<P>&nbsp;</P>
	<table class="frame" cellpadding="0" cellspacing="0" align="center">
		<tr></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0">
					<tr valign=top>
						<td><img src="images/Independencegraphic1.jpg" width="273" height="81" alt="" border="0"></td>
						<td>
							<table cellpadding="0" cellspacing="0">
								<tr><td colspan="2"><img src="images/control_title.gif" width="303" height="63" alt="" border="0"></td></tr>
								<tr><td class="menu">Welcome <%Response.Write strFName & " " & strLName%></td><td class="menu" style="border-right: 1pt solid #999999;"></td></tr>
								<tr height="2"><td class="menu"></td><td class="menu" style="border-right: 1pt solid #999999;"></td></tr>
							</table>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td><img src="images/control_left.GIF" width="64" height="199" alt="" border="0"></td>
						<td>
							<table width="100%" cellpadding="0" cellspacing="0">
								<tr height="20"><td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td><td class="menu" style="border-bottom: 1pt solid #999999;"><a href="">Home</a></td><td class="menu">&nbsp;</td></tr>
								<tr height="20"><td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td><td class="menu" style="border-bottom: 1pt solid #999999;"><a href="SalesHome.asp?intEmpID=<%=Request("intEmpID")%>&strFName=<%=Request("strFName")%>&strLName=<%=Request("strLName")%>">Daily Sales</a></td><td class="menu">&nbsp;</td></tr>
								<tr height="20"><td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td><td class="menu" style="border-bottom: 1pt solid #999999;"><a href="">Contacts</a></td><td class="menu">&nbsp;</td></tr>
								<tr height="20"><td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td><td class="menu" style="border-bottom: 1pt solid #999999;"><a href="Top25Forecast.asp?intEmpID=<%=Request("intEmpID")%>&strFName=<%=Request("strFName")%>&strLName=<%=Request("strLName")%>">Top 25</a></td><td class="menu">&nbsp;</td></tr>
								<tr height="20"><td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td><td class="menu" style="border-bottom: 1pt solid #999999;"><a href="default.aspx">Log Off</a></td><td class="menu">&nbsp;</td></tr>
								<tr><td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td><td class="menu" height="160"></td><td class="menu">&nbsp;</td></tr>
								<tr><td colspan="3"><img src="images/menu_bottom.GIF" width="117" height="26" alt="" border="0"></td></tr>
							</table>
						</td>
						<td class="main" width="100%" style="padding: 20 20 20 20; text-align: center;">
							<table cellpadding="0" cellspacing="0" width="340">
								<TR>
									<Td class="title">TOP 25 Forecast</Td>
								</tr>
								<tr><td height="10"></td></tr>
							</table>
							<table class="dataheader tableheader" cellpadding="0" cellspacing="0" width="340">

<!--#include file="Connect.inc"-->

<%

				Set objCmd = Server.CreateObject("ADODB.Command")
				Set objCmd.ActiveConnection = objConn
				objCmd.CommandText = "{CALL qGetBusinessMonths}"
	'			Response.write(objCmd.CommandText)
				Set objRS = Server.CreateObject("ADODB.Recordset")
				Set objRS = objCmd.Execute
				Dim blnPrevExists, blnNextExists
				blnPrevExists = false
				blnNextExists = false
	
			If Trim(strAnswerSet) = "" Then
				Do While Not objRS.EOF
					
					If cDate(objRS("StartDate")) <= dtAnswerSet And dtAnswerSet <= cDate(objRS("EndDate")) Then
						strAnswerSet = objRS("intMonthID") & "/" & objRS("intYear")
						dtAnswerSet = cDate(strAnswerSet)
					End If
					objRS.MoveNext
				Loop
			End If 
			
			objRS.MoveFirst
			Dim prevAnswerSet, nextAnswerSet
			prevAnswerSet = DateAdd("m", -1, dtAnswerSet)
			nextAnswerSet = DateAdd("m", 1, dtAnswerSet)
			Do While Not objRS.EOF
				If objRS("intMonthID") = Month(prevAnswerSet) And objRS("intYear") = Year(prevAnswerSet) Then
					blnPrevExists = true
				ElseIf objRS("intMonthID") = Month(nextAnswerSet) And objRS("intYear") = Year(nextAnswerSet) Then
					blnNextExists = true
				End If
				objRS.MoveNext
			Loop

			Set objCmd = Nothing
			Set objRS = Nothing
%>
<!--#include file="DisConnect.inc"-->
							  <TR>
								<td class="dataheader"><% If blnPrevExists = true Then %><INPUT class="directional" TYPE="button" NAME="btnPrevious" VALUE="<"><% End If %></TD>
								<td class="dataheader header"><B>
									<%
									 	Response.Write MonthName(Month(dtAnswerSet)) & " " & Year(dtAnswerSet)
									%></B>
<input type=hidden name=AnswerSet value=<%=strAnswerSet%>>

								</Td>
								<td class="dataheader"><% If blnNextExists = true Then %><INPUT class="directional" TYPE="button" NAME="btnNext" VALUE=">"><% End If %></TD>
							  </TR>
							</table>
							<table class="tablebody" cellpadding="0" cellspacing="0" width="340">
								<tr>
									<td>
										<b>Account Names:</b>
									</td>
										<!--Get existing Account Names here-->
									<td>
										<table>
										<tr>
											<td>
												<select id=AccountID name=AccountID style="width:150px">

												<%
													dtAnswerSetDate = Trim(CStr(Month(dtAnswerSet) & "/" & Year(dtAnswerSet)))
													GetEmployeeAccounts intEmpID, dtAnswerSetDate, intAccountID
												%>

												</select>
											</td>
											<td>
												<input type=button name=btnClose value="Close ">
											</td>
										</tr>
										<tr>
											<td><A HREF="reactivateAccount.asp?intEmpID=<%=Request("intEmpID")%>&strFName=<%=Request("strFName")%>&strLName=<%=Request("strLName")%>&intUserType=3"><font size="-2">Re-Open Closed Account</font></a></td>
											<td><input type=button name=btnDelete value="Delete"></td>
										</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<b>Move To:</b>
									</td>
									<td>

										<select id=MonthMoved name=MonthMoved style="width:150px" onChange="if(this.value=='') this.selectedIndex=0;">

<!--#include file="Connect.inc"-->

<%
				Set objCmd = Server.CreateObject("ADODB.Command")
				Set objCmd.ActiveConnection = objConn
				objCmd.CommandText = "{CALL qGetNext3BusinessMonths('" & dtAnswerSet & "')}"
				Response.write(objCmd.CommandText)
				Set objRS = Server.CreateObject("ADODB.Recordset")
				Set objRS = objCmd.Execute 
				
				While Not ObjRS.EOF
%>

<option value="<%= objRS("intMonthID") & "/" & objRS("intYear") %>"><%= MonthName(objRS("intMonthID")) %>&nbsp;<%= objRS("intYear") %></option>
<%					ObjRS.MoveNext
				Wend %>
<option value="">------------</option>
<%
				Set objCmd = Server.CreateObject("ADODB.Command")
				Set objCmd.ActiveConnection = objConn
				objCmd.CommandText = "{CALL qGetPrev3BusinessMonths('" & dtAnswerSet & "')}"
				Response.write(objCmd.CommandText)
				Set objRS = Server.CreateObject("ADODB.Recordset")
				Set objRS = objCmd.Execute 
				
				While Not ObjRS.EOF
%>

<option value="<%= objRS("intMonthID") & "/" & objRS("intYear") %>"><%= MonthName(objRS("intMonthID")) %>&nbsp;<%= objRS("intYear") %></option>
<%					ObjRS.MoveNext
				Wend %>

<!--#include file="DisConnect.inc"-->
										</select>

										<input type=button name=btnMove value="Go">

									</td>
								</tr>
								<% If strMessage <> "" Then %>
									<tr>
										<td colspan=2>
											<% Response.Write "<b><font color=#CC3300>" & strMessage & "</font>" %>
										</td>
									</tr>
								<% End If %>
								<%
									If Request.Form("FormAction") = "New" Or Request.Form("FormAction") = "" Or _
										intAccountID = 0 OR intAccountID = "" Then
										CreateNewAccount
									Else
										If intAccountID > 0 Then
											GetAccountInfo intAccountID, 0
										End If
									End If

								%>
							</table>
							<table cellpadding="0" cellspacing="0" width="340">
								<tr>
									<td>&nbsp;</td>
								</tr>
							  <tr>
							  	<td style="text-align: right;"><INPUT TYPE=button NAME=btnCreate VALUE="Create New Account"></td>
								<td style="text-align: right;"><INPUT TYPE=button NAME=btnSave VALUE="Save Changes"></td>
								<td style="text-align: right;"><INPUT TYPE=button NAME=btnView VALUE="View"></td>
							  </tr>
							</table>
						</td>
						<td><img src="images/control_right.GIF" width="10" height="142" alt="" border="0"></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
	</table>
</FORM>
</BODY>
</HTML>

<SCRIPT Language=VBScript>
	Function bValidData
		bValidData = False
		If Not IsNumeric(frmSalesHome.intLocationNumber.value) And Trim(frmSalesHome.intLocationNumber.value) <> "" Then
			Msgbox "Please enter a valid numeric value for # of Location."
			Exit Function
		ElseIf Not IsNumeric(frmSalesHome.mnyClosedRMR.value) And Trim(frmSalesHome.mnyClosedRMR.value) <> "" Then
			Msgbox "Please enter a valid numeric value for Closed RMR."
			Exit Function
		ElseIf Not IsNumeric(frmSalesHome.mnyClosedRSS.value) And Trim(frmSalesHome.mnyClosedRSS.value) <> "" Then
			Msgbox "Please enter a valid numeric value for Closed RSS."
			Exit Function
		ElseIf Not IsNumeric(frmSalesHome.mnyRMR_10.value) And Trim(frmSalesHome.mnyRMR_10.value) <> "" Then
			Msgbox "Please enter a valid numeric value for 10% RMR."
			Exit Function
		ElseIf Not IsNumeric(frmSalesHome.mnyRSS_10.value) And Trim(frmSalesHome.mnyRSS_10.value) <> "" Then
			Msgbox "Please enter a valid numeric value for 10% RSS."
			Exit Function
		ElseIf Not IsNumeric(frmSalesHome.mnyRMR_50.value) And Trim(frmSalesHome.mnyRMR_50.value) <> "" Then
			Msgbox "Please enter a valid numeric value for 50% RMR."
			Exit Function
		ElseIf Not IsNumeric(frmSalesHome.mnyRSS_50.value) And Trim(frmSalesHome.mnyRSS_50.value) <> "" Then
			Msgbox "Please enter a valid numeric value for 50% RSS."
			Exit Function
		ElseIf Not IsNumeric(frmSalesHome.mnyRMR_90.value) And Trim(frmSalesHome.mnyRMR_90.value) <> "" Then
			Msgbox "Please enter a valid numeric value for 90% RMR."
			Exit Function
		ElseIf Not IsNumeric(frmSalesHome.mnyRSS_90.value) And Trim(frmSalesHome.mnyRSS_90.value) <> "" Then
			Msgbox "Please enter a valid numeric value for 90% RSS."
			Exit Function
		End If

		bValidData = True
	End Function

	Sub btnNext_OnClick()
		frmSalesHome.FormAction.value = "Next"
		Call frmSalesHome.submit()
	End Sub

	Sub btnPrevious_OnClick()
		frmSalesHome.FormAction.value = "Previous"
		Call frmSalesHome.submit()
	End Sub

	Sub btnSave_OnClick()
		If Trim(frmSalesHome.strAccountName.value) = "" Then
			Msgbox "Please enter Account Name"
			Exit Sub
		End If

		If Not bValidData Then
			Exit Sub
		End If

		frmSalesHome.FormAction.value = "Save"
		Call frmSalesHome.submit()
	End Sub

	Sub btnCreate_OnClick()
		frmSalesHome.FormAction.value = "New"
		Call frmSalesHome.submit()
	End Sub

	Sub btnView_OnClick()
		frmSalesHome.FormAction.value = "Report"
		Call frmSalesHome.submit()
	End Sub

	Sub btnDelete_OnClick()
		If frmSalesHome.AccountID.value =  "" Then
			Msgbox "Please select an Account from the List"
			Exit Sub
		End If
		If Msgbox("Are you sure?", vbYesNo, "Delete Account") = vbYes Then
			frmSalesHome.FormAction.value = "Delete"
			Call frmSalesHome.submit()
		End If
	End Sub

	Sub btnClose_OnClick()
		If frmSalesHome.AccountID.value =  "" Then
			Msgbox "Please select an Account from the List"
			Exit Sub
		End If
		If Msgbox("Are you sure?", vbYesNo, "Close Account") = vbYes Then
			frmSalesHome.FormAction.value = "Close"
			Call frmSalesHome.submit()
		End If
	End Sub

	Sub btnMove_OnClick()
		If frmSalesHome.AccountID.value =  "" Then
			Msgbox "Please select an Account from the List"
			Exit Sub
		End If
		If Msgbox("Are you sure?", vbYesNo, "Move Account") = vbYes Then
			frmSalesHome.FormAction.value = "Move"
			Call frmSalesHome.submit()
		End If
	End Sub

	Sub AccountID_OnChange()
		If frmSalesHome.AccountID.value <> "" Then
			frmSalesHome.FormAction.value = "Reload"
			Call frmSalesHome.submit()
		End If
	End Sub
</SCRIPT>

