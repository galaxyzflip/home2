<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String memberID = request.getParameter("memberID");
	String name = request.getParameter("name");
	int updateCount = 0;
	
	Connection conn = null;
	Statement stmt = null;
	
	try{
				
		String query = "update member set name = '" + name + "' where memberid = '" + memberID + "'";
		
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/pool");
		stmt = conn.createStatement();
		updateCount = stmt.executeUpdate(query);
		
		
	}finally{
		if(stmt != null)try{stmt.close();}catch(SQLException ex){}
		if(conn != null)try{conn.close();}catch(SQLException ex){}
	}

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이름 변경</title>
</head>
<body>


<% if(updateCount > 0) {
	%>

	<%= memberID %> 의 이름을 <%= name %> 으로 변경하였습니다.
	
	<% 
		response.sendRedirect("viewMemberList.jsp");

} else{ %>
	<%= memberID %> 아이디가 존재하지 않습니다.
	
<%	
}
%>


</body>
</html>