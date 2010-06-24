<!--#include file="all.inc"-->
<%
if(user && user["is_admin"] == 1 ) {
  var choose_customer_form = {
                      "method":"post",
                      "id":"choose_customer",
                      "action":"choose_customer.asp?customer=" + Request.QueryString("customer") + "&amp;place=" + Request.QueryString("place")
                    };
  var customers = connection.execute("select * from Customer_has_Place where Customer_User_email='" + Request.QueryString("customer") + "' and Place_Address_id=" + Request.QueryString("place")+";" );
  var c = []; 
  while(!customers.eof){
    var item = new String(customers("Customer_User_email"));
    c.push({"value":item, "text":item});
    customers.movenext();
  }
  var choose_customer_select = [
                        {
                          "label":"Купувач",
                          "name":"customer",
                          "id":"customer_id",
                          "values":c
                        }];

  form = generate_form("Избери купувач", choose_customer_form, "Избери", null , choose_customer_select);
}


else {
  Session("flash") = "За да видите тази страница трябва да сте регистриран продавач!";
  Response.redirect("default.asp");
}


if(method == "POST") {
  connection.execute("UPDATE Place SET Customer_User_email='" + form_values["customer"] + "' WHERE Address_id=" + Request.QueryString("place")+ ";");
  Session("flash") = "Успешно избрахте купувач " + Request.QueryString("customer") + "!";
  Response.redirect("default.asp");
}
blocks["content"] = form;
%>
<!-- #include FILE="template.inc" -->
