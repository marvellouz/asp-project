<%@ LANGUAGE="JScript" %>
<%

  var connection = Server.createObject("ADODB.Connection");
  var results = Server.createObject("ADODB.Recordset");
  connection.open("DSN=mysql_dsn");
  results.activeConnection = connection;

  if (connection.errors.count == 0) {
  	Response.write("Some type info:");
	connection.execute("use property;");
	var prop_type = connection.execute("select * from Type;");
	while(!prop_type.eof) {
		Response.write("<ul>");
		Response.write("<li>" + prop_type("name") + "</li>");	
		prop_type.movenext
		Response.write("</ul>");
	}
  }
  else {
  	Response.write("Could not connect to the database.");
  }

%>
