<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String dburl = "jdbc:oracle:thin:@localhost:1521:xe"; 
String user="minji";
String passwd="0228";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
try{
Class.forName(dbdriver);
out.println("jdbc driver �ε� ����");
DriverManager.getConnection(dburl, user, passwd); 
out.println("����Ŭ ���� ����");
} catch (ClassNotFoundException e)
{ System.out.println("driver �ε� ����");
} catch (SQLException e)
{ System.out.println("����Ŭ ���� ����");
}
%>
</body>
</html>