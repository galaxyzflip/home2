<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="logon.LogonDBBean" %>
<%@ page import="logon.LogonDataBean" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	LogonDBBean manager = LogonDBBean.getInstance();
	int check = manager.userCheck(id, passwd);
	String prevPage = request.getParameter("prevPage");

	
	
	if(check == 1){
		LogonDataBean memInfo = manager.getMember(id);
		session.setAttribute("memId", id);
		session.setAttribute("memEmail", memInfo.getEmail());
		
		
		if(prevPage == null || prevPage.equals("null")){
			response.sendRedirect("main.jsp");
					
		}else{
			response.sendRedirect(prevPage);
			
		}
	}else if(check == 0){
%>
		<script>
			alert("비밀번호를 확인해주시기 바랍니다..");
				history.go(-1);
		</script>

<%	
	} else {
%>
		<script>
			alert("아이디를 확인해주시기 바랍니다..");
			history.go(-1);
		</script>
<% 	
	}
%>
