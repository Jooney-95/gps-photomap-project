<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/preview.js"></script>
<meta charset="UTF-8">

<title>게시물 작성</title>
<link rel="stylesheet" href="/resources/css/write.css">
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
   
<div id="nav">
    <c:if test="${session != null }">
         <%@ include file="../include/navLogin.jsp"%>
    </c:if>
    <c:if test="${session == null }">
         <%@ include file="../include/navLogout.jsp"%>
    </c:if>
</div>   
</div>


<form method="post" id="f" enctype="multipart/form-data" >   
<div class="main">

      <div id="top">
         <p>제목     <input type="text" id="title" name="title" placeholder="제목을 입력하세요."/></p>
          <p>작성자  <input type="text" name="writer" value="${session.mNickname }" readOnly /></p>
      </div>
      
      <div class="button-wrapper">
           <p>이미지
           <span class="label">
             내 라이브러리
           </span>
             <input type="file" name="filesList" id="input_imgs" class="upload-box" placeholder="Upload File" accept=".jpg, .jpeg" multiple/></p>
      </div>
      
      <div id="text">
      <p>이미지는 최대 50개까지 선택 가능합니다.</p>
      </div>
      
      <div id="middle">
          <div class="img_box"></div>
      </div>
      
      <div id="bottom">
         공개 범위 
         <input type="radio" name="pNum" value="0" checked="true">  전체 공개
         <input type="radio" name="pNum" value="1">  이웃 공개
         <input type="radio" name="pNum" value="2">  비공개
      </div>   
      
</div>
      
<div class="button">
   <button class="raise" id="bWrite" type="button">작성</button>
</div>   
      
</form>   

<script>
   var title = document.getElementById("title");
   var bWrite = document.getElementById("bWrite");
   
   function resize(obj) {
        obj.style.height = "1px";
        obj.style.height = (12+obj.scrollHeight)+"px";   
   }
   
   bWrite.addEventListener('click', function(event){
	  if(title.value.trim() != ""){
		  document.getElementById("f").submit();
	  } else{
		  alert("제목을 입력하세요.");
	  }
   });
   
   
</script>


</body>
</html>