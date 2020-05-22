<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	
   <!-- 카카오맵 api 호출 -->
   <div id="map" style="width:500px;height:400px;"></div> 
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd9fb87d40ab9678af574d3665e02b6e&libraries=clusterer"></script>
   <script>
      
      //위도, 경도값  배열에 저장
      var lat = new Array();
      var lon = new Array();
      <c:forEach items="${list }" var="list">
      lat.push("${list.latitude}");
      lon.push("${list.longitude}");
      </c:forEach>
      
      var MARKER_WIDTH = 36, // 기본, 클릭 마커의 너비
	      MARKER_HEIGHT = 37, // 기본, 클릭 마커의 높이
	      OFFSET_X = 13, // 기본, 클릭 마커의 기준 X좌표
	      OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
	      SPRITE_MARKER_URL = '${Path}/resources/imgs/markers.png', // 스프라이트 마커 이미지 URL
	      SPRITE_WIDTH = 44, // 스프라이트 이미지 너비
	      SPRITE_HEIGHT = 2254, // 스프라이트 이미지 높이
	      SPRITE_GAP = 9.1; // 스프라이트 이미지에서 마커간 간격

	  var markerSize = new kakao.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
	      markerOffset = new kakao.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
	      spriteImageSize = new kakao.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기
      
	  var positions = [], // 위치정보들을 담는 객체 배열 생성 - 안에서 객체들 반복문 돌려 사진업로드 갯수만큼 저장해야한다.
	  selectedMarker = null; // 클릭한 마커를 담을 변수
	   
	         
	  for (var i=0; i<lat.length; i++) { // 위도값갯수만큼(위도와 경도는 같이 포함되기에 위도갯수만 체크해도 됨) 마커에 위도, 경도값을 저장한다
	  	positions.push(new kakao.maps.LatLng(parseFloat(lat[i]), parseFloat(lon[i])));
	  }

      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = { 
           center: new kakao.maps.LatLng(parseFloat(lat[0]), parseFloat(lon[0])), // 지도의 중심좌표
           level: 11 // 지도의 확대 레벨
       };
      
      var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
        
    
  	  // 지도 위에 마커를 표시합니다
      for (var i = 0, len = positions.length; i < len; i++) {
          var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
              originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
              normalOrigin = new kakao.maps.Point(0, originY); // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
              
              
          // 마커를 생성하고 지도위에 표시합니다
          addMarker(positions[i], normalOrigin);
      }

      // 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
      function addMarker(position, normalOrigin) {

          // 기본 마커이미지, 오버 마커이미지, 클릭 마커이미지를 생성합니다
          var normalImage = createMarkerImage(markerSize, markerOffset, normalOrigin);
              

          //for(var i=0; i<positions.length; i++) { // 등록된 이미지 개수만큼 마커를 표시한다.
	          // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
	          var marker = new kakao.maps.Marker({
	              map: map,
	              position: positions[i],
	              image: normalImage
	          });
        //  }	
          // 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
          marker.normalImage = normalImage;

/*        // 마커에 mouseover 이벤트를 등록합니다
          kakao.maps.event.addListener(marker, 'mouseover', function() {

              // 클릭된 마커가 없고, mouseover된 마커가 클릭된 마커가 아니면
              // 마커의 이미지를 오버 이미지로 변경합니다
              if (!selectedMarker || selectedMarker !== marker) {
                  marker.setImage(overImage);
              }
          });

          // 마커에 mouseout 이벤트를 등록합니다
          kakao.maps.event.addListener(marker, 'mouseout', function() {

              // 클릭된 마커가 없고, mouseout된 마커가 클릭된 마커가 아니면
              // 마커의 이미지를 기본 이미지로 변경합니다
              if (!selectedMarker || selectedMarker !== marker) {
                  marker.setImage(clickImage);
              }
          });

          // 마커에 click 이벤트를 등록합니다
          kakao.maps.event.addListener(marker, 'click', function() {

              // 클릭된 마커가 없고, click 마커가 클릭된 마커가 아니면
              // 마커의 이미지를 클릭 이미지로 변경합니다
              if (!selectedMarker || selectedMarker !== marker) {

                  // 클릭된 마커 객체가 null이 아니면
                  // 클릭된 마커의 이미지를 기본 이미지로 변경하고
                  !!selectedMarker && selectedMarker.setImage(selectedMarker.normalImage);

                  // 현재 클릭된 마커의 이미지는 클릭 이미지로 변경합니다
                  marker.setImage(clickImage);
              }

              // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
              selectedMarker = marker;
          });
*/
      }

      // MakrerImage 객체를 생성하여 반환하는 함수입니다
      function createMarkerImage(markerSize, offset, spriteOrigin) {
          var markerImage = new kakao.maps.MarkerImage(
              SPRITE_MARKER_URL, // 스프라이트 마커 이미지 URL
              markerSize, // 마커의 크기
              {
                  offset: offset, // 마커 이미지에서의 기준 좌표
                  spriteOrigin: spriteOrigin, // 스트라이프 이미지 중 사용할 영역의 좌상단 좌표
                  spriteSize: spriteImageSize // 스프라이트 이미지의 크기
              }
          );
          
          return markerImage;
      }
      
      // 마커가 지도 위에 표시되도록 설정합니다
      //marker.setMap(map);
      
      // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
      // marker.setMap(null);
   </script>
	
	
	
	
	<div>
		<a href="/board/modify?bno=${view.bno}">게시물 수정</a> <a
			href="/board/delete?bno=${view.bno}">게시물 삭제</a>
	</div>
</body>
</html>
