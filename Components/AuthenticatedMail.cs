using System;
using System.Web.Mail;
using System.Configuration;

namespace dmx.Components
{
	/// <summary>
	/// Summary description for AuthenticatedMail.
	/// </summary>
	public class AuthenticatedMail : System.Web.Mail.MailMessage
	{
		private string SMTPUser = ConfigurationSettings.AppSettings["SystemEmail"];
		private string SMTPPassword = ConfigurationSettings.AppSettings["SystemEmailPassword"];
		private string SMTPServerName = ConfigurationSettings.AppSettings["SmtpServer"];
		
		public AuthenticatedMail()
		{
			
			this.Fields["http://schemas.microsoft.com/cdo/configuration/smtsperver"] = SMTPServerName;
//			this.Fields["http://schemas.microsoft.com/cdo/configuration/smtpserverport"] = 8889;
			this.Fields["http://schemas.microsoft.com/cdo/configuration/sendusing"]  = 2;
			this.Fields["http://schemas.microsoft.com/cdo/configuration/smtpauthenticate"] = 1;
			this.Fields["http://schemas.microsoft.com/cdo/configuration/sendusername"] = SMTPUser;
			this.Fields["http://schemas.microsoft.com/cdo/configuration/sendpassword"] = SMTPPassword;
		
		}
	}
}
