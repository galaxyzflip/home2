<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인입니다.</title>
<link href="style.css" rel="stylesheet" type="text/css">

<%
	try{
		if(session.getAttribute("memId") == null){ %>
		<!-- memId 세션이 없으면 로그인 안한상태 -->
		
<script language="javaScript">

	function focusIt(){
		document.inform.id.focus();
	}

function chekIt()
{
	inputForm=eval("document.inform");
	if(!inputForm.id.value){
		alert("아이디를 입력하세요...");
		inputForm.passwd.focus();
		return flase;
	}
}

function findId(){
	url = "findId.jsp";
	window.open(url,"post", "toolbar=no,width=500,height=300,status=yes,scrollbars=yes,menubar=no");
}

function findPasswd(){
	url = "findPasswd.jsp";
	window.open(url,"post", "toolbar=no,width=500,height=300,status=yes,scrollbars=yes,menubar=no");
}

</script>


</head>
<body onLoad="focusIt();" bgcolor="<%=bodyback_c %>">
	
<form name="inform" method="post" action="loginPro.jsp" onsubmit = "return checkIt();">
	
	<table width="500" cellpadding="0" cellspacing="0" align="center" border="1">
	
		<tr>
			<td width="300" bgcolor="<%= bodyback_c %>" height="20">
			&nbsp;
			</td>
			
			
			<td bgcolor="<%=title_c %>" width="100" align="right"> 아이디 </td>
			<td width="100" bgcolor="<%= value_c %>">
				<input type="text" name="id" size="15" maxlength="10" autofocus tabindex="1"/></td>
		</tr>
		<tr>
			<td rowspan="3" bgcolor="<%= bodyback_c %>" width="300"> 
			<a href="../board/list.jsp">게시판</a>
			 </td>
			<td bgcolor="<%=title_c %>" width="100" align="right"> 패스워드 </td>
			<td width="100" bgcolor="<%= value_c %>">
				<input type="password" name="passwd" size="15" maxlength="10" tabindex="2"></td>
		</tr>
		
		<tr>
			<td colspan="3" bgcolor="<%= title_c %>" align="center">
			<input type="submit" name="Submit" value="로그인">
			<input type="button" value="회원가입" onclick="javascript:window.location='inputForm.jsp'">
			</td>
		</tr>
		
		<tr>
        	<td colspan="3" bgcolor="<%=title_c%>" align="center">
        		<input type="button" value="아이디찾기" onclick="findId()">
        		<input type="button" value="비밀번호찾기" onclick="findPasswd()">
        	</td>
        </tr>
			
			
	
	</table>
</form>



<% 					
		} else {
%>
			<table width="500" cellpadding="0" cellspacting="0" align="center" border="1">
			
				<tr>
					<td width="300" bgcolor="<%=value_c %>" align="center">
					<%=session.getAttribute("memId") %> 님이 <br> 방문하셨습니다.
					
					<form method="post" action="logout.jsp">
					<input type="submit" value="로그아웃">
					<input type="button" value="회원정보변경" onclick="javascript:window.location='modify.jsp'">
					</form>
					
					</td>
				</tr>
				
				<tr>
					<td rowspan="2" bgcolor="<%= bodyback_c %>" width="300"> <a href="../board/list.jsp">게시판</a> </td>
				</tr>
			
			</table>
		<br>

<% 	}		
	}catch(NullPointerException ex){}
%>
	

</body>
</html>