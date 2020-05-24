<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 로그인</title>
</head>
<body>
	네이버 로그인 창
	<c:choose>
		<c:when test="${sessionId != null}">
			<h2>네이버 아이디 로그인 성공하셨습니다!!</h2>
			<h3>'${sessionId}' 님 환영합니다!</h3>
			<h3>
				<a href="logout">로그아웃</a>
			</h3>
		</c:when>
		<c:otherwise>
			<form action="login.userdo" method="post" name="frm"
				style="width: 470px;">
				<h2>로그인</h2>
				<input type="text" name="id" id="id" class="w3-input w3-border"
					placeholder="아이디" value="${id}"> <br> <input
					type="password" id="pwd" name="pwd" class="w3-input w3-border"
					placeholder="비밀번호"> <br> <input type="submit"
					value="로그인" onclick="#"> <br>
			</form>
			<br>
			<!-- 네이버 로그인 창으로 이동 -->
			<div id="naver_id_login" style="text-align: center">
				<a href="${url}"> <img width="223"
					src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" /></a>
			</div>
			<br>
			<a href="">
			카카오로그인
			</a>
		</c:otherwise>
	</c:choose>
</body>
</html>