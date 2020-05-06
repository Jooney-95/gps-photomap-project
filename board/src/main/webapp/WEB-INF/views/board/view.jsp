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

	<label>내용</label> ${view.content}
	<br />
	
	<c:forEach items="${list }" var="list">
	      <img width="500" height="500" alt="" src="<spring:url value='${list.path }'/>"><br> <!-- 이미지 출력-->
	      <input type="hidden" name="id" value="${list.id }" />
	      <input type="text" name="latitude" value="${list.latitude }"/><br> <!-- 위도 위치정보 추출-->
	      <input type="text" name="longitude" value="${list.longitude }"/><br> <!-- 경도 위치정보 추출-->
	      <input type="text" name="time" value="${list.timeView }"/><br> <!-- 시간정보 추출-->
   	</c:forEach>
	<br />
	
	<!-- 카카오맵 api 호출 -->
	<div id="map" style="width:500px;height:400px;"></div> 
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd9fb87d40ab9678af574d3665e02b6e"></script>
	<script>
		
		//위도값  배열에 저장
		var latitude = new Array(); 
		<c:forEach items="${list }" var="list">
		latitude.push("${list.latitude}");
		</c:forEach>
		
		// 경도값 배열에 저장
		var longitude = new Array(); 
		<c:forEach items="${list }" var="list">
		longitude.push("${list.longitude}");
		</c:forEach>
		
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(parseFloat(latitude[0]), parseFloat(longitude[0])), // 지도의 중심좌표
	        level: 11 // 지도의 확대 레벨
	    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		
		var positions = []; // 위치정보들을 담는 객체 배열 생성 - 안에서 객체들 반복문 돌려 사진업로드 갯수만큼 저장해야한다.
			
			for (var i=0; i<latitude.length; i++) {
				positions.push(new kakao.maps.LatLng(parseFloat(latitude[i]), parseFloat(longitude[i])));
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
	
	<div>
		<a href="/board/modify?bno=${view.bno}">게시물 수정</a> <a
			href="/board/delete?bno=${view.bno}">게시물 삭제</a>
	</div>
</body>
</html>
