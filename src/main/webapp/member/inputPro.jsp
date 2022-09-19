<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="logon.LogonDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="member" class="logon.LogonDataBean">
	<jsp:setProperty name="member" property="*"/>
</jsp:useBean>	

<%

	member.setReg_date(new Timestamp(System.currentTimeMillis()));
	LogonDBBean manager = LogonDBBean.getInstance();
	int x = manager.checkPhone(member.getPhone());
	
	if(x == 1){
		manager.insertMember(member);	
		response.sendRedirect("loginForm.jsp");
	
	} else{
%>		
		<script>
			alert("휴대폰번호가 중복되었습니다.");
			history.go(-1);
		</script>
		
		
		
	
	
	
	<%}
		
	
	
	
	
	

%>

