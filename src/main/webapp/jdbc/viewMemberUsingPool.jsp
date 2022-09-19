<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
</head>
<body>


MEMBER 테이블의 내용
<table width="100%" border="1">

	<tr>
		<td>이름</td><td>아이디</td><td>이메일</td>
	</tr>

<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	
	try{
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		String query = "select * from member";
		conn = DriverManager.getConnection(jdbcDriver);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
		while(rs.next()){
%>
	<tr>
		<td><%= rs.getString("name") %> </td>
		<td><%= rs.getString("memberid") %> </td>
		<td><%= rs.getString("email") %> </td>
	</tr>


<%			
		}
		
	}finally{
		if(rs != null) try{rs.close();} catch(SQLException ex){}
		if(stmt != null) try{stmt.close();} catch(SQLException ex){}
		if(conn != null) try{conn.close();} catch(SQLException ex){}
	}
	
 %>

</table>

</body>
</html>