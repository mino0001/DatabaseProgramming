//select.jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
</head>
<body>
<%@ include file="top.jsp"%>
<% if (session_id==null) response.sendRedirect("login.jsp"); %>


<br>

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
int count=0;
int u_sum=0;

try {
	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl,user,passwd );
	
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
} catch(SQLException ex) {
	System.err.println("SQLException: " + ex.getMessage()); 
}
%>

<div>
<form method="get" align="center" action="nobootsrap_select_verify.jsp" >
<div>
    <select name="selected_year" required>
    			<option value="" disabled selected>연도 선택</option>
    			<option value=<%= nYear %>><%= nYear %></option>
				<option value=<%= nYear -1 %> ><%= nYear - 1 %></option>
				<option value=<%= nYear - 2 %>><%= nYear - 2 %></option>
				<option value=<%= nYear - 3%>><%= nYear - 3 %></option>
				<option value=<%= nYear - 4%>><%= nYear - 4 %></option> 
    </select>
    <label>년도</label>

    <select name="selected_semester" placeholder="학기" required>
    
    <option value="" disabled selected>학기 선택</option>
		<option value="1">1</option>
		<option value="2">2</option> 

	</select>
    <label>학기</label>
	<input type="submit" value="조회">
 </div>
</form>
</div>


<%
stmt.close();
myConn.close();
%>

</table>
</body>
</html>