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
	/// Summary description for reActivateAcct.
	/// </summary>
	public partial class reActivateUser : dmx.UI.BasePage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");

			if (!IsPostBack)
			{
				Database data = new Database();
				lstEmployeeType.DataSource = data.EmployeeTypes;
				lstEmployeeType.DataBind();
				data.Close();
				data.Dispose();
				lstEmployeeType.SelectedIndex= 2;
				LoadDeactivatedUsers();

			}

		}

		private void LoadDeactivatedUsers()
		{

			
			Database data = new Database();
			lstEmployees.DataSource =  data.GetDeactivatedUsers(int.Parse(lstEmployeeType.SelectedValue));
			lstEmployees.DataTextField = "strFullName";
			lstEmployees.DataValueField = "intEmployeeID";
			lstEmployees.DataBind();
			data.Close();
			data.Dispose();

		}

		protected void btnActivate_Click(object sender, EventArgs e)
		{
			Database data = new Database();
			if (data.ReactivateUser(Convert.ToInt32(lstEmployees.SelectedValue)))
			{
				Message.Text = "User Activated.";
				Message.Visible = true;
			}
			else
			{
				Message.Text = "User Could Not Be Activated.";
				Message.Visible = true;
			}
			LoadDeactivatedUsers();
			data.Close();
			data.Dispose();

		}

		protected void lstEmployeeType_Changed(object sender, System.EventArgs e)
		{
			LoadDeactivatedUsers();

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
