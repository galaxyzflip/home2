<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String uri = request.getRequestURI();

%>


<form action ="test2.jsp" method="post">
	<input type="hidden" name="value" value="<%=uri%>">
	<input type="submit" value="눌러">
</form>


</body>
</html>