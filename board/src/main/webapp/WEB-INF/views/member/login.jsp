<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plus+</title>
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/login.js"></script>
</head>
<body>
	
	<div class="login-form">
	<form id="f" method="post" class="form">
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
          <button type="button" id="login-button">LOGIN</button>
        </div>
        <c:if test="${session == null }">
	    <a href="/member/id" class="id">아이디찾기</a> |
        <a href="/member/password" class="password">비밀번호찾기</a> |
		<a href="/member/fRegister" class="join">회원가입</a>
	</c:if>
	</form>
	</div>
	
</body>
</html>