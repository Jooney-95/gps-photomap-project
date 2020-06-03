<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
</head>
<body>
	
	<div class="login-form">
	<form method="post" class="form">
		<div class="grid">
         <i class="fas fa-user" id="user" ></i>
         <input type="text" id="id" name="mID" placeholder="Username">
        </div>
        
		<div class="grid">
         <i class="fas fa-lock" id="password" ></i>
         <input type="password" id="pw" name="mPW" placeholder="Password">
         <i class="fa fa-eye-slash fa-lg" id="pwHidden"></i>
        </div>
		
		<div class="login">
          <button type="submit" id="login-button">LOGIN</button>
        </div>
        <c:if test="${member == null }">
	    <a href="/member/id" class="id">아이디찾기</a> |
        <a href="/member/password" class="password">비밀번호찾기</a> |
		<a href="/member/fRegister" class="join">회원가입</a>
	</c:if>
	</form>
	</div>
	
	<c:if test="${member != null }">
		<p>${member.mNickname }</p>
		<a href="/member/logout">로그아웃</a>
	</c:if>
	
	
	<c:if test="${msg eq 'falseID'}">
	    <script>
	    	alert("아이디 오류");
	    </script>
 	</c:if>
 	
 	<c:if test="${msg eq 'falsePW'}">
	    <script>
	    	alert("비밀번호 오류");
	    </script>
 	</c:if>
	<script>
	var pw = document.getElementById("pw");
	var pwHidden = document.getElementById("pwHidden");
	
	window.onload = function(){
		document.getElementById("id").focus();
	}
	
	pwHidden.addEventListener('click', function(event) {
		if(pwHidden.className == "fa fa-eye fa-lg"){
			pwHidden.className = "fa fa-eye-slash fa-lg";
			pw.type = "password";
		} else{
			pwHidden.className = "fa fa-eye fa-lg";
			pw.type = "text";
		}
	});
	</script>
</body>
</html>