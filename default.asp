<%
on error resume next
dim adoConn
dim adoRS
dim counter

set adoConn = Server.CreateObject("ADODB.Connection")
set adoRS = Server.CreateObject("ADODB.Recordset")
adoConn.Open "DSN=mysql_dsn"
adoRS.ActiveConnection = adoConn

if adoConn.errors.count = 0 then
response.write "<h2>Fields In The 'Contacts' Table:</h2>"
adoRS.Open "describe contacts"
while not adoRS.EOF
response.write adoRS.fields(0).value & "<br>"
adoRS.MoveNext
wend
else
response.write "ERROR: Couldn't connect to database"
end if
%>
