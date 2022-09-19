<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.*" %>

<%
	Cookie cookie = new Cookie("name", URLEncoder.encode("최범균", "utf-8"));
	response.addCookie(cookie);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>쿠키생성</title>
</head>
<body>

<%= cookie.getName() %> 쿠키의 값 = "<%= cookie.getValue() %>" <br>
<%= cookie.getName() %> 쿠키의 값 = "<%= cookie.getDomain() %>" <br>
<%= cookie.getName() %> 쿠키의 값 = "<%= cookie.getPath() %>" <br>
<%= cookie.getName() %> 쿠키의 값 = "<%= cookie.getMaxAge() %>" <br>



</body>
</html>