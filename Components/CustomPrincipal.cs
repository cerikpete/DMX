using System;
using System.Security.Principal;

namespace dmx.Components
{
	/// <summary>
	/// Summary description for CustomPrincipal.
	/// </summary>
	public class CustomPrincipal : IPrincipal
	{
		private IIdentity _identity;
		private string [] _roles;
		public string FirstName;
		public string LastName;
		public string HomePage;
		public int EmployeeID;

		public string FullName
		{
			get
			{
				return this.FirstName + " " + this.LastName;
			}
		}



 
		public CustomPrincipal(IIdentity identity, string [] roles)
		{
			_identity = identity;
			_roles = new string[roles.Length];
			roles.CopyTo(_roles, 0);
			Array.Sort(_roles);
		}

		public CustomPrincipal(IIdentity identity, DMXUser user)
		{
			_identity = identity;
			FirstName = user.FirstName;
			LastName = user.LastName;
			EmployeeID = user.EmployeeID;
			HomePage = user.HomePage;
			_roles = new string[user.Roles.Length];
			user.Roles.CopyTo(_roles, 0);
			Array.Sort(_roles);
		}

		// IPrincipal Implementation
		public bool IsInRole(string role)
		{
			return Array.BinarySearch( _roles, role ) >=0 ? true : false;
		}
		public IIdentity Identity
		{
			get
			{
				return _identity;
			}
		}

		// Checks whether a principal is in all of the specified set of roles
			public bool IsInAllRoles( params string [] roles )
			{
				foreach (string searchrole in roles )
				{
					if (Array.BinarySearch(_roles, searchrole) < 0 )
						return false;
				}
				return true;
			}
		// Checks whether a principal is in any of the specified set of roles
			public bool IsInAnyRoles( params string [] roles )
			{
				foreach (string searchrole in roles )
				{
					if (Array.BinarySearch(_roles, searchrole ) > 0 )
						return true;
				}
				return false;
			}


	}
}
