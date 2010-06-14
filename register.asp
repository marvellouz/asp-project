<!--#include file="all.inc"-->
<%
var form;

form ="<h1>Регистрация</h1>";
form += generate_form(register_form, register_input, "Submit");
if(method == "POST") {
  var e = validate_form(form_values, register_validation);
  if(!is_empty(e)) {
    for(var key in e) {
      flash += (e[key] + " ") || "";
    }
  }
  else {
    form_values["password"] = hash_password(form_values["password"]);
    sql_insert("User", form_values);
    Session('flash') = "Успешна регистрация!"
    Response.Redirect("default.asp")
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
