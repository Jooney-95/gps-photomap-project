<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/sRegister.css">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
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
      <i class="far fa-user fa-lg"></i>
      <input type="text" id="nickname"  name="mNickname" placeholder="닉네임 (영문 한글 숫자 사용가능)" >
      <button type="button" id="nicknameCheck">닉네임 중복 확인</button>
      <p id="nicknameMsg" ></p>
      
    </div>
    
        
    <div class="info">
       
       <i class="far fa-paper-plane fa-lg"></i>
       <input type="text" id="id" name="mID" placeholder="아이디  (영문 숫자 사용가능)">
       <button type="button" id="idCheck">아이디 중복 확인</button>
       <p id="idMsg" ></p>
     </div>
    
   
    
    <div class="info">
       <i class="fas fa-unlock fa-lg"></i>
       <input type="password" id="pw" name="mPW" placeholder="비밀번호 (영문 숫자 특수문자를 2가지 이상 포함하여 8자 이상)">
       <i class="fa fa-eye-slash fa-lg" id="pwHidden"></i>
      
    </div>
    
    
    <div class="info">
       <i class="fas fa-lock fa-lg"></i>
       <input type="password" id="pwRepeat" placeholder="비밀번호 확인">
       <p id="pwConfirm"></p>
       
    </div>
     
     <div class="info">
       <i class="far fa-envelope fa-lg"></i>
       <input type="hidden" id="mEmail" name="mEmail" >
       <input type="email" id="email" placeholder="이메일">@
       <input class="" id="email2" type="email" class="box">

      <select id="emailSelection" name="emailSelection">
         <option value="1" selected="selected">직접입력</option>
         <option value="naver.com">naver.com</option>
         <option value="daum.net">daum.net</option>
         <option value="gmail.com">gmail.com</option>
         <option value="hanmail.net">hanmail.net</option>
      </select>




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
      var nMsg = document.getElementById("nicknameMsg");
      var id = document.getElementById("id");
      var idMsg = document.getElementById("idMsg");
      var email = document.getElementById("email");
      var email2 = document.getElementById("email2");
      var mEmail = document.getElementById("mEmail");
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
         if (nMsg.value == "check") {
            if (idMsg.value == "check") {
               if (email.value.trim() != "" && email2.value.trim() != "") {
                  mEmail.value = email.value + "@" + email2.value;
                  if (pw.value.trim() != "") {
                     if (regTypePW.test(pw.value)){
                        if (pwRepeat.value == pw.value) {
                           document.getElementById("f").submit();
                        } else {
                           alert("비밀번호가 다릅니다.");
                           pwRepeat.focus();
                        }
                     } else{
                        alert("비밀번호 양식을 맞춰주세요.");
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
               alert("아이디  중복 확인해주세요");
               id.focus();
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
      
      id.addEventListener('keyup', function(event) {
         var v = this.value;
         this.value = v.replace(regTypeID, "");
      });
      
      id.addEventListener('keydown', function(event) {
         idMsg.value = "";
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
      
      $("#idCheck").click(function(){
         var query = {mID : $("#id").val()};
         
         $.ajax({
            url : "/member/idCheck",
            type : "post",
            data : query,
            success : function(data) {
               if(data == 1){
                  $("#idMsg").text("이미 중복된 아이디입니다.");
                  $("#idMsg").val("");
               } else{
                  $("#idMsg").text("사용이 가능합니다");
                  $("#idMsg").val("check");
               }
            }
         });
      });
      $("#nicknameCheck").click(function(){
         var query = {mNickname : $("#nickname").val()};
         
         $.ajax({
            url : "/member/nicknameCheck",
            type : "post",
            data : query,
            success : function(data) {
               if(data == 1){
                  $("#nicknameMsg").text("이미 중복된 닉네임입니다.");
                  $("#nicknameMsg").val("");
               } else{
                  $("#nicknameMsg").text("사용이 가능합니다");
                  $("#nicknameMsg").val("check");
               }
            }
         });
      });
      
      /* 옵션에서 이메일 값 불러오기*/
      $(function(){   

          $(document).ready(function(){

             $('select[name=emailSelection]').change(function() {

                if($(this).val()=="1"){

                   $('#email2').val("");

                } else {

                   $('#email2').val($(this).val());

                   $("#email2").attr("readonly", true);

                }

             });

          });

       });



    
      
   </script>

</body>
</html>