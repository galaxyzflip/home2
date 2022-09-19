<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="style.css" rel="stylesheet" type="text/css">

<script language="javaScript">

	function chechIt(){
		var userinput = eval("document.userinput");
		if(!userinput.id.value){
			alert("ID를 입력하세요.");
			return false;
		}
		
		if(!userinput.passwd.value){
			alert("비밀번호를 입력하세요");
			return false;
		}
		
		if(userinput.passwd.value != userinput.passwd2.value){
			alert("비밀번호를 동일하게 입력하세요");
			return false;
		}
		
		if(!userinput.name.value){
			alert("사용자 이름을 입력하세요");
			return false;
		}
		
		if(!userinput.birthday){
			alert("주민등록번호를 입력하세요");
			return false;
		}
		
		if(!userinput.male){
			alert("성별을 입력해주세요");
			return false;
		}
		
		if(!userinput.phone){
			alert("연락처를 입력해주세요.");
			return false;
		}
		
		
		
		
		
	}

//아이디 중복여부를 판단

	function openConfirmid(userinput){
	//아이디 입력했는지
	if(userinput.id.value == ""){
		alert("아이디를 입력하세요");
		return;
	}
	//url과 사용자 입력 id 를 조합합니다.
	url = "confirmId.jsp?id=" + userinput.id.value;
	
	//새로운 윈도우를 엽니다.
	open(url, "confirm", "toolbar=no, location=no, status=no,menubar=no, scrollbars=no, resizable=no, width=300, height=200");
	}
	
	function zipCheck(){
		url="zipCheck.jsp?check=y";
		window.open(url, "post", "toolbar=no, width=500, height=300, directories=no, status=yes, scrollbars=yes, menubar=no");
	}
	


</script>
</head>

<body bgcolor="<%=bodyback_c %>">

<form method="post" action="inputPro.jsp" name="userinput" onSubmit="return chechIt()">

	<table width="600" border="1" cellspacing="0" cellpadding="3" align="center">
		<tr>
			<td colspan="2" height="39" align="center" bgcolor="<%= value_c %>">
				<font size="+1"><b>회원가입</b></font>
			</td>
		</tr>
		
		<tr>
			<td width="200" bgcolor="<%=value_c %>"><b>아이디 입력</b>
			</td>
		</tr>
		
		<tr>
			<td width="200"> 사용자 ID </td>
			<td width="400">
				<input type="text" name="id" size="10" maxlength="12" placeholder="아이디 입력">
				<input type="button" name="confirm_id" value="ID중복확인" Onclick = "openConfirmid(this.form)">
			</td>
		</tr>
		
		<tr>
			<td width="200"> 비밀번호 </td>
			<td width="400">
				<input type="password" name="passwd" size="15" placeholder="비밀번호 입력" maxlength="12">
			</td>
		</tr>
		
		<tr>
			<td width="200"> 비밀번호 확인</td>
			<td width="400">
				<input type="password" name="passwd2" size="15" placeholder="비밀번호 확인" maxlength="12">
			</td>
		</tr>
		
		<tr>
			<td width="200" bgcolor="<%=value_c %>"><b>개인정보 입력</b></td>
			<td width="400" bgcolor="<%=value_c %>"></td>
		</tr>
		
		<tr>
			<td width="200">사용자이름</td>
			<td width="400">
				<input type="text" name="name" size="15" placeholder="이름입력"  maxlength="10">
			</td>
		</tr>
		
		
		<tr>
			<td width="200"> 생년월일 </td>
			<td width="400">
				<!-- <input type="text" name="birthday" size="8" maxlength="8"> -->
				<form>
					<input type="date" name="birthday" value="1988-07-20" >
				</form>
			</td>
		</tr>
		
		<tr>
			<td width="200"> 휴대폰번호 </td>
			<td width="400">
					<input type="text" name="phone" size="15" placeholder=" ' - ' 없이 입력">
			</td>
		</tr>
			
		<tr>
			<td width="200"> 성별 </td>
			<td width="400">
				<!-- <input type="text" name="male" size="2" maxlength="2"> -->
				
				<select name="male">
					<option value="ma">남자</option>
					<option value="fe">여자</option>
					<option value="">없음</option>
				</select>
			</td>
		</tr>
			
		<tr>
			<td width="200"> E-Mail </td>
			<td width="400">
				<input type="text" name="email" size="40" maxlength="30">
			</td>
		</tr>
		
		<tr>
			<td width="200"> Blog </td>
			<td width="400">
				<input type="text" name="blog" size="60" maxlength="50">
			</td>
		</tr>
		
		<tr>
			<td width="200">우편번호</td>
			<td><input type="text" name="zipcode" size="7">
				<input type="button" value="우편번호찾기" onClick="zipCheck()">
				우편번호를 검색하세요.</td>
		</tr>
		
		<tr>
			<td>주소</td>
			<td><input type="text" name="address" size="70">
				</td>
		</tr>
		
		<tr>
			<td>상세주소</td>
			<td><input type="text" name="detailAddress" size="70">
				주소를 적어주세요.</td>
		</tr>
		
		<tr>
			<td colspan="2" align="center" bgcolor="<%= value_c %>">
				<input type="submit" name="confirm" value="등   록">
				<input type="reset" name="reset" value="다시입력">
				<input type="button" value="가입안함" onclick="javascript:window.location='main.jsp'">
			</td>
		</tr>
	</table>
</form>


</body>
</html>