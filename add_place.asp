<!--#include file="all.inc"-->
<%
var form;

var add_place_form = {"method":"post", "name":"add_place", "action":"add_place.asp"};
var add_place_select = [{"label":"Вид", "name":"type_name", "id":"type_id", "values":[{"value":"Апартамент", "text":"Апартамент"},{"value":"Къща", "text":"Къща"}]}, {"label":"Материал", "name":"material_name", "id":"material_id", "values":[{"value":"Тухла", "text":"Тухла"},{"value":"Панел", "text":"Панел"}]}, {"label":"Град", "name":"city", "id":"city", "values":[{"value":"Стара Загора", "text":"Стара Загора"},{"value":"София", "text":"София"}]}, {"label":"Квартал", "name":"neighbourhood_name", "id":"neighbourhood", "values":[{"value":"Младост", "text":"Младост"},{"value":"Надежда", "text":"Надежда"}]}]
var login_input = [{"label":"Улица", "name":"street", "type":"text", "id":"street_id"}, {"label":"Номер", "name":"number", "type":"text","maxlength":"4" , "id":"number_id"}, {"label":"Етаж", "name":"floor", "type":"text", "maxlength":"4" , "id":"floor_id"}, {"label":"Апартамент", "name":"apartment", "type":"text","maxlength":"4" , "id":"appartment_id"}, {"label":"Квадратура", "name":"meters", "type":"text","maxlength":"4" , "id":"meters_id"}, {"label":"Цена", "name":"price", "type":"text","maxlength":"7" , "id":"price_id"}, {"label":"Допълнителна<br/>информация", "name":"additional_info", "type":"text", "id":"additional_info_id"}];

form = "<h1>Добавяне на имот</h1>"
form += generate_form(add_place_form, "Добави", login_input, add_place_select );

if(method == "POST") {
  
}

blocks["content"] = form;
%>
<!-- #include FILE="template.inc" -->
