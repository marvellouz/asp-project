<!--#include file="all.inc"-->
<%
if(!(user && user["is_admin"] == 0)) {
  Session("flash") = "За да видите тази страница трябва да сте регистриран купувач!";
  Response.Redirect("login.asp");
}

var form = "<h1>Моите места:</h1>"
place = connection.execute("select * from Customer_has_Place cp join place_info p on cp.Place_Address_id = p.id where cp.Customer_User_email = '" + user["email"] + "';");
while(!place.eof) {
  form += "<hr/><strong>Квадратура:</strong> " + place("meters").value + " кв. м." + "<br/><strong>Цена:</strong> " + place("price").value + " лв.";
  form += "<br/><strong>Град:</strong> " + place("city_name").value + "<br/><strong>Квартал:</strong> " + place("Neighbourhood_name").value;
  form += "<br/><strong>Улица:</strong> " + place("street").value + "<br/><strong>Номер:</strong> " + place("number").value;
  form += "<br/><strong>Етаж:</strong> " + place("floor").value + "<br/><strong>Тип:</strong> " + place("Type_name").value;
  form += "<br/><strong>Допълнителна информация:</strong> " + place("additional_info").value + "<br/><strong>Продавач:</strong> " + place("Seller_User_Email").value;
  var remove_place_list_form = {"method":"post", "id":"order", "action":"remove_place_list.asp?id=" + place("id").value};
  form += generate_form(null, remove_place_list_form, 'Изтрий от "Моите места"');
  form += "<hr/>"
  place.movenext;
}

blocks["content"] = form;
%>
<!--#include file="template.inc"-->
