<!--#include file="md5.inc"-->
<%
Response.Charset  = "UTF-8";
Response.Codepage = 65001;


var Settings = {
    salt: "hyuaryu478ry87326dbe3$@$feuih#$&()bgfry^vdfsGTHT"
}

var blocks = {};

var register_form = {"method":"post", "name":"register", "action":"register.asp"}
var register_input = [{"label":"E-mail", "name":"email", "maxlength":"40", "type":"text", "id":"email_id"}, {"label":"Парола","name":"password", "maxlength":"20", "type":"password", "id":"password_id"}, {"label":"Име","name":"first_name", "maxlength":"20", "type":"text", "id":"fname_id"}, {"label":"Фамилия","name":"last_name", "maxlength":"20", "type":"text", "id":"lname_id"}]


function generate_form(form_arr, label_input_arr, submit_value) {
  var res = "<p><form ";
  for(var key in form_arr){
    res += key + "=" + form_arr[key] + " ";
  }
  res += "><p>";

  for(var i=0; i<label_input_arr.length; i++) {
    res += "<label for=" + label_input_arr[i]["id"] + "><br/>" + label_input_arr[i]["label"] + ":<br/></label><input ";
    for(var key in label_input_arr[i]) {
      if(key != "label") {
        res += key + "=" + label_input_arr[i][key] + " ";
      }
    }
  }
  res += "/><p/><input type='submit' value='" + submit_value + "'/>"
  res += "</form></p>"
  return res;
}

function form2arr(req) {
    var res = new Array();
    for(var i = 1; i <= req.Form.count(); i++) { 
        res[new String(req.Form.key(i))] = new String(req.Form.item(i));
    }
    for(var key in res){
        if(key == "password"){
            res[key] = MD5(res[key] + Settings.salt);
        }
    }
    return res;
}

function contains_value(arr, value) {
    for(var key in arr) {
        if(value==arr[key]){
            return true;
        }
    }
    return false;
}

function sql_insert(table_name, req) {
    var attrs = new String();
    var values = new String();
    var x = form2arr(req);
    var empty = new Array();
    for(var key in x) {
        attrs += key + ", ";
        values += x[key] + "', '";
        empty.push(""==x[key])
    }

    var sql = "insert into " + table_name + "(" + attrs.slice(0, attrs.length-2) + ") values ('" + values.slice(0, values.length-4) + "')";
    var prt = sql + "<br/>";
    if(!contains_value(x, "")) {
      connection.execute(sql);
    }
    else {
        throw new Error("Моля попълнете всички полета!");
    }
    return prt;
}
%>
