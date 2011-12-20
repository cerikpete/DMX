<%@ Page CodeBehind="default.aspx.cs" Language="c#" AutoEventWireup="True" Inherits="dmx._default" %>
<HTML>
	<HEAD>
		<title>DMX MUSIC</title>
		<meta content="Microsoft Visual Studio 6.0" name="GENERATOR">
		<style>SPAN.options { DISPLAY: none }
	</style>
		<LINK href="style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body background="images/tile.jpg">
		<p>&nbsp;</p>
		<form id="loginForm" method="post" runat="server">
			<p>&nbsp;</p>
			<table border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td width="273" valign="bottom"><img height="81" alt="" src="images/Independencegraphic1.jpg" width="273" border="0"></td>
					<td><table height="81" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="63" align="left"><IMG height="63" alt="" src="images/control_title.gif" width="303" border="0"></td>
							</tr>
							<tr>
								<td height="18" bgcolor="#dedbde">&nbsp;</td>
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
											<td height="200" class="menu">&nbsp;</td>
										</tr>
										<tr>
											<td><img src="images/menu_bottom.GIF" width="117" height="26"></td>
										</tr>
									</table>
								</td>
								<td width="385" bgcolor="#ffffff" class="main"><div class="title">Login</div>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td align="center" height="10"><asp:label id="Message" runat="server" Visible="False"></asp:label></td>
										</tr>
										<tr>
											<td class="maincell"><table cellSpacing="0" cellPadding="0" width="340">
													<tr>
														<td>Username</td>
														<td class="textfield"><asp:textbox id="txtUserName" runat="server"></asp:textbox></td>
													</tr>
													<tr>
														<td>Password</td>
														<td class="textfield"><asp:textbox id="txtPassword" runat="server" TextMode="Password"></asp:textbox></td>
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
														<td><input type="submit" value="Submit" name="btnSubmit"></td>
														<td><input type="reset" value="Reset" name="btnReset"></td>
													</tr>
												</table>
											</td>
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
		</form>
		<br>
	</body>
</HTML>
