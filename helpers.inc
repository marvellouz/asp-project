<!--#include file="md5.inc"-->
<%
Response.Charset  = "UTF-8";
Response.Codepage = 65001;


var Settings = {
    salt: "hyuaryu478ry87326dbe3$@$feuih#$&()bgfry^vdfsGTHT"
}

var blocks = {};

function select_tag(select){
  var r="";
  for(var i=0; i<select.length; i++) {
    r += '<label for="' + select[i]["id"] + '"><br/> ' +select[i]["label"] + ":<br/></label>";
    r += '<select name="' + select[i]["name"] + '" id="' + select[i]["id"] + '">' + "";
    r += "<option value='' selected='selected'></option>"
    for(var j=0; j<(select[i]["values"].length); j++){
      r += "<option value='" + select[i]["values"][j]["value"] + "'>" + select[i]["values"][j]["text"] + "</option>";
    }
    r += "</select>"
  }
  return r;
}

function textarea_tag(textarea){
  var r="";
  for(var i=0; i<textarea.length; i++) {
    r += '<label for="' + textarea[i]["id"] + '"><br/> ' + textarea[i]["label"] + ":<br/></label>";
    r += "<textarea "
    for(key in textarea[i]) {
      if(key!="label" && key!="text"){
        r += key + "='" + textarea[i][key] + "' ";
      }
    }
    r += "> " + textarea[i]["text"]
    r += "</textarea>";
  }
  return r;
}

function generate_form(legend, form_arr, submit_value, label_input_arr, select, textarea) {
  var select = select==null?[]:select;
  var legend = legend==null?"":legend;
  var textarea = textarea==null?[]:textarea;
  var label_input_arr = label_input_arr==null?[]:label_input_arr;
  var res = "<form ";
  for(var key in form_arr) {
    res += key + "=" + '"' + form_arr[key] + '"' + " ";
  }
  res += ">";
  res += "<fieldset><legend>" + legend + "</legend>"
  if(select.length > 0) {
      res += select_tag(select);
  }
  if(textarea.length > 0) {
      res += textarea_tag(textarea);
  }
  if(label_input_arr.length>0) {
    for(var i=0; i<label_input_arr.length; i++) {
      res += "<label for=" + '"' + label_input_arr[i]["id"] + '"><br/>' + label_input_arr[i]["label"] + ":<br/></label>";
      res += "<input ";
      for(var key in label_input_arr[i]) {
        if(key != "label") {
          res += key + "='" + label_input_arr[i][key] + "' ";
        }
      }
    res += "></input>";
    }
  }
  res += "</fieldset>"
  res +="<p><input type='submit' value='" + submit_value + "'/></p></form>";
  return res;
}

function hash_password(password) {
  return MD5(password + Settings.salt);
}

function form2arr(req) {
    var res = {};
    for(var i = 1; i <= req.Form.count(); i++) { 
        res[new String(req.Form.key(i))] = new String(req.Form.item(i));
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
    vals.push(key + "=" + add_quote(arr[key]));
  }
  return vals.join(" and ");
}

function sql_insert(table_name, form_values) {
    var attrs = [];
    var vals = [];
    for(var key in form_values) {
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
  var res = connection.execute(sql);
  return (res("count(*)"))>0;
}

function validate_email(user_email) {
  var regex = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i
  if(!regex.test(user_email)) {
    throw new ValidationError("Невалиден email.");
  }
  if (exists("User", {email : user_email})){
    throw new ValidationError("Потребителският e-mail вече съществува!");
  }
}

function validate_password(password) {
  if (password.length < 6) {
    throw new ValidationError("Паролата ви е твърде кратка. Моля въведете поне 6 символа.");
  }
}


function validate_empty(form_values, blanks) {
  var blanks = blanks==null?[]:blanks;
  for(var key in form_values) {
      if (form_values[key]=="" && !contains_value(blanks, key)) {
        throw new ValidationError("Моля, попълнете всички полета, отбелязани с *!");
    }
  }
}


function is_empty(arr) {
  for(var key in arr) {
    return false;
  }
  return true;
}

function validate_form(form_values, opts, blanks) {
  var opts = opts==null?[]:opts;
  var errors = {};
  try {
    validate_empty(form_values, blanks);
  }
  catch(e) {
    errors['empty'] = e.msg;
    return errors;
  }
  for(var key in opts) {
    try {
      opts[key](form_values[key]);
    }
    catch(e) {
      errors[key] = e.msg;
    }
  }
  return errors;
}


function login_valid(user_email, user_password) {
  if(exists("User", {email:user_email, password:user_password})){
    Session("flash") = "Успешна регистрация";
    Session("user_email") = user_email;
    return true;
  }
  return false;
}

function select_tag_arr(tablename) {
  var items = connection.execute("select * from " + tablename + ";");
  var arr = [];
  while(!items.eof) {
    var item = new String(items("name"));
    arr.push({"value":item, "text":item});
    items.movenext
  }
  return arr;
}

function sql_insert_values(tablename, values, opts) {
  var opts = opts==null?{}:opts;
  var cols = [];
  var vals = [];
  var rs = Server.CreateObject("ADODB.Recordset");
  rs.CursorLocation = 3;
  rs.Open(tablename, connection, 3, 3, 512);
  for(var key in values) {
    if (form_values[key]!="") {
      cols.push(values[key]);
      vals.push(form_values[key]);
    }
  }
  for(var key in opts) {
    cols.push(key);
    vals.push(opts[key]);
  }
  rs.AddNew(cols, vals);
  var pos = rs.absolutePosition;
  rs.Requery();
  rs.absolutePosition = pos;
  try {
    var id = rs.Fields("id").value;
  }
  catch (e){
    id = undefined;
  }
  rs.Close();
  return id;
}

%>
