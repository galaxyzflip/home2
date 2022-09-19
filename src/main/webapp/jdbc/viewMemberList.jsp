<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
</head>
<body>

member 테이블의 내용 <br>

<a href="insertForm.jsp"> 글 입력 </a> <br>

<table width="600" border="1">

   
   
   
	<tr>
		<td>이름</td>
		<td>아이디</td>
		<td>이메일</td>
	</tr>
<%
	
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs = null;
	
	
	try{
		//String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
		//String dbUser = "scott";
		//String dbPass = "tiger";
		String jdbcDrier = "jdbc:apache:commons:dbcp:/pool";
		String query="select * from member order by name";
		
		conn = DriverManager.getConnection(jdbcDrier);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		

		while(rs.next()){
%>

	<tr>
		<td><%=rs.getString("name") %></td>
		<td><a href="viewMember.jsp?memberID=<%=rs.getString("memberID")%>">
   <%= rs.getString("memberID") %></a></td>
		<td><%=rs.getString("email") %></td>
	</tr>
<%
		
		}
		
	}catch(SQLException ex){
		out.println(ex.getMessage());
		ex.printStackTrace();
		
	}finally{
		if(rs != null)try {rs.close();} catch(SQLException ex){} 
		if(stmt != null)try {stmt.close();} catch(SQLException ex){} 
		if(conn != null)try {conn.close();} catch(SQLException ex){} 
	}

	%>

</table>


</body>
</html>