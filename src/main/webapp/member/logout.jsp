 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 
 <%
 	request.setCharacterEncoding("utf-8");
 
 	session.invalidate();
 	String prevPage = request.getParameter("prevPage");

	if((prevPage == null) || prevPage.equals("null")){%>
		<script>
			alert("로그아웃 되었습니다.");
			location.href = 'main.jsp';
		</script>
 		
		
		
		<% 
		
		
		/* response.sendRedirect("main.jsp"); */
 			
 	} else{ %>
 		<script>
 			var text = "<%=prevPage%>"
			alert("로그아웃 되었습니다.");
			location.href = text ;
		</script> 		
 		
 		
 		<!-- response.sendRedirect(prevPage); -->
 		
 	<% }
 %>
 	
 	
 	
 	
 	
 	
 	
 	

 
 

 
<!-- response.sendRedirect("main.jsp"); -->
 
 
