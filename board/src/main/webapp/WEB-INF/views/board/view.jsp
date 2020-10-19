<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Plus+</title>
<link rel="stylesheet" href="/resources/css/view.css?var=2">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="/resources/dist/css/lightbox.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/dist/js/lightbox.js"></script>
<script src="/resources/js/view.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@500&display=swap');
#infowindow {
   font-family: 'Noto Serif KR', serif;
}
</style>
</head>


<body>
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
         
            <div id="writebutton">
               <!-- 게시물 작성 버튼-->
               <a href="/board/write" title="게시물 작성"><i class="far fa-edit"></i></a>
            </div>
         </c:if>
         

         <c:if test="${session == null }">
            <!-- 로그인 안했을때 -->
            <div id="rr">
               <a href="/member/login"><img src="/resources/imgs/p1.png"></a>
            </div>
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


<div id="top">
      

<div id="abcd">
      

       <!-- 제목 -->
        <div id="b" >
          <input type="text" name="title" value="${view.title }" readOnly />
        </div>
        
        <div id="acd">
      <!-- 카테고리 -->
      <c:if test="${view.kate != '' }">
      <div id="a">
        <div class="a-a" id="a2"><i class="fas fa-angle-right"></i>
        <input type="hidden" class="kate" value="${view.kate}" />
        <div id="kate"></div>
        </div>
      </div>
      </c:if>
      
      <div id="cd">
        <!-- 저장 -->
         <div id="c">
          <i class="fas fa-bookmark" id="bsave"></i>
         </div>
      
        <!-- 공감버튼 -->
      
         <div id="d">
           <i class="far fa-thumbs-up " id="bLike"></i>
           <p id="like"></p>
         </div>
    </div>
   </div> 

   </div>
    </div>   
     
        
        
       
       
         <div class="time">
         <div class="t">
            <div id="user">
               <a href="/member/myPage?num=1&userID=${member.id }"><img src="${member.mImg }"/></a><!-- 작성자 프로필 이미지 -->
               <input type="text" name="writer" value="${member.mNickname } 님" readOnly />
            </div>
         </div>
         <div class="tt" >
            <div class="time1"><p>조회수  <input type="text" id="viewCnt" value="${view.viewCnt }"/></p></div>
            <div class="time3">
            <input type="text" id="date" value="<fmt:formatDate value='${view.regDate }'  pattern='yyyy-MM-dd hh시 mm분' />"/>
            </div>
            <div class="time2">
            <c:choose>
            <c:when test="${view.pNum eq '-1' }">
                        <i class="fas fa-globe-americas"></i>
                      </c:when>
            <c:when test="${view.pNum eq '-2' }">
                        <i class="fas fa-lock"></i>
                     </c:when>
            <c:otherwise>
                        <i class="fas fa-user-friends"></i>
                    </c:otherwise>
            </c:choose>
            </div>
         </div>
         </div>
       
        <div class="mainwrapper">
         
   <!-- 카카오맵 api 호출 -->
   <div id="aside"  style="width:480px; height:430px; float:left" >
      <div id="map" style="width:480px; height:430px;"></div>
   </div>   

  
  <div class="main">
  <!-- 상단 아이콘 -->
  <div class="type" >
    
      <div class="type1" onclick="imgList(1)">
       <i class="fas fa-th-large" id="gg"></i>
      </div>
      <div class="type2" onclick="imgList(2)">
       <i class="fas fa-list" id="ll"></i>
      </div>
    </div>
    
   
  
 
   
    <div class="gallery">
     <div class="imglist">
      <ul>
       <li>
         <c:forEach items="${list }" var="list">
         <input type="hidden" name="id" value="${list.id }" />
         <input type="hidden" id="tblBno" value="${view.bno }" />
         <input type="hidden" name="userID" value="${session.id }" />
     
      
             <a href="<spring:url value='${list.path }${list.fileName }'/>" title="이미지를 클릭해보세요!" data-lightbox="image-1" data-title="${list.place }"><img alt="" src="<spring:url value='${list.path }square/${list.fileName }'/>"></a>
       
      
         </c:forEach>
         </li>
        </ul>
       </div> 
    </div>
  
   
    
  <div class="original"  style="display:none">
  
   <c:forEach items="${list }" var="list">
         <input type="hidden" name="id" value="${list.id }" />
         <input type="hidden" id="tblBno" value="${view.bno }" />
         <input type="hidden" id="userID" name="userID" value="${session.id }" />
   
   
     <div class="middle">
       <div class="m1">
        <div class="m1-1">
        
      
        <div class="leftone">
                 <i class="fas fa-map-marker-alt"></i> 
                 <input type="text" name="loc" value="${list.place }" readOnly />
                 <input type="hidden" name="lat" value="${list.latitude }" readOnly />
                  <input type="hidden" name="lon" value="${list.longitude }" readOnly />
         </div>
       
        
         <div class="one">
                  <input type="text" name="time" value="${list.timeView }" readOnly />
        </div>
      
         </div>   
         
        
           </div>   
           
          <div class="m2">
             <a href="<spring:url value='${list.path }${list.fileName }'/>" title="이미지를 클릭해보세요!" data-lightbox="image-2" data-title="${list.place }"><img alt="" src="<spring:url value='${list.path }view/${list.fileName }'/>"></a>
           </div>
              
         <!-- 대표이미지 설정 아이콘 --><div class="m3 hidden" id="selectLikeImg_${list.id }">대 표
        </div>
               
              
           <div class="m4">
                     <textarea cols="40" rows="5" name="content" readOnly >${list.content }</textarea>
            </div>                 
             
    
       </div> 
            
               
         </c:forEach>
  
  </div>
</div>
</div>             
               
       

 
  
     <div class="button">
     <c:if test="${session.id eq view.writer }">
       <div id="upload">
         <button type="button" class="raise" onclick="location.href='/board/modify?bno=${view.bno}'">게시물 수정</button>
       </div>
       </c:if>
        <c:if test="${session.id eq view.writer or session.mID eq 'root' }">
       <div id="upload-2">
         <button type="button" id="delBtn" class="raise">게시물 삭제</button>
       </div>
       </c:if>
      </div>   
     
     
   
   
   <!-- 구글지도 테스트 -->
	<div id="map"></div>
	<script>
	
		//위도, 경도값  배열에 저장
		var lat = new Array();
		var lon = new Array();
		
		<c:forEach items="${list }" var="list">
		lat.push("${list.latitude}");
		lon.push("${list.longitude}");
		</c:forEach>	

		var address = {};
		var positions = [];
		let map;
		
	    // 업로드된 이미지만큼 (위도,경도)값을 저장한다       
	    for (var i = 0; i < lat.length; i++) {
	    	var myLatLng = {lat: parseFloat(lat[i]), lng: parseFloat(lon[i])}; 
	        positions.push(myLatLng);
	    }
       	console.log(positions); // 업로드된 위치정보 출력
		
         function initMap() {
			var map = new google.maps.Map(document.getElementById('map'), {
					zoom: 12,
					disableDefaultUI: true, // 기본 컨트롤 비활성
					center: positions[0]
				});

			//var myIcon = new google.maps.MarkerImage("/resources/imgs/markers.png", null, null, null, new google.maps.Size(300,200));
			
			var labels = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50"];

	    	//다중마커 출력(인포윈도우 전용)
			//for (var i = 0; i < positions.length; i++) {  
				//var marker = new google.maps.Marker({
			    	//position: positions[i],
			        //map: map,
			        //label: labels[i % labels.length],
			    //});
			//}
			
			var geocoder = new google.maps.Geocoder();
			
			//다중마커 출력(클러스터 전용)
			var markers = positions.map(function(positions, i) {
				var marker = new google.maps.Marker({
						position: positions,
	            		map: map,
	            		label: labels[i % labels.length],
	         	});
            //좌표-주소변환 함수 호출
            const latlng = {
						lat: parseFloat(lat[i]), 
						lng: parseFloat(lon[i])
            }

            geocodeLatLng(geocoder, map, infowindow, latlng, i);
            var infowindow = new google.maps.InfoWindow();
				//마커 클릭이벤트로 인포윈도우(정보창) 생성
				console.log(address)
         		google.maps.event.addListener(marker, 'click', function(evt) {
             		
         			infowindow.setContent(address[i].substring(5));
	              	infowindow.open(map, marker);
         	    });
                console.log(`마커`)
         	    return marker;
			});//markers 끝
         
			
         

			//마커 클러스터링
			var options = {
				imagePath:"https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m",
				gridSize: 50,
				zoomOnClick: true,
				mzxZoom: 10,
			};
			var markerCluster = new MarkerClusterer(map, markers, options);
			
		

		//주소 변환
       function geocodeLatLng(geocoder, map, infowindow, latlng, index) { 
      
				geocoder.geocode({ location: latlng }, (results, status) => {
               
			          if (status === "OK") {
			            if (results[0]) {
			              	address[index] = results[0].formatted_address;
			              	// console.log(results);
			            } else {
			            	window.alert("No results found");
			              }
			          } else {
			            	window.alert("Geocoder failed due to: " + status);
			            }
			         
			 	});
				
         
		}//주소변환 끝

		}//initmap 끝
		
			
		
    </script>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
	<script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
    <script defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3apcshVnvHMEX7tVXdasnQ4qx3alFMTQ&callback=initMap">
    </script>





   
<%-- 
<!-- 카카오맵 다중마커 정렬 -->
   <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd9fb87d40ab9678af574d3665e02b6e&libraries=services,clusterer"></script>
   <script>
      //위도, 경도값  배열에 저장

      var lat = new Array();
      var lon = new Array();

      <c:forEach items="${list }" var="list">
      lat.push("${list.latitude}");
      lon.push("${list.longitude}");
      </c:forEach>


      var MARKER_WIDTH = 100, // 기본, 클릭 마커의 너비
      MARKER_HEIGHT = 50, // 기본, 클릭 마커의 높이
      OFFSET_X = 46, // 기본, 클릭 마커의 기준 X좌표
      OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
      SPRITE_MARKER_URL = '/resources/imgs/markers.png', // 스프라이트 마커 이미지 URL
      SPRITE_WIDTH = 100, // 스프라이트 이미지 너비
      SPRITE_HEIGHT = 2420, // 스프라이트 이미지 높이, // 스프라이트 이미지 높이
      SPRITE_GAP = -1.7; // 스프라이트 이미지에서 마커간 간격

      var markerSize = new kakao.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
      markerOffset = new kakao.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
      spriteImageSize = new kakao.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기

      // 위치정보들을 담는 객체 배열 생성 - 안에서 객체들 반복문 돌려 사진업로드 갯수만큼 저장해야한다.
      var positions = [];

      // 위도값갯수만큼(위도와 경도는 같이 포함되기에 위도갯수만 체크해도 됨) 마커에 위도, 경도값을 저장한다       
      for (var i = 0; i < lat.length; i++) {
         positions.push(new kakao.maps.LatLng(parseFloat(lat[i]),
               parseFloat(lon[i])));
      }

      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new kakao.maps.services.Geocoder();

      // 변환된 주소를 저장할 배열을 생성합니다
      var address = [];

      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new kakao.maps.LatLng(parseFloat(lat[0]),
               parseFloat(lon[0])), // 지도의 중심좌표는 첫번째 사진을 기준으로 함.
         level : 9
      // 지도의 확대 레벨
      };

      // 지도를 생성합니다
      var map = new kakao.maps.Map(mapContainer, mapOption);

      // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
      var mapTypeControl = new kakao.maps.MapTypeControl();

      // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
      // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

      // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
      var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

      // 마커 클러스터러를 생성합니다 
      var clusterer = new kakao.maps.MarkerClusterer({
         map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
         averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
         minLevel : 10, // 클러스터 할 최소 지도 레벨 
         styles : [ {
            width : '50px',
            height : '50px',
            background : 'rgba(051, 153, 102, .8)',
            borderRadius : '25px',
            color : '#fff',
            textAlign : 'center',
            fontWeight : 'bold',
            lineHeight : '45px',
            fontSize : '30px'
         } ]
      });

      // 이미지의 위도경도 좌표값을 좌표값과 일치하는 주소 정보로 변환합니다
      for (var i = 0; i < positions.length; i++) {
         var coord = new kakao.maps.LatLng(parseFloat(lat[i]),
               parseFloat(lon[i]));
         var callback = function(result, status) {
            if (status === kakao.maps.services.Status.OK) {

               // 클러스터 마커 개수를 초기화한다
               clusterer.clear();

               // 좌표값에 해당하는 구주소와 도로명 주소 정보를 요청합니다
               address.push(result[0].address.address_name);

               // 지도 위에 마커를 표시합니다
               for (var i = 0, len = positions.length; i < len; i++) {
                  var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
                  originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
                  normalOrigin = new kakao.maps.Point(0, originY); // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
                  // 마커를 생성하고 지도위에 표시합니다
                  addMarker(positions[i], normalOrigin);
               }

               // 마커를 생성하고 지도 위에 표시하고 이벤트를 등록하는 함수입니다
               function addMarker(position, normalOrigin) {
                  // 기본 마커이미지를 생성합니다
                  var normalImage = createMarkerImage(markerSize,
                        markerOffset, normalOrigin);

                  // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
                  var marker = new kakao.maps.Marker({
                     map : map,
                     position : positions[i],
                     image : normalImage
                  });

                  // 클러스터러에 마커들을 추가합니다
                  clusterer.addMarker(marker);

                  // 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
                  marker.normalImage = normalImage;

                  // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다 - 마우스 오버 이벤트로 인포윈도우 생성하기
                  var content = '<div id="infowindow" style="width:160px;text-align:center;padding:5px;font-size:12px;">'
                        + address[i] + '</div>';
                  // 현재 write.css 때문에 인포윈도우 화살표 top이 짤려보이는 현상 발생

                  // 마커에 표시할 인포윈도우를 생성합니다
                  var infowindow = new kakao.maps.InfoWindow({
                     content : content
                  // 인포윈도우에 표시할 내용
                  });

                  // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
                  // 이벤트 리스너로는 클로저를 만들어 등록합니다 
                  // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
                  kakao.maps.event.addListener(marker, 'mouseover',
                        makeOverListener(map, marker, infowindow));
                  kakao.maps.event.addListener(marker, 'mouseout',
                        makeOutListener(infowindow));
               } // addMarker 함수 끝

            }
         };
         geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
      }

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

      // MakrerImage 객체를 생성하여 반환하는 함수입니다
      function createMarkerImage(markerSize, offset, spriteOrigin) {
         var markerImage = new kakao.maps.MarkerImage(SPRITE_MARKER_URL, // 스프라이트 마커 이미지 URL
         markerSize, // 마커의 크기
         {
            offset : offset, // 마커 이미지에서의 기준 좌표
            spriteOrigin : spriteOrigin, // 스트라이프 이미지 중 사용할 영역의 좌상단 좌표
            spriteSize : spriteImageSize
         // 스프라이트 이미지의 크기
         });
         return markerImage;
      }

      // 마커가 지도 위에 표시되도록 설정합니다
      //marker.setMap(map);
      // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
      // marker.setMap(null);
   </script>
--%>

   <script>   
      //document.getElementById("map").style.marginLeft="5%";
      
      var likeImgArr = new Array();
      <c:forEach items="${likeImg }" var="likeImg">
      likeImgArr.push("${likeImg.imgBno}");
      </c:forEach>
     
   </script>

     
   
 <script>
   function resize(obj) {
        obj.style.height = "1px";
        obj.style.height = (12+obj.scrollHeight)+"px";   
   }
</script>
</body>
</html>