namespace dmx.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using dmx.UI;
	using dmx.Components;

	/// <summary>
	///		Summary description for UserMenu.
	/// </summary>
	public partial class UserMenu : dmx.UI.BaseControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{

			lnkHome.NavigateUrl = "/" + Page.User.HomePage + "?intEmpID=" + Page.User.EmployeeID + "&strFName=" + Page.User.FirstName + "&strLName=" + Page.User.LastName;
			if (Page.User.IsInRole(Database.EmployeeType.Sales.ToString()))
			{
				TableRow myRow = new TableRow();
				TableCell linkCell = new TableCell();
				myRow.Cells.Add(new TableCell());
				linkCell.Text = "<a href=\"" + "/top25forecast.aspx\">Top25</a>";
				myRow.Cells.Add(linkCell);
				myRow.Cells.Add(new TableCell());
				tblMenu.Rows.AddAt(1, myRow);

//				myRow = new TableRow();
//				linkCell = new TableCell();
//				myRow.Cells.Add(new TableCell());
//				linkCell.Text = "<a href=\"" + "/SalesHome.asp?intEmpID=" + Page.User.EmployeeID + "&strFName=" + Page.User.FirstName + "&strLName=" + Page.User.LastName + "\">Daily Sales</a>";
//				myRow.Cells.Add(linkCell);
//				myRow.Cells.Add(new TableCell());
//				tblMenu.Rows.AddAt(1, myRow);

			}
			else if (Page.User.IsInRole(Database.EmployeeType.SalesManager.ToString()))
			{
				TableRow myRow = new TableRow();
				TableCell linkCell = new TableCell();
				myRow.Cells.Add(new TableCell());
				linkCell.Text = "<a href=\"" + "/top25forecast.aspx\">Top25 Approve</a>";
				myRow.Cells.Add(linkCell);
				myRow.Cells.Add(new TableCell());
				tblMenu.Rows.AddAt(1, myRow);

				myRow = new TableRow();
				linkCell = new TableCell();
				myRow.Cells.Add(new TableCell());
				linkCell.Text = "<a href=\"" + "/top25report.aspx\">Top25 Report</a>";
				myRow.Cells.Add(linkCell);
				myRow.Cells.Add(new TableCell());
				tblMenu.Rows.AddAt(1, myRow);
			}
			else if (Page.User.IsInRole(Database.EmployeeType.Administrator.ToString()))
			{
				tblMenu.Rows.RemoveAt(1);
				tblMenu.Rows.RemoveAt(1);
				TableRow myRow = new TableRow();
				TableCell linkCell = new TableCell();
				myRow.Cells.Add(new TableCell());
				linkCell.Text = "<a href=\"" + "/Admin/userQuotas.aspx\">Quotas</a>";
				myRow.Cells.Add(linkCell);
				myRow.Cells.Add(new TableCell());
				tblMenu.Rows.AddAt(1, myRow);

				myRow = new TableRow();
				linkCell = new TableCell();
				myRow.Cells.Add(new TableCell());
				linkCell.Text = "<a href=\"" + "/Admin/userAdmin.aspx\">User Admin</a>";
				myRow.Cells.Add(linkCell);
				myRow.Cells.Add(new TableCell());
				tblMenu.Rows.AddAt(1, myRow);

			}



		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion
	}
}
