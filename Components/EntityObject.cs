using System;

namespace dmx.Components
{
	/// <summary>
	/// Summary description for EntityObject.
	/// </summary>
	/// <summary>
	/// This is a base object I have in my projects that my business object inherit from.  There is obviously a lot more to the
	/// object then what I have shown here but these are the two methods used by the above code.
	/// </summary>
	public class EntityObject
	{
		/// <summary>
		/// Serialize the object to xml
		/// </summary>
		/// <returns>String of xml representing the object</returns>
		public virtual string ToXml()
		{		
			System.IO.MemoryStream stream = new System.IO.MemoryStream();
			System.Xml.Serialization.XmlSerializer serializer = new System.Xml.Serialization.XmlSerializer(this.GetType());
			serializer.Serialize(stream, this);
			string xml = System.Text.Encoding.UTF8.GetString(stream.ToArray()).Replace(Environment.NewLine, "");			
			stream.Close();
			return xml;
		}

		/// <summary>
		/// Deserialize an object from an xml string
		/// </summary>
		/// <param name="xml">The xml representation of the object</param>
		/// <returns>EntityObject</returns>
		/// <remarks>After deserializing the object returned will have to be cast to the proper type</remarks>
		public EntityObject FromXml(string xml)
		{	
			EntityObject entity = null;
			System.IO.StringReader reader = null;
			try 
			{
				System.Xml.Serialization.XmlSerializer serializer = new System.Xml.Serialization.XmlSerializer(this.GetType());
				reader = new System.IO.StringReader(xml);
				entity = (EntityObject)serializer.Deserialize(reader);
			}
			finally 
			{
				if(reader!=null) reader.Close();
			}

			return entity;

		}
	}
}
