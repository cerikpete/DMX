<%@ Page language="c#" Codebehind="WebForm1.aspx.cs" AutoEventWireup="false" Inherits="dmx.WebForm1" %>
<%@ Register TagPrefix="uc1" TagName="Top25Summary" Src="Controls/Top25Summary.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Top25MonthSummary" Src="Controls/Top25MonthSummary.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Top25Account" Src="Controls/Top25Account.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>WebForm1</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="style.css" type="text/css" rel="stylesheet">
  </HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<P>&nbsp;</P>
			<P>
				<uc1:Top25Summary id="Top25Summary1" runat="server"></uc1:Top25Summary></P>
		</form>
	</body>
</HTML>
