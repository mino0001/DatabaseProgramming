<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="style.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<title>수강신청 입력</title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>
<div class="wrapper">
	<form method="post" action="search.jsp" class="search_form">
	<div class="search_container">
	<input type="text" class="search" placeholder="검색어"/>
	<input TYPE="SUBMIT" NAME="Submit" class="search_button rounded" value="검색"/>
	</div>
	</form>
</div>

<%
	Connection myConn = null;
	Statement stmt = null;
	ResultSet myResultSet = null;
	String mySQL = " ";
	
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user="minji";
	String passwd = "0228";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	
	int nYear = 0;
	int nSemester = 0;
	
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		String sql = "{? = call Date2EnrollYear(SYSDATE)}";
		CallableStatement cstmt = myConn.prepareCall(sql);
		cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt.execute();
		nYear = cstmt.getInt(1);
		
		sql = "{? = call Date2EnrollSemester(SYSDATE)}";
		cstmt = myConn.prepareCall(sql);
		cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt.execute();
		nSemester = cstmt.getInt(1);
		stmt = myConn.createStatement();
	} catch(SQLException ex){
		System.err.println("SQLException: "+ ex.getMessage());
	}
%>
<div style="text-align: center;">
<form method="post" align="center" action="inquiry_course.jsp">
	<label>영역 : 	</label>
    <select name="selected_type" required>
    			<option value="" disabled selected>연도 선택</option>
    			<option value="major">전공</option>
				<option value="required">교양필수</option>
				<option value="ge">일반교양</option> 
    </select>
    
	<input type="submit" value="조회">
</form>
</div>
<div class="insert_wrapper">
<h3><%=nYear %>년 <%= nSemester %>학기 수강신청</h3>
<div class="table">
<br>
<div class="row header">
<div class="cell" align="center"style="float: left; width: 10%;">과목번호</div>
<div class="cell" align="center"style="float: left; width: 10%;">분반</div>
<div class="cell" align="center"style="float: left; width: 10%;">담당교수</div>
<div class="cell" align="center"style="float: left; width: 25%;">과목명</div>
<div class="cell" align="center"style="float: left; width: 10%;">학점</div>
<div class="cell" align="center"style="float: left; width: 10%;">정원</div>
<div class="cell" align="center"style="float: left; width: 10%;">여석</div>
<div class="cell" align="center"style="float: left; width: 15%;">수강신청</div>
</div>
<%	
	mySQL = "select c.c_id,c.c_id_no,c.c_name,c.c_unit, t.t_professor, t.t_max, t.t_left from course c, teach t where c.c_id not in (select c_id from enroll where s_id='" + session_id + "' and e_gpa>=2.7) and t.t_year=" + nYear+" and t.t_semester="+nSemester+" and t.c_id=c.c_id and t.c_id_no = c.c_id_no";
	
	myResultSet = stmt.executeQuery(mySQL);
	
	if(myResultSet != null){
		while (myResultSet.next()){
			String c_id = myResultSet.getString("c_id");
			int c_id_no = myResultSet.getInt("c_id_no");
			String c_name = myResultSet.getString("c_name");
			String t_professor = myResultSet.getString("t_professor");
			int t_max = myResultSet.getInt("t_max");
			int t_left = myResultSet.getInt("t_left");
			int c_unit = myResultSet.getInt("c_unit");
			%>
			<div class="row" >
				<div class="cell" align="center" style="float: left; width: 10%;"><%=c_id %></div>
				<div class="cell" align="center" style="float: left; width: 10%;"><%=c_id_no%></div>
				<div class="cell" align="center" style="float: left; width: 10%;"><%=t_professor %></div>				
				<div class="cell" align="center" style="float: left; width: 25%;"><%=c_name %></div>
				<div class="cell" align="center" style="float: left; width: 10%;"><%=c_unit %></div>
				<div class="cell" align="center" style="float: left; width: 10%;"><%=t_max %></div>
				<div class="cell" align="center" style="float: left; width: 10%;"><%=t_left %></div>
				<% if(t_left != 0) {%>
				<div class="cell" align="center" style="float: left; width: 15%;"><a href="insert_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>" class="badge text-bg-primary">신청</a></div>
				
				<% }else {%>
				<div class="cell" align="center" style="float: left; width: 15%;"><a href="insert_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>" class="badge text-bg-danger">신청 불가</a></div>
				<%} %>
			</div>
<% 				
		}
	}
	else
	{
		System.out.println("test");
	}
	stmt.close();
	myConn.close();
%>
</div>
</div>
</body>
</html>