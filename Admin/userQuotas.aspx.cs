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
using dmx.UI;
using System.Web.Security;
using System.Security.Principal;

namespace dmx.Admin
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
	public partial class userQuotas : dmx.UI.BasePage
	{
	
		private const string MONTH_KEY = "ForecastYear";

		private int ForecastYear 
		{
			get 
			{
				if(ViewState[MONTH_KEY] == null)
					ViewState[MONTH_KEY] = DateTime.Now.Year;
				return Convert.ToInt32(ViewState[MONTH_KEY]);
			}
			set { ViewState[MONTH_KEY] = value; }
		}



		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");

			if (!IsPostBack)
			{
				LoadEmployees();
				LoadQuotas();
				lblYear.Text = ForecastYear.ToString();
			}

		}

		protected void LoadEmployees()
		{
			Database data = new Database();
			lstSalesReps.DataSource = data.GetEmployees((int)Database.EmployeeType.Sales);
			lstSalesReps.DataBind();
			data.Close();
			data.Dispose();
		}


		protected void LoadQuotas()
		{

			Database data = new Database();
			DataTable quotas = data.GetQuotas(Convert.ToInt32(lstSalesReps.SelectedValue), ForecastYear);

			DateTime currMonth;
			object[] primaryKey = new object[2];
			object[] values = new object[6];

			for (int i = 1; i <=12; i++)
			{
				currMonth = new DateTime(ForecastYear, i, 1);
				primaryKey[0] = Convert.ToInt32(lstSalesReps.SelectedValue);
				primaryKey[1] = currMonth;


				if (!quotas.Rows.Contains(primaryKey))
				{
					values[0] = Convert.ToInt32(lstSalesReps.SelectedValue);
					values[1] = currMonth;
					values[2] = 0.0m;
					values[3] = 0.0m;
					values[4] = 0.0m;
					values[5] = 0.0m;
					quotas.Rows.Add(values);
				}

			}
			rptQuotas.DataSource = quotas;
			rptQuotas.DataBind();
			data.Close();
			data.Dispose();
		}

		protected void lstSalesReps_Changed(object sender, System.EventArgs e)
		{
			LoadQuotas();

		}
		


		protected void btnNext_Click(object sender, System.EventArgs e)
		{
			ForecastYear++;
			lblYear.Text = ForecastYear.ToString();
			LoadQuotas();

		}

		protected void btnPrev_Click(object sender, System.EventArgs e)
		{
			ForecastYear--;
			lblYear.Text = ForecastYear.ToString();
			LoadQuotas();

		}


		protected void btnSave_Click(object sender, System.EventArgs e)
		{
			Database data = new Database();
			DataTable quotas = data.GetQuotas(Convert.ToInt32(lstSalesReps.SelectedValue), ForecastYear);

			DateTime currMonth;
			object[] values = new object[6];

			for (int i = 0; i < 12; i++)
			{
				currMonth = new DateTime(ForecastYear, i+1, 1);


				values[0] = Convert.ToInt32(lstSalesReps.SelectedValue);
				values[1] = currMonth;
				values[2] = Convert.ToDecimal(((TextBox)rptQuotas.Items[i].FindControl("RMRQuota")).Text);
				values[3] = Convert.ToDecimal(((TextBox)rptQuotas.Items[i].FindControl("RMRFunnel")).Text);
				values[4] = Convert.ToDecimal(((TextBox)rptQuotas.Items[i].FindControl("RSSQuota")).Text);
				values[5] = Convert.ToDecimal(((TextBox)rptQuotas.Items[i].FindControl("RSSFunnel")).Text);
																		

				quotas.LoadDataRow(values, false);
			}
			data.SaveQuotas(quotas);
			data.Close();
			data.Dispose();

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
