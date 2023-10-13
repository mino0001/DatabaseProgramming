<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 정보 수정</title>
</head>
<body>
<%
String s_id = request.getParameter("s_id");
String s_addr = request.getParameter("s_addr");
String s_new_pwd = request.getParameter("s_new_pwd");
String s_old_pwd = request.getParameter("s_old_pwd");

Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl = "jdbc:oracle:thin:@localhost:1521:xe"; 
String user="minji"; 
String passwd="0228";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

String s_original_pwd = null;

try {
Class.forName(dbdriver);
myConn = DriverManager.getConnection(dburl, user, passwd);
stmt=myConn.createStatement();
mySQL = "select s_addr, s_pwd from student where s_id='"+s_id+"'";

ResultSet myResultSet = stmt.executeQuery(mySQL);
if(myResultSet.next()){
	s_original_pwd = myResultSet.getString("s_pwd");
}
} catch(SQLException ex){
System.err.println("SQLException: "+ex.getMessage());
}


if (s_old_pwd != s_original_pwd){
	%>
	<script>
	alert("현재 비밀번호와 일치하지 않습니다.");
	location.href="update.jsp";
	</script>
	<%
}


try {
mySQL = "update student set s_addr='"+s_addr+"', s_pwd='"+s_new_pwd+"' where s_id='"+s_id+"'";
stmt.execute(mySQL);
%>
<script>
alert("학생정보가 수정되었습니다.");
location.href="update.jsp";
</script>
<%
} catch(SQLException ex){
String sMessage;
if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다.";
else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
else sMessage="잠시 후 다시 시도하십시오";
%>
<script>
alert("<%=sMessage%>");
location.href="update.jsp";
</script>
<%
}

finally{
if(stmt!=null)try{stmt.close(); myConn.close();}
catch(SQLException ex) { }
}
%>
</body>
</html>