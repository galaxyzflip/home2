<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="logon.LogonDBBean"%>
<%@ include file="color.jsp" %>

<% request.setCharacterEncoding("utf-8"); %>


<jsp:useBean id="member" class="logon.LogonDataBean">
	<jsp:setProperty name="member" property="*"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">

<title>Insert title here</title>
</head>
<body>




<%
	String id = (String)session.getAttribute("memId");
	member.setId(id);
	
	LogonDBBean manager = LogonDBBean.getInstance();
	int x = manager.checkPhone2(member.getPhone(), id);
	if(x == 1){

		manager.updateMember(member);
%>

		
		<table width="270" border="0" cellspacing="0" cellpadding="5" align="cetner">
		<tr bgcolor="<%=title_c %>">
			<td hetight="39" align="cetner">
				<font size="+1"><b>회원정보가 수정되었습니다.</b></font>
			</td>
		</tr>
		
		<tr>
			<td bgcolor="<%=value_c %>" align="cetner">
				<p>입력하신 내용대로 수정이 완료되었습니다.</p>
			</td>
		</tr>
		
		<tr>
			<td bgcolor="<%=value_c %>" align="center">
				<form>
					<input type="button" value="메인으로" onclick = "window.location='main.jsp'">
				</form> 
				5초 후에 메인으로 이동합니다.	
					<meta http-equiv="Refresh" content="5;url=main.jsp">
			</td>
		</tr>
	</table>
		

<%
	} else{%>
	
		<script>
			alert("휴대폰번호가 중복되었습니다.");
			history.go(-1);
		</script>
	
<% 	}%>
	

	

	
</body>
</html>