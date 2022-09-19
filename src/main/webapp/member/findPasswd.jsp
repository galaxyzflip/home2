<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="logon.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>

<form action="findPasswdPro.jsp" method="post">

<table border="1">
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id"></td>
	</tr>

	<tr>
		<td>휴대폰번호</td>
		<td><input type="text" name="phone"></td>
	</tr>
	<tr>
		<td><input type="submit" value="비밀번호찾기"></td>
		<td><input type="reset" value="다시입력"></td>
		
	</tr>

</form>





</body>
</html>