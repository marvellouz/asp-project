<!--#include file="all.inc"-->
<%
var form = "<h1>Подробна информация:</h1>"

var place = connection.execute("select * from place_info where id = " + Request.QueryString("id") + ";");

form += "<hr/><strong>Квадратура:</strong> " + place("meters").value + " кв. м." + "<br/><strong>Цена:</strong> " + place("price").value + " лв.";
form += "<br/><strong>Град:</strong> " + place("city_name").value + "<br/><strong>Квартал:</strong> " + place("Neighbourhood_name").value;
form += "<br/><strong>Улица:</strong> " + place("street").value + "<br/><strong>Номер:</strong> " + place("number").value;
form += "<br/><strong>Етаж:</strong> " + place("floor").value + "<br/><strong>Тип:</strong> " + place("Type_name").value;
form += "<br/><strong>Допълнителна информация:</strong> " + place("additional_info").value + "<br/><strong>Продавач:</strong> " + place("Seller_User_Email").value;
form += "<br/><strong>Купувач: </strong>" + place("Customer_User_email").value;
form += "<hr/>"

var add_place_list_form = {"method":"post", "id":"order", "action":"add_place_list.asp?id=" + Request.QueryString("id") };

if(user && user["is_admin"] == 0) {
  form += generate_form(null, add_place_list_form, 'Добави в "Моите места"');
}

blocks["content"] = form;
%>
<!--#include file="template.inc"-->
