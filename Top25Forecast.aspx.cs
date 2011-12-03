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
using System.Configuration;
using dmx.Components;
using dmx.UI;

namespace dmx
{
	/// <summary>
	/// Summary description for Top25Forecast.
	/// </summary>
	public partial class Top25Forecast : BasePage
	{

		protected System.Web.UI.WebControls.HyperLink hlReopen;

		private const string MONTH_KEY = "ForecastMonth";
		private const string EMPLOYEE_KEY = "EmployeeID";

		private DateTime ForecastMonth 
		{
			get 
			{
				if(ViewState[MONTH_KEY] == null)
					ViewState[MONTH_KEY] = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
				return Convert.ToDateTime(ViewState[MONTH_KEY]);
			}
			set { ViewState[MONTH_KEY] = value; }
		}

		private int EmployeeID
		{
			get 
			{
				if(ViewState[EMPLOYEE_KEY] == null)
					ViewState[EMPLOYEE_KEY] = -1;
				return Convert.ToInt32(ViewState[EMPLOYEE_KEY]);
			}
			set { ViewState[EMPLOYEE_KEY] = value; }
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");
            Response.Expires = -1;
			lblMessage.Visible = false;


			if (!IsPostBack)
			{
				lblName.Text = User.FullName;
				if (User.IsInRole(Database.EmployeeType.SalesManager.ToString()))
				{
					if (Request["eid"] != null)
					{
						EmployeeID = Convert.ToInt32(Request["eid"]);
						lstEmployees.SelectedValue = Request["eid"];
					}
					if (Request["month"] != null)
					{
						ForecastMonth = Convert.ToDateTime(Request["month"]);
					}
					if (Request["approved"] != null)
					{
						lstStatus.SelectedValue = Request["approved"];
					}
					BuildEmployeesMenu();
					pnlManagerCtrls.Visible = true;
					btnNewAccount.Visible = false;
					btnSave.Text = "Approve";
					btnSave.CommandName="Approve";
					lblTitle.Text = "Approval";

				}
				else
				{
					pnlAcctControls.Visible = true;
					btnDelete.Attributes.Add("onClick", "return confirm('Delete this account?');");
					btnClose.Attributes.Add("onClick", "return confirm('Close this account?');");
					EmployeeID = User.EmployeeID;

				}
				lblMonth.Text = ForecastMonth.ToString("MMMM yyyy");
				BuildAccountsMenu();

				LoadAccountInfo();
				BuildMoveMenu();
			}



		}

		#region Page Functions

		protected void BuildAccountsMenu()
		{
			Database data = new Database();
			if(User.IsInRole(Database.EmployeeType.SalesManager.ToString()))
			{
				lstAccounts.DataSource = data.GetAccountNames(EmployeeID, ForecastMonth, Convert.ToBoolean(lstStatus.SelectedValue), false);
			}
			else
			{
				lstAccounts.DataSource = data.GetAccountNames(EmployeeID, ForecastMonth, true);
			}
			lstAccounts.DataTextField="strAccountName";
			lstAccounts.DataValueField="intAccountID";
			lstAccounts.DataBind();
			if(!User.IsInRole(Database.EmployeeType.SalesManager.ToString()))
			{
				lstAccounts.Items.Insert(0, new ListItem("New Account (Enter Data Below)", ""));
			}
			lstAccounts.SelectedIndex = 0;
			data.Close();
			data.Dispose();
		}

		protected void BuildEmployeesMenu()
		{
			Database data = new Database();
			SqlDataReader reader = data.GetSubordinates(User.EmployeeID, ForecastMonth, Convert.ToBoolean(lstStatus.SelectedValue));
			if (reader.HasRows)
			{
				lstEmployees.DataSource = reader;
				lstEmployees.DataTextField="EmployeeName";
				lstEmployees.DataValueField="intEmployeeID";
				lstEmployees.DataBind();
			}
			else
			{
				lstEmployees.Items.Clear();
			}
			if (lstEmployees.Items.Count > 0)
			{
				if((EmployeeID > 0)&&(lstEmployees.Items.FindByValue(EmployeeID.ToString()) != null))
				{
					lstEmployees.SelectedValue = EmployeeID.ToString();
				}
				else
				{
					lstEmployees.SelectedIndex = 0;
					EmployeeID = int.Parse(lstEmployees.SelectedValue);
				}

			}

			data.Close();
			data.Dispose();
		}

		protected void BuildMoveMenu()
		{
			DateTime[] months = {ForecastMonth.AddMonths(-3),
								  ForecastMonth.AddMonths(-2),
								  ForecastMonth.AddMonths(-1),
								  ForecastMonth.AddMonths(1),
								  ForecastMonth.AddMonths(2),
								  ForecastMonth.AddMonths(3)};

			lstMoveTo.DataSource = months;
			lstMoveTo.DataTextFormatString = "{0:MMM yyyy}";
			lstMoveTo.DataBind();
			lstMoveTo.Items.Insert(3, new ListItem("Select Month", ""));
			lstMoveTo.SelectedIndex = 3;



		}

		protected void ClearForm()
		{
			txtAccountName.Text = "";
			txtContact.Text = "";
			txtPhone.Text = "";
			txtLocations.Text = "";
			txtClosedRMR.Text = "";
			txtClosedRSS.Text = "";
			txtRMR_10.Text = "";
			txtRSS_10.Text = "";
			txtRMR_50.Text = "";
			txtRSS_50.Text = "";
			txtRMR_90.Text = "";
			txtRSS_90.Text = "";



		}

		public void LoadAccountInfo()
		{
			pnlAccountInfo.Visible = true;
			pnlButtons.Visible = true;
			pnlNamesMove.Visible = true;
			if ((lstAccounts.SelectedValue != null)&&(lstAccounts.SelectedValue != ""))
			{

				Top25Account account = new Top25Account(int.Parse(lstAccounts.SelectedValue));
				txtAccountName.Text = account.AccountName;
				txtContact.Text = account.Contact;
				txtPhone.Text = account.Phone;
				txtLocations.Text = account.Locations.ToString();
				txtClosedRMR.Text = account.ClosedRMR.ToString("0.##;-0.##;0");
				txtClosedRSS.Text = account.ClosedRSS.ToString("0.##;-0.##;0");
				txtRMR_10.Text = account.RMR_10.ToString("0.##;-0.##;0");
				txtRSS_10.Text = account.RSS_10.ToString("0.##;-0.##;0");
				txtRMR_50.Text = account.RMR_50.ToString("0.##;-0.##;0");
				txtRSS_50.Text = account.RSS_50.ToString("0.##;-0.##;0");
				txtRMR_90.Text = account.RMR_90.ToString("0.##;-0.##;0");
				txtRSS_90.Text = account.RSS_90.ToString("0.##;-0.##;0");
			}
			else
			{
				if(User.IsInRole(Database.EmployeeType.SalesManager.ToString()))
				{
					// make account info invisible if sales manager
					pnlAccountInfo.Visible = false;
					pnlButtons.Visible = false;
					pnlNamesMove.Visible = false;
				}
				else
				{
					this.ClearForm();

				}
			}
		}

		#endregion

		#region Event Handlers
		protected void btnNext_Click(object sender, System.EventArgs e)
		{
			ForecastMonth = ForecastMonth.AddMonths(1);
			lblMonth.Text = ForecastMonth.ToString("MMMM yyyy");
			ClearForm();
			BuildEmployeesMenu();
			BuildAccountsMenu();
			BuildMoveMenu();
			LoadAccountInfo();
		}

		protected void btnPrev_Click(object sender, System.EventArgs e)
		{
			ForecastMonth = ForecastMonth.AddMonths(-1);
			lblMonth.Text = ForecastMonth.ToString("MMMM yyyy");
			ClearForm();
			BuildEmployeesMenu();
			BuildAccountsMenu();
			BuildMoveMenu();
			LoadAccountInfo();
		}

		protected void btnNewAccount_Click(object sender, System.EventArgs e)
		{
			ClearForm();
			BuildAccountsMenu();
			BuildMoveMenu();
		}


		protected void btnSave_Click(object sender, System.EventArgs e)
		{
			Top25Account account;
			string NotifyAction = "";
			if((lstAccounts.SelectedValue != "")&&(int.Parse(lstAccounts.SelectedValue) > 0))
			{
				account = new Top25Account(int.Parse(lstAccounts.SelectedValue));
				if(User.IsInRole(Database.EmployeeType.SalesManager.ToString()))
				{
					account.Status = AccountStatus.Approved; // managers can ony approve
				}
				else
				{
					if (account.Status == AccountStatus.Approved)
					{ // if pending, or updated - status does not change
						account.Status = AccountStatus.Updated;   // if approved, changes to updated
						NotifyAction = "UPDATED";
					}

				}
			}
			else if (!User.IsInRole(Database.EmployeeType.SalesManager.ToString())) // managers can not create accounts
			{
				if (lstAccounts.Items.Contains(lstAccounts.Items.FindByText(txtAccountName.Text)))
					// if an account with this name already exists for this month, you can't add it
				{
					lblMessage.Text = "Account already exists for this month.";
					lblMessage.Visible = true;
					return;
				}
				else
				{
					account = new Top25Account();
					account.EmployeeID = User.EmployeeID;
					account.Status = AccountStatus.Pending;
					NotifyAction = "CREATED";
				}


			}
			else
			{
				return;
			}

			account.Month = ForecastMonth;
			account.AccountName = txtAccountName.Text;
			account.Contact = txtContact.Text;
			account.Phone = txtPhone.Text;
			if((txtLocations.Text != null)&&(txtLocations.Text != ""))
			{
				account.Locations = int.Parse(txtLocations.Text);
			}
			account.ClosedRMR = Utils.GetDecimal(txtClosedRMR.Text);
			account.ClosedRSS = Utils.GetDecimal(txtClosedRSS.Text);
			account.RMR_10 = Utils.GetDecimal(txtRMR_10.Text);
			account.RSS_10 = Utils.GetDecimal(txtRSS_10.Text);
			account.RMR_50 = Utils.GetDecimal(txtRMR_50.Text);
			account.RSS_50 = Utils.GetDecimal(txtRSS_50.Text);
			account.RMR_90 = Utils.GetDecimal(txtRMR_90.Text);
			account.RSS_90 = Utils.GetDecimal(txtRSS_90.Text);
			account.Save();

			if (NotifyAction != "")
			{
				Database data = new Database();
				data.QueueNotification(account.EmployeeID, account.AccountID, 
					account.AccountName, account.Month, NotifyAction);
				notify.SendNotificationQueue();
				data.Close();
				data.Dispose();
			}

			
			ClearForm();
			BuildEmployeesMenu();
			BuildAccountsMenu();
			BuildMoveMenu();
			LoadAccountInfo();
		}


		protected void lstAccounts_Changed(object sender, System.EventArgs e)
		{
			LoadAccountInfo();
			BuildMoveMenu();

		}

		protected void lstStatus_Changed(object sender, System.EventArgs e)
		{
			ClearForm();
			BuildEmployeesMenu();
			BuildAccountsMenu();
			LoadAccountInfo();
			if (this.lstStatus.SelectedValue == "1")
			{
				this.btnSave.Text = "Save Changes";
				this.btnSave.CommandName = "Save";
			}
			else
			{
				this.btnSave.Text = "Approve";
				this.btnSave.CommandName = "Approve";
			}

		}

		protected void lstEmployees_Changed(object sender, System.EventArgs e)
		{
			ClearForm();
			EmployeeID = int.Parse(lstEmployees.SelectedValue);
			BuildAccountsMenu();
			LoadAccountInfo();

		}

		
		protected void btnDelete_Click(object sender, System.EventArgs e)
		{
			if ((lstAccounts.SelectedValue != null)&&(int.Parse(lstAccounts.SelectedValue) > 0))
			{

				Top25Account account = new Top25Account(int.Parse(lstAccounts.SelectedValue));

				string NotifyAction = "DELETED";
				Database data = new Database();
				data.QueueNotification(account.EmployeeID, account.AccountID, 
					account.AccountName, account.Month, NotifyAction);
				notify.SendNotificationQueue();

				account.Delete();

				ClearForm();
				BuildAccountsMenu();
				BuildMoveMenu();
				data.Close();
				data.Dispose();
			}
			else
			{
				lblMessage.Text = "You must select an account to delete.";
				lblMessage.Visible = true;
				return;
			}
		}

		protected void btnClose_Click(object sender, System.EventArgs e)
		{
			if ((lstAccounts.SelectedValue != null)&&(int.Parse(lstAccounts.SelectedValue) > 0))
			{

				Top25Account account = new Top25Account(int.Parse(lstAccounts.SelectedValue));
				string NotifyAction = "CLOSED";
				Database data = new Database();
				data.QueueNotification(account.EmployeeID, account.AccountID, 
					account.AccountName, account.Month, NotifyAction);

				account.Close();
                
				ClearForm();
				BuildAccountsMenu();
				BuildMoveMenu();
				data.Close();
				data.Dispose();
			}
			else
			{
				lblMessage.Text = "You must select an account to delete.";
				lblMessage.Visible = true;
				return;
			}
		}


		protected void btnView_Click(object sender, System.EventArgs e)
		{
			string redirect = "indivSales.aspx?month=" + Server.UrlEncode(ForecastMonth.ToString("M/yyyy"));
			if ((lstStatus.SelectedValue != null)&&(lstStatus.SelectedValue != ""))
			{
				redirect += "&approved=" + lstStatus.SelectedValue;
			}
			if ((lstEmployees.SelectedValue != null)&&(lstEmployees.SelectedValue != ""))
			{
				redirect += "&eid=" + lstEmployees.SelectedValue;
			}
			Response.Redirect(redirect);
		
		}


		protected void btnMove_Click(object sender, System.EventArgs e)
		{
			if((lstAccounts.SelectedValue != "")&&(int.Parse(lstAccounts.SelectedValue) > 0)
				&&(lstMoveTo.SelectedValue != ""))
			{
				Top25Account account = new Top25Account(int.Parse(lstAccounts.SelectedValue));
				account.Month = Convert.ToDateTime(lstMoveTo.SelectedValue);
				account.Save();
				ClearForm();
				BuildAccountsMenu();
				LoadAccountInfo();
			}

		
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion

		

	}
}
