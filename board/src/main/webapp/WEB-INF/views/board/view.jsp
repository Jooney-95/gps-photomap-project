<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 조회</title>
<style>
  
</style>
</head>
<body>
   <div id="nav">
      <%@ include file="./nav.jsp"%>
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
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd9fb87d40ab9678af574d3665e02b6e&libraries=services,clusterer"></script>
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
         SPRITE_MARKER_URL = '/resources/imgs/markers.png', // 스프라이트 마커 이미지 URL
         SPRITE_WIDTH = 44, // 스프라이트 이미지 너비
         SPRITE_HEIGHT = 2254, // 스프라이트 이미지 높이
         SPRITE_GAP = 9.1; // 스프라이트 이미지에서 마커간 간격

     var markerSize = new kakao.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
         markerOffset = new kakao.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
         spriteImageSize = new kakao.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기





     var positions = [], // 위치정보들을 담는 객체 배열 생성 - 안에서 객체들 반복문 돌려 사진업로드 갯수만큼 저장해야한다.
		 iwContents = []; // 인포윈도우에 출력할 주소값을 담는 배열 생성
     //selectedMarker = null; // 클릭한 마커를 담을 변수

     
      
     // 위도값갯수만큼(위도와 경도는 같이 포함되기에 위도갯수만 체크해도 됨) 마커에 위도, 경도값을 저장한다       
     for (var i=0; i<lat.length; i++) { 
        positions.push(new kakao.maps.LatLng(parseFloat(lat[i]), parseFloat(lon[i])));
     }

     // 주소-좌표 변환 객체를 생성합니다
     var geocoder = new kakao.maps.services.Geocoder();
   	 // 변환된 주소를 저장합니다
   	 var address = [];
   	 address[0] = "test";
   	 // 이미지의 위도경도 좌표값을 좌표값과 일치하는 주소 정보로 변환한다. 
     for (var i=0; i<positions.length; i++) { 
     	var coord = new kakao.maps.LatLng(parseFloat(lat[i]), parseFloat(lon[i]));
        var callback = function(result, status) {
        	if (status === kakao.maps.services.Status.OK) {
            	address.push('해당 위치의 주소는 ' + result[0].address.address_name + ' 입니다!');
            	iwContents.push('<div style="padding:5px;">'+ address[0] +'</div>');
            }
        };
     	
          		geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
     }    

	 


     
     var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
     	 mapOption = { 
         	center: new kakao.maps.LatLng(parseFloat(lat[0]), parseFloat(lon[0])), // 지도의 중심좌표
           	level: 11 // 지도의 확대 레벨
         };

     //var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
      	  //infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
      	      
      // 지도를 생성합니다
     var map = new kakao.maps.Map(mapContainer, mapOption); 
      
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
         // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
         var marker = new kakao.maps.Marker({ 
             map: map,
             position: positions[i],
             image: normalImage
         });
         // 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
         marker.normalImage = normalImage;
                   
         // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다 - 마우스 오버 이벤트로 인포윈도우 생성하기
         //var iwContent = '<div style="padding:5px;">Hello</div>'; 	
       
	     // 마커에 표시할 인포윈도우를 생성합니다
	     var infowindow = new kakao.maps.InfoWindow({
	         content: address[0] // 인포윈도우에 표시할 내용
	     });
          
         // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
         // 이벤트 리스너로는 클로저를 만들어 등록합니다 
         // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
         kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
         kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
          
      } // addMarker 함수 끝

      // 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
      function makeOverListener(map, marker, infowindow) {
          return function() {
              infowindow.open(map, marker);
          };
      }

      // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
      function makeOutListener(infowindow) {
          return function() {
              infowindow.close();
          };
      }

      /*// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
      kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
          searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
              if (status === kakao.maps.services.Status.OK) {
                  var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
                  detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
                  
                  var content = '<div class="bAddr">' +
                                  '<span class="title">이 장소는?</span>' + 
                                  detailAddr + 
                              '</div>';

                  // 마커를 클릭한 위치에 표시합니다 
                  marker.setPosition(mouseEvent.latLng);
                  marker.setMap(map);                  

                  // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
                  infowindow.setContent(content);
                  infowindow.open(map, marker);
              }   
          });
      });


      function searchAddrFromCoords(coords, callback) {
    	    // 좌표로 행정동 주소 정보를 요청합니다
    	    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
    	}

      function searchDetailAddrFromCoords(coords, callback) {
    	    // 좌표로 법정동 상세 주소 정보를 요청합니다
    	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
    	}*/ // 클릭시 인포윈도우에 주소출력 생성 코드 끝 
	  	
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