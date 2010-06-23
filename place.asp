<!--#include file="all.inc"-->
<%
var form = "<h1>Подробна информация:</h1>"

var place = connection.execute("select * from place_info where id = " + Request.QueryString("id") + ";");

form += "<strong>Номер: </strong>" + place("id").value + "<br/><strong>Продавач: </strong>" + place("Seller_User_email").value + "<br/><strong>Квадратура: </strong>" + place("meters").value;

var add_place_list_form = {"method":"post", "id":"order", "action":"add_place_list.asp?id=" +Request.QueryString("id") };

if(user && user["is_admin"] == 0) {
  form += generate_form(null, add_place_list_form, 'Добави в "Моите имоти"');
}

blocks["content"] = form;
%>
<!--#include file="template.inc"-->
