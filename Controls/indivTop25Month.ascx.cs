namespace dmx.Controls
{
	using System;
	using System.Collections;
	using System.ComponentModel;
	using System.Data;
	using System.Data.SqlClient;
	using System.Drawing;
	using System.Web;
	using System.Web.SessionState;
	using System.Web.UI;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using dmx.Components;

	/// <summary>
	///		Summary description for indivTop25Month.
	/// </summary>
	public partial class indivTop25Month : dmx.UI.BaseControl
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			lblMonth.Text = ReportMonth.ToString("MMMM yyyy");
			LoadQuotas();

		}

		public void LoadData()
		{
			Database data = new Database();

			DataView dv = data.GetEmployeesTop25(EmployeeID, ReportMonth, Approved);
			if (ViewState[EMPLOYEES_SORT_KEY] != null)
			{
				dv.Sort = Convert.ToString(ViewState[EMPLOYEES_SORT_KEY]);
			}

			gridAccounts.DataSource = dv;
			gridAccounts.DataBind();
			data.Close();
			data.Dispose();

		}

		public void LoadQuotas()
		{
			Database data = new Database();
			SqlDataReader reader = data.GetQuotaFunnel(EmployeeID, ReportMonth);

			if (reader.Read())
			{
				RMRQuota = DataUtility.RetrieveDecimal(reader, "mnyRMRQuota", 0.0m);
				RMRFunnel = DataUtility.RetrieveDecimal(reader, "mnyRMRFunnel", 0.0m);
				RSSQuota = DataUtility.RetrieveDecimal(reader, "mnyRSSQuota", 0.0m);
				RSSFunnel = DataUtility.RetrieveDecimal(reader, "mnyRSSFunnel", 0.0m);

				tblQuotaFunnels.Rows[1].Cells[0].Text = RMRQuota.ToString("C");
				tblQuotaFunnels.Rows[1].Cells[1].Text = RMRFunnel.ToString("C");
				tblQuotaFunnels.Rows[1].Cells[2].Text = RSSQuota.ToString("C");
				tblQuotaFunnels.Rows[1].Cells[3].Text = RSSFunnel.ToString("C");
			}

			data.Close();
			data.Dispose();

		}

		protected void gridAccounts_Sort(object sender, DataGridSortCommandEventArgs e)
		{
			ViewState[EMPLOYEES_SORT_KEY] = e.SortExpression;
			LoadData();
		}

		protected void gridAccounts_AddToForecast(object sender, DataGridItemEventArgs e)
		{
			if (((int)e.Item.ItemType == (int)ListItemType.Item) || 
				((int)e.Item.ItemType == (int)ListItemType.AlternatingItem))
			{
				for (int i = 4; i < e.Item.Cells.Count; i++)
				{
					summaryTotal[i-4] += Convert.ToDecimal(e.Item.Cells[i].Text.Substring(1));
				}

			}
			else if((int)e.Item.ItemType == (int)ListItemType.Footer)
			{
				e.Item.Cells[0].Text = "Totals:";
				e.Item.Cells[0].CssClass = "Top25FooterRowHeader";
				e.Item.Cells[0].ColumnSpan = 4;
				e.Item.Cells.RemoveAt(1);
				e.Item.Cells.RemoveAt(1);
				e.Item.Cells.RemoveAt(1);

				e.Item.CssClass = "Top25ColumnFooter";
				for (int i = 0; i < summaryTotal.Length; i++)
				{
					e.Item.Cells[i+1].Text = summaryTotal[i].ToString("C");

				}
				RMRForecast = this.GetProjectedTotals(e.Item.Cells, "RMR");
				RSSForecast = this.GetProjectedTotals(e.Item.Cells, "RSS");
				RMRProposed  = this.GetTotalProposed(e.Item.Cells, "RMR");
				RSSProposed  = this.GetTotalProposed(e.Item.Cells, "RSS");

				
				FillForecastTable();
				FillQuotaTable();
			}

		}

		private void FillForecastTable()
		{

			tblForecastSummary.Rows[1].Cells[0].Text = RMRForecast.ToString("C");
			tblForecastSummary.Rows[1].Cells[1].Text  = RSSForecast.ToString("C");
			tblForecastSummary.Rows[1].Cells[2].Text  = (RMRProposed + RSSProposed).ToString("C");

		}

		private void FillQuotaTable()
		{
			tblQuotaFunnels.Rows[1].Cells[1].Text =  RMRClosed.ToString("C");;
			tblQuotaFunnels.Rows[1].Cells[2].Text =  RMRQuota.ToString("C");;
			tblQuotaFunnels.Rows[1].Cells[3].Text =  (RMRClosed - RMRQuota).ToString("C");;
			tblQuotaFunnels.Rows[1].Cells[4].Text  = RMRProposed.ToString("C");
			tblQuotaFunnels.Rows[1].Cells[5].Text =  RMRFunnel.ToString("C");;
			tblQuotaFunnels.Rows[1].Cells[6].Text =  (RMRProposed - RMRFunnel).ToString("C");;

			tblQuotaFunnels.Rows[2].Cells[1].Text =  RSSClosed.ToString("C");;
			tblQuotaFunnels.Rows[2].Cells[2].Text =  RSSQuota.ToString("C");;
			tblQuotaFunnels.Rows[2].Cells[3].Text =  (RSSClosed - RSSQuota).ToString("C");;
			tblQuotaFunnels.Rows[2].Cells[4].Text  = RSSProposed.ToString("C");
			tblQuotaFunnels.Rows[2].Cells[5].Text =  RSSFunnel.ToString("C");;
			tblQuotaFunnels.Rows[2].Cells[6].Text =  (RSSProposed - RSSFunnel).ToString("C");;

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

		private Decimal GetTotalProposed(TableCellCollection cells, string TotalType)
		{
			int i = 1;
			Decimal total = 0.0m;
			if (TotalType == "RSS"){ i++;}
			for (; i <= summaryTotal.Length; i++)
			{
				total += Convert.ToDecimal(cells[i++].Text.Substring(1));
			}
			return total;

		}

		const string EMPLOYEE_KEY = "EMPLOYEE_ID";
		const string MONTH_KEY = "REPORT_MONTH";
		const string APPROVED_KEY = "APPROVED";
		const string EMPLOYEES_SORT_KEY = "EMPLOYEES_SORT";
		protected Decimal[] summaryTotal = new Decimal[8];
		protected Decimal RMRClosed, RMRProposed, RMRForecast, RMRQuota, RMRFunnel = 0.0m;
		protected Decimal RSSClosed, RSSProposed, RSSForecast, RSSQuota, RSSFunnel = 0.0m;

		
		public int EmployeeID
		{
			get 
			{
				if(ViewState[EMPLOYEE_KEY] == null)
					ViewState[EMPLOYEE_KEY] = Page.User.EmployeeID;
				return Convert.ToInt32(ViewState[EMPLOYEE_KEY]);
			}
			set { ViewState[EMPLOYEE_KEY] = value; }
		}
			
		public DateTime ReportMonth
		{
			get 
			{
				if(ViewState[MONTH_KEY] == null)
					ViewState[MONTH_KEY] = DateTime.Now;
				return Convert.ToDateTime(ViewState[MONTH_KEY]);
			}
			set { ViewState[MONTH_KEY] = value; }
		}
			
		public bool Approved
		{
			get 
			{
				if(ViewState[APPROVED_KEY] == null)
					ViewState[APPROVED_KEY] = false;
				return Convert.ToBoolean(ViewState[APPROVED_KEY]);
			}
			set { ViewState[APPROVED_KEY] = value; }
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
