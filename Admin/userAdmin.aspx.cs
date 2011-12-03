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
using dmx.UI;
using System.Web.Security;
using System.Security.Principal;

namespace dmx.Admin
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
	public partial class userAdmin : dmx.UI.BasePage
	{
		protected System.Web.UI.WebControls.Label Message;
	
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
				LoadEmployees();
			}

		}

		protected void LoadEmployees()
		{
			Database data = new Database();
			grdEmployees.DataSource = data.GetEmployees(Convert.ToInt32(lstEmployeeType.SelectedValue));
			grdEmployees.DataBind();
		}

		protected void lstEmployeeType_Changed(object sender, System.EventArgs e)
		{
			LoadEmployees();

		}
		
		protected void grdEmployees_DataBound(Object sender, DataGridItemEventArgs e) 
		{
			if ((e.Item.ItemType != ListItemType.Header)&&(e.Item.ItemType != ListItemType.Footer))
			{
				LinkButton btn = (LinkButton)e.Item.Cells[3].Controls[0];
				btn.Attributes.Add("onclick", "return confirm('Are sure you want to delete " +
					DataBinder.Eval(e.Item.DataItem, "strFirstName") + " " +  
					DataBinder.Eval(e.Item.DataItem, "strLastName") + "?');");
			}

		}
	
		protected void grdEmployees_Deactivate(Object sender, DataGridCommandEventArgs e) 
		{
			Database data = new Database();
			data.DeactivateUser(int.Parse(e.Item.Cells[0].Text));
			LoadEmployees();

		}

		protected void btnAddUser_Click(object sender, EventArgs e)
		{
			Response.Redirect("editUser.aspx");
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
