<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/modify.js?var=2"></script>
<meta charset="UTF-8">
<title>게시물 수정</title>
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
       <a href="/board/listPageSearch?num=1">SAMPLE</a>
     </div>
     
     <!-- 검색창 -->
   <div class="wrap">
         <div class="search">
            <input type="text" class="searchTerm" placeholder="어떤 곳을 찾으시나요?">
            <button type="submit" class="searchButton">
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


<form method="post" id="f" enctype="multipart/form-data">
<div class="main">

   <div id="top">
      <input type="hidden" id="bno" name="bno" value="${view.bno }" />
      <p>제목     <input type="text" id="title" name="title" value="${view.title }"/></p>
      <input type="hidden" id="userID" name="writer" value="${session.id }" />
      <p>작성자  <input type="text" value="${session.mNickname }" readOnly/></p>
      <br/>
   </div>
   
   <div class="button-wrapper">
      <p>이미지
           <span class="label">
             내 라이브러리
           </span>
             <input type="file" name="imgList" id="input_imgs" class="upload-box" placeholder="Upload File"accept=".jpg, .jpeg" multiple/></p>
   </div>
   
   <div id="text">
   <p>이미지는 최대 50개까지 선택 가능합니다.</p>
   </div>
   
   
   <c:forEach items="${list }" var="list" varStatus="status">
     <input type="hidden" id="id_${status.index }" name="id" value="${list.id }" />
      
      <div class="middle" id="middle_${status.index }" name="imgDiv">
      
         <div class="left">
            <img width="100" height="100" alt="" onclick="del(${status.index })" id="img_${status.index }" name="filesList" src="<spring:url value='${list.path }'/>">
         </div>         

         <div class="right">
            <div class="one">
               <input type="text" id="lat_${status.index }" name="lat" value="${list.latitude }"/>
               <input type="text" id="lon_${status.index }" name="lon" value="${list.longitude }"/>
               <input type="text" id="time_${status.index }" name="time" value="${list.timeView }"/>
            </div>
            
            <div class="two">
               <textarea style="width:90%" cols="50" rows="5" id="textarea_${status.index }" name="content" >${list.content  }</textarea>
            </div>   
                                 
            <div class="three">
            <div class="t-1"></div>
                <div class="t-2" id="tp_${status.index }" >
                     <input type="checkbox" id="sneakers_${status.index }" name="tp" value="sneakers" /><label><img src="/resources/imgs/sneakers.png"></label>
                     <input type="checkbox" id="bus_${status.index }" name="tp" value="bus" /><label><img src="/resources/imgs/bus.png"></label>
                     <input type="checkbox" id="train_${status.index }" name="tp" value="train" /><label><img src="/resources/imgs/train.png"></label>
                     <br>
                     <input type="checkbox" id="car_${status.index }" name="tp" value="car" /><label><img src="/resources/imgs/car.png"></label>
                      <input type="checkbox" id="taxi_${status.index }" name="tp" value="taxi" /><label><img src="/resources/imgs/taxi.png"></label>
                     <input type="checkbox" id="bike_${status.index }" name="tp" value="bike" /><label><img src="/resources/imgs/bike.png"></label>
                     <input type="checkbox" id="scooter_${status.index }" name="tp" value="scooter" /><label><img src="/resources/imgs/scooter.png"></label>
               </div>

            </div>
         
          </div>
      </div>
      
   </c:forEach>
   
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
   <button class="raise" id="bModify" type="button">완료</button>
   <button class="raise" id="bImgUpload" type="button">이미지 업로드</button>
</div>   

</form>



   <script>
   
      var regTypeLat = /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)$/;
      var regTypeLon = /^[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/; 
      var regTypeTime = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])\s([1-9]|[01][0-9]|2[0-3]):([0-5][0-9])$/;
      
      var pNum = ${view.pNum }
      var title = document.getElementById("title");
      var pNum0 = document.getElementById("pNum0");
      var pNum1 = document.getElementById("pNum1");
      var pNum2 = document.getElementById("pNum2");
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
    /*   function latLon(){
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
      } */
      switch(pNum){
      case -1:
         pNum0.checked = true;
         break;
      case -2:
         pNum1.checked = true;
         break;
      default:
         pNum2.checked = true;
         break;
      }

     /*  bWrite.addEventListener('click', function(event) {
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


</body>
</html>