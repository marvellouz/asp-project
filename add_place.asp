<!--#include file="all.inc"-->
<%
var form;
var city = select_tag_arr("City");

var add_place_form = {"method":"post", "id":"add_place", "action":"add_place.asp"};
var add_place_select = [{"label":"Вид", "name":"type_name", "id":"type_id", "values":[{"value":"Апартамент", "text":"Апартамент"},{"value":"Къща", "text":"Къща"}]}, {"label":"Материал", "name":"material_name", "id":"material_id", "values":[{"value":"Тухла", "text":"Тухла"},{"value":"Панел", "text":"Панел"}]}, {"label":"Град", "name":"city_name", "id":"city", "values":city}, {"label":"Квартал", "name":"neighbourhood_name", "id":"neighbourhood", "values":[{"value":"Младост", "text":"Младост"},{"value":"Надежда", "text":"Надежда"}]}]

var place_input = [{"label":"Улица", "name":"street", "type":"text", "id":"street_id"}, {"label":"Номер", "name":"number", "type":"text","maxlength":"4" , "id":"number_id"}, {"label":"Етаж", "name":"floor", "type":"text", "maxlength":"4" , "id":"floor_id"}, {"label":"Апартамент", "name":"apartment", "type":"text","maxlength":"4" , "id":"apartment_id"}, {"label":"Квадратура*", "name":"meters", "type":"text","maxlength":"4" , "id":"meters_id"}, {"label":"Цена*", "name":"price", "type":"text","maxlength":"7" , "id":"price_id"}];

var textarea = [{"label":"Допълнителна информация", "name":"additional_info", "id":"additional_info_id", "rows":"10", "cols":"40", "text":""}]
form = generate_form("Добавяне на имот", add_place_form, "Добави", place_input, add_place_select, textarea);

var blanks = {"street":"street", "number":"number","floor":"floor", "apartment":"apartment", "additional_info":"additional_info", "city_name":"city_name", "neighbourhood_name":"neighbourhood_name", "type_name":"type_name", "material_name":"material_name"};

if(method == "POST") {
  var e = validate_form(form_values, null, blanks);
  if(!is_empty(e)) {
    for(var key in e) {
      flash += (e[key] + " ") || "";
    }
  }
  else {
    Session('flash') = "Успешно добавихте имот!"
    Response.Redirect("default.asp")
  }
}


blocks["content"] = form;
%>
<!-- #include FILE="template.inc" -->
