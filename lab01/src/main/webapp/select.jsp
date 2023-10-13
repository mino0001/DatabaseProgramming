<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
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

<div class="row d-flex justify-content-center" >
<form method="get" align="center" action="select_verify.jsp" >
<div class="row mb-3 col-md-6" style="float:none; margin:0 auto" >
    <select name="selected_year" id="selected_year" class="form-select" required  style="width: 120px">
    			<option value="" disabled selected>연도 선택</option>
    			<option value=<%= nYear %>><%= nYear %></option>
				<option value=<%= nYear -1 %> ><%= nYear - 1 %></option>
				<option value=<%= nYear - 2 %>><%= nYear - 2 %></option>
				<option value=<%= nYear - 3%>><%= nYear - 3 %></option>
				<option value=<%= nYear - 4%>><%= nYear - 4 %></option> 
    </select>
    <label for="selected_year" class="col-sm-2 col-form-label">년도</label>

    <select name="selected_semester" id="selected_semester" class="form-select" placeholder="학기" required style="width: 120px">
    
    <option value="" disabled selected>학기 선택</option>
	<option value="1">1</option>
	<option value="2">2</option> 

	</select>
    <label for="selected_semester" class="col-sm-2 col-form-label">학기</label>
	<input type="submit" value="조회" class="col-md-2 btn btn-primary ">
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