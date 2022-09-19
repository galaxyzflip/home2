 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="color.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function writeSave(){
		if(document.comment.commentt.value==""){
			alert("작성자를 입력해주셍.");
			document.comment.commentt.focus();
			return false;
		}
	}

</script>
</head>

<%
	//board 용
	request.setCharacterEncoding("utf-8");
	String target = (String)request.getParameter("target");
	String value = (String)request.getParameter("value");

	
	int num = Integer.parseInt(request.getParameter("num"));
	
	
	
	String pageNum = request.getParameter("pageNum");
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
	final int PAGESIZE = 5;
	String cPageNum = request.getParameter("cPageNum");
	if(cPageNum == null || cPageNum.equals("null")){
		cPageNum = "1";
	}
	
	int cCurrentPage = Integer.parseInt(cPageNum);
	int startRow = (cCurrentPage * PAGESIZE) - (PAGESIZE-1);
	int endRow = cCurrentPage  * PAGESIZE;
	
	
	
	
	try{
		BoardDAO manager = BoardDAO.getInstance();
		BoardDTO article = manager.getArticle(num);
		
		CommentDAO cManager = CommentDAO.getInstance();
		ArrayList<CommentDTO> comments = null; 
		comments = cManager.getComments(article.getNum(), startRow, endRow);
		
		int count = cManager.getCommentCount(article.getNum());
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		
		
		
%>		
		 				
<body bgcolor="<%=bodyback_c%>">		
<center>
<b>글 내용 보기</b><br>

<form>

	<table width="500" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c %>" align="center">
	
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>"> 글 번호 </td>
			<td align="center" width="125" align="center"> <%= article.getNum() %> </td>
			<td align="center" width="125" bgcolor="<%=value_c %>">조회수</td>
			<td align="center" width="125" align="center"><%=article.getReadcount() %></td>
		</tr>
		
		
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c%>">작성자</td>
			<td align="center" width="125" align="center"> 
			
			<a href="list.jsp?target=writer&value=<%=article.getWriter()%>"><%= article.getWriter() %></a>
			
			 
			
			
			</td>
			<td align="center" width="125" bgcolor="<%=value_c %>">작성일</td>
			<td align="center" width="125" align="center"><%=article.getReg_date() %></td>
		</tr>
		
		<tr height="30">
			<td align="center" width="125" bgcolor=<%=value_c %> > 글 제목 </td>
			<td align="center" width="375" colspan="3"><%=article.getSubject() %></td>
		</tr>
			
		<tr>
			<td align="center" width="125" bgcolor="<%=value_c %>">글 내용</td>
			<td align="center" width="375" colspan="3"><pre><%=article.getContent() %></pre></td>
		</tr>		
		
		
		<tr height="30">
			<td colspan="4" bgcolor="<%=value_c %>" align="right">
				<input type="button" value="글 수정" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>'"> &nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글 삭제" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>'"> &nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="답글쓰기" onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'"> &nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글 목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>&target=<%=target%>&value=<%=value%>'">
			</td>
		</tr>
	
	</table>	
</form>

<form method="post" action="contentPro.jsp" name="comment" onsubmit="return writeSave()">
<table width="500" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c %>" align="center">

	<tr bgcolor="<%=value_c %>" align="center">
		<td colpsan="2">
			<textarea name="commentt" rows = "6" cols="40"></textarea>
			<input type="hidden" name="con_num" value=<%=article.getNum() %>>
			<input type="hidden" name="p_num" value=<%=pageNum %>>
		</td>
	<tr align="center">
		<td align=center>
			작성자<input type="text" name=commenter size=10>
			비밀번호<input type="password" name=passwd size=10>
			<input type="submit" value="코멘트달기">
		</td>
	</tr>

</table>
</form>


<table width="500" border=0 cellspacing=0 cellpadding=0 bgcolor=<%=bodyback_c %> align=center>

	<tr>
		<td>코멘트 수 : <%=count %></td>
	</tr>
	
	
	
	<%
	if(count > 0){
		for(int i=0;i<comments.size();i++){
			CommentDTO cmt = comments.get(i);%>
			
			<tr>
				<td align=left size=250 bgcolor=<%=value_c %>>
				<b><%=cmt.getCommenter() %> 님</b> (<%=sdf.format(cmt.getReg_date()) %>)
				</td>
				
				<td align=riglt size=250 bgcolor=<%=value_c %>> 접속 IP : <%=cmt.getIp() %>  
				<a href="delCommentForm.jsp?ctn=<%=cmt.getContent_num() %>&cmn=<%=cmt.getComment_num()%>&p_num=<%=pageNum%>">삭제</a>
				</td>
			</tr>
			
			<tr>
				<td colspan=2><%=cmt.getCommentt() %></td>
			
		<%} 
	}%>
	
	
</table>
	
<table width=500 border=0 cellspacing=0 cellpadding=0 bgcolor=<%=bodyback_c %>>
<center>

	<tr>
	<% 
		if(count>0){
			int pageCount = count / PAGESIZE + (count % PAGESIZE == 0 ? 0 : 1);
			//					1					
			int pageBlock = 5;
			int startPage = (int)(cCurrentPage/5) * 5 + 1;
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;
			
			
			if(startPage > 5){%>
				 <a href="content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=startPage - 5 %>">[이전]</a>
			<%}
			for(int i=startPage;i<=endPage;i++){%>
				<a href="content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=i %>">[<%=i %>]</a>
			
			<%}
			
			if(endPage < pageCount){ %>
				<a href="content.jsp?num=<%=num %>&pageNum=<%=pageNum %>&cPageNum=<%=startPage + 5 %>">[다음]</a>	
			
			
			<%}
		}
	
	%>
	
</center>	
</table>	
	
	
	<%
	
	}catch(Exception ex){
		ex.printStackTrace();
	}
%>


</center>


</body>
</html>