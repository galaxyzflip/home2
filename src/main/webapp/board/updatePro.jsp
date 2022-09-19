<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.sql.Timestamp" %>

<%request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="article" class="board.BoardDTO">
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>


<%
	String pageNum = request.getParameter("pageNum");
	BoardDAO manager = BoardDAO.getInstance();
	int check = manager.updateArticle(article);
	
	if(check == 1){%>
	
	00
	<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum %>">

<% 		
	} else {%>
		<script language="JavaScript">
		/* 	alert("비밀번호가 맞지 않습니다.");
			history.go(-1); */
		</script>
	
		<% 		
	}
	
%>
