using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using dmx.Components;

namespace dmx.Admin
{
	/// <summary>
	/// Summary description for editUser.
	/// </summary>
	public partial class editUser : dmx.UI.BasePage
	{

	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");

			if (!IsPostBack)
			{
				LoadMenu(lstRegion);
				LoadMenu(lstArea);
				LoadMenu(lstLSO);
				LoadMenu(lstEmployeeType);
				LoadMenu(lstManagers);
				if ((Request["intEmpID"] != null)&&(Request["intEmpID"] != ""))
				{
					EmployeeID = int.Parse(Request["intEmpID"]);
					user = new DMXUser();
					user.Find(EmployeeID);
					LoadEmployeeInfo(user);
				}
				else
				{
					this.lstEmployeeType.SelectedValue = ((int)Database.EmployeeType.Sales).ToString();

				}
			}

			switch (Convert.ToInt16(lstEmployeeType.SelectedValue))
			{
				case (short)Database.EmployeeType.Administrator:
					rwRegion.Visible = false;
					rwArea.Visible = false;
					rwLSO.Visible = false;
					rwManager.Visible = false;
					break;
				case (short)Database.EmployeeType.Sales:
					rwRegion.Visible = true;
					rwArea.Visible = true;
					rwLSO.Visible = true;
					rwManager.Visible = true;
					break;
				default:
					rwRegion.Visible = true;
					rwArea.Visible = true;
					rwLSO.Visible = true;
					rwManager.Visible = false;
					break;
			}

		}


		#region Page Functions
		private void LoadMenu(DropDownList list)
		{
			Database data = new Database();
			switch (list.ID) 
			{
				case "lstRegion":
					list.DataSource = data.Regions;
					break;
				case "lstArea":
					list.DataSource = data.Areas;
					break;
				case "lstLSO":
					list.DataSource = data.LSOs;
					break;
				case "lstManagers":
					list.DataSource = data.GetEmployees((int)Database.EmployeeType.SalesManager);
					break;
				case "lstEmployeeType":
					lstEmployeeType.DataSource = data.EmployeeTypes;
					list.DataBind();
					return;

			}
			list.DataBind();
			data.Close();
			data.Dispose();
			list.Items.Insert(0, new ListItem("Select...", ""));
			list.SelectedIndex = 0;

		}

		protected void LoadEmployeeInfo(DMXUser user)
		{
			this.txtFirstName.Text = user.FirstName;
			this.txtLastName.Text = user.LastName;
			this.txtUserName.Text = user.UserName;
			this.txtPassword.Text = user.Password;
			this.txtAddress.Text = user.Address;
			this.txtEmail.Text = user.Email;
			this.txtPhone.Text = user.Phone;

			this.lstRegion.SelectedValue = user.Region;
			this.lstArea.SelectedValue = user.Area;
			this.lstLSO.SelectedValue = user.LSO;
            this.lstEmployeeType.SelectedValue = ((int)user.UserType).ToString();
			if (user.SalesManagerID > 0)
			{
				this.lstManagers.SelectedValue = user.SalesManagerID.ToString();
			}


		}


		#endregion

		#region Event Handlers

		protected void btnSubmit_Click(object sender, System.EventArgs e)
		{

			user = new DMXUser();

			if (EmployeeID > 0)
			{
				user.Find(EmployeeID);
			}

			user.UserType = (Database.EmployeeType)int.Parse(lstEmployeeType.SelectedValue);
			user.UserName = this.txtUserName.Text;
			user.Password = this.txtPassword.Text;
			user.FirstName = this.txtFirstName.Text;
			user.LastName = this.txtLastName.Text;
			user.Address = this.txtAddress.Text;
			user.Phone = this.txtPhone.Text;
			user.Email = this.txtEmail.Text;

			if (int.Parse(lstEmployeeType.SelectedValue) != (int)Database.EmployeeType.Administrator)
			{
				user.Region = lstRegion.SelectedValue;
				user.Area = lstArea.SelectedValue;
				user.LSO = lstLSO.SelectedValue;

				if (int.Parse(lstEmployeeType.SelectedValue) == (int)Database.EmployeeType.Sales)
				{
					if (lstManagers.SelectedValue != "")
					{
						user.SalesManagerID = int.Parse(lstManagers.SelectedValue);
					}
				}

			}

			user.Save();

			lblMessage.Text = "Changes Saved.";
			lblMessage.Visible = true;

			
						

		}

		protected void lstEmployeeType_Changed(object sender, System.EventArgs e)
		{
			lblMessage.Visible = false;

		}



		#endregion

		private const string EMPLOYEE_KEY = "EmployeeID";
		private DMXUser user;
		private int EmployeeID
		{
			get 
			{
				if(ViewState[EMPLOYEE_KEY] == null)
					ViewState[EMPLOYEE_KEY] = 0;
				return Convert.ToInt32(ViewState[EMPLOYEE_KEY]);
			}
			set { ViewState[EMPLOYEE_KEY] = value; }
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
