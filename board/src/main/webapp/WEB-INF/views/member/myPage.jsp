<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/myPage.js"></script>
<title>insert title here</title>
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="/resources/css/mypage.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
</head>

<body>

	<!-- 상단 바 -->
	<div id="header">
		<!-- 로고 -->
		<div class="logo">
			<a href="/board/listPageSearch?num=1">Plus+</a>
		</div>

		<!-- 사용자 로그인 현황 -->
		<div class="log">
			<c:if test="${session != null }">
				<!-- 로그인했을때 -->
				<div id="r">
					<div class="profile">
						<a href="/member/myPage?num=1&userID=${session.id }"><img
							src="${session.mImg }" /> </a>
						<div class="out">
							<c:if test="${session != null }">
								<%@ include file="../include/navLogin.jsp"%>
							</c:if>
							<c:if test="${session == null }">
								<%@ include file="../include/navLogout.jsp"%>
							</c:if>
						</div>

					</div>
				</div>

				<div id="writebutton">
					<!-- 게시물 작성 버튼-->
					<a href="/board/write"><img src="/resources/imgs/w1.png" /></a>
				</div>
			</c:if>

			<c:if test="${session == null }">
				<!-- 로그인 안했을때 -->
				<div id="rr">
					<a href="/member/login"><img src="/resources/imgs/p1.png"></a>
				</div>
			</c:if>
		</div>
	</div>

	<div class="main">
<input type="hidden" id="userID" value="${member.id }"/>
		<div class="modify">
			<c:if test="${session.id eq userID }">
				<a href="/member/profile"><i class="fas fa-cog fa-3x"></i></a>
			</c:if>
		</div>
		<div class="bFollow">
			<c:if test="${session.id ne userID }">
				<i class="fas fa-user-plus fa-2x" id="bFollow"></i>
			</c:if>
		</div>

		<div class="ff">
			<img alt="" src="<spring:url value='${member.mImg }'/>">
		</div>


		<div class="one">${member.mNickname }님</div>

		<div class="show">게시글 : ${count } 서로이웃 : ${countFollow }</div>


		<div class="all">
			<div class="nav">
				<div class="o" title="내 게시물">
					<a href="#"><i class="fas fa-clipboard fa-2x"></i></a>
				</div>
				<div class="t" title="이웃목록">
					<a href="#"><i class="fas fa-users fa-2x"></i></a>
				</div>
				<c:if test="${session.id eq userID }">
					<div class="th" title="이웃요청">
						<a href="#"><i class="fas fa-user-plus fa-2x"></i></a>
					</div>
				</c:if>
			</div>
			<div class="in"></div>
		</div>
	</div>

	<script>
		window.onload = function() {
			followCheck();
		}

		$("#bFollow").click(
				function() {
					var query = {
						sessionID : "${session.id}",
						userID : "${userID}"
					};
					$.ajax({
						url : "/member/followClick",
						type : "post",
						data : query,
						success : function() {
							followCheck();
						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "message:"
									+ request.responseText + "\n" + "error:"
									+ error);
						}
					});
				});

		function followCheck() {
			if ("${session }" != "") {
				var query = {
					sessionID : "${session.id}",
					userID : "${userID}"
				};
				$.ajax({
					url : "/member/followingCheck",
					type : "post",
					data : query,
					success : function(check) {
						if (check == 1) {
							$("#bFollow").attr("class",
									"fas fa-user-clock fa-2x");
						} else if (check == 2) {
							$("#bFollow").attr("class",
									"fas fa-user-check fa-2x");
						} else {
							$("#bFollow").attr("class",
									"fas fa-user-plus fa-2x");
						}
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "message:"
								+ request.responseText + "\n" + "error:"
								+ error);
					}
				});
			}
		}
	</script>

</body>

</html>