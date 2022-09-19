<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>


<%

	Cookie cookie1 = new Cookie("id", "naver");
	cookie1.setDomain(".tistory.com");
	response.addCookie(cookie1);
	
	Cookie cookie2 = new Cookie("only", "onlycookie");
	response.addCookie(cookie2);
	
	Cookie cookie3 = new Cookie("invalid", "invalidcoocie");
	cookie3.setDomain("javacan.tistory.com");
	response.addCookie(cookie3);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키생성</title>
</head>
<body>

다음과 같이 쿠키를 생성했습니다.<br>

<%= cookie1.getName() %> = <%= cookie1.getValue() %> [<%= cookie1.getDomain() %>] <br>
<%= cookie2.getName() %> = <%= cookie2.getValue() %> [<%= cookie2.getDomain() %>] <br>
<%= cookie3.getName() %> = <%= cookie3.getValue() %> [<%= cookie3.getDomain() %>] <br>


</body>
</html>