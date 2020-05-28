<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
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
	<form method="post" enctype="multipart/form-data">
		<input type="hidden" name="bno" value="${view.bno }" />
		<label>제목</label>
		<input type="text" name="title" value="${view.title }"/>
		<br/>
		<label>작성자</label>
		<input type="text" name="writer" value="${view.writer }" readOnly/>
		<br/>
		<c:forEach items="${list }" var="list">
			<input type="hidden" name="id" value="${list.id }" />
			<img width="100" height="100" alt="" src="<spring:url value='${list.path }'/>">
			<textarea cols="50" rows="5" name="content" >${list.content  }</textarea><br>
			<input type="text" name="lat" value="${list.latitude }"/><br>
			<input type="text" name="lon" value="${list.longitude }"/><br>
			<input type="text" name="time" value="${list.timeView }"/><br>
			<input type="checkbox" class="delete" name="del" value="${list.id }">삭제
			<br/>
		</c:forEach>
		<input type="file" name="filesList" accept=".jpg, .jpeg" multiple/>
		<button type="submit">완료</button>
	</form>
</body>
</html>