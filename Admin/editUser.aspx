<%@ Page language="c#" Codebehind="editUser.aspx.cs" AutoEventWireup="True" Inherits="dmx.Admin.editUser" %>
<%@ Register TagPrefix="uc1" TagName="UserMenu" Src="../Controls/UserMenu.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>DMX MUSIC</title>
		<meta content="Microsoft Visual Studio 6.0" name="GENERATOR">
		<style>SPAN.options {
	DISPLAY: none
}
</style>
		<LINK href="../style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body background="../images/tile.jpg">
		<p>&nbsp;</p>
		<form id="loginForm" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" align="center" border="0">
				<tr>
					<td vAlign="bottom" width="273"><IMG height="81" alt="" src="../images/control_top.GIF" width="273" border="0"></td>
					<td>
						<table height="81" cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td align="left" height="63"><IMG height="63" alt="" src="../images/control_title.GIF" width="303" border="0"></td>
							</tr>
							<tr>
								<td bgColor="#dedbde" height="18"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colSpan="2">
						<table cellSpacing="0" cellPadding="0" width="576" border="0">
							<tr vAlign="top">
								<td width="64"><IMG height="199" src="../images/control_left.GIF" width="64"></td>
								<td width="117">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td class="menu" height="200">&nbsp;
												<uc1:usermenu id="ucMenu" runat="server"></uc1:usermenu></td>
										</tr>
										<tr>
											<td><IMG height="26" src="../images/menu_bottom.GIF" width="117"></td>
										</tr>
									</table>
								</td>
								<td class="main" width="385" bgColor="#ffffff">
									<div class="title">Edit USER
									</div>
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td align="center"><asp:label id="lblMessage" runat="server" CssClass="error" Visible="False"></asp:label></td>
										</tr>
										<tr>
											<td class="maincell">
												<table cellSpacing="0" cellPadding="0" width="340">
													<tr>
														<td>
															<P>
																<TABLE id="formTable" cellSpacing="2" cellPadding="2" width="100%" border="0">
																	<TR>
																		<TD align="right" height="18">User Type:</TD>
																		<TD height="18"><asp:dropdownlist id="lstEmployeeType" runat="server" OnSelectedIndexChanged="lstEmployeeType_Changed"
																				DataValueField="intEmployeeTypeID" DataTextField="strEmployeeType" AutoPostBack="True"></asp:dropdownlist></TD>
																	</TR>
																	<TR>
																		<TD align="right" height="40">First Name:</TD>
																		<TD height="40"><asp:textbox id="txtFirstName" runat="server"></asp:textbox><asp:requiredfieldvalidator id="vldFirstName" runat="server" Display="Dynamic" ControlToValidate="txtFirstName"
																				ErrorMessage="First Name Required"></asp:requiredfieldvalidator></TD>
																	</TR>
																	<TR>
																		<TD align="right">Last Name:</TD>
																		<TD><asp:textbox id="txtLastName" runat="server"></asp:textbox></TD>
																	</TR>
																	<TR>
																		<TD align="right">User Name:</TD>
																		<TD><asp:textbox id="txtUserName" runat="server"></asp:textbox><asp:regularexpressionvalidator id="vldUserName" runat="server" Display="Dynamic" ControlToValidate="txtUserName"
																				ErrorMessage="User name must be at least 3 characters long, and can only contain letters and numbers." ValidationExpression="\w{3}[\w]*"></asp:regularexpressionvalidator><asp:requiredfieldvalidator id="vldUserNameReq" runat="server" Display="Dynamic" ControlToValidate="txtUserName"
																				ErrorMessage="User Name Required"></asp:requiredfieldvalidator></TD>
																	</TR>
																	<TR>
																		<TD align="right">Password:</TD>
																		<TD><asp:textbox id="txtPassword" runat="server"></asp:textbox><asp:regularexpressionvalidator id="vldPassword" runat="server" Display="Dynamic" ControlToValidate="txtPassword"
																				ErrorMessage="Password must be at least 3 characters long, and can only contain letters and numbers." ValidationExpression="\w{3}[\w]*"></asp:regularexpressionvalidator><asp:requiredfieldvalidator id="vldPasswordReq" runat="server" Display="Dynamic" ControlToValidate="txtPassword"
																				ErrorMessage="Password Required"></asp:requiredfieldvalidator></TD>
																	</TR>
																	<TR>
																		<TD align="right">Address:</TD>
																		<TD><asp:textbox id="txtAddress" runat="server"></asp:textbox></TD>
																	</TR>
																	<TR>
																		<TD align="right">Email:</TD>
																		<TD><asp:textbox id="txtEmail" runat="server"></asp:textbox><asp:regularexpressionvalidator id="vldEmail" runat="server" Display="Dynamic" ControlToValidate="txtEmail" ErrorMessage="Not a valid email address!"
																				ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator></TD>
																	</TR>
																	<TR>
																		<TD align="right">Phone:</TD>
																		<TD><asp:textbox id="txtPhone" runat="server"></asp:textbox><asp:regularexpressionvalidator id="vldPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Not a valid phone number!"
																				ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:regularexpressionvalidator></TD>
																	</TR>
																	<TR id="rwRegion" runat="server">
																		<TD align="right">Region:</TD>
																		<TD><asp:dropdownlist id="lstRegion" runat="server" DataTextField="strRegion"></asp:dropdownlist></TD>
																	</TR>
																	<TR id="rwArea" runat="server">
																		<TD align="right">Area:</TD>
																		<TD><asp:dropdownlist id="lstArea" runat="server" DataTextField="strArea"></asp:dropdownlist></TD>
																	</TR>
																	<TR id="rwLSO" runat="server">
																		<TD align="right">LSO:</TD>
																		<TD><asp:dropdownlist id="lstLSO" runat="server" DataTextField="strLSO"></asp:dropdownlist></TD>
																	</TR>
																	<TR id="rwManager" runat="server" Visible="False">
																		<TD align="right">Sales Manager:
																		</TD>
																		<TD><asp:dropdownlist id="lstManagers" runat="server" DataValueField="intEmployeeID" DataTextField="strFullName"></asp:dropdownlist></TD>
																	</TR>
																	<TR>
																		<TD></TD>
																		<TD></TD>
																	</TR>
																</TABLE>
															<p></p>
														</td>
													</tr>
													<tr>
														<td>&nbsp;</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
												<table cellSpacing="0" cellPadding="0" width="340">
													<tr>
														<td>&nbsp;</td>
													</tr>
													<tr>
														<td><asp:button id="btnSubmit" onclick="btnSubmit_Click" runat="server" Text="Submit"></asp:button></td>
														<td><INPUT type="reset" value="Reset" name="reset"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<td width="10"><IMG height="142" src="../images/control_right.GIF" width="10"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<p>&nbsp;</p>
		</form>
		<br>
	</body>
</HTML>
