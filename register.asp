<!--#include file="all.inc"-->
<%
var form;

form ="<h1>Регистрация</h1>";
form += generate_form(register_form, register_input, "Submit");


if(method == "POST") {
  try {
    sql_insert("User", Request);
  }
  catch(e) {
      flash=e.msg || "";
  }
}


var users = connection.execute("select * from User;");

while(!users.eof) {
  form += "<ul>";
  form += "<li>" + users("email") +", "+ users("password") +", "+ users("first_name") +", "+ users("last_name") + "</li>";	
  users.movenext
  form += "</ul>";
}
blocks["content"] = form;
%>
<!-- #include FILE="template.inc" -->
