<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plus+</title>
<link rel="stylesheet" href="/resources/css/sRegister.css">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/sRegister.js"></script>
</head>


<body>
<div id="header">
 
  <div class="logo">
    <a href="/board/main">Plus+</a>
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
     
     <div class="infos">
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

</body>
</html>