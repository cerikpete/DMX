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

namespace dmx
{
	/// <summary>
	/// Summary description for indivSales.
	/// </summary>
	public partial class indivSales : dmx.UI.BasePage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");

			if(!IsPostBack)
			{
				if ((Request["eid"] != null)&&(Request["eid"] != ""))
				{
					EmployeeID = Convert.ToInt32(Request["eid"]);
				}
				ReportMonth = Convert.ToDateTime(Request["month"]);
				Approved = Convert.ToBoolean(Request["approved"]);
				DMXUser user = new DMXUser();
				user.Find(EmployeeID);
				lblName.Text = user.FullName;
				LoadData();
				if (User.IsInRole(Database.EmployeeType.Executive.ToString()))
				{
					lnkHome.Text = "Return to Top 25 Summary";
					lnkHome.NavigateUrl = "top25Report.aspx";

				}

			}

			if (User.IsInRole(Database.EmployeeType.SalesManager.ToString()))
			{
				lnkHome.Text = "Return to Top 25 Approval";
				lnkHome.NavigateUrl = "top25forecast.aspx?eid=" + EmployeeID.ToString() + 
					"&approved=" + Approved.ToString() + "&month=" + ReportMonth.ToString();
			}
		}

		public void LoadData()
		{
			ucMonth1.EmployeeID = this.EmployeeID;
			ucMonth1.Approved = this.Approved;
			ucMonth1.ReportMonth = this.ReportMonth;
			ucMonth1.LoadData();

			ucMonth2.EmployeeID = this.EmployeeID;
			ucMonth2.Approved = this.Approved;
			ucMonth2.ReportMonth = this.ReportMonth.AddMonths(1);
			ucMonth2.LoadData();

			ucMonth3.EmployeeID = this.EmployeeID;
			ucMonth3.Approved = this.Approved;
			ucMonth3.ReportMonth = this.ReportMonth.AddMonths(2);
			ucMonth3.LoadData();

		}

		protected void gridAccounts_Sort(object sender, DataGridSortCommandEventArgs e)
		{
			ViewState[EMPLOYEES_SORT_KEY] = e.SortExpression;
			LoadData();
		}

		protected void btnNext_Click(object sender, System.EventArgs e)
		{
			ReportMonth = ReportMonth.AddMonths(1);
			LoadData();
		}

		protected void btnPrev_Click(object sender, System.EventArgs e)
		{
			ReportMonth = ReportMonth.AddMonths(-1);
			LoadData();
		}


		const string EMPLOYEE_KEY = "EMPLOYEE_ID";
		const string MONTH_KEY = "REPORT_MONTH";
		const string APPROVED_KEY = "APPROVED";
		protected dmx.Controls.indivTop25Month ucMonth1;
		protected dmx.Controls.indivTop25Month ucMonth2;
		protected dmx.Controls.indivTop25Month ucMonth3;
		const string EMPLOYEES_SORT_KEY = "EMPLOYEES_SORT";
		protected Decimal[] summaryTotal = new Decimal[8];

		
		protected int EmployeeID
		{
			get 
			{
				if(ViewState[EMPLOYEE_KEY] == null)
					ViewState[EMPLOYEE_KEY] = User.EmployeeID;
				return Convert.ToInt32(ViewState[EMPLOYEE_KEY]);
			}
			set { ViewState[EMPLOYEE_KEY] = value; }
		}
			
		protected DateTime ReportMonth
		{
			get 
			{
				if(ViewState[MONTH_KEY] == null)
					ViewState[MONTH_KEY] = DateTime.Now;
				return Convert.ToDateTime(ViewState[MONTH_KEY]);
			}
			set { ViewState[MONTH_KEY] = value; }
		}
			
		protected bool Approved
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion

	}
}
