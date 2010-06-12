<%
Response.Charset = "UTF-8";
  var connection = Server.createObject("ADODB.Connection");
  var results = Server.createObject("ADODB.Recordset");
  connection.open("DSN=mysql_dsn");
  results.activeConnection = connection;
	connection.execute("use property;");
%>
