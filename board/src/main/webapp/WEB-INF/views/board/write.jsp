<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/preview.js"></script>
<meta charset="UTF-8">
<title>게시물 작성</title>

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
		<label>제목</label>
		<input type="text" name="title" />
		<br/>
		<label>작성자</label>
		<input type="text" name="writer" value="${member.mNickname }" readOnly />
		<br/>
		<input type="file" id="input_imgs" name="filesList" accept=".jpg, .jpeg" multiple/>
		<br/>
		<button type="submit">작성</button>
		<div class="img_box"></div>
	</form>
	
	 
</body>
</html>