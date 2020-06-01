<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div id="nav">
		<c:if test="${member != null }">
			<%@ include file="../include/navLogin.jsp"%>
		</c:if>
		<c:if test="${member == null }">
			<%@ include file="../include/navLogout.jsp"%>
		</c:if>
	</div>
	
	<form method="post">
		<label>아이디</label>
		<input type="text" name="mID" />
		<br/>
		<label>비밀번호</label>
		<input type="password" name="mPW" />
		<br/>
		<button type="submit">로그인</button>
	</form>

	<c:if test="${member != null }">
		<p>${member.mNickname }</p>
		<a href="/member/logout">로그아웃</a>
	</c:if>
	
	<c:if test="${member == null }">
		<a href="/member/fRegister">회원가입</a>
		<a href="/member/naverLogin">네이버 로그인</a>
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
	
</body>
</html>