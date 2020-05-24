<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>
	<form method="post">
		<label>아이디</label>
		<input type="text" name="mID" />
		<br/>
		<label>비밀번호</label>
		<input type="password" name="mPW" />
		<input type="checkbox" name="hidePW" value="1"/>
		<br/>
		<label>닉네임</label>
		<input type="text" name="mNickname" />
		<br/>
		<button type="submit">확인</button>
	</form>
	
	<script>
	var pw = document.querySelector("body > form > input[type=password]:nth-child(5)");
	var checkBox = document.querySelector("body > form > input[type=checkbox]:nth-child(6)");
	var checkValue = checkBox.value;
	
	checkBox.addEventListener('click', function(event){
		if(checkValue){
			checkValue = 0;
			pw.type = "text";
		} else{
			checkValue = 1;
			pw.type = "password";
		}
	});
	
	</script>
</body>
</html>