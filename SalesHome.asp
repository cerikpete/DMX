<%@ Language=VBScript %>
<!-- #include file="adovbs.inc" -->
<!-- #include file="ErrorHandler.inc" -->
<%
Dim blnChanged
Dim intEAnswerID, intEQuestionID, strEAnswer, strAnswerSetDate
Dim dtmDate, dtDate, dtAnswerSet
Dim arrEAnswerID, arrEQuestionID, arrEAnswerText, arrSetDate
Dim intCnt, Number_Of_Records, i
Dim intEmpID, strFName, strLName



intEmpID = Request("intEmpID")
strFName = Request("strFName")
strLName = Request("strLName")
If Trim(Request.Form("AnswerSet")) = "" Then
	dtAnswerSet = Date()
Else
	dtAnswerSet = Request.Form("AnswerSet")
End If

If Request.Form("FormAction") = "Edit" _
	Or  Request.Form("FormAction") = "Previous" _
	Or  Request.Form("FormAction") = "Next" _
Then
	On Error Resume Next
%>
<!-- #include file="Connect.inc" -->
<%

	'Check for database errors
	Call CheckForErrors(objConn)
	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn
	Set objRS = Server.CreateObject("ADODB.Recordset")
	objConn.beginTrans
		intEAnswerID = Request.Form("intEmployeeAnswerID")
		intEQuestionID = Request.Form("intEmployeeQuestionID")
		strEAnswer = Request.Form ("strEmployeeAnswer")
		strAnswerSetDate = Request.Form("strAnswerSet")
		dtmDate = Date()

	  'Place values in arrays
	  arrEAnswerID = Split(intEAnswerID,",")
	  arrEQuestionID = Split(intEQuestionID,",")
	  arrEAnswer = Split(strEAnswer, ",")
	  arrAnswerSetDate = Split(strAnswerSetDate, ",")
	  Number_Of_Records = UBound(arrEQuestionID)
		For i = 0 to Number_Of_Records
			Set objRS = Server.CreateObject("ADODB.Recordset")
			objCmd.CommandText = "{CALL sp_InsertUpdateEmployeeQA (" & _
					 CInt(arrEQuestionID(i)) & _
					 ", '" & CStr(trim(arrEAnswer(i))) & _
	        "', '" & CStr(Trim(arrAnswerSetDate(i))) & _
	        "', '" & Date() & "')}"
	        'Response.Write objCmd.CommandText
			Set objRS = objCmd.Execute
			Set objRS = Nothing
		Next
		'Response.End

	If objConn.Errors.Count > 0 Then
		objConn.rollbackTrans
	Else
		objConn.commitTrans
	End If
	Call CheckForErrors(objConn)

	If Request.Form("FormAction") = "Next" Then
		If CDate(Request.Form("AnswerSet")) < Date() Then
			dtDate = CDate(Request.Form("AnswerSet")) + 1
			if Weekday(dtDate) = 1 Then
				'It is a Sunday,advance to Monday
				dtDate = dtDate + 1
			elseif Weekday(dtDate) = 7 Then
				'It is a Saturday, advance to Monday
				dtDate = dtDate + 2
			end if
		Else
			dtDate = CDate(Request.Form("AnswerSet"))
		End If
		dtAnswerSet = dtDate
	ElseIf Request.Form("FormAction") = "Previous" Then
		dtDate = CDate(Request.Form("AnswerSet")) - 1
		If Weekday(dtDate) = 1 Then
			'It is a Sunday, go back to Friday
			dtDate = dtDate - 2
		ElseIf Weekday(dtDate) = 7 Then
			'It is a Saturday, go back to Friday
			dtDate = dtDate - 1
		End If
		dtAnswerSet = dtDate
	End If
End If
%>
<!-- #include file="DisConnect.inc" -->
<!-- Load Sales Information for a specific Sales Staff -->
<!-- #include file="Connect.inc" -->
<%

	dtAnswerSet = Trim(CStr(dtAnswerSet))
	Call CheckForErrors(objConn)
	Set objCmd = Server.CreateObject("ADODB.Command")
	Set objCmd.ActiveConnection = objConn
	objCmd.CommandText = "{CALL qparmGetEmployeeQA(" & intEmpID & ", '" & dtAnswerSet & "')}"
	Set objRS = Server.CreateObject("ADODB.Recordset")
	Set objRS = objCmd.Execute

	Call CheckForErrors(objConn)
%>

<html>
<head>
	<title>DMX Music - Salesforce</title>
	<style>
			span.options {
				display:none;
			}
		</style>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body background="images/tile.jpg">
<form ACTION=SalesHome.asp?intEmpID=<%=Request("intEmpID")%>&strFName=<%=Request("strFName")%>&strLName=<%=Request("strLName")%> METHOD=post NAME=frmSalesHome>
<input type=hidden name=FormAction value=>
<input type=hidden name=AnswerSet value=<%=dtAnswerSet%>>
<p>
  <table class="frame" cellpadding="0" cellspacing="0" align="center">
		<tr></tr>
		<tr>
			<td>
				<table cellpadding="0" cellspacing="0">
					<tr valign=top>
						<td><img src="images/control_top.GIF" width="273" height="81" alt="" border="0"></td>
						<td>
							<table cellpadding="0" cellspacing="0">
								<tr><td colspan="2"><img src="images/control_title.GIF" width="303" height="63" alt="" border="0"></td></tr>
								<tr><td class="menu">Welcome <%Response.Write strFName & " " & strLName%></td><td class="menu" style="border-right: 1pt solid #999999;"></td></tr>
								<tr height="2"><td class="menu"></td><td class="menu" style="border-right: 1pt solid #999999;"></td></tr>
							</table>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td><img src="images/control_left.GIF" width="64" height="199" alt="" border="0"></td>
						<td><table width="100%"  border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td height="200" bgcolor="#DCDADA"><table width="100%" cellpadding="0" cellspacing="0">
                              <tr height="20">
                                <td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td>
                                <td class="menu" style="border-bottom: 1pt solid #999999;"><a href="">Home</a></td>
                                <td class="menu">&nbsp;</td>
                              </tr>
                              <tr height="20">
                                <td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td>
                                <td class="menu" style="border-bottom: 1pt solid #999999;"><a href="SalesHome.asp?intEmpID=<%=Request("intEmpID")%>&strFName=<%=Request("strFName")%>&strLName=<%=Request("strLName")%>">Daily Sales</a></td>
                                <td class="menu">&nbsp;</td>
                              </tr>
                              <tr height="20">
                                <td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td>
                                <td class="menu" style="border-bottom: 1pt solid #999999;"><a href="top25forecast.aspx">Top 25</a></td>
                                <td class="menu">&nbsp;</td>
                              </tr>
                              <tr height="20">
                                <td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td>
                                <td class="menu" style="border-bottom: 1pt solid #999999;"><a href="Installation_Log.xls">Installation Log</a></td>
                                <td class="menu">&nbsp;</td>
                              </tr>
                              <tr height="20">
                                <td class="menu" style="border-left: 1pt solid #999999;">&nbsp;</td>
                                <td class="menu" style="border-bottom: 1pt solid #999999;"><a href="default.aspx">Log Off</a></td>
                                <td class="menu">&nbsp;</td>
                              </tr>
                              <tr>
                                <td colspan="3">&nbsp;</td>
                              </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td><img src="images/menu_bottom.GIF" width="117" height="26" alt="" border="0"></td>
                          </tr>
                        </table></td>
						<td class="main" width="100%" style="padding: 20 20 20 20; text-align: center;">
							<table cellpadding="0" cellspacing="0" width="340">
								<TR>
									<Td class="title">Sales Questions</Td>
								</tr>
								<tr><td height="10"></td></tr>
							</table>
							<table class="dataheader tableheader" cellpadding="0" cellspacing="0" width="340">
							  <TR>
								<td class="dataheader"><INPUT class="directional" TYPE="button" NAME="btnPrevious" VALUE="<"></TD>
								<td class="dataheader header"><B>
									<%
										If Not objRS.EOF Then
											Response.Write FormatDateTime(dtAnswerSet, 1)
										End If
									%></B>
								</Td>
								<td class="dataheader"><INPUT class="directional" TYPE="button" NAME="btnNext" VALUE=">"></TD>
							  </TR>
							</table>
							<table class="tablebody" cellpadding="0" cellspacing="0" width="340">
								<%
								intCnt = 0
								Do While Not objRS.EOF
									intCnt = intCnt + 1
									if (intCnt mod 2) = 0 then
										strStyle = "even"
									else
										strStyle = "odd"
									end if
								%>
								<TR>
								<td class=<%Response.Write strStyle%>><%Response.Write objRS.Fields("strQuestionText")%></TD>
								<td class=<%Response.Write strStyle%> style="text-align: right;"><INPUT class="textfield" TYPE=text
										   NAME="strEmployeeAnswer"
										   VALUE="<%Response.Write objRS.Fields("strEmployeeAnswer")%>" 
										   <% If objRS.fields("questionType") = 1 Then %>
										   onChange="return checkNum(this)"
										   <% End If %> 
										   SIZE=5>
								</TD>
								<td class=<%Response.Write strStyle%>></TD>
								<INPUT TYPE=hidden
													 NAME="intEmployeeQuestionID"
													 VALUE="<%Response.Write objRS.Fields("intEmployeeQuestionID")%>">

								<INPUT TYPE=hidden
													 NAME="intEmployeeAnswerID"
													 VALUE="<%Response.Write objRS.Fields("intEmployeeAnswerID")%>">

								<INPUT TYPE=hidden
													 NAME="strAnswerSet"
													 VALUE="<%Response.Write dtAnswerSet
													 		  'Response.Write objRS.Fields("strAnswerSet")%>">

							  </TR>
								<%
										objRS.MoveNext
								Loop
								%>
							</table>
							<table cellpadding="0" cellspacing="0" width="340">
								<tr>
									<td>&nbsp;</td>
								</tr>
							  <tr>
								<td style="text-align: right;"><INPUT TYPE=button NAME=btnSave VALUE="Save Changes"></TD>
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
  <p>&nbsp;
  </p>
  <p>
    <!-- #include file="DisConnect.inc" -->
    
    <SCRIPT Language="JavaScript">
function checkNum(field) {
	var strCheck = field.value;
	var valid = true;
    if (!strCheck) {valid = false;}
    var Chars = "0123456789";

    for (var i = 0; i < strCheck.length; i++) {
       if (Chars.indexOf(strCheck.charAt(i)) == -1){
	   	  valid = false;
		  break;
	   }
    }
	if (!(valid)){
	  alert("Value must be numeric.");
	  field.value = '';
	  field.focus();
      return false;
	}else {
	    return true;
	}
} 
    </SCRIPT>
    
    <SCRIPT Language=VBScript>
	Sub btnNext_OnClick()
		frmSalesHome.FormAction.value = "Next"
		Call frmSalesHome.submit()
	End Sub

	Sub btnPrevious_OnClick()
		frmSalesHome.FormAction.value = "Previous"
		Call frmSalesHome.submit()
	End Sub

	Sub btnSave_OnClick()
		frmSalesHome.FormAction.value = "Edit"
		Call frmSalesHome.submit()
	End Sub
    </SCRIPT>
    
</p>
</FORM>
</BODY>
</HTML>
