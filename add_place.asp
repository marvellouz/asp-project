<!--#include file="all.inc"-->
<%
var form;
var add_place_form = {"method":"post", "name":"add_place", "action":"add_place.asp"};
var add_place_select = [{"label":"Град", "name":"city", "id":"city", "values":[{"value":"Стара Загора", "text":"Стара Загора"},{"value":"София", "text":"София"}]}]
var login_input = [{"label":"E-mail", "name":"email", "type":"text", "id":"login_email_id"}, {"label":"Парола", "name":"password", "type":"password", "id":"login_password_id"}];
form = "<h1>Добавяне на имот</h1>"
form += generate_form(add_place_form, "Добави", login_input, add_place_select );
blocks["content"] = form;
%>
<!-- #include FILE="template.inc" -->
