using System;
using System.ComponentModel;
using System.Collections;
using System.Diagnostics;
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;
using System.Configuration;

namespace dmx.Components 
{
	/// <summary>
	/// ADO.NET data access using the SQL Server Managed Provider.
	/// </summary>
	public class Database : IDisposable 
	{
		// connection to data source
		private SqlConnection con;

		#region Database Access		
		/// <summary>
		/// Run stored procedure.
		/// </summary>
		/// <param name="procName">Name of stored procedure.</param>
		/// <returns>Stored procedure return value.</returns>
		public int RunProc(string procName) 
		{
			SqlCommand cmd = CreateCommand(procName, null);
			cmd.ExecuteNonQuery();
			this.Close();
			return (int)cmd.Parameters["ReturnValue"].Value;
		}

		/// <summary>
		/// Run stored procedure.
		/// </summary>
		/// <param name="procName">Name of stored procedure.</param>
		/// <param name="prams">Stored procedure params.</param>
		/// <returns>Stored procedure return value.</returns>
		public int RunProc(string procName, SqlParameter[] prams) 
		{
			SqlCommand cmd = CreateCommand(procName, prams);
			
			String test = cmd.CommandText;

			cmd.ExecuteNonQuery();
			this.Close();
			return (int)cmd.Parameters["ReturnValue"].Value;
		}

		/// <summary>
		/// Run stored procedure.
		/// </summary>
		/// <param name="procName">Name of stored procedure.</param>
		/// <param name="dataReader">Return result of procedure.</param>
		public void RunProc(string procName, out SqlDataReader dataReader) 
		{
			SqlCommand cmd = CreateCommand(procName, null);
			dataReader = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
		}

		/// <summary>
		/// Run stored procedure.
		/// </summary>
		/// <param name="procName">Name of stored procedure.</param>
		/// <param name="prams">Stored procedure params.</param>
		/// <param name="dataReader">Return result of procedure.</param>
		public void RunProc(string procName, SqlParameter[] prams, out SqlDataReader dataReader) 
		{
			SqlCommand cmd = CreateCommand(procName, prams);
			dataReader = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
		}
		
		/// <summary>
		/// Create command object used to call stored procedure.
		/// </summary>
		/// <param name="procName">Name of stored procedure.</param>
		/// <param name="prams">Params to stored procedure.</param>
		/// <returns>Command object.</returns>
		private SqlCommand CreateCommand(string procName, SqlParameter[] prams) 
		{
			// make sure connection is open
			Open();

			//command = new SqlCommand( sprocName, new SqlConnection( ConfigManager.DALConnectionString ) );
			SqlCommand cmd = new SqlCommand(procName, con);
			cmd.CommandType = CommandType.StoredProcedure;

			// add proc parameters
			if (prams != null) 
			{
				foreach (SqlParameter parameter in prams)
					cmd.Parameters.Add(parameter);
			}
			
			// return param
			cmd.Parameters.Add(
				new SqlParameter("ReturnValue", SqlDbType.Int, 4,
				ParameterDirection.ReturnValue, false, 0, 0,
				string.Empty, DataRowVersion.Default, null));

			return cmd;
		}

		/// <summary>
		/// Open the connection.
		/// </summary>
		private void Open() 
		{
			// open connection
			if (con == null) 
			{
				con = new SqlConnection(ConfigurationSettings.AppSettings["ConnectionString"]);
				con.Open();
			}
			else if (con.State == ConnectionState.Closed)
				con.Open();
		}

		/// <summary>
		/// Close the connection.
		/// </summary>
		public void Close() 
		{
			if (con != null)
				con.Close();
		}

		/// <summary>
		/// Release resources.
		/// </summary>
		public void Dispose() 
		{
			// make sure connection is closed
			if (con != null) 
			{
				con.Dispose();
				con = null;
			}				
		}

		/// <summary>
		/// Make input param.
		/// </summary>
		/// <param name="ParamName">Name of param.</param>
		/// <param name="DbType">Param type.</param>
		/// <param name="Size">Param size.</param>
		/// <param name="Value">Param value.</param>
		/// <returns>New parameter.</returns>
		public SqlParameter MakeInParam(string ParamName, SqlDbType DbType, int Size, object Value) 
		{
			return MakeParam(ParamName, DbType, Size, ParameterDirection.Input, Value);
		}		

		/// <summary>
		/// Make input param.
		/// </summary>
		/// <param name="ParamName">Name of param.</param>
		/// <param name="DbType">Param type.</param>
		/// <param name="Size">Param size.</param>
		/// <returns>New parameter.</returns>
		public SqlParameter MakeOutParam(string ParamName, SqlDbType DbType, int Size) 
		{
			return MakeParam(ParamName, DbType, Size, ParameterDirection.Output, null);
		}		

		/// <summary>
		/// Make stored procedure param.
		/// </summary>
		/// <param name="ParamName">Name of param.</param>
		/// <param name="DbType">Param type.</param>
		/// <param name="Size">Param size.</param>
		/// <param name="Direction">Parm direction.</param>
		/// <param name="Value">Param value.</param>
		/// <returns>New parameter.</returns>
		public SqlParameter MakeParam(string ParamName, SqlDbType DbType, Int32 Size, ParameterDirection Direction, object Value) 
		{
			SqlParameter param;

			if(Size > 0)
				param = new SqlParameter(ParamName, DbType, Size);
			else
				param = new SqlParameter(ParamName, DbType);

			param.Direction = Direction;
			if (!(Direction == ParameterDirection.Output && Value == null))
				param.Value = Value;

			return param;
		}
		#endregion

		#region User

		public SqlDataReader FindUser(string UserName)
		{
			SqlParameter[] prams = {this.MakeInParam("@strUserName", SqlDbType.VarChar, UserName.Length, UserName)};
			SqlDataReader reader;
			this.RunProc("sp_FindUserByUserName", prams, out reader);
			return reader;
		}

		public SqlDataReader FindUser(int intEmployeeID)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeID", SqlDbType.Int, 4, intEmployeeID)};
			SqlDataReader reader;
			this.RunProc("sp_FindUserByID", prams, out reader);
			return reader;
		}


		public SqlDataReader GetSubordinates(int intEmployeeID, DateTime dtmMonth, bool Approved)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeID", SqlDbType.Int, 4, intEmployeeID),
									   this.MakeInParam("@dtmMonth", SqlDbType.DateTime, 8, dtmMonth),
									   this.MakeInParam("@bitApproved", SqlDbType.Bit, 1, Approved)};

			SqlCommand cmd = CreateCommand("sp_GetSubordinates", prams);
			return cmd.ExecuteReader();


		}

		public SqlDataReader GetDeactivatedUsers(int intEmployeeTypeID)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeTypeID", SqlDbType.Int, 4, intEmployeeTypeID)};

			SqlCommand cmd = CreateCommand("sp_GetDeactivatedUsers", prams);
			return cmd.ExecuteReader();


		}

		public int SaveEmployee(DMXUser user)
		{
			string procName;
			SqlParameter empID;
			if (user.EmployeeID > 0)
			{
				procName = "sp_UpdateEmployee";
				empID = this.MakeInParam("@intEmpID", SqlDbType.Int, 4, user.EmployeeID);
			}
			else
			{
				procName = "sp_InsertEmployee";
				empID = this.MakeOutParam("@intEmpID", SqlDbType.Int, 4);
			}

			



			SqlParameter[] prams = {empID,
									   this.MakeInParam("@intEmpTypeID", SqlDbType.Int, 4, (int)user.UserType),
									   this.MakeInParam("@strUserName", SqlDbType.VarChar, user.UserName.Length, user.UserName),
									   this.MakeInParam("@strPassword", SqlDbType.VarChar, user.Password.Length, user.Password),
									   this.MakeInParam("@strFirstName", SqlDbType.VarChar, user.FirstName.Length, user.FirstName),
									   this.MakeInParam("@strLastName", SqlDbType.VarChar, user.LastName.Length, user.LastName),
									   this.MakeInParam("@strAddress", SqlDbType.VarChar, user.Address.Length, user.Address),
									   this.MakeInParam("@strPhone", SqlDbType.VarChar, user.Phone.Length, user.Phone),
									   this.MakeInParam("@strRegion", SqlDbType.VarChar, user.Region.Length, user.Region),
									   this.MakeInParam("@strArea", SqlDbType.VarChar, user.Area.Length, user.Area),
									   this.MakeInParam("@strLSO", SqlDbType.VarChar, user.LSO.Length, user.LSO),
									   this.MakeInParam("@strEmail", SqlDbType.VarChar, user.Email.Length, user.Email),
									   this.MakeInParam("@intSalesManagerID", SqlDbType.Int, 4, user.SalesManagerID)};

			this.RunProc(procName, prams);

			return (int)prams[0].Value;

		}

		public void DeactivateUser(int userID)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmpID", SqlDbType.Int, 4, userID)};
			this.RunProc("sp_DeactivateEmployee", prams);

		}
		
		public bool ReactivateUser(int userID)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmpID", SqlDbType.Int, 4, userID)};
			SqlCommand cmd = CreateCommand("sp_ReactivateEmployee", prams);
			if (cmd.ExecuteNonQuery() < 1)
			{
				return false;
			}
			else return true;
		}
		
		#endregion

		#region Top 25

		public SqlDataReader GetTop25ForMonth(int intEmployeeID, DateTime ForecastMonth, bool blApproved)
		{
			string strMonthYear = ForecastMonth.Month + "/" + ForecastMonth.Year;
			if (blApproved)
			{
				return this.GetTop25ForMonth(intEmployeeID, strMonthYear, 1);
			}
			else
			{
				return this.GetTop25ForMonth(intEmployeeID, strMonthYear, 0);
			}

		}


		public SqlDataReader GetTop25ForMonth(int intEmployeeID, DateTime ForecastMonth)
		{
			string strMonthYear = ForecastMonth.Month + "/" + ForecastMonth.Year;
			return this.GetTop25ForMonth(intEmployeeID, strMonthYear, -1);
		}


		private SqlDataReader GetTop25ForMonth(int intEmployeeID, string strMonthYear, int intApprovedParam)
		{
			SqlParameter[] prams = {this.MakeInParam("@p_intEmployeeID", SqlDbType.Int, 4, intEmployeeID),
									   this.MakeInParam("@p_bitApproved", SqlDbType.Int, 4, intApprovedParam),
									   this.MakeInParam("@p_strAnswerSet", SqlDbType.VarChar, strMonthYear.Length, strMonthYear)};
			SqlDataReader reader;
			this.RunProc("sp_GetTop25ForMonth", prams, out reader);
			return reader;
		}

		public SqlDataReader GetAccountNames(int intEmployeeID, DateTime dtmMonth, bool Active)
		{
			return  GetAccountNames(intEmployeeID, dtmMonth, -1, true);
		}

		public SqlDataReader GetAccountNames(int intEmployeeID, DateTime dtmMonth, bool Approved, bool Active)
		{
			if(Approved){ return  GetAccountNames(intEmployeeID, dtmMonth, 1, Active);}
			else{return  GetAccountNames(intEmployeeID, dtmMonth, 0, Active);}
		}

		private SqlDataReader GetAccountNames(int intEmployeeID, DateTime dtmMonth, int Approved, bool Active)
		{
			SqlParameter[] prams = {this.MakeInParam("@p_intEmployeeID", SqlDbType.Int, 4, intEmployeeID),
									   this.MakeInParam("@p_dtmMonth", SqlDbType.DateTime, 8, dtmMonth),
									   this.MakeInParam("@p_intApproved", SqlDbType.Int, 4, Approved),
									   this.MakeInParam("@p_bitActive", SqlDbType.Bit, 1, Active),};

			SqlCommand cmd = CreateCommand("sp_GetAccountNames", prams);
			return cmd.ExecuteReader();

		}

		public SqlDataReader GetClosedAccounts(int intEmployeeID)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeID", SqlDbType.Int, 4, intEmployeeID)};

			SqlCommand cmd = CreateCommand("sp_GetClosedAccounts", prams);
			return cmd.ExecuteReader();

		}

		public bool ReActivateAccount(int intAccountID)
		{
			SqlParameter[] prams = {this.MakeInParam("@intAccountID", SqlDbType.Int, 4, intAccountID)};

			SqlCommand cmd = CreateCommand("sp_ReActivateAccount", prams);
			if (cmd.ExecuteNonQuery() != 1)
			{
				return false;
			}
			else return true;

		}

		public SqlDataReader GetAccountInfo(int intAccountID, bool ApprovedOnly)
		{
			SqlParameter[] prams = {this.MakeInParam("@intAccountID", SqlDbType.Int, 4, intAccountID),
									   this.MakeInParam("@bitApprovedOnly", SqlDbType.Bit, 1, ApprovedOnly)};

			SqlCommand cmd = CreateCommand("sp_GetAccountInfo", prams);
			return cmd.ExecuteReader();

		}

		public void DeleteAccount(Top25Account account)
		{
			SqlParameter[] prams = {this.MakeInParam("@intAccountID", SqlDbType.Int, 4, account.AccountID)};
			this.RunProc("sp_DeleteAccount", prams);
		}

		public void CloseAccount(Top25Account account)
		{
			SqlParameter[] prams = {this.MakeInParam("@intAccountID", SqlDbType.Int, 4, account.AccountID)};
			this.RunProc("sp_CloseAccount", prams);
		}


		public int SaveAccount(Top25Account account)
		{
			string status = "";
			switch (account.Status)
			{
				case AccountStatus.Approved:
					status = "A";
					break;
				case AccountStatus.Pending:
					status = "P";
					break;
				case AccountStatus.Updated:
					status = "U";
					break;
			}


			SqlParameter[] prams = {this.MakeInParam("@intAccountID", SqlDbType.Int, 4, account.AccountID),
									   this.MakeInParam("@intEmployeeID", SqlDbType.Int, 4, account.EmployeeID),
									   this.MakeInParam("@dtmMonth", SqlDbType.DateTime, 8, account.Month),
									   this.MakeInParam("@strAccountName", SqlDbType.VarChar, account.AccountName.Length, account.AccountName),
									   this.MakeInParam("@strContact", SqlDbType.VarChar, account.Contact.Length, account.Contact),
									   this.MakeInParam("@intLocations", SqlDbType.Int, 4, account.Locations),
									   this.MakeInParam("@strPhone", SqlDbType.VarChar, account.Phone.Length, account.Phone),
									   this.MakeInParam("@mnyClosedRMR", SqlDbType.Money, 8, account.ClosedRMR),
									   this.MakeInParam("@mnyClosedRSS", SqlDbType.Money, 8, account.ClosedRSS),
									   this.MakeInParam("@mnyRMR_10", SqlDbType.Money, 8, account.RMR_10),
									   this.MakeInParam("@mnyRSS_10", SqlDbType.Money, 8, account.RSS_10),
									   this.MakeInParam("@mnyRMR_50", SqlDbType.Money, 8, account.RMR_50),
									   this.MakeInParam("@mnyRSS_50", SqlDbType.Money, 8, account.RSS_50),
									   this.MakeInParam("@mnyRMR_90", SqlDbType.Money, 8, account.RMR_90),
									   this.MakeInParam("@mnyRSS_90", SqlDbType.Money, 8, account.RSS_90),
									   this.MakeInParam("@charStatus", SqlDbType.Char, 1, status),
									   this.MakeOutParam("@intNewAccountID", SqlDbType.Int, 4)};

			this.RunProc("sp_SaveAccount", prams);

			return (int)prams[1].Value;
			

		}


		public DataView GetTop25Summary(DateTime StartMonth, 
			DateTime EndMonth, 
			bool Approved,
			string strRegion,
			string strArea,
			string strLSO,
			int intSalesManagerID)
		{
			SqlParameter[] prams = {this.MakeInParam("@dtmStartMonth", SqlDbType.DateTime, 8, StartMonth),
									   this.MakeInParam("@dtmEndMonth", SqlDbType.DateTime, 8, EndMonth),
									   this.MakeInParam("@bitApproved", SqlDbType.Bit, 1, Approved),
									   this.MakeInParam("@strRegion", SqlDbType.VarChar, strRegion.Length, strRegion),
									   this.MakeInParam("@strArea", SqlDbType.VarChar, strArea.Length, strArea),
									   this.MakeInParam("@strLSO", SqlDbType.VarChar, strLSO.Length, strLSO),
									   this.MakeInParam("@intSalesManagerID", SqlDbType.Int, 4, intSalesManagerID)};

			SqlCommand cmd = CreateCommand("sp_GetTop25Summary", prams);
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			DataTable table = new DataTable("Top25Summary");

			da.Fill(table);
			return table.DefaultView;

		}

		public DataView GetEmployeesTop25Summary(DateTime StartMonth, 
			DateTime EndMonth, 
			bool Approved,
			string strRegion,
			string strArea,
			string strLSO,
			int intSalesManagerID)
		{
			SqlParameter[] prams = {this.MakeInParam("@dtmStartMonth", SqlDbType.DateTime, 8, StartMonth),
									   this.MakeInParam("@dtmEndMonth", SqlDbType.DateTime, 8, EndMonth),
									   this.MakeInParam("@bitApproved", SqlDbType.Bit, 1, Approved),
									   this.MakeInParam("@strRegion", SqlDbType.VarChar, strRegion.Length, strRegion),
									   this.MakeInParam("@strArea", SqlDbType.VarChar, strArea.Length, strArea),
									   this.MakeInParam("@strLSO", SqlDbType.VarChar, strLSO.Length, strLSO),
									   this.MakeInParam("@intSalesManagerID", SqlDbType.Int, 4, intSalesManagerID)};

			SqlCommand cmd = CreateCommand("sp_GetEmployeesTop25Summary", prams);
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			DataTable table = new DataTable("Top25Summary");

			da.Fill(table);
			return table.DefaultView;

		}

		
		public DataView GetEmployeesTop25(int EmployeeID, DateTime Month, 
			bool Approved)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeID", SqlDbType.Int, 4, EmployeeID),
									   this.MakeInParam("@dtmMonth", SqlDbType.DateTime, 8, Month),
									   this.MakeInParam("@bitApproved", SqlDbType.Bit, 1, Approved)};

			SqlCommand cmd = CreateCommand("sp_GetEmployeesTop25", prams);
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			DataTable table = new DataTable("sp_GetEmployeesTop25");

			da.Fill(table);
			return table.DefaultView;

		}

		

		public SqlDataReader GetTop25SummaryForMonth(DateTime month)
		{
			// make sure datetime is the first of the month, to match database
			DateTime myMonth = new DateTime(month.Year, month.Month, 1); 

			SqlParameter[] prams = {this.MakeInParam("@dtmMonth", SqlDbType.DateTime, 8, myMonth)};
			SqlDataReader reader;
			this.RunProc("sp_GetTop25SummaryForMonth", prams, out reader);
			return reader;
		}
		
		public bool QueueNotification(int EmployeeID, 
			int AccountID, string AccountName, DateTime Month, string Action)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeID", SqlDbType.Int, 4, EmployeeID),
									   this.MakeInParam("@intAccountID", SqlDbType.Int, 4, AccountID),
									   this.MakeInParam("@strAccountName", SqlDbType.VarChar, AccountName.Length, AccountName),
									   this.MakeInParam("@dtmMonth", SqlDbType.DateTime, 8, Month),
									   this.MakeInParam("@strAction", SqlDbType.VarChar, Action.Length, Action)};

			if (this.RunProc("sp_QueueNotification", prams) == 1)
			{
				return true;
			}
			else 
			{
				return false;
			}

		}


		public DataTable GetNotificationQueue()
		{

			DataTable dt = new DataTable("NotificationQueue");
			SqlDataAdapter da = new SqlDataAdapter(CreateCommand("sp_GetNotificationQueue", null));
			da.MissingSchemaAction = MissingSchemaAction.AddWithKey;
			da.Fill(dt);
			return dt;
		}

		public void UpdateNotificationQueue(DataTable newData)
		{
			this.Open();

			//			DataSet ds = new DataSet("NotificationQueue");
			SqlDataAdapter da = new SqlDataAdapter();

			SqlCommand cmd = new SqlCommand("UPDATE NotificationQueue SET dtmSent = @dtmSent WHERE intMessageID = @intMessageID",
				this.con);
			//Create and append the parameters for the Update command.
			cmd.Parameters.Add(new SqlParameter("@dtmSent", SqlDbType.DateTime));
			cmd.Parameters["@dtmSent"].SourceVersion = DataRowVersion.Current;
			cmd.Parameters["@dtmSent"].SourceColumn = "dtmSent";

			cmd.Parameters.Add(new SqlParameter("@intMessageID", SqlDbType.Int));
			cmd.Parameters["@intMessageID"].SourceVersion = DataRowVersion.Original;
			cmd.Parameters["@intMessageID"].SourceColumn = "intMessageID";

			da.UpdateCommand = cmd;
			da.Update(newData);
		}

		public DataTable GetQuotas(int intEmployeeID, int intYear)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeID", SqlDbType.Int, 4, intEmployeeID),
									   this.MakeInParam("@intYear", SqlDbType.Int, 4, intYear)};

			SqlCommand cmd = CreateCommand("sp_GetEmployeeQuotas", prams);
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			DataTable dt = new DataTable("QuotaFunnel");
			da.MissingSchemaAction = MissingSchemaAction.AddWithKey;
			da.Fill(dt);


			return dt;


		}


		public void SaveQuotas(DataTable Quotas)
		{
			
			this.Open();

			//			DataSet ds = new DataSet("NotificationQueue");
			SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM QuotaFunnel", this.con);
			SqlCommandBuilder cb = new SqlCommandBuilder(da);

			da.Update(Quotas);


		}

		public SqlDataReader GetQuotaFunnel(int intEmployeeID, DateTime dtmMonth)
		{
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeID", SqlDbType.Int, 4, intEmployeeID),
									   this.MakeInParam("@dtmMonth", SqlDbType.DateTime, 8, dtmMonth)};

			SqlDataReader reader;
			this.RunProc("sp_GetEmployeeQuotasForMonth", prams, out reader);
			return reader;


		}



		#endregion

		#region Admin


		public SqlDataReader GetEmployees(int intEmployeeTypeID)
		{
			SqlDataReader reader;
			SqlParameter[] prams = {this.MakeInParam("@intEmployeeTypeID", SqlDbType.Int, 4, intEmployeeTypeID)};
			this.RunProc("sp_GetEmployeeList",  prams, out reader);
			return reader;
		}



		#endregion

		#region Reference

		public SqlDataReader BusinessMonths
		{
			get
			{
				SqlDataReader reader;
				this.RunProc("sp_GetBusinessMonths", out reader);
				return reader;
			}
		}

		public SqlDataReader Regions
		{
			get
			{
				SqlDataReader reader;
				this.RunProc("sp_GetRegions", out reader);
				return reader;
			}
		}

		public SqlDataReader Areas
		{
			get
			{
				SqlDataReader reader;
				this.RunProc("sp_GetAreas", out reader);
				return reader;
			}
		}


		public SqlDataReader LSOs
		{
			get
			{
				SqlDataReader reader;
				this.RunProc("sp_GetLSOs", out reader);
				return reader;
			}
		}



		public SqlDataReader EmployeeTypes
		{
			get
			{
				SqlDataReader reader;
				this.RunProc("sp_GetEmployeeTypes", out reader);
				return reader;
			}
		}


		public enum EmployeeType : short
		{
			Administrator = 1,
			Executive = 2,
			Sales = 3,
			SalesManager = 4
		}

		#endregion

	}

	

}
