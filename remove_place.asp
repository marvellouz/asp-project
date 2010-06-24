<!--#include file="all.inc"-->
<%
if(user && user["is_admin"] == 1 && method == "POST") {
  connection.execute("delete from Customer_has_Place where Place_Address_id = " + Request.QueryString("id") + ";");
  connection.execute("delete from Address_has_City where Address_id = " + Request.QueryString("id") + ";");
  connection.execute("delete from Address_has_Neighbourhood where Address_id = " + Request.QueryString("id") + ";");
  connection.execute("delete from Place where Address_id = " + Request.QueryString("id") + ";");
  connection.execute("delete from Address where id = " + Request.QueryString("id") + ";");
  Session("flash") = 'Успешно премахнахте имот от "Моите места"';
  Response.redirect("seller_place_list.asp");
}
else {
  Session("flash") = "За да видите тази страница трябва да сте регистриран продавач!";
  Response.redirect("default.asp");
}
%>
