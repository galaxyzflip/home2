<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="color.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="style.css" rel="stylesheet" type="text/css">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    
                
                } else {
                    
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>


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
			<td>
				<input type="text" name="zipcode" id="sample6_postcode" size="7">
				<input type="button" onclick="sample6_execDaumPostcode()" value="다음우편번호"><br></td>
		</tr>
   
		<tr> 
			<td>주소</td>
			<td><input type="text" name="address" id="sample6_address" size="70"><br>
				<input type="text" name="detailAddress" id="sample6_detailAddress" size="70">
			</td>
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