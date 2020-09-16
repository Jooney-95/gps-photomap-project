<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd9fb87d40ab9678af574d3665e02b6e&libraries=services,clusterer"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/write.js?var=2"></script>

<meta charset="UTF-8">

<title>Plus+</title>
<link rel="stylesheet" href="/resources/css/write.css">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
</head>


<body>

<div id="header">
   <!-- 로고 -->
     <div class="logo">
        <a href="/board/main">Plus+</a>
     </div>
     
<!-- 검색창 -->
<div class="wrap">
   <div class="search">
   <select class="ss" name="searchType">
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
                    <img src="${session.mImg }" onclick="loginPopup()"/>
             </div>
                  <p id="sessionNickname">${session.mNickname }</p>
            </div>

            <div id="alam">
               <i class="fas fa-bell" onclick="alamPopup()"></i>
            </div>

            </c:if>
            
            <c:if test="${session == null }"> <!-- 로그인 안했을때 -->
                <a href="/member/login"><img width="50" height="50" src="/resources/imgs/p1.png"></a>
            </c:if>
      </div>
            <div class="pop" id="loginPopup" style="display:none">               
                <div class="pi"><a href="/member/myPage?num=1&userID=${session.id }"><i class="fas fa-user-cog"></i>  마이페이지</a></div>
                <div class="pii"><a href="/member/logout"><i class="fas fa-power-off"></i>  로그아웃</a></div>
            </div>
            
            <div class="apop" id="alamPopup" style="display:none">               
                <div class="ai"> <a>알람 내용</a></div>
            </div>

</div>
   

<form method="post" id="f" enctype="multipart/form-data" >   
<div class="main">
      <div id="top">
         <p>제목     <input type="text" id="title" name="title" placeholder="제목을 입력하세요."/></p>
         <input type="hidden" id="userID" name="writer" value="${session.id }" />
         <div id="loading" style="display: none;">
            <p >이미지 업로드중</p>
            <i class="fa fa-spinner fa-pulse fa-fw"></i> 
         </div>
      </div>
      
      <div class="button-wrapper">
           <p>이미지
           <span class="label">
       <input type="file" id="input_imgs" name="imgList" class="upload-box" placeholder="Upload File" accept=".jpg, .jpeg" multiple/>      
             내 라이브러리
           </span>
             </p>
      </div>
      
      <div id="text">
      <p>이미지는 최대 50개까지 선택 가능합니다.</p>
      </div>
      
      

      <div class="img_box"><div class="m" ></div></div>
      
      <div id="bottom">
       <div id="bottom1">
                    공개 범위 
             <label><input type="radio" name="pNum" value="-1" checked="checked">  전체공개</label>
             <label><input type="radio" name="pNum" value="${session.id }">  이웃공개</label>
             <label><input type="radio" name="pNum" value="-2">  비공개</label>
       </div>
       <div id="bottom2" >
           <div class="category" onclick="menu()">
    
             <label>카테고리 <i class="fas fa-angle-down"></i></label>
           </div>
           <div class="hide" style="display:none">
           <div class="list">
            <ul>
             <li>
              <label><input type="radio" >카테고리는</label>
             </li>
             <li>
              <label><input type="radio">어떤것을</label>
             </li>
             <li>
              <label><input type="radio">넣어야</label>
             </li>
             <li>
              <label><input type="radio">할까유</label>
             </li>
             </ul>  
           </div>  
    
           <div class="list">
              <ul>
                 <li>
                    <label><input type="radio" >카테고리는</label>
                 </li>
                 <li>
                    <label><input type="radio">어떤것을</label>
                 </li>
                 <li>
                    <label><input type="radio">넣어야</label>
                 </li>
                 <li>
                    <label><input type="radio">할까유</label>
                 </li>
             </ul>  
          </div>  
           <div class="list">
              <ul>
                 <li>
                    <label><input type="radio" >카테고리는</label>
                 </li>
                 <li>
                    <label><input type="radio">어떤것을</label>
                 </li>
                 <li>
                    <label><input type="radio">넣어야</label>
                 </li>
                 <li>
                    <label><input type="radio">할까유</label>
                 </li>
             </ul>  
          </div>      
   
    </div>
      </div> 
 </div> 
 </div> 
     
      
      <div class=button>
      
       <div class="upload" >
        <button class="raise" id="bWrite" type="button">작성</button>
</div>   
      </div>
</form>   

 <!-- 카카오맵 api 호출 -->
   <div id="map" style="display:none"></div>

<script>
   function resize(obj) {
        obj.style.height = "1px";
        obj.style.height = (12+obj.scrollHeight)+"px";   
   }

</script>

<script>
$(function(){
   $('.left').bind('load',fitImgFrameSize);
});

function fitImgFrameSize(e){
   var frWidth=$(this).closet('.left').width();
   var frHeight=$(this).closet('.left').height();
   var frRatio=frWidth/frHeight;
   var ntWidth=$(this).get(0).naturalWidth;
   var ntHeight=$(this).get(0).naturalHeight;
   var ntRatio=ntWidth/ntHeight;
   if(ntRatio > frRatio){//더 납작하면
   $(this).css({'width':'100%','height':'auto'});   
   var vwHeight = frWidth/ntWidth*ntHeight;
   var paddingTop = (frHeight - vwHeight)/2.0;
   consol.lof('+++ ntRatio > frRatio : vwHeight,paddingTop',vwHeight,paddingTop);
   $(this).css({'width':'auto','height':'100%,'});
   $(this).closet('.left').css({'text-aligh':'center'});
   }
}
</script>


</body>
</html>