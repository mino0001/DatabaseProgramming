<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>수강신청 삭제</title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null)
	response.sendRedirect("login.jsp");
%>
<table width="75%" align="center" border>
<br>
<tr><th>과목번호</th><th>분반</th><th>과목명</th><th>학점</th>
<th>수강신청</th></tr>
<%
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="minji";
String passwd="0228";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
int nYear=0;
int nSemester=0;
try
{
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection (dburl, user, passwd);
	String sql = "{? = call Date2EnrollYear(SYSDATE)}";
	CallableStatement cstmt = myConn.prepareCall(sql);
	cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt.execute();
	nYear = cstmt.getInt(1);
	
	sql = "{? = call Date2EnrollSemester(SYSDATE)}";
	cstmt = myConn.prepareCall(sql);
	cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt.execute();
	nSemester = cstmt.getInt(1);
	stmt = myConn.createStatement();
}
catch(SQLException ex)
{
	System.err.println("SQLException: " + ex.getMessage());
}
mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_unit from course c, enroll e where e.s_id='" + session_id+"' and e.c_id = c.c_id and e.c_id_no = c.c_id_no and e.e_year=" + nYear+" and e.e_semester="+nSemester+"";
myResultSet = stmt.executeQuery(mySQL);
if (myResultSet != null)
{
	while (myResultSet.next())
	{
		String c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		String c_name = myResultSet.getString("c_name");
		int c_unit = myResultSet.getInt("c_unit");
		%>
		<tr>
		<td align="center"><%= c_id %></td>
		<td align="center"><%= c_id_no %></td>
		<td align="center"><%= c_name %></td>
		<td align="center"><%= c_unit %></td>
		<td align="center"><a href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%=
		c_id_no %>">삭제</a></td>
		</tr>
		<%
	}
}
else
{
	
}
stmt.close();
myConn.close();
%>
</body>
</html>