<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>path2/viewCookies.jsp <br></title>
</head>
<body>

path2/viewCookies.jsp <br>

<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null && cookies.length>0)	{
		for( int i=0;i<cookies.length;i++){
			
%>
	<%= cookies[i].getName() %> = 
	<%= URLDecoder.decode(cookies[i].getValue(), "utf-8") %> <br>
<% 			
		}
	}else {

	%>
	
	쿠키가 존재하지 않습니다.
<%
	}
%>

</body>
</html>