<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
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
      <c:if test="${member != null }">
         <%@ include file="../include/navLogin.jsp"%>
      </c:if>
      <c:if test="${member == null }">
         <%@ include file="../include/navLogout.jsp"%>
      </c:if>
</div>
</div>

<form method="post" id="f" enctype="multipart/form-data">
<div class="main">

   <div id="top">
      <input type="hidden" name="bno" value="${view.bno }" />
      <p>제목     <input type="text" id="title" name="title" value="${view.title }"/></p>
      <p>작성자  <input type="text" name="writer" value="${view.writer }" readOnly/></p>
      <br/>
   </div>
   
   <div class="button-wrapper">
      <p>이미지
           <span class="label">
             내 라이브러리
           </span>
             <input type="file" name="filesList" id="input_imgs" class="upload-box" placeholder="Upload File"accept=".jpg, .jpeg" multiple/></p>
   </div>
   
   <div id="text">
   <p>이미지는 최대 50개까지 선택 가능합니다.</p>
   </div>
   
   
   <c:forEach items="${list }" var="list">
     <input type="hidden" name="id" value="${list.id }" />
      
      <div id="middle">
      
         <div id="left">
            <img width="100" height="100" alt="" src="<spring:url value='${list.path }'/>"><br>
         </div>         

         
         <div id="right">
            <div id="one">
               <input type="text" id="lat${list.id }" name="lat" value="${list.latitude }"/>
               <input type="text" id="lon${list.id }" name="lon" value="${list.longitude }"/>
               <input type="text" id="time${list.id }" name="time" value="${list.timeView }"/>
            </div>
            
            <div id="two">
               <textarea cols="50" rows="5" name="content" >${list.content  }</textarea>
            </div>   
                                 
            <div id="three">
               <input type="checkbox" id="${list.id }s" name="${list.id }" value="s" />버스
                  <input type="checkbox" id="${list.id }b" name="${list.id }" value="b" />지하철
                  <input type="checkbox" id="${list.id }w" name="${list.id }" value="w" />자가용
         
            </div>
   

         </div>
         
         <div class="down">
            <input type="checkbox" id="del${list.id }" name="del" value="${list.id }">삭제
         </div>
      </div>
      
   </c:forEach>
   
   <div id="bottom">
            <input type="radio" id="pNum0" name="pNum" value="0" /> 전체공개
            <input type="radio" id="pNum1" name="pNum" value="1" /> 이웃공개
            <input type="radio" id="pNum2" name="pNum" value="2" /> 비공개
   </div>
   
</div>

<div class="button">
   <button class="raise" id="bWrite" type="button">완료</button>
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
			for (i = 0; i < listID.length; i++) {
				lat.push(document.getElementById("lat" + listID[i]));
				lon.push(document.getElementById("lon" + listID[i]));
				time.push(document.getElementById("time" + listID[i]));
				for (j = 0; j < tp.length; j++) {
					if (listID[i] == tpBno[j]) {
						var checktp = listID[i] + tp[j];
						document.getElementById(checktp).checked = true;
					}
				}
			}
			latLon();
			Time();
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
		switch(pNum){
		case 0:
			pNum0.checked = true;
			break;
		case 1:
			pNum1.checked = true;
			break;
		case 2:
			pNum2.checked = true;
			break;
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
		});
		
		function resize(obj) {
			obj.style.height = "1px";
			obj.style.height = (12 + obj.scrollHeight) + "px";
		}
		
		
		
	</script>


</body>
</html>