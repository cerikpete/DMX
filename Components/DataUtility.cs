
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace dmx.Components
{
	/// <summary>
	/// A utility class for dealing with data retrieved from the Database 
	/// </summary>
	public class DataUtility
	{

		private static readonly string _DatabaseExceptionUserMessage = ConfigurationSettings.AppSettings["DatabaseExceptionUserMessage"];        

		/// <summary>
		/// Retrieve a string from a IDataReader
		/// </summary>
		/// <param name="dr">The IDataReader to read the string from</param>
		/// <param name="columnName">The name of the column</param>
		/// <param name="valueIfNull">The value to return if the column is null</param>
		public static string RetrieveString(IDataReader dr,string columnName,string valueIfNull)
		{

			string retVal = valueIfNull;

			try
			{				
				retVal = dr.IsDBNull(dr.GetOrdinal(columnName)) ? valueIfNull:dr.GetString(dr.GetOrdinal(columnName));
			}
			catch (SqlException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage,"SqlException occured while retrieving the column:" + columnName, "RetrieveString", e);
			}
			catch (IndexOutOfRangeException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "The name specified is not a valid column name:" + columnName, "RetrieveString", e);
			}

			return retVal;

		}


		/// <summary>
		/// Retrieve a Int32 from a IDataReader
		/// </summary>
		/// <param name="dr">The IDataReader to read the string from</param>
		/// <param name="columnName">The name of the column</param>
		/// <param name="valueIfNull">The value to return if the column is null</param>
		public static int RetrieveInt32(IDataReader dr,string columnName,int valueIfNull)
		{

			int retVal = valueIfNull;

			try
			{				
				retVal = dr.IsDBNull(dr.GetOrdinal(columnName)) ? valueIfNull:dr.GetInt32(dr.GetOrdinal(columnName));
			}
			catch (SqlException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "SqlException occured while retrieving the column:" + columnName, "RetrieveInt32", e);
			}
			catch (IndexOutOfRangeException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "The name specified is not a valid column name:" + columnName, "RetrieveInt32", e);
			}

			return retVal;

		}

		/// <summary>
		/// Retrieve a Double from a IDataReader
		/// </summary>
		/// <param name="dr">The IDataReader to read the string from</param>
		/// <param name="columnName">The name of the column</param>
		/// <param name="valueIfNull">The value to return if the column is null</param>
		public static double RetrieveDouble(IDataReader dr,string columnName,double valueIfNull)
		{

			double retVal = valueIfNull;

			try
			{				
				retVal = dr.IsDBNull(dr.GetOrdinal(columnName)) ? valueIfNull:dr.GetDouble(dr.GetOrdinal(columnName));
			}
			catch (SqlException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "SqlException occured while retrieving the column:" + columnName, "RetrieveDouble", e);
			}
			catch (IndexOutOfRangeException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "The name specified is not a valid column name:" + columnName, "RetrieveDouble", e);
			}

			return retVal;

		}

		/// <summary>
		/// Retrieve a Decimal from a IDataReader
		/// </summary>
		/// <param name="dr">The IDataReader to read the string from</param>
		/// <param name="columnName">The name of the column</param>
		/// <param name="valueIfNull">The value to return if the column is null</param>
		public static decimal RetrieveDecimal(IDataReader dr,string columnName,decimal valueIfNull) {

			decimal retVal = valueIfNull;

			try {				
				retVal = dr.IsDBNull(dr.GetOrdinal(columnName)) ? valueIfNull:dr.GetDecimal(dr.GetOrdinal(columnName));
			}
			catch (SqlException e) {
				throw new DatabaseException(_DatabaseExceptionUserMessage, "SqlException occured while retrieving the column:" + columnName, "RetrieveDecimal", e);
			}
			catch (IndexOutOfRangeException e) {
				throw new DatabaseException(_DatabaseExceptionUserMessage, "The name specified is not a valid column name:" + columnName, "RetrieveDecimal", e);
			}

			return retVal;

		}


		/// <summary>
		/// Retrieve a Int32 from a DataRow
		/// </summary>
		/// <param name="row">The DataRow to read the string from</param>
		/// <param name="columnName">The name of the column</param>
		/// <param name="valueIfNull">The value to return if the column is null</param>
		public static int RetrieveInt32(DataRow row,string columnName,int valueIfNull)
		{

			int retVal = valueIfNull;

			try
			{				
				retVal = row.IsNull(columnName) ? valueIfNull:Convert.ToInt32(row[columnName]);
			}
			catch (SqlException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "SqlException occured while retrieving the column:" + columnName, "RetrieveInt32", e);
			}

			return retVal;

		}

		/// <summary>
		/// Retrieve a bool from a IDataReader
		/// </summary>
		/// <param name="dr">The IDataReader to read the string from</param>
		/// <param name="columnName">The name of the column</param>
		public static bool RetrieveBool(IDataReader dr,string columnName)
		{

			bool retVal = false;

			try
			{				
				retVal = dr.IsDBNull(dr.GetOrdinal(columnName)) ? false : dr.GetBoolean(dr.GetOrdinal(columnName));
			}
			catch (SqlException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "SqlException occured while retrieving the column:" + columnName, "RetrieveBool", e);
			}
			catch (IndexOutOfRangeException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "The name specified is not a valid column name:" + columnName, "RetrieveBool", e);
			}

			return retVal;

		}

		/// <summary>
		/// Retrieve a DateTime from a IDataReader
		/// </summary>
		/// <param name="dr">The IDataReader to read the string from</param>
		/// <param name="columnName">The name of the column</param>
		/// <param name="valueIfNull">The value to return if the column is null</param>
		public static DateTime RetrieveDateTime(IDataReader dr,string columnName,DateTime valueIfNull)
		{

			DateTime retVal = valueIfNull;

			try
			{				
				retVal = dr.IsDBNull(dr.GetOrdinal(columnName)) ? valueIfNull:dr.GetDateTime(dr.GetOrdinal(columnName));
			}
			catch (SqlException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "SqlException occured while retrieving the column:" + columnName, "RetrieveDateTime", e);
			}
			catch (IndexOutOfRangeException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "The name specified is not a valid column name:" + columnName, "RetrieveDateTime", e);
			}

			return retVal;

		}

	
		/// <summary>
		/// Retrieve a DataTime from a DataRow
		/// </summary>
		/// <param name="row">The DataRow to read the string from</param>
		/// <param name="columnName">The name of the column</param>
		/// <param name="valueIfNull">The value to return if the column is null</param>
		public static DateTime RetrieveDateTime(DataRow row,string columnName,DateTime valueIfNull)
		{

			DateTime retVal = valueIfNull;

			try
			{				
				retVal = row.IsNull(columnName) ? valueIfNull:Convert.ToDateTime(row[columnName]);
			}
			catch (SqlException e)
			{
				throw new DatabaseException(_DatabaseExceptionUserMessage, "SqlException occured while retrieving the column:" + columnName, "RetrieveDateTime", e);
			}

			return retVal;

		}
	}
}
