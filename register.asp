<!--#include file="all.inc"-->
<%
var form;
var register_form = {"method":"post", "name":"register", "action":"register.asp"}
var register_input = [{"label":"E-mail", "name":"email", "maxlength":"40", "type":"text", "id":"email_id"}, {"label":"Парола","name":"password", "maxlength":"20", "type":"password", "id":"password_id"}, {"label":"Име","name":"first_name", "maxlength":"20", "type":"text", "id":"fname_id"}, {"label":"Фамилия","name":"last_name", "maxlength":"20", "type":"text", "id":"lname_id"}, {"label":"Продавам имот", "type":"checkbox", "name":"is_admin", "value":1}]

var register_validation = {email:validate_email, password:validate_password};

form ="<h1>Регистрация</h1>";
form += generate_form(register_form, "Регистрация", register_input);
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
    if(Request.Form("is_admin")==1){
      sql_insert("Seller", {"User_email":form_values["email"]});
    }
    else {
      sql_insert("Customer", {"User_email":form_values["email"]});
    }
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
