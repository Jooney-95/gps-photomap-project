<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Plus+</title>
<link rel="stylesheet" href="/resources/css/fRegister.css">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/fRegister.js"></script>
</head>


<body>
<div id="header">
 
  <div class="logo">
    <a href="/board/main">Plus+</a>
  </div>
  

   
</div>

<div class="pg">
   <img src="/resources/imgs/1p.png">
</div>
 
<form id="f" method="post" >
<div class="register">
  <div class="top">
   <p>약관동의</p>
  </div>
  
  
  <div class="middle">
    
    
    
    <div class="info">
      <label>
      <input id="ch1" value="ch1" name="ch" type="checkbox">이용약관 동의 (필수)  </label>  
      <a href="#pop01"><i class="fas fa-info-circle"></i></a>
      
   </div>
   <div class="info">
   <label>
      <input id="ch2" value="ch2" name="ch" type="checkbox">개인정보 수집 및 이용 동의 (필수)</label>
      <a href="#pop02"><i class="fas fa-info-circle"></i></a>
   
   </div>
   <div class="info">
   <label>
      <input id="ch3" value="ch3" name="ch" type="checkbox">위치 정보 동의 (필수)</label>
      <a href="#pop03"><i class="fas fa-info-circle"></i></a>   
   
   </div>
   <div class="info">
   <label>
      <input type="checkbox">이메일 및 광고 홍보 동의 (선택)</label>
      <a href="#pop04"><i class="fas fa-info-circle"></i></a>
 
   </div>
   <div class="all">
   <label>
      <input id="ch4" type="checkbox">전체동의</label>
     
 
   </div>



<div id="pop01" class="overlay">
  <div class="popup">
    <a href="#none" class="close"><i class="fas fa-times"></i></a>
    이용 약관 동의 내용
  </div>
</div>

<div id="pop02" class="overlay">
  <div class="popup">
    <a href="#none" class="close"><i class="fas fa-times"></i></a>
    개인정보 수집 및 이용 동의 내용
  </div>
</div>

<div id="pop03" class="overlay">
  <div class="popup">
    <a href="#none" class="close"><i class="fas fa-times"></i></a>
     위치 정보 동의 내용
  </div>
</div>

<div id="pop04" class="overlay">

  <div class="popup">
    <a href="#none" class="close"><i class="fas fa-times"></i></a>
   이메일 및 광고 홍보 동의 내용
  </div>
  
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

 