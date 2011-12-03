using System;
using System.Web.UI;
using dmx.Components;

namespace dmx.UI
{
	/// <summary>
	/// Summary description for BaseControl.
	/// </summary>
	public class BaseControl : UserControl
	{
		public new BasePage Page
		{
			get
			{
				return (BasePage)base.Page;
			}
		}

		public BaseControl()
		{
			//
			// TODO: Add constructor logic here
			//
		}
	}
}
