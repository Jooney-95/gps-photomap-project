var sel_files;
var selFiles;
var del_files;
var unloadFlag;
var likeImgs;

$(document).ready(function () {
   $("#sessionNickname").text(textOverCut($("#hiddenNickname").val(), "nickname") + "님");
   sel_files = [];
   selFiles = [];
   del_files = [];
   likeImgs = [];
   unloadFlag = false;

   sessionStorage.clear();
   localStorage.removeItem("writeImgData");
   deleteImg();
   fileDropDown();

   if (localStorage.getItem("writeImgData") != null) {
      var writeImgData = JSON.parse(localStorage.getItem("writeImgData"));
      printImgBox(writeImgData);
   }

   $("#input_imgs").on("change", handleImgFileSelect);

   $(window).bind("beforeunload", function () {
      if (unloadFlag) {
         return true;
      }
   });

   /*
   function handleBrowserCloseButton(event) {
      if (($(window).width() - window.event.clientX) < 35
         && window.event.clientY < 0) {
         // Call method by Ajax call
         alert("종료 테스트");
         deleteImg();
      }
   }
   */
});

function deleteImg() {
   if ($("input[name='id']").val() != "") {
      var query = {
         userID: $("#userID").val()
      }
      $.ajax({
         type: "post",
         url: "/board/beforeunload",
         data: query,
         success: function () {
         },
         error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:"
               + request.responseText + "\n" + "error:" + error);
         }
      });

   }
}

function handleImgFileSelect(e) {
   unloadFlag = true;
   var files = e.target.files;
   console.log(files);
   fileUpLoad(files);
}

function fileUpLoad(files) {
   var filesArr = Array.prototype.slice.call(files);
   for (var i = 0; i < filesArr.length; i++) {
      if (!filesArr[i].type.match("image/jpeg")) {
         alert("jpeg 만 업로드 가능합니다.");
         return;
      }
      console.log(sel_files.length + selFiles.length)
      if (sel_files.length + selFiles.length < 50) {

         if (filesArr[i].size < 31457280) {
            sel_files.push(filesArr[i]);

         } else {
            alert("파일 용량크기 제한");            
         }
      } else {
         alert("이미지 50장 제한");
         break;
      }
   }
   uploadImg();
}

// 파일 드롭 다운
function fileDropDown() {
   var dropZone = $("#f");
   //Drag기능 
   dropZone.on('dragenter', function (e) {
   
		e.stopPropagation();
		e.preventDefault();
		// 드롭다운 영역 css
		dropZone.css('background-color', '#E3F2FC');
	});
	dropZone.on('dragleave', function (e) {
		
		e.stopPropagation();
		e.preventDefault();
		// 드롭다운 영역 css
		dropZone.css('background-color', '#FFFFFF');
	});
	dropZone.on('dragover', function (e) {
		
		e.stopPropagation();
		e.preventDefault();
		// 드롭다운 영역 css
		dropZone.css('background-color', '#E3F2FC');
	});
   dropZone.on("drop", function (e) {
      e.preventDefault();
      // 드롭다운 영역 css
      dropZone.css("background-color", "#FFFFFF");

      var files = e.originalEvent.dataTransfer.files;

      if (files != null) {
         if (files.length >= 1) {
            fileUpLoad(files);
         }
      } else {
         alert("ERROR");
      }
   });
}

$(document).on("change", ":checkbox", function () {
   console.log("id : " + $(this).attr("id") + "   checked : " + $(this));
   if (sessionStorage.getItem($(this).attr("id")) == null) {
      sessionStorage.setItem($(this).attr("id"), "checked");
   } else {
      sessionStorage.removeItem($(this).attr("id"));
   }
})

$(document).on("keyup", "textarea[name='content']", function () {
   sessionStorage.setItem($(this).attr("id"), $(this).val());
})

function getSession() {

   for (var i = 0; i < sessionStorage.length; i++) {
      if (sessionStorage.key(i).substr(0, 8) == "textarea") {
         $("#" + sessionStorage.key(i)).val(sessionStorage.getItem(sessionStorage.key(i)));
      } else if (sessionStorage.key(i).substr(0, 9) == "deleteBtb") {
         deleteBtn(sessionStorage.getItem(sessionStorage.key(i)));
      } else {
         $("#" + sessionStorage.key(i)).attr("checked", "checked");
      }
   }
}

function tpList(index) {
   if (document.querySelector("#tp_" + index).style.display == "none") {
      $("#tp_" + index).css("display", "");
   } else {
      $("#tp_" + index).css("display", "none");
   }
}

function deleteBtn(index) {
   $("#middle_" + index).css("opacity", 0.5);
   $("#b_" + index).attr("onclick", "unDeleteBtn(" + index + ")");
   $("#b_" + index).html("복원");
   sessionStorage.setItem("deleteBtb_" + index, index);
}

function unDeleteBtn(index) {
   $("#middle_" + index).css("opacity", "");
   $("#b_" + index).attr("onclick", "deleteBtn(" + index + ")");
   $("#b_" + index).html("삭제");
   sessionStorage.removeItem("deleteBtb_" + index);
}

function selectLikeImg(index) {
   unloadFlag = true;
   console.log(likeImgs.indexOf(index))
   console.log(likeImgs.length)
   if (likeImgs.indexOf(index) == -1) {
      if (likeImgs.length < 4) {
         storageLikeImg(index);
         console.log("test1")
      } else {
         var firstImgBno = likeImgs.shift();
         deleteStorageLikeImg(firstImgBno);
         storageLikeImg(index);
         console.log("test2")
      }
   } else {
      deleteStorageLikeImg(index);
      console.log("test3")
   }
}

function storageLikeImg(imgBno) {
   likeImgs.push(imgBno);
   sessionStorage.setItem("selectLikeImg_" + imgBno, "fas fa-star");
   $("#selectLikeImg_" + imgBno).attr("class", "fas fa-star");
}

function deleteStorageLikeImg(imgBno) {
   if (likeImgs.indexOf(imgBno) != -1) {
      likeImgs.splice(likeImgs.indexOf(imgBno), 1);
   }
   sessionStorage.removeItem("selectLikeImg_" + imgBno);
   $("#selectLikeImg_" + imgBno).attr("class", "far fa-star");
}


function uploadImg() {
   $("#loading").css("display", "");
   if (sel_files.length > 0) {
      var form = $("#f")[0];
      var formData = new FormData(form);

      for (var i = 0; i < sel_files.length; i++) {
         selFiles.push(sel_files[i]);
         formData.append("imgFileList", sel_files[i]);
      }
      formData.append("userID", $("#userID").val());

      $.ajax({
         type: "post",
         enctype: "multipart/form-data",
         processData: false,
         contentType: false,
         traditional: true,
         url: "/board/writeFile",
         dataType: "json",
         data: formData,
         success: function (data) {
            localStorage.setItem("writeImgData", JSON.stringify(data));
            printImgBox(data);
            sel_files = [];
         },
         error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:"
               + request.responseText + "\n" + "error:"
               + error);
         }
      });
   }
}

$(document).on("click", "#bWrite", function () {
   if ($("#title").val().trim() != "") {
      var id = [];
      var lat = [];
      var lon = [];
      var loc = [];
      var time = [];
      var content = [];
      var tp = [];
      var size = 0;
      unloadFlag = false;

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
            loc.push($("input[name='loc']")[i].value);
            time.push($("input[name='time']")[i].value);
            content.push($("textarea[name='content']")[i].value);
            var tp_sub = [];
            $("#tp_" + [i] + " input:checked").each(function () {
               tp_sub.push($(this).val());
            });
            tp.push(tp_sub);
         }

      }

      if (size != 0) {

         var query = {
            title: $("#title").val().trim(),
            userID: $("#userID").val(),
            pNum: $("input[name='pNum']:checked").val(),
            id: id,
            lat: lat,
            lon: lon,
            loc: loc,
            time: time,
            content: content,
            del: del_files,
            tp: tp,
            size: size,
            likeImgs: likeImgs
         };

         $.ajax({
            type: "post",
            url: "/board/writeClick",
            traditional: true,
            data: query,
            success: function (data) {
               localStorage.removeItem("writeImgData");
               sessionStorage.clear();
               location.href = data;
            },
            error: function (request, status, error) {
               alert("code:" + request.status + "\n" + "message:"
                  + request.responseText + "\n" + "error:"
                  + error);
            }
         });
      } else {
         alert("사진을 골라주세요");
      }
   } else {
      alert("제목을 입력하세요.");
      $("#title").focus();
   }
});

function printImgBox(obj) {
   $(".img_box").empty();
   for (var i = 0; i < obj.length; i++) {

      var img_html = '  <div class="middle" id="middle_' + obj[i].id + '" name="imgDiv">';
      img_html += '		<!-- 대표이미지 설정 아이콘 --><i class="far fa-star" id="selectLikeImg_' + obj[i].id + '" onclick="selectLikeImg(' + obj[i].id + ')"></i>';
      img_html += '        <div class="left">';
      img_html += '           <ul>';
      img_html += '              <li>';
      img_html += '                 <div class="leftone">';
      img_html += '                    <i class="fas fa-map-marker-alt"></i>';
      img_html += '                    <input type="hidden" id="id_' + obj[i].id + '" name="id">';
      img_html += '                    <input type="text"  id="loc_' + obj[i].id + '" name="loc">';
      img_html += '                    <input type="hidden" id="lat_' + obj[i].id + '" name="lat" />';
      img_html += '                    <input type="hidden" id="lon_' + obj[i].id + '" name="lon" />';
      img_html += '                 </div>';
      img_html += '              </li>';
      img_html += '              <li>';
      img_html += '                 <div class="lefttwo">';
      img_html += '                    <img id="img_' + obj[i].id + '" name="filesList" src="" />';
      img_html += '                 </div>';
      img_html += '              </li>';
      img_html += '           </ul>';
      img_html += '        </div>';
      img_html += '        <div class="right">';
      img_html += '           <div class="one">';
      img_html += '              <input type="text" id="time_' + obj[i].id + '" name="time" />';
      img_html += '           </div>';
      img_html += '           <div class="two">';
      img_html += '              <textarea style="width:90%" cols="30" rows="5" id="textarea_' + obj[i].id + '" name="content"></textarea>';
      img_html += '           </div>';
      img_html += '           <div id="three">';
      img_html += '              <div class="t">';
      img_html += '                 <div class="t-1" onclick="tpAdd(' + obj[i].id + ')">';
      img_html += '                    <p>이동수단</p>';
      img_html += '                 </div>';
      img_html += '              <div class="t-2" id="tp_' + i + '" >';
      img_html += '                 <ul>';
      img_html += '                    <li class="b"><label><input type="checkbox" id="sneakers_' + obj[i].id + '" name="tp" value="sneakers" /><img src="/resources/imgs/sneakers.png">도 보</label></li>';
      img_html += '                    <li class="b"><label><input type="checkbox" id="bus_' + obj[i].id + '" name="tp" value="bus" /><img src="/resources/imgs/bus.png">버 스</label></li>';
      img_html += '                    <li class="a"><label><input type="checkbox" id="train_' + obj[i].id + '" name="tp" value="train" /><img src="/resources/imgs/train.png">지하철</label></li>';
      img_html += '                    <li class="a"><label><input type="checkbox" id="car_' + obj[i].id + '" name="tp" value="car" /><img src="/resources/imgs/car.png">자동차</label></li>';
      img_html += '                    <li class="b"><label><input type="checkbox" id="taxi_' + obj[i].id + '" name="tp" value="taxi" /><img src="/resources/imgs/taxi.png">택 시</label></li>';
      img_html += '                    <li class="a"><label><input type="checkbox" id="bike_' + obj[i].id + '" name="tp" value="bike" /><img src="/resources/imgs/bike.png">자전거</label></li>';
      img_html += '                    <li class="a"><label><input type="checkbox" id="scooter_' + obj[i].id + '" name="tp" value="scooter" /><img src="/resources/imgs/scooter.png">스쿠터</label></li>';
      img_html += '                 </ul>';
      img_html += '              </div>';
      img_html += '           </div>';
      img_html += '        </div>';
      img_html += '     </div>';
      img_html += '     <div class="down"><button type="button" id="b_' + obj[i].id + '" onclick="deleteBtn(' + obj[i].id + ')">삭제</button></div>'

      $(".img_box").append(img_html);

      $("#time_" + obj[i].id).val(obj[i].timeView);
      $("#id_" + obj[i].id).val(obj[i].id);
      $("#img_" + obj[i].id).attr("src", "/img/thumb/" + obj[i].fileName);

      getLoc(obj[i].latitude, obj[i].longitude, obj[i].id);
   }
   getSession();
   $("#loading").css("display", "none");
}

function getLoc(x, y, iIndex) {
   var coord = new kakao.maps.LatLng(parseFloat(x), parseFloat(y));

   var geocoder = new kakao.maps.services.Geocoder();

   var callback = function (result, status) {
      if (status === kakao.maps.services.Status.OK) {
         document.getElementById("loc_" + iIndex).value = result[0].address.address_name;

      }
   };
   geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
}

function loginPopup() {
   if (document.getElementById("loginPopup").style.display == "none") {
      document.getElementById("loginPopup").style.display = "";
   } else {
      document.getElementById("loginPopup").style.display = "none";
   }
}

function textOverCut(text, type) {
   var lastText = "...";

   if (type == "title") {
      var len = 15;
   } else {
      var len = 10;
   }
   if (text.length > len) {
      return text.substr(0, len) + lastText;
   } else {
      return text;
   }
}