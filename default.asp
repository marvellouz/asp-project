<%@ LANGUAGE="JScript" %>
<form method="get" action="Default.asp">
First Name: <input type="text" name="fname" /><br />
Last Name: <input type="text" name="lname" /><br /><br />
<input type="submit" value="Submit" />
</form>
>
<%

Response.Charset = "UTF-8"

Response.write(Request.QueryString("fname"))
Response.write(" " + Request.QueryString("lname") + "<br/>")

  var connection = Server.createObject("ADODB.Connection");
  var results = Server.createObject("ADODB.Recordset");
  connection.open("DSN=mysql_dsn");
  results.activeConnection = connection;
  if (connection.errors.count == 0) {
  	Response.write("Информация за типа:" + "<br/><br/>");
	connection.execute("use property;");

  var sql = "insert into Type(name) values('" +  Request.QueryString("fname") + "');";
  if (sql!="undefined"){
  try
    {
	  connection.execute(sql);
    }
  catch(err)
    {
    txt="There was an error on this page.\n\n";
    txt+="Error description: " + err.description + "\n\n";

    Response.write(txt);
    }
  }

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
