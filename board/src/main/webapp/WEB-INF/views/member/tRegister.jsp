<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/tRegister.css">
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
   <img src="/resources/imgs/3p.png">
</div>
 
<form method="post" name="form">
<div class="register">
   <div class="top">
    <p>가입완료</p>
   </div>
  
  
   <div class="middle">
    <div class="finish">
    <img src="/resources/imgs/congratulation (1).png">
    <p id="finish">가입을 축하드립니다!
    </div>
  
  
    
    
    
 </div>
    <div class="low">
    
       <div class="start" >
         <button onclick="location.href='/'">시작하기</button>
       </div>
       
    </div>






</div>



</form>


</body>
</html>