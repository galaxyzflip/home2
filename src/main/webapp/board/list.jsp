<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="color.jsp" %>

<% request.setCharacterEncoding("utf-8"); %>

<%!
	final int PAGESIZE = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>


<%
	
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum.equals("null")){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage * PAGESIZE) - (PAGESIZE-1);
	int endRow = currentPage * PAGESIZE;
	int count = 0;
	int number = 0;
	
	
	List<BoardDTO> articleList = null;
	BoardDAO manager = BoardDAO.getInstance();
	
	
	String target = (String)request.getParameter("target");
	String value = (String)request.getParameter("value");
	if(target == null || target.equals("null")){
		target = null;
		value = null;
	}
	
	count = manager.getArticleCount(target, value);
	
	if(count > 0){
		articleList = manager.getArticles(target, value, startRow, endRow);
	}
	
	number = count-(currentPage-1) * PAGESIZE;

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	<%@ include file="script.js"%>
</script>

</head>
<body bgcolor="<%=bodyback_c%>">

<center>
<b>글 목 록(전체글 : <%=count %>)</b>


<table width="1000" align="center">
	<tr>
		<td align=right bgcolor="<%=value_c %>">
		<%
		if((session.getAttribute("memId") != null)){%>
			<a href="writeForm.jsp">글쓰기</a>
			
			<form action="../member/logout.jsp">
				<input type="hidden" name="prevPage" value="<%=request.getRequestURI()%>">
				<input type="submit" value="로그아웃">
			</form>
			
			<%

		
		} else { %>
			<form action="../member/loginForm.jsp">
				<input type="hidden" name="prevPage" value="<%=request.getRequestURI()%>">
				<input type="submit" value="로그인">
			</form>
		
		<%}	%>
		
		</td>
	</tr>
</table>

	<% if(count == 0){%>
		<table width="1000" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
			</tr>
		
		</table>
	
	<% 	
	} else{%>
		<table border="1" width="1000" cellpadding="0" cellspacing="0" align="center">
			<tr height="30" bgcolor="<%=value_c %>">
				<td align="center" width="50"> 번호 </td>
				<td align="center" width="250"> 제목 </td>
				<td align="center" width="100"> 작성자 </td>
				<td align="center" width="150"> 작성일 </td>
				<td align="center" width="50"> 조회 </td>
				<td align="center" width="100"> IP </td>
			</tr>
		
		<%
			for(int i=0;i<articleList.size();i++){
				BoardDTO article = articleList.get(i);
		%>
			<tr height="30">
				<td align="center" width="50"><%=number-- %></td>
				<td width="250">
		<%		
				int wid=0;
			if(article.getRe_level() > 0){
				wid = 5*(article.getRe_level());
			%>
				<img src="images/level.gif" width="<%=wid %>" height="16">
				<img src="images/re.gif">
			
		<%} else{%>
			<img src="images/level.gif" width="<%=wid %>" height="16">
		<% }%>
		
				<a class="tooltip" title="<%=article.getContent() %>" href="content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>&target=<%=target%>&value=<%=value%>">
				<%=article.getSubject() %>
				</a>
				
				<%if(article.getReadcount() >= 20){  %>
					<img src="images/hot.gif" border="0" height="16">
				<%	}%>
					
					
					
				<td align="center" width="100">
					<a href="mailto:<%=article.getEmail() %>"><%=article.getWriter() %></a>					
				</td>
				
				<td align="center" width="150"><%=sdf.format(article.getReg_date()) %></td>
				<td align="center" width="50"><%=article.getReadcount() %></td>
				<td align="center" width="100"><%=article.getIp() %></td>
			</tr>
	
		<%} 
	}
%>	
	</table>
	

<td align="center">
<%if (target != null){%>
	<a href="list.jsp">전체글 보기</a>
	<% }%>
	</td>


<br>
<form action="list.jsp" method="post" name="suchForm">
<td align = "center" width="400">
	<select name="target">
		<option value="writer">작성자</option>
		<option value="subject">제목</option>
		<option value="content">내용</option>
	</select>
	<input type="text" name="value"> <input type="submit" value="검색" onclick="return suchSave()">
</td>
</form>

<%

	if(count>0){
		int pageCount = count / PAGESIZE + (count % PAGESIZE == 0 ? 0 : 1);
		int pageBlock = 5;
		int startPage = (int)(currentPage/5) * 5 + 1;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 5){%>
			<a href="list.jsp?pageNum=<%=startPage - 5 %>&target=<%=target%>&value=<%=value%>">[이전]</a>
		<%}
		
		for(int i = startPage ;i <= endPage ; i++){%>
			<a href="list.jsp?pageNum=<%= i %>&target=<%=target%>&value=<%=value%>">[<%= i %>]</a>
		<%}
		
		if(endPage > pageCount){%>
			<a href="list.jsp?pageNum=<%=startPage + 5 %>&target=<%=target%>&value=<%=value%>">[다음]</a>
		<%}
		
	}
%>
</center>
</body>
</html>