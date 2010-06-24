<!--#include file="all.inc"-->
<%
if(user && user["is_admin"] == 1) {
  var form = "<h1>Продадени места:</h1>"
  places = connection.execute("select * from Place where Seller_User_email = '" + user["email"] + "' and Customer_User_email!='NULL' order by created_at desc limit 30;");
  while(!places.eof) {
    form += "<ul>";
    form += "<li><a href='./place.asp?id=" + places("Address_id").value + "'><strong> продавач: </strong>" + places("Seller_User_email").value +",<strong> квадратура:</strong> "+ places("meters").value +",<strong> цена: </strong>"+ places("price").value + " лв., <strong>тип: </strong>"+ places("Type_name").value + "</a></li>";	
    places.movenext
    form += "</ul>";
  }
}

else {
  Session("flash") = "За да видите тази страница трябва да сте регистриран продавач!";
  Response.redirect("default.asp");
}

blocks["content"] = form;
%>
<!--#include file="template.inc"-->
