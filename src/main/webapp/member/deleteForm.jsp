<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">

	<script>
		function begin(){
			document.myform.passwd.focus();
		}
		
		function checkIt(){
			if(!document.myform.passwd.value){
				alert("비밀번호를 입력하지 않았습니다.");
				document.myform.passwd.focus();
				return false;
			}
		}
	
	
	</script>
</head>
<body onload = "begin()" bgcolor="<%= bodyback_c%>">

	<form name="myform" action="deletePro.jsp" method="post" onsubmit="return chechIt()">
	<table cellspacint="1" cellpadding="1" width="260" border="1" align="cetner">
		<tr height="30">
			<td colspan="2" align="middle" bgcolor="<%=title_c %>">
			<font size="+1"><b>회원 탈퇴</b></font>
			</td>
		</tr>
		
		<tr height="30">
			<td width="110" bgcolor="<%=value_c %>" align="cetner"> 비밀번호 </td>
			<td width="150" align="center">
				<input type="password" name="passwd" size="15" maxlength="12">
			</td>
		</tr>
		
		<tr height="30">
			<td colspan="2" align="middle" bgcolor="<%=value_c %>">
				<input type="submit" value="회원탈퇴">
				<input type="button" value="취   소" onclick="javascript:window.location='main.jsp'">
			</td>
		</tr>
	</table>
	</form>

</body>
</html>