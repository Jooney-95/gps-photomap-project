<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/fRegister.css">
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
   <img src="/resources/imgs/1p.png">
</div>
 
<form id="f" method="post" >
<div class="register">
  <div class="top">
   <p>약관동의</p>
  </div>
  
  
  <div class="middle">
    
    
    
    <div class="info">
      
      <input id="ch1" type="checkbox">이용약관 동의 (필수)    
      <a href="#pop01"><i class="fas fa-info-circle"></i></a>
      
   </div>
   <div class="info">
      <input id="ch2" type="checkbox">개인정보 수집 및 이용 동의 (필수)
      <a href="#pop02"><i class="fas fa-info-circle"></i></a>
   </div>
   <div class="info">
      <input id="ch3" type="checkbox">위치 정보 동의 (필수)
      <a href="#pop03"><i class="fas fa-info-circle"></i></a>   
   </div>
   <div class="info">
      <input type="checkbox">이메일 및 광고 홍보 동의 (선택)
      <a href="#pop04"><i class="fas fa-info-circle"></i></a>
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

	<script>
		var ch1 = document.getElementById("ch1");
		var ch2 = document.getElementById("ch2");
		var ch3 = document.getElementById("ch3");
		var bBack = document.getElementById("bBack");
		var bNext = document.getElementById("bNext");

		bBack.addEventListener('click', function(event) {
			location.href = "/member/login";
		});

		bNext.addEventListener('click', function(event) {

			if (ch1.checked) {
				if (ch2.checked) {
					if (ch3.checked) {
						document.getElementById("f").submit();
					} else {
						alert("위치 정보 동의");
					}
				} else {
					alert("개인정보 수집 및 이용 동의");
				}
			} else {
				alert("이용약관 동의");
			}
		});
	</script>
</body>
</html>

 