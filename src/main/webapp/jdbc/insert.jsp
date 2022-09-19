<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%

	request.setCharacterEncoding("utf-8");

	String memberID = request.getParameter("memberID");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbUser = "scott";
		String dbPass = "tiger";
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		
		pstmt = conn.prepareStatement("insert into member values(?,?,?,?,?)");
		pstmt.setString(1, memberID);
		pstmt.setString(2, name);
		pstmt.setString(3, password);
		pstmt.setString(4, email);
		pstmt.setString(5, phone);
		
		pstmt.executeUpdate();
		
	}
	finally{
		if(pstmt != null) try{pstmt.close();} catch(SQLException ex){}
		if(conn != null) try{conn.close();} catch(SQLException ex){}
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert 결과 화면</title>
</head>
<body>




MEMBER테이블에 새로운 레코드를 삽입했습니다. <br>
<%= memberID %>(<%= name %>)
<%
response.sendRedirect("viewMemberList.jsp");
%>
</body>
</html>