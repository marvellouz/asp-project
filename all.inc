<%@ LANGUAGE="JScript" CODEPAGE=65001 %>
<!--#include file="connection.inc"-->
<!--#include file="helpers.inc"-->
<%
var flash = new String(Session("flash") || "");
Session.Contents.Remove("flash");

var form_values = form2arr(Request);

var method = Request.ServerVariables("REQUEST_METHOD");

if(Session("user_email")) {
  var user = {};
  var u = connection.execute("select * from User where email = '" + Session("user_email") + "';");
  while(!u.eof) {
    user["email"] = u("email").value;
    user["first_name"] = u("first_name").value;
    user["last_name"] = u("last_name").value;
    user["is_admin"] = u("is_admin").value;
    u.movenext
  }
}
%>
