<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 변경</title>
<link rel="stylesheet" href="/resources/css/profile.css">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

<div id="header">
 
  <div class="logo">
    <a href="/board/listPageSearch?num=1">SAMPLE</a>
  </div>
  
<div class="wrap">
   <div class="search">
      <input type="text" class="searchTerm" placeholder="어떤 곳을 찾으시나요?">
      <button type="submit" class="searchButton">
        <i class="fa fa-search"></i>
     </button>
   </div>
</div>
 <!-- 사용자 로그인 현황 -->
      <div class="log">
            <c:if test="${session != null }"> <!-- 로그인했을때 -->
                <div id="r">
               <div class="profile">
                    <img src="${session.mImg }" onclick="loginPopup()"/>
                  <p>${session.mNickname }님</p>
               </div>
            </div>
            
            <div id="writebutton"> <!-- 게시물 작성 버튼-->
                   <a href="/board/write"><img src="/resources/imgs/w1.png"/></a>
            </div>  
            </c:if>
            
            <c:if test="${session == null }"> <!-- 로그인 안했을때 -->
            <div id="rr">
          <a href="/member/login"><img src="/resources/imgs/p1.png"></a>
          </div>
            </c:if>
      </div>
<div class="pop" id="loginPopup" style="display:none">               
                <div class="pi"><a href="/member/myPage?num=1&userID=${session.id }"><i class="fas fa-user-cog"></i>  마이페이지</a></div>
                <div class="pii"><a href="/member/logout"><i class="fas fa-power-off"></i>  로그아웃</a></div>
            </div>
   </div>


   <form method="post" id="f">
   <div class="wrapper">
    <div class="nav" >
      <ul>
      <li>
      <div class="o"><a href="/member/profile">프로필 편집</a></div>
      </li>
      <li>
      <div class="s"><a href="/member/password" id="bPW" type="button">비밀번호 변경</a></div>
       </li>
      </ul>
   </div>
   <div class="main">
      <input type="hidden" id="mID" name="mID" value="${session.mID }">
      <input type="password" id="curPW" name="PW" placeholder="현재 비밀번호" />
      최소 하나의 특수문자를 포함해 8자 이상 입력해주세요.<br />
      <input type="password" id="pw" name="mPW" placeholder="변경할 비밀번호" />
      <i class="fa fa-eye-slash fa-lg" id="pwHidden"></i> <br />
      <input type="password" id="pwRepeat" placeholder="비밀번호 재입력"/>
      <p id="pwConfirm"></p>
      
      <button id="bBack" type="button">이전</button>
      <button id="bSub" type="button">확인</button>
     </div>
    </div> 
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
	

    function loginPopup() {
        if (document.getElementById("loginPopup").style.display == "none") {
           document.getElementById("loginPopup").style.display = "";
        } else {
           document.getElementById("loginPopup").style.display = "none";
        }
     }
	</script>
	
</body>
</html>