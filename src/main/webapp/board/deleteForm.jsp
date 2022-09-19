<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jsp" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">

<script language="JavaScript">
	/* function deleteSave(){
		if(document.delForm.passwd.value==''){
			alert("비밀번호를 입력하십시오.");
			document.delForm.passwd.focus();
			return false;
		}
	} */
</script>


</head>
<body bgcolor="<%=bodyback_c%>">
<b>글 삭 제</b><br>


<form method="post" name="delForm" action="deletePro.jsp?pageNum=<%=pageNum %>" onsubmit="return deleteSave()">

<table border="1" align="center" cellspacing="0" cellpadding="0" width="360">

	<tr height="30">
		<td align="center" bgcolor="<%=value_c %>"> <b>비밀번호를 입력해주세요.</b> </td>
	</tr>
	
	<tr height="30">
		<td align="center">비밀번호 :  
		<input type="password" name="passwd" > </td>
		<input type="hidden" name="num" value="<%=num %>"> 
	</tr>
	
	<tr height="30">
		<td align=center bgcolor=<%=value_c %> >
			<input type="submit" value="글삭제">
			<input type="button" value="글목록" onclick = "document.location.href='list.jsp?pageNum=<%=pageNum %>'">
		</td>
	</tr>

</table>


</form>


</body>
</html>