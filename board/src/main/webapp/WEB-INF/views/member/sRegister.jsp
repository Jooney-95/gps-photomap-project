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
 
<form method="post" name="form">
<div class="register">
  <div class="top">
   <p>회원가입</p>
  </div>
  
  
  <div class="middle">
    
  
  
    <div class="info">
      <i class="far fa-user fa-lg"></i>
      <input type="text"  name="mNickname" placeholder="닉네임" >
       
    </div>
    
    <div class="info">
       <i class="far fa-paper-plane fa-lg"></i>
       <input type="text" name="mID" placeholder="아이디">
    </div>
    
    <div class="info">
       <i class="far fa-envelope fa-lg"></i>
       <input type="email" name="mEmail" placeholder="이메일">
       
   </div>
    
    <div class="info">
       <i class="fas fa-unlock fa-lg"></i>
       <input type="password" name="mPW" placeholder="비밀번호">
    </div>
    
    
    <div class="info">
       <i class="fas fa-lock fa-lg"></i>
       <input type="password" placeholder="비밀번호 확인">
    </div>
    
    
 </div>
    <div class="low">
    
       <div class="back" style=" float:left">
          <button onclick="location.href='/member/register'">이전</button>
       </div>    
       
       <div class="next" style="float:right">
          <button type="submit" >다음</button>
       </div>
       
    </div>






</div>



</form>


</body>
</html>