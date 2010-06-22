<!--#include file="all.inc"-->
<%
var form;
var login_form = {"method":"post", "id":"register", "action":"login.asp"};
var login_input = [{"label":"E-mail", "name":"email", "type":"text", "id":"login_email_id"}, {"label":"Парола", "name":"password", "type":"password", "id":"login_password_id"}];
form = generate_form("Вход", login_form, "Вход", login_input);

if(method == "POST") {
  var user_email = new String(Request.Form("email"));
  var user_password = MD5(new String(Request.Form("password")) + Settings.salt);
  if(login_valid(user_email, user_password)) {
    Session("user_email") = user_email;
    Session("flash") = "Успешно влязохте като " + Session("user_email") + "!";
    Response.redirect("default.asp");
  }
  else {
    flash = "Грешно потребителско име или парола!"
  }
}

blocks["content"] = form;
%>
<!-- #include FILE="template.inc" -->
