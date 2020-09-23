<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd9fb87d40ab9678af574d3665e02b6e&libraries=services,clusterer"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/modify.js?var=3"></script>
<meta charset="UTF-8">
<title>Plus+</title>
<link rel="stylesheet" href="/resources/css/modify.css">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
</head>
<body>
<c:if test="${session.id ne view.writer }">
   <script>
      alert("권한이 없습니다.");
      window.history.back();
   </script>
</c:if>

<!-- 상단 바 -->
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
            <c:if test="${session != null }">
            <!-- 로그인했을때 -->
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
            
            <c:if test="${session == null }"> 
            <!-- 로그인 안했을때 -->
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


<form method="post" id="f" enctype="multipart/form-data">
<div class="main">

   <div id="top">
      <input type="hidden" id="bno" name="bno" value="${view.bno }" />
      <p>제목     <input type="text" id="title" name="title" value="${view.title }"/></p>
      <input type="hidden" id="userID" name="writer" value="${session.id }" />
       <br/>
   </div>
   
   <div class="button-wrapper">
      <p>이미지
           <span class="label">
             <input type="file" name="imgList" id="input_imgs" class="upload-box" placeholder="Upload File"accept=".jpg, .jpeg" multiple/>
              내 라이브러리
           </span>
      </p>       
   </div>
   
   <div id="text">
   <p>이미지는 최대 50개까지 선택 가능합니다.</p>
   </div>
   
   
   <div class="img_box"></div>      
      
   <div class="bottom">
 <div id="bottom1">
         공개 범위 
        <label><input type="radio" id="pNum0" name="pNum" value="-1">  전체공개</label> 
         <label><input type="radio" id="pNum1" name="pNum" value="${session.id }">  이웃공개</label>
         <label><input type="radio" id="pNum2" name="pNum" value="-2">  비공개</label>
 </div>   
 <div id="bottom2" >
  
    <div class="category" onclick="menu()">
    
      <label>카테고리 <i class="fas fa-angle-down"></i></label>
    </div>
    <div class="hide" style="display:none">
      <input type="hidden" id="kate" value="${view.kate}">
    <div class="list">
     	<ul>
             <li>
             <input type="radio" id="none" name="kategorie" value="" checked>
             <label for="none">카테고리 설정 안함</label>
             </li>
             
             <li>
                <span>테마별</span>
                   <input type="radio" id="a1" name="kategorie" value="a1">
                   <label for="a1">피크닉</label>
                   <input type="radio" id="b1" name="kategorie" value="b1">
                   <label for="b1">전시회</label>
                   <input type="radio" id="c1" name="kategorie" value="c1">
                   <label for="c1">박물관</label>
                   <input type="radio" id="d1" name="kategorie" value="d1">
                   <label for="d1">맛집투어</label>
                   <input type="radio" id="e1" name="kategorie" value="e1">
                   <label for="e1">사진명소</label>
                   <input type="radio" id="f1" name="kategorie" value="f1">
                   <label for="f1">드라이브</label>
                   <input type="radio" id="g1" name="kategorie" value="g1">
                   <label for="g1">데이트</label>
                   <input type="radio" id="h1" name="kategorie" value="h1">
                   <label for="h1">등산</label>
                   <input type="radio" id="i1" name="kategorie" value="i1">
                   <label for="i1">바다</label>
                   <input type="radio" id="j1" name="kategorie" value="j1">
                   <label for="j">강</label>
                   <input type="radio" id="k1" name="kategorie" value="k1">
                   <label for="k1">낚시</label>
                   <input type="radio" id="l1" name="kategorie" value="l1">
                   <label for="l1">액티비티</label>
                   <input type="radio" id="m1" name="kategorie" value="m1">
                   <label for="m1">호캉스</label>
             </li>
             
             <li>
                <span>지역별</span>
                   <input type="radio" id="a2" name="kategorie" value="a2">
                   <label for="a2">서울특별시</label>
                   <input type="radio" id="b2" name="kategorie" value="b2">
                   <label for="b2">경기도</label>
                   <input type="radio" id="c2" name="kategorie" value="c2">
                   <label for="c2">인천광역시</label>
                   <input type="radio" id="d2" name="kategorie" value="d2">
                   <label for="d2">강원도</label>
                   <input type="radio" id="e2" name="kategorie" value="e2">
                   <label for="e2">대구광역시</label>
                   <input type="radio" id="f2" name="kategorie" value="f2">
                   <label for="f2">경상북도</label>
                   <input type="radio" id="g2" name="kategorie" value="g2">
                   <label for="g2">부산광역시</label>
                   <input type="radio" id="h2" name="kategorie" value="h2">
                   <label for="h2">울산광역시</label>
                   <input type="radio" id="i2" name="kategorie" value="i2">
                   <label for="i2">경상남도</label>
                   <input type="radio" id="j2" name="kategorie" value="j2">
                   <label for="j2">충청북도</label>
                   <input type="radio" id="k2" name="kategorie" value="k2">
                   <label for="k2">세종특별자치시</label>
                   <input type="radio" id="l2" name="kategorie" value="l2">
                   <label for="l2">대전광역시</label>
                   <input type="radio" id="m2" name="kategorie" value="m2">
                   <label for="m2">충청남도</label>
                   <input type="radio" id="n2" name="kategorie" value="n2">
                   <label for="n2">전라북도</label>
                   <input type="radio" id="o2" name="kategorie" value="o2">
                   <label for="o2">광주광역시</label>
                   <input type="radio" id="p2" name="kategorie" value="p2">
                   <label for="p2">전라남도</label>
                   <input type="radio" id="q2" name="kategorie" value="q2">
                   <label for="q2">제주특별시</label>
             </li>
             
             <li>
                <span>모임/단체별</span>
                   <input type="radio" id="a3" name="kategorie" value="a3">
                   <label for="a3">가족</label>
                   <input type="radio" id="b3" name="kategorie" value="b3">
                   <label for="b3">연인</label>
                   <input type="radio" id="c3" name="kategorie" value="c3">
                   <label for="c3">친구</label>
                   <input type="radio" id="d3" name="kategorie" value="d3">
                   <label for="d3">대학교</label>
                   <input type="radio" id="e3" name="kategorie" value="e3">
                   <label for="e3">동아리</label>
                   <input type="radio" id="f3" name="kategorie" value="f3">
                   <label for="f3">동호회</label>
                   <input type="radio" id="g3" name="kategorie" value="g3">
                   <label for="g3">회사</label>
             </li>
        </ul>
    </div>  
    
    
    </div>
       
 </div> 
 </div> 
</div>

   <div class=button>
    
   <div class="upload" >
   <button class="raise" id="bModify" type="button">작성</button>
</div>   
      </div>

</form>




   <script>
   
   var pNum0 = document.getElementById("pNum0");
   var pNum1 = document.getElementById("pNum1");
   var pNum2 = document.getElementById("pNum2");
   var pNum = ${view.pNum };
   
   switch(pNum){
      case -1:
          pNum0.checked = "checked";
          break;
       case -2:
          pNum2.checked = "checked";
          break;
       default:
          pNum1.checked = "checked";
          break;
       }
   /* var regTypeLat = /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)$/;
      var regTypeLon = /^[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/; 
      var regTypeTime = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])\s([1-9]|[01][0-9]|2[0-3]):([0-5][0-9])$/;
      
      
      var title = document.getElementById("title");
      
      var bWrite = document.getElementById("bWrite");
      
      var lat = new Array();
      var lon = new Array();
      var time = new Array();
      var tpBno = new Array();
      var tp = new Array();
      var listID = new Array();

      <c:forEach items="${list }" var="list">
      listID.push("${list.id}");
      </c:forEach>
      
      <c:forEach items="${tp }" var="tp">
      tpBno.push("${tp.tpBno }");
      tp.push("${tp.tp }");
      </c:forEach>
      
      window.onload = function forListID(){
         for (var i = 0; i < listID.length; i++) {
            lat.push(document.getElementById("lat_" + [i]));
            lon.push(document.getElementById("lon_" + [i]));
            time.push(document.getElementById("time_" + [i]));
            for (var j = 0; j < tp.length; j++) {
               if (listID[i] == tpBno[j]) {
                  var checktp = tp[j]+"_"+[i];
                  document.getElementById(checktp).checked = true;
               }
            }
         }
      }
       function latLon(){
         for(i=0;i<lat.length;i++){
            if(regTypeLat.test(lat[i].value)){
               if(regTypeLon.test(lon[i].value)){
                  
               } else{
                  lon[i].focus();
                  return false;
               }
            } else{
               lat[i].focus();
               return false;
            }
         }
         return true;
      }
      function Time(){
         for(i=0;i<time.length;i++){
            if(regTypeTime.test(time[i].value)){
               
            } else{
               time[i].focus();
               return false;
            }
         }
         return true;
      } 
      
      

       bWrite.addEventListener('click', function(event) {
         if(latLon()){
            if(Time()){
               if (title.value.trim() != "") {
                  document.getElementById("f").submit();
               } else {
                  alert("제목을 입력하세요.");
               }
            }
         }
      }); */
      
      function resize(obj) {
         obj.style.height = "1px";
         obj.style.height = (12 + obj.scrollHeight) + "px";
      }
      
    
      
   </script>
<script>
    // html dom 이 다 로딩된 후 실행된다.
    $(document).ready(function(){
        // category 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".category>a").click(function(){
            var submenu = $(this).next("ul");
 
            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
    });
</script>






</body>
</html>