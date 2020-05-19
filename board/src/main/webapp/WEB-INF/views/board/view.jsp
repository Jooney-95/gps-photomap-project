<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 조회</title>
</head>
<body>
	<div id="nav">
		<%@ include file="../include/nav.jsp"%>
	</div>
	<label>제목</label> ${view.title}
	<br />

	<label>작성자</label> ${view.writer}
	<br />

	<label>내용</label>
	<br /> ${view.content}<br>
	<c:forEach items="${list }" var="list">
		<img width="100" height="100" alt="" src="<spring:url value='${list.path }'/>"><br>
		<input type="hidden" name="id" value="${list.id }" />
		<input type="text" name="lat" value="${list.latitude }"/><br>
		<input type="text" name="lon" value="${list.longitude }"/><br>
		<input type="text" name="time" value="${list.timeView }"/><br>
	</c:forEach>
	<br />
	<div>
		<a href="/board/modify?bno=${view.bno}">게시물 수정</a> <a
			href="/board/delete?bno=${view.bno}">게시물 삭제</a>
	</div>
	<!-- 카카오맵 api 호출 -->
   <div id="map" style="width:500px;height:400px;"></div> 
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd9fb87d40ab9678af574d3665e02b6e"></script>
   <script>
      
      //위도값  배열에 저장
      var lat = new Array();
      var lon = new Array();
      <c:forEach items="${list }" var="list">
      lat.push("${list.latitude}");
      lon.push("${list.longitude}");
      </c:forEach>
      
      
      
      
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = { 
           center: new kakao.maps.LatLng(parseFloat(lat[0]), parseFloat(lon[0])), // 지도의 중심좌표
           level: 11 // 지도의 확대 레벨
       };
      
      var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
      
      
      var positions = []; // 위치정보들을 담는 객체 배열 생성 - 안에서 객체들 반복문 돌려 사진업로드 갯수만큼 저장해야한다.
         
      for (var i=0; i<lat.length; i++) {
         positions.push(new kakao.maps.LatLng(parseFloat(lat[i]), parseFloat(lon[i])));
      }
         
      
      
      // 마커가 표시될 위치입니다 
      //var markerPosition = new kakao.maps.LatLng(parseFloat(latitude[0]), parseFloat(longitude[0])); 
      
      
      for (var i=0; i<positions.length; i++) { // 저장된 위치 갯수만큼 다중 마커로 표시
         
         // 마커를 생성합니다
         var marker = new kakao.maps.Marker({
             map: map, // 마커를 표시할 지도
            position: positions[i] // 마커를 표시할 위치
             
         });
      }
      
      // 마커가 지도 위에 표시되도록 설정합니다
      marker.setMap(map);
      
      // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
      // marker.setMap(null);
   </script>
</body>
</html>
