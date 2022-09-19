<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
	String id = request.getParameter("id");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
</head>
<body>


<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	try{
		String jdbc = "jdbc:oracle:thin:@localhost:1521:xe?" + "useUnicode=true&characterEncoding=utf8";
		String dbUser = "scott";
		String dbPass = "tiger";
		String query = "select * from member_history where memberid='" + id +  "'";
		
		conn = DriverManager.getConnection(jdbc, dbUser, dbPass);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
		if(rs.next()){
%>
		<table border="1">
			<tr>
				<td>아이디</td><td><%= id %></td>
			</tr>
			
			<tr>
				<td>히스토리</td>
				<td>
<%
			String history = null;
			Reader reader = null;
			BufferedReader br = null;
			
			try{
				reader = rs.getCharacterStream("history");
				br = new BufferedReader(reader);
				
				if(reader != null){
					StringBuffer buff = new StringBuffer();
					char[] ch = new char[512];
					int len = -1;
					
					while((len = br.read(ch)) != -1){
						buff.append(ch, 0, len);
					}
					
					history = buff.toString();
				}
				
			}catch(IOException ex){
				out.println("예외발생 : " + ex.getMessage());
			}finally{
				if(reader != null) try{reader.close();} catch(IOException ex){}
			}

%>				
	<%= history %>
	</td>
</tr>
</table>

<%
		} else {
%>
<%= id %> 회원의 히스토리가 없습니다.
<%		} 
	}catch(SQLException ex){
	
%>	
	에러발생 : <%= ex.getMessage() %>

<% 
	}finally{
		if(rs != null) try{rs.close();} catch(SQLException ex){}
		if(stmt != null) try{stmt.close();} catch(SQLException ex){}
		if(conn != null) try{conn.close();} catch(SQLException ex){}
	}


%>


 
</body>
</html>