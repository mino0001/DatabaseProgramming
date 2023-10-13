//select_verify.jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>



<%
	int s_year = 2023;
	int s_semester =1 ;
	//int s_year = Integer.parseInt(request.getParameter("selected_year"));
	//int s_semester = Integer.parseInt(request.getParameter("selected_semester"));
	
	

	Connection myConn = null;
	Statement stmt = null;
	ResultSet myResultSet = null;
	String mySQL = null;
	
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user="minji";
	String passwd = "0228";
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
	
	mySQL = "select c.c_id, c.c_id_no, c.c_name, c.c_unit, t.t_time, t.t_place, e.e_gpa from course c, teach t, enroll e " 
			+"where e.s_id='" + session_id+"' and e.c_id = c.c_id and e.c_id_no = c.c_id_no and e.e_year= " + s_year +" and e.e_semester= "+s_semester
			+" and e.c_id = t.c_id and e.c_id_no = t.c_id_no and e.e_year = t.t_year and e.e_semester = t.t_semester";

	myResultSet = stmt.executeQuery(mySQL);
	%>
	<br>
	<h3 align="center"><%=s_year %>년 <%= s_semester %>학기 수강조회</h3>
	
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

    <select name="selected_semester" placeholder="학기" required >
	    <option value="" disabled selected>학기 선택</option>
			<option value="1">1</option>
			<option value="2">2</option> 
		</select>
    <label>학기</label>
	<input type="submit" value="조회">
 	</div>
	</form>
	</div>
	
	<table width="75%" align="center" border>
	<br>
	<tr align="center"><th>과목번호</th><th>분반</th><th>과목명</th><th>학점</th><th>시간</th><th>장소</th><th>등급</th></tr>
	<% 
	if (myResultSet != null) {
		while (myResultSet.next()) {
			String c_id = myResultSet.getString("c_id");
			int c_id_no = myResultSet.getInt("c_id_no");
			String c_name = myResultSet.getString("c_name");
			int c_unit = myResultSet.getInt("c_unit");
			int t_time = myResultSet.getInt("t_time");
			String t_place = myResultSet.getString("t_place");
			String e_gpa = myResultSet.getString("e_gpa");
			u_sum += c_unit;
			count++;
			
	%>
			<tr>
				<td align="center" ><%= c_id %></td>
				<td align="center"><%= c_id_no %></td>
				<td align="center"><%= c_name %></td>
				<td align="center"><%= c_unit %></td>
				<td align="center"><%= t_time %></td>
				<td align="center"><%= t_place %></td>
				<%if(e_gpa==null){%>
					<td align="center"> </td>
				<%}else{ %>
					<td align="center"><%= e_gpa %></td>
				<%} %>	
			</tr>
			
		
	<%
		}
	}
	
	if (count == 0) {
	%>
		<tr>
		<td align="center" colspan="7">조회된 수업이 없습니다.</td>
		</tr>
	<%
	}else{
	%>
		<tr><td align="center">총 신청과목 수</td>
			<td colspan="6" align="center"><%= count %></td>
		</tr>
		<tr><td align="center">총 신청학점</td>
			<td colspan="6" align="center"><%= u_sum %></td>
		</tr>
		
	<%
	}
	%>
	
	


<%
	stmt.close();
	myConn.close();
%>

</table>
</body>
</html>