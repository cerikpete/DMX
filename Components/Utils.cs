using System;

namespace dmx.Components
{
	/// <summary>
	/// Summary description for Utils.
	/// </summary>
	public class Utils
	{
		public Utils()
		{
			//
			// TODO: Add constructor logic here
			//
		}

		public static Decimal GetDecimal(string m_value)
		{
			try
			{
				return Decimal.Parse(m_value);
			}
			catch (Exception ex)
			{
				return 0.0m;

			}


		}
	}
}
