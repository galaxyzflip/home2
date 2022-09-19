<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.CommentDAO" %>
<%@ page import="java.sql.Timestamp" %>
<%request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="cmt" scope="page" class="board.CommentDTO">
	<jsp:setProperty name="cmt" property="*"/>
</jsp:useBean>


<%
	CommentDAO manager = CommentDAO.getInstance();
	cmt.setReg_date(new Timestamp(System.currentTimeMillis()));
	cmt.setIp(request.getRemoteAddr());
	
	
	String conNum = request.getParameter("con_num");
	int con_num = Integer.parseInt(conNum);
	
	cmt.setContent_num(con_num);
	
	cmt.setComment_num((manager.getCommentCount(con_num))+1);
	manager.insertComment(cmt);
	
	String content_num = request.getParameter("content_num");
	String p_num = request.getParameter("p_num");
	String url = "content.jsp?num="+con_num+"&pageNum="+p_num;
	response.sendRedirect(url);
	
	
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