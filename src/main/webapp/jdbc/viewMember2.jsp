<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>

<%
	String id = request.getParameter("id");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
</head>
<body>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try{
		String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbUser = "scott";
		String dbPass = "tiger";
		String query = "select * from member where id='" + id + "'";
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
		if(rs.next()){
%>
회원조회 결과
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><%= rs.getString("id") %></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><%= rs.getString("name") %></td>
				</tr>
			</table>
<%
		} else{
%>			<%= id %> 회원이 존재하지 않습니다.


<%
		}
	}finally{
		if(rs != null) try{rs.close();} catch(SQLException ex){}
		if(stmt != null) try{stmt.close();} catch(SQLException ex){}
		if(conn != null) try{conn.close();} catch(SQLException ex){}
	}

%>




</body>
</html>