<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- <script src="/resources/js/write.js?var=2"></script> -->
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

   <!-- 카카오맵 api 호출 -->
   <div id="map" style="display: none;"></div>
   

<!-- 카카오맵 다중마커 정렬 -->
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd9fb87d40ab9678af574d3665e02b6e&libraries=services,clusterer"></script>
   <script>
         
     //위도, 경도값  배열에 저장
     var lat = new Array();
     var lon = new Array();

     <c:forEach items="${list }" var="list">
        lat.push("${list.latitude}");
         lon.push("${list.longitude}");
     </c:forEach>

     var lat2 = [];
     var lon2 = [];
     var loc = [];
     var loc2 = document.getElementsByName("loc");
    
	 	
function mapTest() {
	
     // 위치정보들을 담는 객체 배열 생성 - 안에서 객체들 반복문 돌려 사진업로드 갯수만큼 저장해야한다.
     var positions = []; 
     
     // 위도값갯수만큼(위도와 경도는 같이 포함되기에 위도갯수만 체크해도 됨) 마커에 위도, 경도값을 저장한다       
     for (var i=0; i<lat.length; i++) { 
        positions.push(new kakao.maps.LatLng(parseFloat(lat[i]), parseFloat(lon[i])));
     }
     
     // 주소-좌표 변환 객체를 생성합니다
     var geocoder = new kakao.maps.services.Geocoder();

     
      
     var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
         mapOption = { 
            center: new kakao.maps.LatLng(parseFloat(lat[0]), parseFloat(lon[0])), // 지도의 중심좌표는 첫번째 사진을 기준으로 함.
              level: 9 // 지도의 확대 레벨
         };
 
     // 지도를 생성합니다
     var map = new kakao.maps.Map(mapContainer, mapOption); 


      // 이미지의 위도경도 좌표값을 좌표값과 일치하는 주소 정보로 변환합니다
     for (var j=0; j<lat2.length; j++) { 
        var coord = new kakao.maps.LatLng(parseFloat(lat2[j]), parseFloat(lon2[j]));
        var callback = function(result, status) {
           if (status === kakao.maps.services.Status.OK) {

              // 좌표값에 해당하는 구주소와 도로명 주소 정보를 요청합니다
          
              loc.push(result[0].address.address_name);
              locPush(loc);
              console.log(loc);
             
            }
        };         
                geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
                
     }
     
         
     function locPush(loc) {
         for(var j=0; j<loc.length; j++) {
        	 document.getElementById("loc_" + j).value = loc[j]
			 console.log(loc.length);
			 
             }
         }
    
}      
   </script>



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

<!-- write.js -->
<script>
/**
 * 
 */
var sel_files;
var selFiles;
var MAX_W = 300;
var MAX_H = 300;
var j;
var index;
var del_files;
$(document).ready(
      function() {
         sel_files = [];
         selFiles = [];
         del_files = [ -1 ];
         j = 0;
         index = 0;
         $("#input_imgs").on("change", handleImgFileSelect);
         $(window).bind("beforeunload", function() {
               delImg();
         });
         
         function handleBrowserCloseButton(event) {
            if (($(window).width() - window.event.clientX) < 35
                  && window.event.clientY < 0) {
               // Call method by Ajax call
               delImg();
            }
         }
      });

function delImg() {
   if($("input[name='id']").val() != "" && $("input[name='id']").length > 0){
   var query = {
      userID : $("#userID").val()
   }
   $.ajax({
      type : "post",
      url : "/board/beforeunload",
      data : query,
      success : function() {
      },
      error : function(request, status, error) {
         alert("code:" + request.status + "\n" + "message:"
               + request.responseText + "\n" + "error:" + error);
      }
   });
   
   }
}

function handleImgFileSelect(e) {

   var files = e.target.files;
   var filesArr = Array.prototype.slice.call(files);

   filesArr
         .forEach(function(f) {

            if (f.type.match('image/jpg' || 'image/jpeg')) {
               alert("이미지만 업로드 가능합니다.");
               return;
            }

            console.log(f.size);

            var reader = new FileReader();
            reader.onload = function(e) {

               console.log(sel_files.length);
               if (sel_files.length + selFiles.length < 50) {
                  if (f.size < 31457280) {
                     sel_files.push(f);
                     var tempImage = new Image();
                     tempImage.src = reader.result;

                     tempImage.onload = function() {
                        var canvas = document.createElement('canvas');
                        var canvasContext = canvas.getContext("2d");

                        var img = new Image();
                        img.src = e.target.result;

                        var w = img.width;
                        var h = img.height;

                        if (w > h) {
                           if (w > MAX_W) {
                              h *= MAX_W / w;
                              w = MAX_W;
                           }
                        } else {
                           if (h > MAX_H) {
                              w *= MAX_H / h;
                              h = MAX_H;
                           }
                        }

                        canvas.width = w;
                        canvas.height = h;

                        canvasContext.drawImage(this, 0, 0,
                              canvas.width, canvas.height);
                        var dataURI = canvas.toDataURL('image/jpeg');
                        var img_html = '<div class="middle" id="middle_'
                              + index
                              + '" name="imgDiv"><div class="left"><input type="hidden" id="id_'
                              + index
                              + '" name="id"><img width="250" style="max-width:250px; height:auto; max-height:250px;" onclick="del('
                              + index
                              + ')" id="img_'
                              + index
                              + '" name="filesList" src="'
                              + dataURI
                              + '" /></div><div class="right"><div class="one"><input type="text" id="loc_'+index+'"><input type="hidden" id="lat_'
                              + index
                              + '" name="lat" /><input type="hidden" id="lon_'
                              + index
                              + '" name="lon" /><input type="text" id="time_'
                              + index
                              + '" name="time" /></div><div class="two"><textarea cols="30" rows="5" id="textarea_'
                              + index
                              + '" name="content" ></textarea><br/></div><div id="three"><div class="t-1"><p>이동수단</p></div><div class="t-2" id="tp_'
                              + index
                              + '">'
                              + '<input type="checkbox" id="sneakers_'
                              + index
                              + '" name="tp" value="sneakers" /><label><img src="/resources/imgs/sneakers.png"></label>'
                              + ' <input type="checkbox" id="bus_'
                              + index
                              + '" name="tp" value="bus" /><label><img src="/resources/imgs/bus.png"></label>'
                              + ' <input type="checkbox" id="train_'
                              + index
                              + '" name="tp" value="train" /><label><img src="/resources/imgs/train.png"></label>'
                              + ' <br>'
                              + ' <input type="checkbox" id="car_'
                              + index
                              + '" name="tp" value="car" /><label><img src="/resources/imgs/car.png"></label>'
                              + '  <input type="checkbox" id="taxi_'
                              + index
                              + '" name="tp" value="taxi" /><label><img src="/resources/imgs/taxi.png"></label>'
                              + ' <input type="checkbox" id="bike_'
                              + index
                              + '" name="tp" value="bike" /><label><img src="/resources/imgs/bike.png"></label>'
                              + ' <input type="checkbox" id="scooter_'
                              + index
                              + '" name="tp" value="scooter" /><label><img src="/resources/imgs/scooter.png"></label>'
                        '</div></div></div>'
                        $(".img_box").append(img_html);
                        index++;
                     }
                  } else {
                     console.log("이미지는 30MB 이하로 등록 가능합니다.");
                  }
               } else {
                  console.log("이미지는 50개까지 등록 가능합니다.");
               }
               
            }

            reader.readAsDataURL(f);
         });

}

function del(index) {
   // sel_files.splice(index, 1);

   $("#middle_" + index).css("opacity", 0.5);
   $("#img_" + index).attr("onclick", "undel(" + index + ")");
}

function undel(index) {
   $("#middle_" + index).css("opacity", "");
   $("#img_" + index).attr("onclick", "del(" + index + ")");
}

$(document).on(
      'click',
      '#bImgUpload',
      function() {
         if (sel_files.length != 0) {
            var form = $("#f")[0];
            var formData = new FormData(form);

            for (var i = 0; i < sel_files.length; i++) {
               formData.append('imgFileList', sel_files[i]);
            }
            formData.append('userID', $("#userID").val());

            $.ajax({
               type : "post",
               enctype : "multipart/form-data",
               processData : false,
               contentType : false,
               traditional : true,
               url : "/board/imgUpload",
               dataType : "json",
               data : formData,
               success : function(data) {
                  console.log(data);
                  imgPrint(data);
                  selFiles = sel_files;
                  sel_files = [];
                  loc = [];
               },
               error : function(request, status, error) {
                  alert("code:" + request.status + "\n" + "message:"
                        + request.responseText + "\n" + "error:"
                        + error);
               }
            });
         }
      });

$(document).on(
      'click',
      '#bWrite',
      function() {
         if ($("#title").val().trim() != "") {

            var id = [];
            var lat = [];
            var lon = [];
            var time = [];
            var content = [];
            var tp = [];
            var size = 0;

            for (var i = 0; i < $("input[name='id']").length; i++) {
               if ($("div[name='imgDiv']")[i].style.opacity == 0.5
                     && $("input[name='id']")[i].value != "") {
                  del_files.push($("input[name='id']")[i].value);
               }
               if ($("div[name='imgDiv']")[i].style.opacity == ""
                     && $("input[name='id']")[i].value != "") {
                  size++;
                  id.push($("input[name='id']")[i].value);
                  lat.push($("input[name='lat']")[i].value);
                  lon.push($("input[name='lon']")[i].value);
                  time.push($("input[name='time']")[i].value);
                  content.push($("textarea[name='content']")[i].value);
                  var tp_sub = [];
                  $("#tp_" + [ i ] + " input:checked").each(function() {
                     tp_sub.push($(this).val());
                  });
                  tp.push(tp_sub);
               }

            }

            var query = {
               title : $("#title").val().trim(),
               userID : $("#userID").val(),
               pNum : $("input[name='pNum']:checked").val(),
               id : id,
               lat : lat,
               lon : lon,
               time : time,
               content : content,
               del : del_files,
               tp : tp,
               size : size
            };
            $.ajax({
               type : "post",
               url : "/board/writeClick",
               traditional : true,
               data : query,
               success : function(data) {
                  location.href = data;
               },
               error : function(request, status, error) {
                  alert("code:" + request.status + "\n" + "message:"
                        + request.responseText + "\n" + "error:"
                        + error);
               }
            });
         } else {
            alert("제목을 입력하세요.");
            $("#title").focus();
         }
      });

function imgPrint(obj) {
   var lat = document.getElementsByName("lat");
   var lon = document.getElementsByName("lon");
   var time = document.getElementsByName("time");
   var id = document.getElementsByName("id");

   while (j < lat.length) {
      lat[j].value = obj[j].latitude;
      lon[j].value = obj[j].longitude;
      time[j].value = obj[j].timeView;
      id[j].value = obj[j].id;

      lat2.push(obj[j].latitude);
	  lon2.push(obj[j].longitude);
      j++;
   }

mapTest();
}
</script>

</body>
</html>