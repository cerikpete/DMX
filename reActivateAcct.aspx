<%@ Page language="c#" Codebehind="reActivateAcct.aspx.cs" AutoEventWireup="True" Inherits="dmx.reActivateAcct" %>
<%@ Register TagPrefix="uc1" TagName="UserMenu" Src="Controls/UserMenu.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>reActivateAcct</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body background="images/tile.jpg">
		<form id="Form1" method="post" runat="server">
			<p>&nbsp;</p>
			<table border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td width="273" valign="bottom"><img height="81" alt="" src="images/Independencegraphic1.jpg" width="273" border="0"></td>
					<td><table height="81" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="63" align="left"><IMG height="63" alt="" src="images/control_title.gif" width="303" border="0"></td>
							</tr>
							<tr>
								<td height="18" bgcolor="#dedbde">Welcome, <span class="menu">
										<asp:label id="lblName" runat="server"></asp:label>
									</span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2"><table width="576" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
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
								<td width="385" bgcolor="#ffffff" class="main"><div class="title">Re-activate Account</div>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="maincell"><table cellSpacing="0" cellPadding="0" width="340">
													<tr>
														<td>
															<P>Closed Accounts<BR>
																<asp:ListBox id="lstAccounts" runat="server" Width="250px" Rows="8"></asp:ListBox>
																<BR>
																<asp:RequiredFieldValidator id="vldAccounts" runat="server" ErrorMessage="You must select an account!" ControlToValidate="lstAccounts"></asp:RequiredFieldValidator>
																<BR>
															</P>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td><table cellSpacing="0" cellPadding="0" width="340">
													<tr>
														<td>&nbsp;</td>
													</tr>
													<tr>
														<td>
															<asp:Button id="btnActivate" runat="server" Text="Re-Activate Account" OnClick="btnActivate_Click"></asp:Button></td>
														<td></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<td width="10"><img src="images/control_right.GIF" width="10" height="142"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
