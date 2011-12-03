using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;

namespace dmx.Components
{
	/// <summary>
	/// Summary description for User.
	/// </summary>
	public class DMXUser : EntityObject
	{
		private string mPassword;
		public int EmployeeID;
		public string UserName;
		public string FirstName;
		private string strHomePage;

		public string LastName;
		public string Email;
		public string Address;
		public string Phone;
		public string Region;
		public string Area;
		public string LSO;
		public int SalesManagerID;
		public bool Active;
		private int intEmployeeTypeID;


		public string HomePage
		{
			get
			{
				return strHomePage;
			}
			set
			{
				strHomePage = value;
			}
		}


		public Database.EmployeeType UserType
		{
			get
			{
				return (Database.EmployeeType)intEmployeeTypeID;
			}
			set
			{
				intEmployeeTypeID = (int)((Database.EmployeeType)value);
			}
		}



		public string Password
		{
			get
			{
				return mPassword;
			}
			set
			{
				mPassword = value;
			}
		}

		public string[] Roles
		{
			get
			{
				return new string[] {UserType.ToString()};
			}
		}

		public string FullName
		{
			get
			{
				return this.FirstName + " " + this.LastName;
			}
		}

		public DMXUser()
		{
			//
			// TODO: Add constructor logic here
			//
		}

		public bool Find(string strUserName)
		{
			Database data = new Database();
			SqlDataReader reader = data.FindUser(strUserName);
			if (reader.Read())
			{
				LoadFromReader(reader);
				data.Close();
				data.Dispose();
				return true;
			}
			else
			{
				data.Close();
				data.Dispose();
				return false;
			}
		}

	
		public bool Find(int intEmployeeID)
		{
			Database data = new Database();
			SqlDataReader reader = data.FindUser(intEmployeeID);
			if (reader.Read())
			{
				LoadFromReader(reader);
				data.Close();
				data.Dispose();
				return true;
			}
			else
			{
				data.Close();
				data.Dispose();
				return false;
			}
		}

		public void Save()
		{
			Database data = new Database();

			data.SaveEmployee(this);
			data.Close();
			data.Dispose();

		
		}

		private void LoadFromReader(SqlDataReader reader)
		{
			this.EmployeeID = (int)reader["intEmployeeID"];
			this.UserName = (string)reader["strEmployeeUserName"];
			this.Password = (string)reader["strEmployeePassword"];
			this.intEmployeeTypeID = (int)reader["intEmployeeTypeID"];
			this.FirstName = (string)reader["strFirstName"];
			this.LastName = DataUtility.RetrieveString(reader, "strLastName", "");
			this.Email = DataUtility.RetrieveString(reader, "strEmail", "");
			this.Address = DataUtility.RetrieveString(reader, "strAddress", "");
			this.Phone = DataUtility.RetrieveString(reader, "strPhone", "");
			this.Region = DataUtility.RetrieveString(reader, "strRegion", "");
			this.Area = DataUtility.RetrieveString(reader, "strArea", "");
			this.LSO = DataUtility.RetrieveString(reader, "strLSO", "");
			this.strHomePage = DataUtility.RetrieveString(reader, "strHomePage", "");
			this.SalesManagerID = DataUtility.RetrieveInt32(reader, "intSalesManagerID", 0);
			this.Active = Convert.ToBoolean(reader["bitVisible"]);
		}
	
	
	}
}
