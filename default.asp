<!--#include file="all.inc"-->
<%
var form = "<h1>Последно добавени места:</h1>"
places = connection.execute("select * from Place order by created_at desc limit 30;");
while(!places.eof) {
  form += "<ul>";
  form += "<li><a href='./place.asp?id=" + places("Address_id").value + "'><strong> продавач: </strong>" + places("Seller_User_email").value +",<strong> квадратура:</strong> "+ places("meters").value +",<strong> цена: </strong>"+ places("price").value + " лв., <strong>тип: </strong>"+ places("Type_name").value + "</a></li>";	
  places.movenext
  form += "</ul>";
}

blocks["content"] = form;
%>
<!--#include file="template.inc"-->
