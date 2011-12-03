<%@ Page CodeBehind="userQuotas.aspx.cs" Language="c#" AutoEventWireup="True" Inherits="dmx.Admin.userQuotas" %>
<%@ Register TagPrefix="uc1" TagName="UserMenu" Src="../Controls/UserMenu.ascx" %>
<HTML>
	<HEAD>
		<title>DMX MUSIC</title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
		<meta content="Microsoft Visual Studio 6.0" name="GENERATOR">
		<style>SPAN.options { DISPLAY: none }
	</style>
		<LINK href="../style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body background="../images/tile.jpg">
		<p>&nbsp;</p>
		<form id="loginForm" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" align="center" border="0">
				<tr>
					<td vAlign="bottom"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td width="273"><img height="81" alt="" src="../images/control_top.GIF" width="273" border="0"></td>
                        <td><table width="100%" height="81" border="0" cellPadding="0" cellSpacing="0">
                          <tr>
                            <td align="left" height="63"><IMG height="63" alt="" src="../images/control_title.GIF" width="303" border="0"></td>
                          </tr>
                          <tr>
                            <td bgColor="#dedbde" height="18"></td>
                          </tr>
                        </table></td>
                      </tr>
                </table>				    </td>
				</tr>
				<tr>
					<td>
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
									<div class="title">Staff list
									</div>
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td class="mainheader" align="center">
												<table cellSpacing="0" cellPadding="0" width="80%">
													<TR>
														<td class="dataheader"><asp:button id="btnPrev" onclick="btnPrev_Click" runat="server" CausesValidation="False" Text="<<"></asp:button></td>
														<td class="dataheader header"><asp:label id="lblYear" runat="server" Font-Bold="True"></asp:label></td>
														<td class="dataheader" align="right"><asp:button id="btnNext" onclick="btnNext_Click" runat="server" CausesValidation="False" Text=">>"></asp:button></td>
													</TR>
												</table>
											</td>
										</tr>
										<tr>
											<td class="maincell">
												<P><STRONG>Sales Rep:</STRONG>
													<asp:dropdownlist id="lstSalesReps" runat="server" OnSelectedIndexChanged="lstSalesReps_Changed" DataValueField="intEmployeeID"
														DataTextField="strFullName" AutoPostBack="True"></asp:dropdownlist></P>
												<table cellpadding="2" cellspacing="2">
													<tr>
														<td align="center"><b>Month:</b></td>
														<td align="center"><b>RMR Quota:</b></td>
														<td align="center"><b>RMR Funnel:</b></td>
														<td align="center"><b>RSS Quota:</b></td>
														<td align="center"><b>RSS Funnel:</b></td>
													</tr>
													<asp:repeater id="rptQuotas" runat="server">
														<ItemTemplate>
															<tr>
																<td align="right">
																	<asp:TextBox ID="EmployeeID" Visible="False" Runat=server Text='<%# DataBinder.Eval(Container.DataItem, "intEmployeeID") %>' />
																	<b>
																		<%# DataBinder.Eval(Container.DataItem, "dtmMonth", "{0:MMM}") %>
																	</b>
																</td>
																<td>
																	<asp:TextBox TabIndex="1" Columns=10 ID="RMRQuota" Runat=server Text='<%# DataBinder.Eval(Container.DataItem, "mnyRMRQuota", "{0:0.##;-0.##;0}") %>' CssClass="money" />
																	<asp:regularexpressionvalidator id="vldRMRQuota" runat="server" ErrorMessage="Must be a number!" ControlToValidate="RMRQuota"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator>
																</td>
																<td>
																	<asp:TextBox TabIndex="2" Columns=10 ID="RMRFunnel" Runat=server Text='<%# DataBinder.Eval(Container.DataItem, "mnyRMRFunnel", "{0:0.##;-0.##;0}") %>' CssClass="money" />
																	<asp:regularexpressionvalidator id="vldRMRFunnel" runat="server" ErrorMessage="Must be a number!" ControlToValidate="RMRFunnel"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator>
																</td>
																<td>
																	<asp:TextBox TabIndex="3" Columns=10 ID="RSSQuota" Runat=server Text='<%# DataBinder.Eval(Container.DataItem, "mnyRSSQuota", "{0:0.##;-0.##;0}") %>' CssClass="money" />
																	<asp:regularexpressionvalidator id="vldRSSQuota" runat="server" ErrorMessage="Must be a number!" ControlToValidate="RSSQuota"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator>
																</td>
																<td>
																	<asp:TextBox TabIndex="4" Columns=10 ID="RSSFunnel" Runat=server Text='<%# DataBinder.Eval(Container.DataItem, "mnyRSSFunnel", "{0:0.##;-0.##;0}") %>' CssClass="money" />
																	<asp:regularexpressionvalidator id="vldRSSFunnel" runat="server" ErrorMessage="Must be a number!" ControlToValidate="RSSFunnel"
																		Display="Dynamic" ValidationExpression="\d+.?\d*"></asp:regularexpressionvalidator>
																</td>
															</tr>
														</ItemTemplate>
													</asp:repeater>
												</table>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td><table cellpadding="0" cellspacing="0" border="0" width="100%">
													<tr>
														<td><asp:Button id="btnSave" runat="server" Text="Save Changes" OnClick="btnSave_Click"></asp:Button></td>
														<td align="right"><INPUT type="reset" value="Reset"></td>
													</tr>
												</table>
											</td>
										<tr>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
								<td width="10"><IMG height="142" src="../images/control_right.GIF" width="10"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<br>
	</body>
</HTML>
