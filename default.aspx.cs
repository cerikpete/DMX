using System;
using System.Web;
using dmx.Components;
using dmx.UI;
using System.Web.Security;

namespace dmx
{
	/// <summary>
	/// Summary description for _default.
	/// </summary>
	public partial class _default : BasePage
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if (!IsPostBack)
			{
				// Extract the forms authentication cookie
				string cookieName = FormsAuthentication.FormsCookieName;
				HttpCookie authCookie = Context.Request.Cookies[cookieName];

				if (authCookie != null)
				{

					authCookie.Expires = DateTime.Now.AddDays(-1);
					Response.Cookies.Add(authCookie);
				}
				Session.Abandon();

			}
			else
			{
				DMXUser user = new DMXUser();

//				User = new GenericPrincipal(

				if ((user.Find(txtUserName.Text))&&(user.Active))
				{
					if(user.Password == txtPassword.Text)
					{
						// Create the authentication ticket
						FormsAuthenticationTicket authTicket = new 
							FormsAuthenticationTicket(1,                          //  version
							txtUserName.Text,           // user name
							DateTime.Now,               // creation
							DateTime.Now.AddMinutes(60),						// Expiration
							false,                      //Persistent
							user.ToXml() );            // Userdata

						// Now encrypt the ticket.
						string encryptedTicket = FormsAuthentication.Encrypt(authTicket);

						// Create a cookie and add the encrypted ticket to the 
						// cookie as data.
						HttpCookie authCookie =
							new HttpCookie(FormsAuthentication.FormsCookieName,
							encryptedTicket);

						// Add the cookie to the outgoing cookies collection. 
						Response.Cookies.Add(authCookie); 

						// this is a temp fix for old ASP security
						Session.Add("EmployeeID", user.EmployeeID);

						
//						Response.Redirect("Top25Report.aspx");
						Response.Redirect(user.HomePage + 
							"?intEmpID=" + user.EmployeeID + 
							"&strLName=" + user.LastName + 
							"&strFName=" + user.FirstName);

					}
					else
					{
						Message.Text = "Password invalid.";
						Message.Visible = true;
					}
				}
				else 
				{
					Message.Text = "User not found.";
					Message.Visible = true;
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion
	}
}
