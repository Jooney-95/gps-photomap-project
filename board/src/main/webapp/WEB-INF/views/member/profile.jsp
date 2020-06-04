<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>프로필 설정</title>
<link rel="stylesheet" href="/resources/css/profile.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/profile.js"></script>
</head>
<body>
	<form method="post" id="f" enctype="multipart/form-data">
		<input type="hidden" name="mID" value="${session.mID }" />
	 	<c:choose>
        <c:when test="${session.mImg eq null }">
        <img id="pImg" width="100" height="100" alt="" src="/resources/imgs/unnamed.png">
        </c:when>
        <c:otherwise>
        <img id="pImg" width="100" height="100" alt="" src="<spring:url value='${session.mImg }'/>">
        </c:otherwise>
        </c:choose>
        <input type="file" id="upload" name="Img" accept=".jpg, .jpeg, .png" style="display:none" />
		<button type="button" id="bImg" >프로필 사진 변경</button>
		<br/>
		영어, 한글, 숫자를 사용할 수 있습니다.<br/> 
		<input type="text" id="nickname" name="mNickname" value="${session.mNickname }" />
		<button type="button" id="nicknameCheck">닉네임 중복 확인</button>
      	<p id="nicknameMsg" ></p>
      	
		<input type="text" id="email" name="mEmail" value="${session.mEmail }" />
		<br/>
		
		
		
		<button id="bBack" type="button">이전</button>
		<button id="bSub" type="button">확인</button>
		<button id="bPW" type="button">비밀번호 변경</button>
		
	</form>

	<script>
		var regTypeNickname = /[^a-z0-9ㄱ-ㅎ가-힣0-9]/gi;	
		var regTypeEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		var nickname = document.getElementById("nickname");
		var nMsg = document.getElementById("nicknameMsg");
		var email = document.getElementById("email");
		
		var upload = document.getElementById("upload");
		var bImg = document.getElementById("bImg");
		var bBack = document.getElementById("bBack");
		var bSub = document.getElementById("bSub");
		var bPW = document.getElementById("bPW");

		nMsg.value="check";
		
		bImg.addEventListener('click', function(event) {
			upload.click();
		});
		
		bBack.addEventListener('click', function(event) {
			window.history.back();
		});
		
		bPW.addEventListener('click', function(event) {
			location.href = "/member/password";
		});
		
		bSub.addEventListener('click', function(event) {
			if (nMsg.value == "check") {
				if (email.value.trim() != "") {
					if (regTypeEmail.test(email.value)) {
						alert("수정완료");
						document.getElementById("f").submit();
					} else {
						alert("이메일 양식을 맞춰주세요.");
						email.focus();
					}
				} else {
					alert("이메일을 입력해주세요");
					email.focus();
				}
			} else {
				alert("닉네임 중복 확인해주세요");
				nickname.focus();
			}
		});

		nickname.addEventListener('keyup', function(event) {
			var v = this.value;
			this.value = v.replace(regTypeNickname, "");
		});

		nickname.addEventListener('keydown', function(event) {
			nMsg.value = "";
		});

		$("#nicknameCheck").click(
				function() {
					if ($("#nickname").val() != ""
							&& $("#nickname").val() != null
							&& $("#nickname").val() != undefined) {
						var query = {
							mNickname : $("#nickname").val()
						};

						$.ajax({
							url : "/member/nicknameCheck",
							type : "post",
							data : query,
							success : function(data) {
								if (data == 1) {
									$("#nicknameMsg").text("사용 불가");
									$("#nicknameMsg").val("");
								} else {
									$("#nicknameMsg").text("사용 가능");
									$("#nicknameMsg").val("check");
								}
							}
						});
					}
				});
	</script>
</body>
</html>