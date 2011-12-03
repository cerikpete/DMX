<%@ Register TagPrefix="uc1" TagName="UserMenu" Src="../Controls/UserMenu.ascx" %>
<%@ Page CodeBehind="userAdmin.aspx.cs" Language="c#" AutoEventWireup="True" Inherits="dmx.Admin.userAdmin" %>
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
			<table border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td width="273" valign="bottom"><img height="81" alt="" src="../images/control_top.GIF" width="273" border="0"></td>
					<td><table height="81" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="63" align="left"><IMG height="63" alt="" src="../images/control_title.GIF" width="303" border="0"></td>
							</tr>
							<tr>
								<td height="18" bgcolor="#dedbde">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2"><table width="576" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td width="64"><img src="../images/control_left.GIF" width="64" height="199"></td>
								<td width="117"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="200" class="menu">&nbsp;
												<uc1:UserMenu id="ucMenu" runat="server"></uc1:UserMenu></td>
										</tr>
										<tr>
											<td><img src="../images/menu_bottom.GIF" width="117" height="26"></td>
										</tr>
									</table>
								</td>
								<td width="385" bgcolor="#ffffff" class="main"><div class="title">Staff list
									</div>
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td class="maincell"><P><STRONG>Employee Type:</STRONG>
													<asp:dropdownlist id="lstEmployeeType" runat="server" AutoPostBack="True" DataTextField="strEmployeeType"
														DataValueField="intEmployeeTypeID" OnSelectedIndexChanged="lstEmployeeType_Changed"></asp:dropdownlist>
												</P>
												<P align="center">
													<asp:Button id="btnAddUser" runat="server" Text="Add New User" OnClick="btnAddUser_Click"></asp:Button>
													<br>
													<a href="reactivateUser.aspx">re-activate user</a></P>
												<asp:datagrid id="grdEmployees" runat="server" AutoGenerateColumns="False" GridLines="None" CellPadding="2"
													ItemStyle-BackColor="Gainsboro" CellSpacing="2" OnDeleteCommand="grdEmployees_Deactivate"
													OnItemDataBound="grdEmployees_DataBound">
													<Columns>
														<asp:BoundColumn DataField="intEmployeeID" Visible="False"></asp:BoundColumn>
														<asp:TemplateColumn>
															<HeaderTemplate>
																<b>Name:</b>
															</HeaderTemplate>
															<ItemTemplate>
																<b>
																	<%# DataBinder.Eval(Container.DataItem, "strLastName") %>
																	,
																	<%# DataBinder.Eval(Container.DataItem, "strFirstName") %>
																</b>
															</ItemTemplate>
														</asp:TemplateColumn>
														<asp:TemplateColumn>
															<ItemTemplate>
																<a href='editUser.aspx?intEmpID=<%# DataBinder.Eval(Container.DataItem, "intEmployeeID") %>'>
																	edit</a>
															</ItemTemplate>
														</asp:TemplateColumn>
														<asp:ButtonColumn Text="de-activate" CommandName="Delete" ItemStyle-CssClass="error" ButtonType="LinkButton"></asp:ButtonColumn>
													</Columns>
												</asp:datagrid></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
								<td width="10"><img src="../images/control_right.GIF" width="10" height="142"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<br>
	</body>
</HTML>
