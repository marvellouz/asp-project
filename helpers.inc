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
    var res = {};
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

function p(v) {
  Response.write("[DEBUG] " + v + "<br/>");
}

function values (arr) {
  var vals = [];
  for(var key in arr) {
    vals.push(key + "=" + ad_quote(arr[key]));
  }
  return vals.join(" and ");
}

function sql_insert(table_name, req) {
    var attrs = [];
    var vals = [];
    var form_values = form2arr(req);
    for(var key in form_values) {
      if (!(form_values[key]=="")) {
        throw new ValidationError("Моля попълнете всички полета!");
      }
      attrs.push(key);
      vals.push(add_quote(form_values[key]));
    }

    var sql = "insert into " + table_name + "(" + attrs.join(', ') + ") values (" + vals.join(", ") + ")";
    connection.execute(sql);
}


function ValidationError(msg) {
  this.msg = msg;
}

ValidationError.prototype.toString = function() {
  return this.msg;
}


function add_quote(x) {
  var s;
  if(x instanceof String || typeof(x) == 'string') {
    s = "'" + x + "'";
  }
  else {
    s = x;
  }
  return s;
}

function where (arr) {
  return " where " + values(arr);
}

function exists(table_name, arr) {
  var sql = "select count(*) from " + table_name + where(arr);
  return connection.execute(sql)("count");
}

%>
