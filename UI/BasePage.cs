using System;
using System.Web.UI;
using dmx.Components;

namespace dmx.UI
{
	/// <summary>
	/// Base Page for my stinky stuff
	/// </summary>
	public class BasePage : Page
	{
		public new CustomPrincipal User
		{
			get
			{
				return (CustomPrincipal)base.User;
			}
		}

		public BasePage()
		{

		
		}
	}
}
