<!--#include file="md5.inc"-->
<%
var Settings = {
    salt: "hyuaryu478ry87326dbe3$@$feuih#$&()bgfry^vdfsGTHT"
}

function form2arr() {
    var res = new Array();
    for (var i = 1; i <= Request.QueryString.count(); i++) { 
        res[new String(Request.QueryString.key(i))] = new String(Request.QueryString.item(i));
    }
    for(var key in res){
        if(key == "password"){
            res[key] = MD5(res[key] + Settings.salt);
        }
        Response.Write(key + " : " + res[key] + "<br/>");
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

function sql_insert(table_name) {
    var attrs = new String();
    var values = new String();
    x = form2arr();
    empty = new Array();
    for(var key in x) {
        attrs += key + ", ";
        values += x[key] + "', '";
        empty.push(""==x[key])
    }

    var sql = "insert into " + table_name + "(" + attrs.slice(0, attrs.length-2) + ") values ('" + values.slice(0, values.length-4) + "')";
    Response.write(sql);

    if(!contains_value(x, "")) {
        try {
          connection.execute(sql);
        }
        catch(err) {
          txt="There was an error on this page.\n\n";
          txt+="Error description: " + err.description + "\n\n";
          Response.write(txt);
        }
    }
    else {
        Response.write("<br/>Моля попълнете всички полета!<br/>");
    }
}
%>
