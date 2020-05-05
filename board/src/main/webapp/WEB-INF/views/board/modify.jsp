<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.1.1.min.js"></script>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>
	<form method="post">
		<label>제목</label>
		<input type="text" name="title" value="${view.title }"/>
		<br/>
		<label>작성자</label>
		<input type="text" name="writer" value="${view.writer }"/>
		<br/>
		<label>내용</label>
		<textarea cols="50" rows="5" name="content" >${view.content }</textarea>
		<br/>
		<c:forEach items="${list }" var="list">
			<img width="100" height="100" alt="" src="<spring:url value='${list.path }'/>"><br>
			<input type="text" name="gps" value="${list.gps }"/><br>
			<input type="text" name="time" value="${list.timeView }"/><br>
			<input type="checkbox" class="delete" name="del" value="${list.id }">삭제
			<br/>
		</c:forEach>
		<button type="submit">완료</button>
	</form>
	<script>
	
	</script>
</body>
</html>