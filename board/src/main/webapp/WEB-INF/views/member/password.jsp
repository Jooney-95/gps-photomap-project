<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 변경</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<form method="post" id="f">
		<input type="hidden" id="mID" name="mID" value="${session.mID }">
		<input type="password" id="curPW" name="PW" placeholder="현재 비밀번호" />
		최소 하나의 특수문자를 포함해 8자 이상 입력해주세요.<br />
		<input type="password" id="pw" name="mPW" placeholder="변경할 비밀번호" />
		<i class="fa fa-eye-slash fa-lg" id="pwHidden"></i> <br />
		<input type="password" id="pwRepeat" placeholder="비밀번호 재입력"/>
		<p id="pwConfirm"></p>
		
		<button id="bBack" type="button">이전</button>
		<button id="bSub" type="button">확인</button>

	</form>
	
	<script>
	var regTypePW = /^[a-zA-Z0-9](?=.*[!@#$%^*+=-]){8,}/;
	var pw = document.getElementById("pw");
	var pwRepeat = document.getElementById("pwRepeat");
	var bBack = document.getElementById("bBack");
	var bSub = document.getElementById("bSub");
	
	bBack.addEventListener('click', function(event) {
		window.history.back();
	});
	
	pw.addEventListener('keyup', function(event) {
		if (regTypePW.test(pw.value)) {
			pwRepeat.addEventListener('keyup', function(event) {

				if (pwRepeat.value == pw.value) {
					pwConfirm.innerText = "비밀번호 일치";
				} else {
					pwConfirm.innerText = "비밀번호 불일치";
				}
			});
		} else {
			pwConfirm.innerText = "";
		}
	});

	pwHidden.addEventListener('click', function(event) {
		if (pwHidden.className == "fa fa-eye fa-lg") {
			pwHidden.className = "fa fa-eye-slash fa-lg";
			pw.type = "password";
			pwRepeat.type = "password";
		} else {
			pwHidden.className = "fa fa-eye fa-lg";
			pw.type = "text";
			pwRepeat.type = "text";
		}
	});
	
	$("#bSub").click(
			function() {
				if ($("#curPW").val() != ""
						&& $("#curPW").val() != null
						&& $("#curPW").val() != undefined) {
					var query = {
							curPW : $("#curPW").val(),
							mID : $("#mID").val()
					};

					$.ajax({
						url : "/member/pwCheck",
						type : "post",
						data : query,
						success : function(data) {
							if (data == 1) {
								if(pw.value != ""){
									if(regTypePW.test(pw.value)){
										if(pw.value == pwRepeat.value){
											alert("비밀번호 변경 완료. 다시 로그인해 주세요");
											$("#f").submit();
										} else{
											alert("비밀번호가 일치하지 않습니다.");
										}
									} else{
										alert("비밀번호 양식을 맞춰주세요.");
									}
								} else{
									alert("변경할 비밀번호를 입력해 주세요.");
								}
							} else {
								alert("현재 비밀번호가 다릅니다.");
							}
						}
					});
				}
			});
	</script>
	
</body>
</html>