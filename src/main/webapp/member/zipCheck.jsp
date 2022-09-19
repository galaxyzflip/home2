<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, logon.*" %>

<%
	request.setCharacterEncoding("utf-8");

	String check = request.getParameter("check");
	String area3 = request.getParameter("area3");
	LogonDBBean manager = LogonDBBean.getInstance();
	Vector<ZipcodeBean> zipcodeList = manager.zipcodeRead(area3);
	int totlaList = zipcodeList.size();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우편번호검색</title>
<link href="style.css" rel="stylesheet" type="text/css">

<script>
	function dongCheck(){
		if(document.zipForm.area3.value == ""){
			alert("동 이름을 입력하세요");
			document.zipForm.area3.focus();
			return;
		}
		document.zipForm.submit();
	}
	
	function sendAddress(zipcode, area1, area2, area3, area4){
		var address = area1 + " " + area2 + " " + area3 + " " + area4;
		opener.document.userinput.zipcode.value = zipcode;
		opener.document.userinput.address.value = address;
		self.close();
	}
	


</script>
</head>
<body bgcolor="#ffffcc">


	<b>우편번호 찾기</b>
	
	<form name="zipForm" method="post" action="zipCheck.jsp">
	<table>
		<tr>
			<td><br>
			동이름 입력 : <input name="area3" type="text">
			<input type="button" value="검색" onclick="dongCheck();">
			</td>
		</tr>
		
		<input type="hidden" name="check" value="n">
	
	</table>
	</form>
	
	
<%
	if(check.equals("n")){
		
		if(zipcodeList.isEmpty()){
%>		
		<tr>
			<td align="center"><br>검색된 결과가 없습니다.</td>
		</tr>	
				
<%		} else{%>

		<tr>
			<td align="center"><br>검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td>
		</tr>
<%
			for(int i=0; i<totlaList;i++){

				ZipcodeBean zipBean = zipcodeList.elementAt(i);
				String tempZipcode = zipBean.getZipcode();
				String tempArea1 = zipBean.getArea1();
				String tempArea2 = zipBean.getArea2();
				String tempArea3 = zipBean.getArea3();
				String tempArea4 = zipBean.getArea4();
%>
			<tr>
				<td>
				<a href="javascript:sendAddress('<%=tempZipcode %>','<%=tempArea1 %>','<%=tempArea2 %>','<%=tempArea3 %>','<%=tempArea4 %>')">
				<%=tempZipcode %>&nbsp;<%=tempArea1 %>&nbsp;<%=tempArea2 %>&nbsp;<%=tempArea3 %>&nbsp;<%=tempArea4 %>
				</a><br>

<%
			}
}
	}
%>
				</td>
			</tr>
			
			<tr>
				<td align="center"><br>
				<a href="javascript:this.close();">닫기</a>
				</td>
			</tr>
	


</body>
</html>



