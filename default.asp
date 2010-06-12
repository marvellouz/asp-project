<%@ LANGUAGE="JScript" CODEPAGE=65001 %>
<!--#include file="connection.inc"-->
<!--#include file="helpers.inc"-->


<%
Response.Charset  = "UTF-8";
Response.Codepage = 65001;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="bg" lang="bg">
  <head>
    <title> Имоти </title>
    <meta http-equiv="content-type" 
      content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
  </head>

  <body>

      <div id="container">
    <div id="header"><a href="/asp-project/"><img alt="logo" id="logo" src="images/logo.png" /></a>
      <div id = "hmenu_div">
        <ul id = "hmenu">
          <li><a id="search" href = "/asp-project/"></a></li>
        </ul>
    </div>
    </div>
        <div id="content">
      <form method="get" name="register" action="Default.asp">
        E-mail: <br />
        <input type="text" name="email" /><br /><br />
        Парола: <br />
        <input type="password" name="password" /><br /><br />
        Име: <br />
        <input type="text" name="first_name" /><br /><br />
        Фамилия: <br />
        <input type="text" name="last_name" /><br /><br />
        <input type="submit" value="Submit" />
      </form>
      <%
      form2arr();
      sql_insert("User");
      var users = connection.execute("select * from User;");
      while(!users.eof) {
        Response.write("<ul>");
        Response.write("<li>" + users("email") +", "+ users("password") +", "+ users("first_name") +", "+ users("last_name") + "</li>");	
        users.movenext
        Response.write("</ul>");
      }
      %>
        </div>
        <div id="footer"></div>
    </div>
  </body>
</html>
