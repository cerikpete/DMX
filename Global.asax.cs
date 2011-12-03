using System;
using System.Collections;
using System.ComponentModel;
using System.Web;
using System.Web.SessionState;
using System.Web.Security;
using System.Security.Principal;
using System.Configuration;
using dmx.Components;

namespace dmx 
{
	/// <summary>
	/// Summary description for Global.
	/// </summary>
	public class Global : System.Web.HttpApplication
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		public Global()
		{
			InitializeComponent();
		}	
		
		protected void Application_Start(Object sender, EventArgs e)
		{

		}
 
		protected void Session_Start(Object sender, EventArgs e)
		{

		
		}

		protected void Application_BeginRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_EndRequest(Object sender, EventArgs e)
		{

		}

		protected void Application_AuthenticateRequest(Object sender, EventArgs e)
		{
			// Extract the forms authentication cookie
			string cookieName = FormsAuthentication.FormsCookieName;
			HttpCookie authCookie = Context.Request.Cookies[cookieName];

			if(null == authCookie)
			{
				// There is no authentication cookie.
				return;
			} 

			FormsAuthenticationTicket authTicket = null;
//			try
//			{
				authTicket = FormsAuthentication.Decrypt(authCookie.Value);
/*			}
			catch(Exception ex)
			{
				// Log exception details (omitted for simplicity)
				return;
			}
*/
			if (null == authTicket)
			{
				// Cookie failed to decrypt.
				return; 
			} 

			DMXUser user = (DMXUser)new DMXUser().FromXml(authTicket.UserData);

			string[] roles = {user.UserType.ToString()};

			// Create an Identity object
			FormsIdentity id = new FormsIdentity( authTicket ); 

			// This principal will flow throughout the request.
			CustomPrincipal principal = new CustomPrincipal(id, user);
			// Attach the new principal object to the current HttpContext object
			Context.User = principal;

		}

		protected void Application_Error(Object sender, EventArgs e)
		{

		}

		protected void Session_End(Object sender, EventArgs e)
		{

		}

		protected void Application_End(Object sender, EventArgs e)
		{

		}
			
		#region Web Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.components = new System.ComponentModel.Container();
		}
		#endregion
	}
}

