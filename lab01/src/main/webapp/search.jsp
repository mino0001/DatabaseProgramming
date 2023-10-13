<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>
<div class="wrapper">
	<form method="post" action="search.jsp" class="search_form">
	<div class="search_container">
	<input type="text" class="search" placeholder="검색어" name="search" />
	<input TYPE="SUBMIT" NAME="Submit" class="search_button rounded" value="검색"/>
	</div>
	</form>
</div>
<%
	String Search = request.getParameter("search");

	Connection myConn = null;
	Statement stmt = null;
	ResultSet myResultSet = null;
	String mySQL = null;
	
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
<div class="insert_wrapper">
<h3><%=nYear %>년 <%= nSemester %>학기 수강신청</h3>
<div class="table">
<div class="row header">
<div class="cell">과목번호</div>
<div class="cell">분반</div>
<div class="cell">담당교수</div>
<div class="cell">과목명</div>
<div class="cell">학점</div>
<div class="cell">최대 수강인원</div>
<div class="cell">여석</div>
<div class="cell">수강신청</div>
</div>
<%
	mySQL = "SELECT c.c_id, c.c_id_no, t.t_professor, c.c_name, c.c_unit, t.t_max, t.t_left from course c, teach t where c.c_name like '%"+Search+"%' OR c.c_id = (SELECT c_id from teach where t_professor like '%"+Search+"%')";
	
	myResultSet = stmt.executeQuery(mySQL);
	
	if(myResultSet != null){
		while (myResultSet.next()){
			String c_id = myResultSet.getString("c_id");
			int c_id_no = myResultSet.getInt("c_id_no");
			String t_professor = myResultSet.getString("t_professor");
			String c_name = myResultSet.getString("c_name");
			int c_unit = myResultSet.getInt("c_unit");
			int t_max = myResultSet.getInt("t_max");
			int t_left = myResultSet.getInt("t_left");
			%>
			<div class="row">
				<div class="cell" align="center"><%=c_id %></div>
				<div class="cell" align="center"><%=c_id_no %></div>
				<div class="cell" align="center"><%=t_professor %></div>				
				<div class="cell" align="center"><%=c_name %></div>
				<div class="cell" align="center"><%=c_unit %></div>
				<div class="cell" align="center"><%=t_max %></div>
				<div class="cell" align="center"><%=t_left %></div>
				<div class="cell" align="center"><a href="insert_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>">신청</a></div>
			</div>
<% 				
		}
	}
	stmt.close();
	myConn.close();
%>
</div>
</div>
</body>
</html>