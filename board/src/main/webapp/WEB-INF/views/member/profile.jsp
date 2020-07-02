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
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/profile.js"></script>

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
            <c:if test="${session != null }"><!-- 로그인했을때 -->
            <div id="r">
               <div class="profile">
                    <img src="${session.mImg }" onclick="loginPopup()"/>
                  <p>${session.mNickname }님</p>
               </div>
            </div>
            
            <div id="writebutton">
               <!-- 게시물 작성 버튼-->
               <a href="/board/write" title="게시물 작성"><i class="far fa-edit"></i></a>
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
   <form method="post" id="f" enctype="multipart/form-data">
   
   <div class="wrapper">    
    <div class="nav" >
      <ul>
      <li>
      <div class="o"><i class="fas fa-user-edit"></i><a href="/member/profile">프로필 편집</a></div>
      
      </li>
      <li>
      <div class="s"><i class="fas fa-lock "></i><a href="/member/password" id="bPW" type="button">비밀번호 변경</a>
      </div>
       </li>
      </ul>
   </div>
   <div class="main" >
   <ul>
    <li>
      <div class="f">
   
   
      <input type="hidden" name="mID" value="${session.mID }" />
      
        <!-- 프로필 사진 -->
       <div id="ff">    
      
      
        <c:choose>
        <c:when test="${session.mImg eq null }">
        <img id="pImg" width="170" height="170" alt="" src="/resources/imgs/unnamed.png">
        </c:when>
        <c:otherwise>
        <img id="pImg" width="170" height="170" alt="" src="<spring:url value='${session.mImg }'/>">
        </c:otherwise>
        </c:choose>
        <input type="file" id="upload" name="Img" accept=".jpg, .jpeg, .png" style="display:none" />
      </div>
     <!-- 프로필 사진 변경 버튼 부분 -->
      
      <button type="button" id="bImg" ><i class="fas fa-camera fa-2x"></i></button>
      
      </div>    
      </li>
     <li>
      <div class="t">
       <i class="far fa-user fa-lg"></i>
      <input type="text" id="nickname" name="mNickname" value="${session.mNickname }" placeholder="영어, 한글, 숫자를 사용할 수 있습니다."/>
      <button type="button" id="nicknameCheck">닉네임 중복 확인</button>
         <p id="nicknameMsg" ></p>
       </div> 
      </li>
      <li>
      
       <div class="t">
       <i class="far fa-envelope fa-lg"></i>
         <input type="text" id="email" name="mEmail" value="${session.mEmail }" />
     </div>
     </li>   
   </ul>
        
       
        <div class="low">
        <button id="bBack" type="button">이전</button>
        <button id="bSub" type="button">확인</button>
        </div>
        
      
      
   
</div>

</div>   
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