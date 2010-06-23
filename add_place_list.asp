<!--#include file="all.inc"-->
<%
if(user && user["is_admin"] == 0 && method == "POST") {
  var seller = connection.execute("select Seller_User_email from Place where Address_id=" + Request.QueryString("id") + ";");
  sql_insert_values("Customer_has_place", null, {"Customer_User_email": user["email"], "Place_Seller_User_email":seller("Seller_User_email").value});
  Response.redirect("customer_place_list.asp");
}
else {
  Session("flash") = "За да видите тази страница трябва да сте регистриран купувач!";
  Response.redirect("default.asp");
}
%>
