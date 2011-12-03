using System;
using System.Data;
using System.Data.SqlClient;


namespace dmx.Components
{
	/// <summary>
	/// Summary description for Top25Account.
	/// </summary>
	public class Top25Account
	{
		public Top25Account()
		{

		}

		public Top25Account(int AccountID)
		{
			this.Find(AccountID, false);
		}

		public bool Find(int AccountID)
		{
			return Find(AccountID, false);
		}

		
		public bool Find(int AccountID, bool ApprovedOnly)
		{
			Database data = new Database();
			SqlDataReader reader = data.GetAccountInfo(AccountID, ApprovedOnly);
			if (reader.Read())
			{
				this.EmployeeID = (int)reader["intEmployeeID"];
				this.intAccountID = (int)reader["intAccountID"];
				this.AccountName = (string)reader["strAccountName"];
				this.Contact = (string)reader["strContact"];
				this.Phone = (string)reader["strPhone"];
				this.Locations = (int)reader["intLocations"];
				this.ClosedRMR = (Decimal)reader["mnyClosedRMR"];
				this.ClosedRSS = (Decimal)reader["mnyClosedRSS"];
				this.RMR_10 = (Decimal)reader["mnyRMR_10"];
				this.RSS_10 = (Decimal)reader["mnyRSS_10"];
				this.RMR_50 = (Decimal)reader["mnyRMR_50"];
				this.RSS_50 = (Decimal)reader["mnyRSS_50"];
				this.RMR_90 = (Decimal)reader["mnyRMR_90"];
				this.RSS_90 = (Decimal)reader["mnyRSS_90"];
				this.Month = (DateTime)reader["dtmMonth"];
				this.blActive = (bool)reader["bitActive"];

				switch (((string)reader["charStatus"]).Trim())
				{
					case "P":
						this.Status = AccountStatus.Pending;
						break;
					case "A":
						this.Status = AccountStatus.Approved;
						break;
					case "U":
						this.Status = AccountStatus.Updated;
						break;
				}


				data.Close();
				data.Dispose();
				return true;
			}
			data.Close();
			data.Dispose();
			return false;

		}

		public void Save()
		{
			Database data = new Database();
			data.SaveAccount(this);
			data.Close();
			data.Dispose();
		}

		public void Delete()
		{
			Database data = new Database();
			data.DeleteAccount(this);
			data.Close();
			data.Dispose();
			
		}

		public void Close()
		{
			Database data = new Database();
			data.CloseAccount(this);
			data.Close();
			data.Dispose();
			
		}


		private int intAccountID;
		private DateTime dtmMonth;
		private bool blActive;
		
		public int EmployeeID ;
		public string AccountName;
		public string Contact;
		public int Locations;
		public string Phone;
		public Decimal ClosedRMR;
		public Decimal ClosedRSS;
		public Decimal RMR_10;
		public Decimal RSS_10;
		public Decimal RMR_50;
		public Decimal RSS_50;
		public Decimal RMR_90;
		public Decimal RSS_90;
		public AccountStatus Status;

		public int AccountID
		{
			get
			{
				return intAccountID;
			}
		}

		public DateTime Month
		{
			get
			{
				return dtmMonth;
			}
			set
			{
				dtmMonth = new DateTime(value.Year, value.Month, 1);
			}
		}

		public bool Active
		{
			get
			{
				return blActive;
			}
		}

	
	}

	public enum AccountStatus
	{
		Pending,
		Approved,
		Updated

	}

}
