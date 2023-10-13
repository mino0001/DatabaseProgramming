<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String s_id = (String)session.getAttribute("user");
String c_id = request.getParameter("c_id");
int c_id_no = Integer.parseInt(request.getParameter("c_id_no"));

Connection myConn = null;
Statement stmt = null;
String mySQL = null;
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
	stmt=myConn.createStatement();
}
catch(SQLException ex)
{
	System.err.println("SQLException: " + ex.getMessage());
}
try
{
	mySQL ="delete from enroll where c_id='"+c_id+"' and c_id_no='"+c_id_no+"'and s_id='"+s_id+"' and e_year=" + nYear+" and e_semester="+nSemester+""; 
	stmt.execute(mySQL);
	mySQL="update teach set t_left = t_left+1 where c_id='"+c_id+"' and c_id_no='"+c_id_no+"' and t_year=" + nYear+" and t_semester="+nSemester+"";
	stmt.execute(mySQL);
	%>
	<script>
	location.href="delete.jsp";
	</script>
<% 
}
catch(SQLException ex)
{
	System.err.println("SQLException: " + ex.getMessage());
}
finally
{
	if (stmt != null)
	try
	{	
		stmt.close();
		myConn.close();
	}
catch(SQLException ex) { }
}
%>

</body>
</html>