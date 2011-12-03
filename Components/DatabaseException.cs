using System;
using System.Data.SqlClient;

namespace dmx.Components
{

	public enum DBErrorType
	{
		DuplicateEmail,
		DuplicateRegistration
	}

	public class DatabaseException : Exception
	{
		public DBErrorType ErrorType;

		public DatabaseException(String message, SqlException innerException): base(message, innerException)
		{
			
			switch(innerException.Number)
			{
				case 2627:
					if (innerException.Message.IndexOf("PK_tblMemberProfile") > -1)
					{
						ErrorType = DBErrorType.DuplicateEmail;
					}
					else if (innerException.Message.IndexOf("IX_tblMemberProfile_strScreenName") > -1)
					{
						ErrorType = DBErrorType.DuplicateRegistration;
					}

					break;
				default:
					break;
			}
		}

		public DatabaseException(string datautilitymsg, string message, string function, Exception innerException): base(datautilitymsg + message + function, innerException)
		{
			

		}

	}
}
