<!--
*	FileName: subCreateNewAccount.asp
*	Description:
*		Creates/Updates Account
*
-->
<%
Sub CreateNewAccount

Response.Write "<input type=hidden id=intAccountID name=intAccountID value=></input>"
Response.Write "<tr>"
Response.Write "	<td class=odd>Account Name:</td>"
Response.Write "	<td class=odd><input type=text id=strAccountName name=strAccountName value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=even>Contact:</td>"
Response.Write "	<td class=even><input type=text id=strContact name=strContact value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=odd>Phone No.:</td>"
Response.Write "	<td class=odd><input type=text id=strPhone name=strPhone value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=even># of Location:</td>"
Response.Write "	<td class=even><input type=text id=intLocationNumber name=intLocationNumber value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=odd>Closed RMR:</td>"
Response.Write "	<td class=odd><input type=text id=mnyClosedRMR name=mnyClosedRMR value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=even>Closed RSS:</td>"
Response.Write "	<td class=even><input type=text id=mnyCLosedRSS name=mnyCLosedRSS value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=odd>10% RMR:</td>"
Response.Write "	<td class=odd><input type=text id=mnyRMR_10 name=mnyRMR_10 value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=even>10% RSS:</td>"
Response.Write "	<td class=even><input type=text id=mnyRSS_10 name=mnyRSS_10 value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=odd>50% RMR:</td>"
Response.Write "	<td class=odd><input type=text id=mnyRMR_50 name=mnyRMR_50 value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=even>50% RSS:</td>"
Response.Write "	<td class=even><input type=text id=mnyRSS_50 name=mnyRSS_50 value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=odd>90% RMR:</td>"
Response.Write "	<td class=odd><input type=text id=mnyRMR_90 name=mnyRMR_90 value=></td>"
Response.Write "</tr>"
Response.Write "<tr>"
Response.Write "	<td class=even>90% RSS:</td>"
Response.Write "	<td class=even><input type=text id=mnyRSS_90 name=mnyRSS_90 value=></td>"
Response.Write "</tr>"

End Sub
%>