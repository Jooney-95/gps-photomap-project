<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/sRegister.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
</head>


<body>
<div id="header">
 
  <div class="logo">
    <a href="#">SAMPLE</a>
  </div>
  
<div class="wrap">
   <div class="search">
      <input type="text" class="searchTerm" placeholder="어떤 곳을 찾으시나요?">
      <button type="submit" class="searchButton">
        <i class="fa fa-search"></i>
     </button>
   </div>
</div>
   
</div>

<div class="pg">
   <img src="/resources/imgs/2p.png">
</div>
 
<form method="post" id="f" name="form">
<div class="register">
  <div class="top">
   <p>회원가입</p>
  </div>
  
  
  <div class="middle">
    
  
  
    <div class="info">
      영어, 한글, 숫자를 사용할 수 있습니다.<br/> 
      <i class="far fa-user fa-lg"></i>
      <input type="text" id="nickname"  name="mNickname" placeholder="닉네임" >
      
    </div>
    
    <div class="info">
       영어, 숫자를 사용할 수 있습니다.<br/>
       <i class="far fa-paper-plane fa-lg"></i>
       <input type="text" id="id" name="mID" placeholder="아이디">
       
    </div>
    
    <div class="info">
       <i class="far fa-envelope fa-lg"></i>
       <input type="email" id="email" name="mEmail" placeholder="이메일">
       
   </div>
    
    <div class="info">
    	최소 하나의 특수문자를 포함해 8자 이상 입력해주세요.<br/>
       <i class="fas fa-unlock fa-lg"></i>
       <input type="password" id="pw" name="mPW" placeholder="비밀번호">
       <i class="fa fa-eye-slash fa-lg" id="pwHidden"></i>
    </div>
    
    
    <div class="info">
       <i class="fas fa-lock fa-lg"></i>
       <input type="password" id="pwRepeat" placeholder="비밀번호 확인">
       <p id="pwConfirm"></p>
    </div>
     
    
    
 </div>
    <div class="low">
    
       <div class="back" style=" float:left">
          <button type="button" id="bBack">이전</button>
       </div>    
       
       <div class="next" style="float:right">
          <button type="button" id="bNext">다음</button>
       </div>
       
    </div>






</div>



</form>

	<script>
		var regTypeID = /[^a-z0-9]/gi;
		var regTypePW = /^[a-zA-Z0-9](?=.*[!@#$%^*+=-]){8,}/;
		var regTypeNickname = /[^a-z0-9ㄱ-ㅎ가-힣0-9]/gi;
		
		var nickname = document.getElementById("nickname");
		var id = document.getElementById("id");
		var email = document.getElementById("email");
		var pw = document.getElementById("pw");
		var pwRepeat = document.getElementById("pwRepeat");
		var pwConfirm = document.getElementById("pwConfirm");
		var pwHidden = document.getElementById("pwHidden");
		var bBack = document.getElementById("bBack");
		var bNext = document.getElementById("bNext");

		bBack.addEventListener('click', function(event) {
			location.href = "/member/fRegister";
		});
		bNext.addEventListener('click', function(event) {
			if (regTypeID.test(nickname.value)) {
				console.log(nickname);
				if (id.value.trim() != "") {
					console.log(id);
					if (email.value.trim() != "") {
						console.log(email);
						if (pw.value.trim() != "") {
							console.log(pw);
							if (pwRepeat.value == pw.value) {
								console.log(pwRepeat);
								document.getElementById("f").submit();
							} else {
								alert("비밀번호가 다릅니다.");
								pwRepeat.focus();
							}
						} else {
							alert("비밀번호를 입력해주세요");
							pw.focus();
						}
					} else {
						alert("이메일을 입력해주세요");
						email.focus();
					}
				} else {
					alert("아이디를 입력해주세요");
					id.focus();
				}
			} else {
				alert("닉네임을 입력해주세요");
				nickname.focus();
			}
		});

		nickname.addEventListener('keyup', function(event) {
			var v = this.value;
			this.value = v.replace(regTypeNickname, "");
		});
		
		id.addEventListener('keyup', function(event) {
			var v = this.value;
			this.value = v.replace(regTypeID, "");
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
			if(pwHidden.className == "fa fa-eye fa-lg"){
				pwHidden.className = "fa fa-eye-slash fa-lg";
				pw.type = "password";
				pwRepeat.type = "password";
			} else{
				pwHidden.className = "fa fa-eye fa-lg";
				pw.type = "text";
				pwRepeat.type = "text";
			}
		});
	</script>

</body>
</html>