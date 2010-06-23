<!--#include file="all.inc"-->
<%
if(user && user["is_admin"] == 0 && method == "POST") {
  connection.execute("delete from Customer_has_Place where Place_Address_id = " + Request.QueryString("id") + ";");
  Session("flash") = 'Успешно премахнахте имот от "Моите места"';
  Response.redirect("customer_place_list.asp");
}
else {
  Session("flash") = "За да видите тази страница трябва да сте регистриран купувач!";
  Response.redirect("default.asp");
}
%>
