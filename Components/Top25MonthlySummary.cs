using System;
using System.Data;
using System.Data.SqlClient;

namespace dmx.Components
{
	/// <summary>
	/// Summary description for Top25MonthlySummary.
	/// </summary>
	public class Top25MonthlySummary
	{
		private DateTime _summaryMonth;
		private Decimal _ClosedRSS = 0.0M;
		private Decimal _ClosedRMR = 0.0M;
		private Decimal _RSS_10 = 0.0M;
		private Decimal _RMR_10 = 0.0M;
		private Decimal _RSS_50 = 0.0M;
		private Decimal _RMR_50 = 0.0M;
		private Decimal _RSS_90 = 0.0M;
		private Decimal _RMR_90 = 0.0M;
		private Decimal _ProjRSS = 0.0M;
		private Decimal _ProjRMR = 0.0M;
		private Decimal _TotalProposedRSS = 0.0M;

		public DateTime SummaryMonth
		{
			get
			{
				return _summaryMonth;
			}
			set
			{
				_summaryMonth = value;
				LoadData(_summaryMonth);
			}
		}

		public Decimal ClosedRSS
		{
			get
			{
				return _ClosedRSS;
			}
		}

		public Decimal ClosedRMR
		{
			get
			{
				return _ClosedRMR;
			}
		}

		public Decimal RSS_10
		{
			get
			{
				return _RSS_10;
			}
		}

		public Decimal RMR_10
		{
			get
			{
				return _RMR_10;
			}
		}

		public Decimal RSS_50
		{
			get
			{
				return _RSS_50;
			}
		}

		public Decimal RMR_50
		{
			get
			{
				return _RMR_50;
			}
		}

		public Decimal RSS_90
		{
			get
			{
				return _RSS_90;
			}
		}

		public Decimal RMR_90
		{
			get
			{
				return _RMR_90;
			}
		}

		public Decimal ProjectedRSS
		{
			get
			{
				return _ProjRSS;
			}
		}

		public Decimal ProjectedRMR
		{
			get
			{
				return _ProjRMR;
			}
		}

		public Decimal TotalProposedRSS
		{
			get
			{
				return _TotalProposedRSS;
			}
		}

		public Top25MonthlySummary()
		{
			_summaryMonth = DateTime.Now;
		}

		public Top25MonthlySummary(DateTime summaryMonth)
		{
			_summaryMonth = summaryMonth;
			LoadData(_summaryMonth);
		}

		private void LoadData(DateTime myMonth)
		{
			Database data = new Database();
			SqlDataReader reader = data.GetTop25SummaryForMonth(myMonth);
			if (reader.Read())
			{
				_ClosedRSS = (Decimal)reader["ClosedRSS"];
				_ClosedRMR = (Decimal)reader["ClosedRMR"];
				_RSS_10 = (Decimal)reader["RSS_10"];
				_RMR_10 = (Decimal)reader["RMR_10"];
				_RSS_50 = (Decimal)reader["RSS_50"];
				_RMR_50 = (Decimal)reader["RMR_50"];
				_RSS_90 = (Decimal)reader["RSS_90"];
				_RMR_90 = (Decimal)reader["RMR_90"];
			}

			CalculateForecast();
			data.Close();
			data.Dispose();

		}

		private void CalculateForecast()
		{
			_ProjRSS = _ClosedRSS + (_RSS_10 * .10M) + (_RSS_50 * .50M) + (_RSS_90 * .90M);
			_ProjRMR = _ClosedRMR + (_RMR_10 * .10M) + (_RMR_50 * .50M) + (_RMR_90 * .90M);
			_TotalProposedRSS = _ClosedRSS + _RSS_10 + _RSS_50 + _RSS_90;


		}



	}
}
