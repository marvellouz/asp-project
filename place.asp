<!--#include file="all.inc"-->
<%
var form = "<h1>Подробна информация:</h1>"
place = connection.execute("select * from Place where Address_id = " + Request.QueryString("id") + ";");
form += "<strong>Номер: </strong>" + place("Address_id").value + "<br/><strong>Продавач: </strong>" + place("Seller_User_email").value + "<br/><strong>Квадратура: </strong>" + place("meters").value;
blocks["content"] = form;
%>
<!--#include file="template.inc"-->
