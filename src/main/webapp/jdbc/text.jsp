<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%= request.getServerName() %> <br>
<%= request.getRequestURI() %> <br>
<%= request.getContextPath() %> <br>
<%= request.getProtocol() %> <br>
<%= request.getRemoteAddr() %> <br>


</body>
</html>