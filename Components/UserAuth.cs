using System;
using System.Web;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using dmx.Components;
using System.Text;
using System.Web.Security;

namespace dmx.Components
{
	/// <summary>
	/// Summary description for UserAuth.
	/// </summary>
	public class UserAuth
	{
		public UserAuth()
		{
			//
			// TODO: Add constructor logic here
			//
		}

		public bool Authenticate(string UserName, string Password)
		{
			Database data = new Database();

			SqlDataReader reader;

			SqlParameter[] prmtrs = {
										data.MakeInParam("@strUserName", SqlDbType.VarChar, 200, UserName),
										data.MakeInParam("@strPassword", SqlDbType.VarChar, 50, Password)
									};
			data.RunProc("sp_AuthenticateUser", prmtrs, out reader);
			if (reader.Read())
			{
				FormsAuthentication.SetAuthCookie(UserName, true);
				
				data.Close();
				data.Dispose();
				return true;				
			}
			else 
			{
				data.Close();
				data.Dispose();
				return false;
				// TODO:  USER IS NOT YET ACTIVATED
			}
			
		}

		

	}
}
