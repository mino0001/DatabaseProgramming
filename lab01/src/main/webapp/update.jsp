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
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); %>
<% Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl = "jdbc:oracle:thin:@localhost:1521:xe"; 
String user="minji"; 
String passwd="0228";
String dbdriver = "oracle.jdbc.driver.OracleDriver";


String s_addr = null;
String s_pwd = null;

Class.forName(dbdriver);
myConn=DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();
mySQL = "select s_addr, s_pwd from student where s_id='"+session_id+"'";

ResultSet myResultSet = stmt.executeQuery(mySQL);
if(myResultSet.next()){
	
	s_addr = myResultSet.getString("s_addr");
	s_pwd = myResultSet.getString("s_pwd");

%>
<div class="update_button_wrapper">
<div class="update_wrapper">
<form class="update_form" method="post" action="update_verify.jsp"></form>
<input type="hidden" name="s_id" size="30" value="<%=session_id%>">
<label class="update_label">주소</label>
<input class="update_input" type="text" name="s_addr" size="50" value="<%=s_addr%>">
<br>
<label class="update_label">기존 비밀번호</label>
<input class="update_input"type="password" name="s_old_pwd" size="50" >
<br>
<label class="update_label">새 비밀번호</label>
<input class="update_input"type="password" name="s_new_pwd" size="50" >
<br>
</div>
<%
}
stmt.close(); myConn.close();
%>
<input class="update_button" type="submit" value="수정">
</form></div></body>
</html>