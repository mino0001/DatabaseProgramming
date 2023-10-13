<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의실 시간표 조회</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id == null) response.sendRedirect("login.jsp"); 
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
<div class="d-flex justify-content-center">
<form class="row g-3" >
  <div class="col-md-6">
    <label for="inputEmail4" class="form-label">Email</label>
    <input type="email" class="form-control" id="inputEmail4">
  </div>
  <div class="col-md-6">
    <label for="inputPassword4" class="form-label">Password</label>
    <input type="password" class="form-control" id="inputPassword4">
  </div>
  <div class="col-12">
    <label for="inputAddress" class="form-label">Address</label>
    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
  </div>
  <div class="col-12">
    <label for="inputAddress2" class="form-label">Address 2</label>
    <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
  </div>
  <div class="col-md-6">
    <label for="inputCity" class="form-label">City</label>
    <input type="text" class="form-control" id="inputCity">
  </div>
  <div class="col-md-4">
    <label for="inputState" class="form-label">State</label>
    <select id="inputState" class="form-select">
      <option selected>Choose...</option>
      <option>...</option>
    </select>
  </div>
  <div class="col-md-2">
    <label for="inputZip" class="form-label">Zip</label>
    <input type="text" class="form-control" id="inputZip">
  </div>
  <div class="col-12">
    <div class="form-check">
      <input class="form-check-input" type="checkbox" id="gridCheck">
      <label class="form-check-label" for="gridCheck">
        Check me out
      </label>
    </div>
  </div>
  <div class="col-12">
    <button type="submit" class="btn btn-primary">Sign in</button>
  </div>
</form>
</div>
</body>
</html>