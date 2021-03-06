<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="bg" lang="bg">
  <head>
    <title> Имоти </title>
    <meta http-equiv="content-type" 
      content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
  </head>

  <body>

      <div id="container">
    <div id="header"><a href="./"><img alt="logo" id="logo" src="images/logo.png" /></a>
      <div id = "hmenu_div">
        <ul id = "hmenu">
          <li><a id="home" href = "default.asp"></a></li>
          <li><a id="search" href = "search.asp"></a></li>
        </ul>
    </div>
    </div>
    <div id="menu2_div">
        <ul id="menu2">
        <%
          if(new String(Session("user_email"))!="undefined") {
            Response.write("<li><a href='./logout.asp'>Изход</a></li>");
            if(user["is_admin"]==1){
              Response.write("<li><a href='./add_place.asp'>Добави място</a></li>");
              Response.write("<li><a href='./seller_place_list.asp'>Моите места</a></li>");
              Response.write("<li><a href='./bought.asp'>Продадени места</a></li>");
            }
            else {
              Response.write("<li><a href='./customer_place_list.asp'>Моите места</a></li>");
            }
          }
          else {
            Response.write("<li><a href='./register.asp'>Регистрация</a></li> <li><a href='./login.asp'>Вход</a></li>");
            }
          %>
        </ul>
    </div>
    <%
        if (flash != "") {
          Response.write("<div id='flash'>" + flash + "</div>");
        }
    %>
        <div id="content">

            <%= blocks['content'] %>
        </div>
        <div id="footer"></div>
    </div>
  </body>
</html>
