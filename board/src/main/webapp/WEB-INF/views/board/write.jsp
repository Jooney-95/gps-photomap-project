<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/write.js?var=2"></script>
<meta charset="UTF-8">

<title>게시물 작성</title>
<link rel="stylesheet" href="/resources/css/write.css">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
</head>


<body>

<div id="header">
   <!-- 로고 -->
     <div class="logo">
        <a href="/board/listPageSearch?num=1">SAMPLE</a>
     </div>
     
<!-- 검색창 -->
<div class="wrap">
   <div class="search">
   <select name="searchType">
   			<option value="title">제목</option>
            <option value="writer">작성자</option>           
         </select>
        <input type="text" class="searchTerm" name="keyword" placeholder="어떤 곳을 찾으시나요?">
        <button type="button" class="searchButton" id="searchBtn">
           <i class="fa fa-search"></i>
        </button>
    </div>
</div>

   
     <!-- 사용자 로그인 현황 -->
      <div class="log">
            <c:if test="${session != null }"> <!-- 로그인했을때 -->

               <div id="r">
               <div class="profile">
                   <a href="/member/myPage?num=1&userID=${session.id }"><img src="${session.mImg }"/>
                    </a>
                    <p>${session.mNickname } 님</p>
                  </div>       
               </div>             

            </c:if>
            
            <c:if test="${session == null }"> <!-- 로그인 안했을때 -->
                <a href="/member/login"><img width="50" height="50" src="/resources/imgs/p1.png"></a>
            </c:if>
      </div>

</div>


<form method="post" id="f" enctype="multipart/form-data" >   
<div class="main">

      <div id="top">
         <p>제목     <input type="text" id="title" name="title" placeholder="제목을 입력하세요."/></p>
         <input type="hidden" id="userID" name="writer" value="${session.id }" />
          <p>작성자  <input type="text" value="${session.mNickname }" readOnly /></p>
      </div>
      
      <div class="button-wrapper">
           <p>이미지
           <span class="label">
             내 라이브러리
           </span>
             <input type="file" id="input_imgs" name="imgList" class="upload-box" placeholder="Upload File" accept=".jpg, .jpeg" multiple/></p>
      </div>
      
      <div id="text">
      <p>이미지는 최대 50개까지 선택 가능합니다.</p>
      </div>
      
      <div class="middle">
          <div class="img_box"></div>
      </div>
      
      <div id="bottom">
         공개 범위 
         <input type="radio" name="pNum" value="-1" checked="checked">  전체공개
         <input type="radio" name="pNum" value="-2">  비공개
         <input type="radio" name="pNum" value="${session.id }">  맞팔공개
      </div>   
      
</div>
      
<div class="button">
   <button class="raise" id="bWrite" type="button">작성</button>
   <button class="raise" id="bImgUpload" type="button">이미지 업로드</button>
</div>   
      
</form>   

<script>
   function resize(obj) {
        obj.style.height = "1px";
        obj.style.height = (12+obj.scrollHeight)+"px";   
   }

</script>


</body>
</html>