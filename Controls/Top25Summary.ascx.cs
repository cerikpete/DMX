namespace dmx.Controls
{
	using System;
	using System.Data;
	using System.Data.SqlClient;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using dmx.Components;
	using dmx.UI;

	/// <summary>
	///		Summary description for Top25Summary.
	/// </summary>
	public class Top25Summary : BaseControl
	{
		protected System.Web.UI.WebControls.DataGrid grdSummary;
		protected System.Web.UI.WebControls.DropDownList lstEndMonth;
		protected System.Web.UI.WebControls.Button btnRefresh;
		protected System.Web.UI.WebControls.DataGrid grdEmployeeSummary;
		protected System.Web.UI.WebControls.DropDownList lstApproved;
		protected System.Web.UI.WebControls.DropDownList lstStartMonth;
		protected System.Web.UI.WebControls.DropDownList lstRegion;
		protected System.Web.UI.WebControls.DropDownList lstArea;
		protected System.Web.UI.WebControls.DropDownList lstLSO;
		protected System.Web.UI.WebControls.Table tblForecastSummary;


		
		#region Fields
		const string START_MONTH_KEY = "START_MONTH";
		const string END_MONTH_KEY = "END_MONTH";
		const string APPROVED_KEY = "APPROVED";
		const string SUMMARY_SORT_KEY = "SUMMARY_SORT";
		const string EMPLOYEES_SORT_KEY = "EMPLOYEES_SORT";
		protected Decimal[] summaryTotal = new Decimal[8];

		#endregion

		#region Properties
		private DateTime StartMonth
		{
			get 
			{
				if(ViewState[START_MONTH_KEY] == null)
					ViewState[START_MONTH_KEY] = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
				return Convert.ToDateTime(ViewState[START_MONTH_KEY]);
			}
			set { ViewState[START_MONTH_KEY] = value; }
		}
			
		private DateTime EndMonth
		{
			get 
			{
				if(ViewState[END_MONTH_KEY] == null)
					ViewState[END_MONTH_KEY] = StartMonth.AddMonths(2);
				return Convert.ToDateTime(ViewState[END_MONTH_KEY]);
			}
			set { ViewState[END_MONTH_KEY] = value; }
		}
			
		private bool Approved
		{
			get 
			{
				if(ViewState[APPROVED_KEY] == null)
					ViewState[APPROVED_KEY] = true;
				return Convert.ToBoolean(ViewState[APPROVED_KEY]);
			}
			set { ViewState[APPROVED_KEY] = value; }
		}
		#endregion Properties
			

		private void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				LoadMonthMenu(lstStartMonth);
				LoadMonthMenu(lstEndMonth);
				lstStartMonth.SelectedValue = (new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)).ToString();
				lstEndMonth.SelectedValue = (new DateTime(DateTime.Now.AddMonths(2).Year, DateTime.Now.AddMonths(2).Month, 1)).ToString();
				Database data = new Database();
				LoadMenu(lstRegion);
				LoadMenu(lstArea);
				LoadMenu(lstLSO);
				LoadSummary();
				LoadEmployees();


			}
		}

		#region Control Functions

		private void LoadMenu(DropDownList list)
		{
			Database data = new Database();
			switch (list.ID) 
			{
				case "lstRegion":
					list.DataSource = data.Regions;
					list.DataTextField = "strRegion";
					break;
				case "lstArea":
					list.DataSource = data.Areas;
					list.DataTextField = "strArea";
					break;
				case "lstLSO":
					list.DataSource = data.LSOs;
					list.DataTextField = "strLSO";
					break;
			}
			list.DataBind();
			list.Items.Insert(0, new ListItem("All", ""));
			list.SelectedIndex = 0;

		}


		private void LoadMonthMenu(DropDownList list)
		{
			Database data = new Database();
			SqlDataReader reader = data.BusinessMonths;
			list.DataSource = reader;
			list.DataTextField="dtmBaseMonth";
			list.DataTextFormatString = "{0:MMMM yyyy}";
			list.DataValueField = "dtmBaseMonth";
			list.DataBind();

		}

		private void LoadSummary()
		{
			Database data = new Database();
			DataView dv = data.GetTop25Summary(Convert.ToDateTime(lstStartMonth.SelectedValue), 
				Convert.ToDateTime(lstEndMonth.SelectedValue), 
				Convert.ToBoolean(lstApproved.SelectedValue),
				lstRegion.SelectedValue,
				lstArea.SelectedValue,
				lstLSO.SelectedValue,
				this.Sale);
			if (ViewState[SUMMARY_SORT_KEY] != null)
			{
				dv.Sort = Convert.ToString(ViewState[SUMMARY_SORT_KEY]);
			}

			grdSummary.DataSource = dv;
			grdSummary.DataBind();
		}

		private void LoadEmployees()
		{
			Database data = new Database();
			DataView dv = data.GetEmployeesTop25Summary(Convert.ToDateTime(lstStartMonth.SelectedValue), 
				Convert.ToDateTime(lstEndMonth.SelectedValue), 
				Convert.ToBoolean(lstApproved.SelectedValue),
				lstRegion.SelectedValue,
				lstArea.SelectedValue,
				lstLSO.SelectedValue);
			if (ViewState[EMPLOYEES_SORT_KEY] != null)
			{
				dv.Sort = Convert.ToString(ViewState[EMPLOYEES_SORT_KEY]);
			}

			grdEmployeeSummary.DataSource = dv;
			grdEmployeeSummary.DataBind();
		}

		private Decimal GetProjectedTotals(TableCellCollection cells, string TotalType)
		{
			int i = 1;
			Decimal total = 0.0m;
			if (TotalType == "RSS"){ i++;}

			total += Convert.ToDecimal(cells[i].Text.Substring(1));
			total += Convert.ToDecimal(cells[i+2].Text.Substring(1)) * .1m;
			total += Convert.ToDecimal(cells[i+4].Text.Substring(1)) * .5m;
			total += Convert.ToDecimal(cells[i+6].Text.Substring(1)) * .9m;

			return total;

		}

		private Decimal GetTotalProposed(TableCellCollection cells)
		{
			Decimal total = 0.0m;
			for (int i = 1; i < cells.Count; i++)
			{
				total += Convert.ToDecimal(cells[i].Text.Substring(1));
			}
			return total;

		}

		#endregion

		#region Event Handlers

		protected void grdSummary_Sort(object sender, DataGridSortCommandEventArgs e)
		{
			ViewState[SUMMARY_SORT_KEY] = e.SortExpression;
			LoadSummary();

		}

		protected void grdEmployeeSummary_Sort(object sender, DataGridSortCommandEventArgs e)
		{
			ViewState[EMPLOYEES_SORT_KEY] = e.SortExpression;
			LoadSummary();
			LoadEmployees();

		}

		protected void btnRefresh_Click(object sender, EventArgs e)
		{
			ViewState[SUMMARY_SORT_KEY] = "";
			ViewState[EMPLOYEES_SORT_KEY] = "";
			LoadSummary();
			LoadEmployees();
		}

		protected void grdEmployeeSummary_ItemCommand(object sender, DataGridCommandEventArgs e)
		{
			if (e.CommandName == "indivSales")
			{
				Response.Redirect("indivSales.aspx?eid=" + e.Item.Cells[0].Text + 
								  "&month=" + Server.UrlEncode(StartMonth.ToString("M/yyyy")) + 
								  "&approved=" + Approved.ToString());
			}
		}

		protected void grdSummary_AddToSum(object sender, DataGridItemEventArgs e)
		{
			if (((int)e.Item.ItemType == (int)ListItemType.Item) || 
				((int)e.Item.ItemType == (int)ListItemType.AlternatingItem))
			{
				for (int i = 1; i < e.Item.Cells.Count; i++)
				{
					summaryTotal[i-1] += Convert.ToDecimal(e.Item.Cells[i].Text.Substring(1));
				}

				AddForecastRow(e.Item.Cells);
			}
			else if((int)e.Item.ItemType == (int)ListItemType.Footer)
			{
				e.Item.Cells[0].Text = "Total:";
				e.Item.Cells[0].CssClass = "Top25FooterRowHeader";

				e.Item.CssClass = "Top25ColumnFooter";
				for (int i = 0; i < summaryTotal.Length; i++)
				{
					e.Item.Cells[i+1].Text = summaryTotal[i].ToString("C");

				}
			}

		}

		private void AddForecastRow(TableCellCollection cells)
		{
			TableRow monthForecast = new TableRow();
			TableCell cell = new TableCell();
			cell.Text = cells[0].Text;
			monthForecast.Cells.Add(cell);
			cell = new TableCell();
			cell.Text = this.GetProjectedTotals(cells, "RMR").ToString("C");
			monthForecast.Cells.Add(cell);
			cell = new TableCell();
			cell.Text = this.GetProjectedTotals(cells, "RSS").ToString("C");
			monthForecast.Cells.Add(cell);
			cell = new TableCell();
			cell.Text = this.GetTotalProposed(cells).ToString("C");
			monthForecast.Cells.Add(cell);
			tblForecastSummary.Rows.Add(monthForecast);


		}




		#endregion

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
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion
	}
}
