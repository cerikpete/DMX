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
using System.Web.Mail;
using System.Configuration;
using dmx.Components;

namespace dmx
{
	/// <summary>
	/// Summary description for notify.
	/// </summary>
	public partial class notify : System.Web.UI.Page
	{
	
		protected void Page_Load(object sender, System.EventArgs e)
		{
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");

			SendNotificationQueue();
			grdQueue.DataSource = SendNotificationQueue();
			grdQueue.DataBind();
		}

		public static DataTable SendNotificationQueue ()
		{
			Database data = new Database();
			DataTable dt = data.GetNotificationQueue();

			string msgBody = "";
			int intRecipientID = -1;
			int intEmployeeID = -1;
			ArrayList Messages = new ArrayList();
			AuthenticatedMail msg = null;
			DMXUser user = new DMXUser();
			SmtpMail.SmtpServer = ConfigurationSettings.AppSettings["SmtpServer"];

			foreach (DataRow row in dt.Rows)
			{
				if (intRecipientID != Convert.ToInt32(row["intRecipientID"]))
				{
					if (msg !=null)
					{
						msg.Body = msgBody;
						Messages.Add(msg);
						SmtpMail.Send(msg);
					}
					intRecipientID = Convert.ToInt32(row["intRecipientID"]);
					msg = new AuthenticatedMail();
					msg.BodyFormat = MailFormat.Html;
					user.Find(intRecipientID);
					if ((string)ConfigurationSettings.AppSettings["TestingServer"] == "true")
					{
						msg.To = "stuff@pigeonmoon.com"; // FOR TESTING
					}
					else
					{
						msg.To = user.Email;
						//msg.Bcc = "stuff@pigeonmoon.com"; // FOR TESTING
					}
					msg.From = ConfigurationSettings.AppSettings["SystemEmail"];
					msg.Subject = "Top 25 Account Updates";
					
					msgBody += user.FullName + ",\n\nThe following changes have been made:\n\n<pre>\n";
				}

				intEmployeeID = Convert.ToInt32(row["intEmployeeID"]);
				user.Find(intEmployeeID);
				msgBody += Convert.ToString(row["strAction"]) + ":\t" + Convert.ToString(row["strAccountName"]) + 
					" - " + user.FullName + 
					", " + Convert.ToDateTime(row["dtmCreated"]).ToString("M-d-yy, h:mm") + "\n";

				row["dtmSent"] = DateTime.Now;

			}
//			if (msg !=null)
//			{
//				msg.Body = msgBody + "</pre>\n\n<a href=\"http://www.top25hpa.com\">Log in to Top25HPA.com</a> \n\n";
//				Messages.Add(msg);
//				SmtpMail.Send(msg);
//			}

			//			dt.AcceptChanges();
			data.UpdateNotificationQueue(dt);
			data.Close();
			data.Dispose();
			return dt;

			


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
