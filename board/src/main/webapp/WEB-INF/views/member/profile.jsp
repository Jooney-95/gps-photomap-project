<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>프로필 설정</title>
</head>
<body>
	<form action="post" id="f">
		<button type="button" id="img" name="mImg" >프로필 사진 변경</button>
		<input type="text" id="nicmname" name="mNickname" />
		<input type="email" id="email" name="mEmail" />
		<input type="password" id="pw" name="mPW" />
		<input type="password" id="pwRepeat" />
	</form>
</body>
</html>