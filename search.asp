<!--#include file="all.inc"-->
<%
var form;
var city = select_tag_arr("City");
var type = select_tag_arr("Type");
var material = select_tag_arr("Material");
var neighbourhood = select_tag_arr("Neighbourhood");

var add_place_form = {
                      "method":"post",
                      "id":"add_place",
                      "action":"search.asp"
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
                          "label":"Град",
                          "name":"city_name",
                          "id":"city",
                          "values":city
                        },
                        {
                          "label":"Квартал",
                          "name":"Neighbourhood_name",
                          "id":"neighbourhood",
                          "values":neighbourhood
                        }
                      ];

var place_input = [
                    {
                      "label":"Улица",
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
                      "label":"Квадратура",
                      "name":"meters",
                      "type":"text","maxlength":"4",
                      "id":"meters_id"
                    },
                    {
                      "label":"Цена",
                      "name":"price",
                      "type":"text",
                      "maxlength":"7",
                      "id":"price_id"
                    }
                  ];


form = generate_form("Търсене на имот", add_place_form, "Търси", null, add_place_select, null);

if(method == "POST"){
  x = form2arr(Request);
  var place = connection.execute("select * from place_info " + where(x)+ ";");

  while(!place.eof) {
    form += "<hr/><strong>Квадратура:</strong> " + place("meters").value + " кв. м." + "<br/><strong>Цена:</strong> " + place("price").value + " лв.";
    form += "<br/><strong>Град:</strong> " + place("city_name").value + "<br/><strong>Квартал:</strong> " + place("Neighbourhood_name").value;
    form += "<br/><strong>Улица:</strong> " + place("street").value + "<br/><strong>Номер:</strong> " + place("number").value;
    form += "<br/><strong>Етаж:</strong> " + place("floor").value + "<br/><strong>Тип:</strong> " + place("Type_name").value;
    form += "<br/><strong>Материал:</strong> " + place("Material_name").value;
    form += "<br/><strong>Допълнителна информация:</strong> " + place("additional_info").value + "<br/><strong>Продавач:</strong> " + place("Seller_User_Email").value;
    form += "<hr/>"
    place.movenext;
  }
      
//    var id = sql_insert_values("Address", {"street":"street", "number":"number", "floor":"floor", "appartment":"appartment", "entrance":"entrance"}, null);
//    sql_insert_values("Place", {"meters":"meters", "price":"price", "additional_info":"additional_info", "Type_name":"Type_name", "Material_name":"Material_name"}, {"Address_id":id, "Seller_User_email":Session("user_email")});
//    sql_insert_values("Neighbourhood", {"name": "neighbourhood"}, null);
//    sql_insert_values("Address_has_Neighbourhood", {"Neighbourhood_name": "neighbourhood" }, {"Address_id":id});
//    sql_insert_values("Address_has_City", {"City_name": "city_name" }, {"Address_id":id});
//    Session('flash') = "Успешно добавихте имот!";
//    Response.Redirect("default.asp");
}
blocks["content"] = form;
%>
<!-- #include FILE="template.inc" -->
