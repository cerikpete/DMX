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

namespace dmx
{
	/// <summary>
	/// Summary description for reActivateAcct.
	/// </summary>
	public partial class reActivateAcct : dmx.UI.BasePage
	{
		protected System.Web.UI.WebControls.Label Message;
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");

			lblName.Text = User.FullName;

			if(!IsPostBack)
			{
				LoadAccounts();

			}

		}

		private void LoadAccounts()
		{

			
			Database data = new Database();
			lstAccounts.DataSource =  data.GetClosedAccounts(User.EmployeeID);
			lstAccounts.DataTextField = "strAccountName";
			lstAccounts.DataValueField = "intAccountID";
			lstAccounts.DataBind();
			data.Close();
			data.Dispose();

		}

		protected void btnActivate_Click(object sender, EventArgs e)
		{
			Database data = new Database();
			if (data.ReActivateAccount(Convert.ToInt32(lstAccounts.SelectedValue)))
			{
				Message.Text = "Account Activated.";
				Message.Visible = true;
			}
			else
			{
				Message.Text = "Account Could Not Be Activated.";
				Message.Visible = true;
			}
			LoadAccounts();
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
