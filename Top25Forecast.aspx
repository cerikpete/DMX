<%@ Register TagPrefix="uc1" TagName="UserMenu" Src="Controls/UserMenu.ascx" %>
<%@ Page language="c#" Codebehind="Top25Forecast.aspx.cs" AutoEventWireup="True" Inherits="dmx.Top25Forecast" %>
<HTML>
	<HEAD>
		<title>DMX MUSIC</title>
		<meta content="Microsoft Visual Studio 6.0" name="GENERATOR">
		<LINK href="style.css" type="text/css" rel="stylesheet">
			<script language="javascript">
	function openWin(URL, height, width)
	{
		aWindow=window.open(URL,'displaypic1600','width=' + width + ',height=' + height + ',resizable=0,scrollbars=1,toolbar=0,location=0,directories=0,status=0,menubar=0')
	}
			</script>
	</HEAD>
	<body background="images/tile.jpg">
		<form id="frmTop25" runat="server">
			<p></p>
			<p></p>
			<table border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td width="273" valign="bottom"><img height="81" alt="" src="images/Independencegraphic1.jpg" width="273" border="0"></td>
					<td><table height="81" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="63" align="left"><IMG height="63" alt="" src="images/control_title.gif" width="303" border="0"></td>
							</tr>
							<tr>
								<td height="18" bgcolor="#dedbde">Welcome,
									<span class="menu">
										<asp:label id="lblName" runat="server"></asp:label>
									</span></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2"><table width="576" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td width="64"><img src="images/control_left.GIF" width="64" height="199"></td>
								<td width="117"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="200" class="menu">&nbsp;
												<uc1:UserMenu id="ucMenu" runat="server"></uc1:UserMenu></td>
										</tr>
										<tr>
											<td><img src="images/menu_bottom.GIF" width="117" height="26"></td>
										</tr>
									</table>
								</td>
								<td width="385" bgcolor="#ffffff" class="main"><div class="title">TOP 25
										<asp:label id="lblTitle" runat="server">Forecast</asp:label>
									</div>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td align="center" class="mainheader"><table cellSpacing="0" cellPadding="0" width="80%">
													<TR>
														<td class="dataheader"><asp:button id="btnPrev" onclick="btnPrev_Click" runat="server" Text="<<" CausesValidation="False"></asp:button></td>
														<td class="dataheader header"><asp:label id="lblMonth" runat="server" Font-Bold="True"></asp:label></td>
														<td class="dataheader" align="right"><asp:button id="btnNext" onclick="btnNext_Click" runat="server" Text=">>" CausesValidation="False"></asp:button></td>
													</TR>
												</table>
											</td>
										</tr>
										<tr>
											<td class="maincell"><br>
												<table cellSpacing="0" cellPadding="0" width="340">
													<TBODY>
														<asp:panel id="pnlManagerCtrls" runat="server" Visible="False">
															<TR id="trStatus" runat="server">
																<TD><B>Forecast Status:</B>
																</TD>
																<TD>
																	<asp:dropdownlist id="lstStatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="lstStatus_Changed">
																		<asp:ListItem Value="False" Selected="True">Unapproved</asp:ListItem>
																		<asp:ListItem Value="True">Approved</asp:ListItem>
																	</asp:dropdownlist></TD>
															</TR>
															<TR id="trEmployees" runat="server">
																<TD><B>Employees:</B>
																</TD>
																<TD>
																	<asp:dropdownlist id="lstEmployees" runat="server" AutoPostBack="True" OnSelectedIndexChanged="lstEmployees_Changed"></asp:dropdownlist></TD>
															</TR>
														</asp:panel>
														<asp:panel id="pnlNamesMove" Runat="server">
															<TR>
																<TD><B>Account Names:</B>
																</TD>
																<TD>
																	<TABLE cellSpacing="0" cellPadding="0">
																		<TR>
																			<TD>
																				<asp:dropdownlist id="lstAccounts" runat="server" AutoPostBack="true" OnSelectedIndexChanged="lstAccounts_Changed"></asp:dropdownlist></TD>
																		</TR>
																		<asp:panel id="pnlAcctControls" runat="server" Visible="false">
																			<TR>
																				<TD>
																					<P align="center">
																						<asp:button id="btnClose" onclick="btnClose_Click" runat="server" CausesValidation="False" Text="Close"></asp:button>&nbsp;
																						<asp:button id="btnDelete" onclick="btnDelete_Click" runat="server" CausesValidation="False"
																							Text="Delete"></asp:button></P>
																				</TD>
																			</TR>
																			<TR>
																				<TD align="center">
																					<asp:hyperlink id="lnkReopen" runat="server" Font-Size="7pt" NavigateUrl="reActivateAcct.aspx">Re-Open Closed Account</asp:hyperlink></TD>
																			</TR>
																		</asp:panel></TABLE>
																	<asp:label id="lblMessage" runat="server" Visible="False" CssClass="error"></asp:label></TD>
															</TR>
															<TR>
																<TD><B>Move To:</B>
																</TD>
																<TD>
																	<asp:dropdownlist id="lstMoveTo" runat="server"></asp:dropdownlist>&nbsp;
																	<asp:button id="btnMove" onclick="btnMove_Click" runat="server" CausesValidation="False" Text="Move"></asp:button></TD>
															</TR>
														</asp:panel>
														<asp:panel id="pnlAccountInfo" Runat="server">
															<TR>
																<TD class="odd">Account Name:</TD>
																<TD class="odd">
																	<asp:textbox id="txtAccountName" runat="server"></asp:textbox>
																	<asp:requiredfieldvalidator id="reqAccountName" runat="server" ErrorMessage="Required!" ControlToValidate="txtAccountName"
																		Display="Dynamic"></asp:requiredfieldvalidator></TD>
															</TR>
															<TR>
																<TD class="even">Contact:</TD>
																<TD class="even">
																	<asp:textbox id="txtContact" runat="server"></asp:textbox></TD>
															</TR>
															<TR>
																<TD class="odd">Phone No.:</TD>
																<TD class="odd">
																	<asp:textbox id="txtPhone" runat="server"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldPhone" runat="server" ErrorMessage="Invalid phone format" ControlToValidate="txtPhone"
																		Display="Dynamic" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="even"># of Location:</TD>
																<TD class="even">
																	<asp:textbox id="txtLocations" runat="server" Width="40px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldLocations" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtLocations"
																		Display="Dynamic" ValidationExpression="\d+"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="odd">Closed RMR:</TD>
																<TD class="odd">
																	<asp:textbox id="txtClosedRMR" runat="server" CssClass="money" Width="80px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldClosedRMR" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtClosedRMR"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="even">Closed RSS:</TD>
																<TD class="even">
																	<asp:textbox id="txtClosedRSS" runat="server" CssClass="money" Width="80px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldClosedRSS" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtClosedRSS"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="odd">10% RMR:</TD>
																<TD class="odd">
																	<asp:textbox id="txtRMR_10" runat="server" CssClass="money" Width="80px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldRMR_10" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtRMR_10"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="even">10% RSS:</TD>
																<TD class="even">
																	<asp:textbox id="txtRSS_10" runat="server" CssClass="money" Width="80px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldRSS_10" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtRSS_10"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="odd">50% RMR:</TD>
																<TD class="odd">
																	<asp:textbox id="txtRMR_50" runat="server" CssClass="money" Width="80px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldRMR_50" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtRMR_50"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="even">50% RSS:</TD>
																<TD class="even">
																	<asp:textbox id="txtRSS_50" runat="server" CssClass="money" Width="80px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldRSS_50" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtRSS_50"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="odd">90% RMR:</TD>
																<TD class="odd">
																	<asp:textbox id="txtRMR_90" runat="server" CssClass="money" Width="80px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldRMR_90" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtRMR_90"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator></TD>
															</TR>
															<TR>
																<TD class="even">90% RSS:</TD>
																<TD class="even">
																	<asp:textbox id="txtRSS_90" runat="server" CssClass="money" Width="80px"></asp:textbox>
																	<asp:regularexpressionvalidator id="vldRSS_90" runat="server" ErrorMessage="Must be a number!" ControlToValidate="txtRSS_90"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator></TD>
															</TR>
														</asp:panel>
													</TBODY>
												</table>
											</td>
										</tr>
										<tr>
											<td><asp:panel id="pnlButtons" Runat="server">
													<TABLE cellSpacing="0" cellPadding="0" width="340">
														<TR>
															<TD>&nbsp;</TD>
														</TR>
														<TR>
															<TD>
																<asp:button id="btnNewAccount" onclick="btnNewAccount_Click" runat="server" CausesValidation="False"
																	Text="Clear Form"></asp:button></TD>
															<TD>
																<asp:button id="btnSave" onclick="btnSave_Click" runat="server" Text="Save Changes" CommandName="Save"></asp:button></TD>
															<TD>
																<asp:button id="btnView" onclick="btnView_Click" runat="server" CausesValidation="False" Text="View"></asp:button></TD>
														</TR>
													</TABLE>
												</asp:panel></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
								<td width="10"><img src="images/control_right.GIF" width="10" height="142"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
		</form>
	</body>
</HTML>
