<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
	request.setCharacterEncoding("utf-8");

	String memberID = request.getParameter("memberID");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
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
		
	} finally{
		if(pstmt != null) try{pstmt.close();} catch(SQLException ex){}
		if(conn != null) try{conn.close();} catch(SQLException ex){}
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삽입</title>
</head>
<body>

<script>
alert("<%=memberID%> 가 삽입되었습니다.");
</script>

<%
response.sendRedirect("viewMemberList.jsp");
%>


</body>
</html>