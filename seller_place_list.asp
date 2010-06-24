<!--#include file="all.inc"-->
<%
if(!(user && user["is_admin"] == 1)) {
  Session("flash") = "За да видите тази страница трябва да сте регистриран продавач!";
  Response.Redirect("login.asp");
}

var form = "<h1>Моите места:</h1>"
place = connection.execute("select * from place_info where Seller_User_email = '" + user["email"] + "';");
while(!place.eof) {
  form += "<hr/><strong>Квадратура:</strong> " + place("meters").value + " кв. м." + "<br/><strong>Цена:</strong> " + place("price").value + " лв.";
  form += "<br/><strong>Град:</strong> " + place("city_name").value + "<br/><strong>Квартал:</strong> " + place("Neighbourhood_name").value;
  form += "<br/><strong>Улица:</strong> " + place("street").value + "<br/><strong>Номер:</strong> " + place("number").value;
  form += "<br/><strong>Етаж:</strong> " + place("floor").value + "<br/><strong>Тип:</strong> " + place("Type_name").value;
  form += "<br/><strong>Допълнителна информация:</strong> " + place("additional_info").value + "<br/><strong>Продавач:</strong> " + place("Seller_User_Email").value ;
  var remove_place_form = {"method":"post", "action":"remove_place.asp?id=" + place("id").value};
  var customer = connection.execute("select Customer_User_email from Customer_has_Place where Place_Address_id = " + place("id").value + ";");
  if(!customer.eof) {
    if(new String(place("Customer_User_email").value).toString()=="null") {
      form += "<p><a href='choose_customer.asp?customer=" + customer("Customer_User_email").value + "&amp;place=" + place("id").value + "'>" + "Желаещи да закупят имота" + "</a></p>";
    }
    else {
      form += "<p>Имотът е закупен от " + place("Customer_User_email") + "</p>";
    }
  }
  form += generate_form(null, remove_place_form, 'Изтрий');
  form += "<hr/>"
  place.movenext();
}

blocks["content"] = form;
%>
<!--#include file="template.inc"-->
