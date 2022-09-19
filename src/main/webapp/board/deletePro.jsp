<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.sql.Timestamp" %>

<%request.setCharacterEncoding("utf-8"); %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String passwd = request.getParameter("passwd");
	
	BoardDAO manager = BoardDAO.getInstance();
	int check = manager.deleteArticle(num, passwd);
	
	if(check == 1){%>
		<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum %>">
 		
	<%} else{%>
		<script language="JavaScript">
/* 			alert("비밀번호가 맞지 않습니다.");
			history.go(-1); */
		
		</script>
		모르겠고 탈퇴 안됨
	
		<% 		
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>