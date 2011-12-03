namespace dmx.Controls
{
	using System;
	using System.Data;
	using System.Data.SqlClient;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
	using System.Collections;
	using dmx.Components;
	using dmx.UI;

	/// <summary>
	///		Summary description for Top25MonthSummary.
	/// </summary>
	public partial class Top25MonthSummary : BaseControl
	{
		private DateTime summaryMonth = DateTime.Now;
		private int numMonths = 3;

		public DateTime Month
		{
			set
			{
				summaryMonth = value;
			}
		}

		public int ForecastMonths
		{
			set
			{
				numMonths = value;
			}
		}

		public string AnswerSet
		{
			set
			{
				try
				{
					char[] delim = {'/'};
					int mo = int.Parse(value.Split(delim)[0]);
					int yr = int.Parse(value.Split(delim)[1]);
					summaryMonth = new DateTime(yr, mo, 1);
				}
				catch(Exception ex)
				{
					throw new Exception("Could not parse AnswerSet.  Must be in mm/yyyy format.", ex);
				}
			}
		}


		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack)
			{
				BuildForecastTable();

			}

		}

		private void BuildForecastTable()
		{
			ArrayList t25Array = new ArrayList();
			Database data = new Database();
			for(int i = 0; i < numMonths; i++)
			{
				t25Array.Add(new Top25MonthlySummary(summaryMonth.AddMonths(i)));
			}

			string[] headers = {"Month:", 
								   "Actual RSS:", 
								   "Actual RMR:",
								   "RSS 10%:", 
								   "RMR 10%:", 
								   "RSS 50%:", 
								   "RMR 50%:", 
								   "RSS 90%:", 
								   "RMR 90%:",
								   "Projected RSS:", 
								   "Projected RMR:", 
								   "Total Proposed RSS:"};
			
			for (int i=0; i < 12; i++)
			{
				tblForecast.Rows.Add(new TableRow());
				TableCell tc = new TableCell();
				tc.Text = headers[i];
				tc.HorizontalAlign = HorizontalAlign.Right;
				tc.CssClass= "Top25RowHeader";
				tblForecast.Rows[i].Cells.Add(tc);

				for (int j=0; j < t25Array.Count; j++)
				{
					tc = new TableCell();

					switch (i)
					{
						case 0:
							tc.Text = ((Top25MonthlySummary)t25Array[j]).SummaryMonth.ToString("MMMM yyyy");
							tc.HorizontalAlign = HorizontalAlign.Center;
							tc.CssClass= "Top25ColumnHeader";
							break;
						case 1:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).ClosedRSS);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 2:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).ClosedRMR);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 3:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).RSS_10);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 4:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).RMR_10);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 5:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).RSS_50);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 6:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).RMR_50);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 7:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).RSS_90);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 8:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).RMR_90);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 9:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).ProjectedRSS);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 10:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).ProjectedRMR);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
						case 11:
							tc.Text = string.Format("{0:C}", ((Top25MonthlySummary)t25Array[j]).TotalProposedRSS);
							tc.HorizontalAlign = HorizontalAlign.Right;
							break;
					}
					if (i != 0)
					{
						tc.CssClass= "Top25Data";
					}

					tblForecast.Rows[i].Cells.Add(tc);
					data.Close();
					data.Dispose();
				}

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
