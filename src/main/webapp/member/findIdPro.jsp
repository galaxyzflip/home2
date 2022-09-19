<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="logon.LogonDBBean" %>


<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	
	LogonDBBean manager = LogonDBBean.getInstance();
	String id = manager.findId(name, phone);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>


<script language="javascript">

	function close(){
		self.close();
	}

</script>

</head>
<body>

<%
	if(id != ""){
%>
	아이디는 <%=id %> 입니다.

<% 		
	} else{
%>
	찾으시는 아이디가 존재하지 않습니다. <br>
	다시 시도해주시기 바랍니다.
<% 		
	}
%>
<br>

<button onclick="close()">닫기</button>

<!--  이거 안됨 시발 -->


</body>
</html>


