<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>insert title here</title>
</head>

<body>
	<div id="nav">
		<c:if test="${session != null }">
			<%@ include file="../include/navLogin.jsp"%>
		</c:if>
		<c:if test="${session == null }">
			<%@ include file="../include/navLogout.jsp"%>
		</c:if>
		<a href="/member/profile">프로필 수정</a>
	</div>
	<table>
		<thead>
			<tr>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach items="${list}" var="list">
				<tr>
					<td id="writer${list.bno }"></td>
					<td><a href="/board/view?bno=${list.bno}">${list.title}</a><br/><c:forEach
							items="${fileList }" var="fileList">
							<c:forEach items="${fileList }" var="fileList" end="2">
								<c:if test="${fileList.fileBno == list.bno}">
								<img width="100" height="100" alt="" src="<spring:url value='${fileList.path }'/>">						
									</c:if>
							</c:forEach>
						</c:forEach></td>
					<td>${list.regDate}</td>
					<td>${list.viewCnt}</td>
					<td>${list.likeCnt}</td>
				</tr>
			</c:forEach>
		</tbody>

	</table>
	<div>
		<c:if test="${page.prev}">
			<span>[ <a href="/board/listPageSearch?num=${page.startPageNum - 1}">이전</a> ]</span>
		</c:if>

		<c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			<span>

				<c:if test="${select != num}">
					<a href="/board/listPageSearch?num=${num}">${num}</a>
				</c:if>

				<c:if test="${select == num}">
					<b>${num}</b>
				</c:if>

			</span>
		</c:forEach>

		<c:if test="${page.next}">
			<span>[ <a href="/board/listPageSearch?num=${page.endPageNum + 1}">다음</a> ]</span>
		</c:if>
		
		<div>
	    	<select name="searchType">
	    		<option value="writer">작성자</option>
				<option value="title">제목</option>
			</select>
        	<input type="text" name="keyword" />
			<button type="button" id="searchBtn">검색</button>
 		</div>
		<script>
		
			var mImg = new Array();
			var mNickname = new Array();
			var bno = new Array();
			
			<c:forEach items="${member }" var="member">
				mImg.push("${member.mImg }");
				mNickname.push("${member.mNickname }");
			</c:forEach>
			<c:forEach items="${list}" var="list">
				bno.push("writer${list.bno }");
			</c:forEach>
			
			for(i=0;i<bno.length;i++){
				document.getElementById(bno[i]).innerHTML = '<img width="100" height="100" alt="" src=' + mImg[i] + '>' + mNickname[i] + '';	
			}

			document.getElementById("searchBtn").onclick = function() {

				let searchType = document.getElementsByName("searchType")[0].value;
				let keyword = document.getElementsByName("keyword")[0].value;

				location.href = "/board/listPageSearch?num=1" + "&searchType="
						+ searchType + "&keyword=" + keyword;
			};
		</script>
	</div>
</body>

</html>