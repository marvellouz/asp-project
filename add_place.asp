<!--#include file="all.inc"-->
<%
var form;
var city = select_tag_arr("City");
var type = select_tag_arr("Type");
var material = select_tag_arr("Material");

var add_place_form = {
                      "method":"post",
                      "id":"add_place",
                      "action":"add_place.asp"
                    };

var add_place_select = [
                        {
                          "label":"Вид",
                          "name":"Type_name",
                          "id":"type_id",
                          "values":type
                        },
                        {
                          "label":"Материал",
                          "name":"Material_name",
                          "id":"material_id",
                          "values":material
                        },
                        {
                          "label":"Град*",
                          "name":"city_name",
                          "id":"city",
                          "values":city
                        }
                      ];

var place_input = [
                    {
                      "label":"Квартал*",
                      "name":"neighbourhood",
                      "type":"text",
                      "id":"neighbourhood_id"
                    },
                    {
                      "label":"Улица*",
                      "name":"street",
                      "type":"text",
                      "id":"street_id"
                    },
                    {
                      "label":"Номер",
                      "name":"number",
                      "type":"text",
                      "maxlength":"4",
                      "id":"number_id"
                    },
                    {
                      "label":"Етаж",
                      "name":"floor",
                      "type":"text",
                      "maxlength":"4",
                      "id":"floor_id"},
                    {
                      "label":"Апартамент",
                      "name":"appartment",
                      "type":"text",
                      "maxlength":"4",
                      "id":"appartment_id"
                    },
                    {
                      "label":"Вход",
                      "name":"entrance",
                      "type":"text",
                      "maxlength":"3",
                      "id":"entrance_id"},
                    {
                      "label":"Квадратура*",
                      "name":"meters",
                      "type":"text","maxlength":"4",
                      "id":"meters_id"
                    },
                    {
                      "label":"Цена*",
                      "name":"price",
                      "type":"text",
                      "maxlength":"7",
                      "id":"price_id"
                    }
                  ];

var textarea = [
                {
                  "label":"Допълнителна информация",
                  "name":"additional_info",
                  "id":"additional_info_id",
                  "rows":"10",
                  "cols":"40",
                  "text":""
                }
              ];

form = generate_form("Добавяне на имот", add_place_form, "Добави", place_input, add_place_select, textarea);

var blanks = {
              "neighbourhood":"neighbourhood",
              "entrance":"entrance",
              "number":"number",
              "floor":"floor",
              "appartment":"appartment",
              "additional_info":"additional_info",
              "Type_name":"Type_name",
              "Material_name":"Material_name"
            };

if(method == "POST") {
  var e = validate_form(form_values, null, blanks);
  if(!is_empty(e)) {
    for(var key in e) {
      flash += (e[key] + " ") || "";
    }
  }
  else {
    var id = sql_insert_values("Address", {"street":"street", "number":"number", "floor":"floor", "appartment":"appartment", "entrance":"entrance"}, null);
    sql_insert_values("Place", {"meters":"meters", "price":"price", "additional_info":"additional_info", "Type_name":"Type_name", "Material_name":"Material_name"}, {"Address_id":id, "Seller_User_email":Session("user_email")});
    sql_insert_values("Neighbourhood", {"name": "neighbourhood"}, null);
    sql_insert_values("Address_has_Neighbourhood", {"Neighbourhood_name": "neighbourhood" }, {"Address_id":id});
    Session('flash') = "Успешно добавихте имот!";
    Response.Redirect("default.asp");
  }
}

blocks["content"] = form;
%>
<!-- #include FILE="template.inc" -->
