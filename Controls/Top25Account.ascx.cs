namespace dmx.Controls
{
	using System;
	using System.Data;
	using System.Data.SqlClient;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using System.Web.Security;
	using dmx.Components;
	using dmx.UI;
	using System.Configuration;

	/// <summary>
	///		Summary description for Top25Account.
	/// </summary>
	public partial class Top25Account : BaseControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			


		}

		public void LoadData()
		{
			int empID = Page.User.EmployeeID;
			Database data = new Database();

			gridAccounts.DataSource = data.GetEmployeesTop25(intEmployeeID, Month, Approved);

			gridAccounts.DataBind();
			data.Close();
			data.Dispose();

		}

		protected void gridAccounts_Sort(object sender, DataGridSortCommandEventArgs e)
		{
			ViewState["SortExpression"] = e.SortExpression;
//			BindGrid();
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

		public int intEmployeeID;
		public DateTime Month;
		public bool Approved;


	}
}
