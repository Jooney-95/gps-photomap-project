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
var loadingImage;

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
   if ($("input[name='id']").val() != "" && $("input[name='id']").length > 0) {
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
   var exifData;
   filesArr
         .forEach(function(f) {

            if (f.type.match('image/jpg' || 'image/jpeg')) {
               alert("이미지만 업로드 가능합니다.");
               return;
            }

            /*
             * loadingImage = loadImage(f,function(img){
             *  }, {orientation:true});
             * 
             * loadImage.parseMetaData( f, function (data) {
             * console.log('Original image head: ', data.imageHead)
             * console.log('Exif data: ', data.exif) // requires exif
             * extension console.log('IPTC data: ', data.iptc) // requires
             * iptc extension exifData = data.exif;
             * 
             * console.log("회전" + exifData.get("Orientation")); }, {
             * orientation : 1
             *  } )
             * 
             * console.log(loadingImage);
             */

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
                            +index
                             +'" name="imgDiv"><div class="left"><ul><li><div class="leftone"><i class="fas fa-map-marker-alt"></i> <input type="text" id="loc_'
                            +index
                            +'"><input type="hidden" id="lat_'
                            +index
                            +'" name="lat" /><input type="hidden" id="lon_'
                            +index
                            +'" name="lon" /></div></li><li><div class="lefttwo"><input type="hidden" id="id_'
                            +index
                            +'" name="id"><img id="img_'
                            +index
                             +'" name="filesList" src="'
                            + dataURI
                              + '" /></div></li></ul></div><div class="right"><div class="one"><input type="text" id="time_'
                              + index
                              + '" name="time" /></div><div class="two"><textarea style="width:90%" cols="30" rows="5" id="textarea_'
                              + index
                              + '" name="content" ></textarea><br/></div><div id="three"><div class="t"><div class="t-1" onclick="tpAdd('
                              + index
                              + ')"><p>이동수단</p></div><div class="t-2" id="tp_'
                              + index
                              + '" ><ul>'
                              + '<li class="b"><label><input type="checkbox" id="sneakers_'
                              + index
                              + '" name="tp" value="sneakers" /><img src="/resources/imgs/sneakers.png">도 보</label></li>'
                              + ' <li class="b"><label><input type="checkbox" id="bus_'
                              + index
                              + '" name="tp" value="bus" /><img src="/resources/imgs/bus.png">버 스</label></li>'
                              + ' <li class="a"><label><input type="checkbox" id="train_'
                              + index
                              + '" name="tp" value="train" /><img src="/resources/imgs/train.png">지하철</label></li>'
                              + ' '
                              + ' <li class="a"><label><input type="checkbox" id="car_'
                              + index
                              + '" name="tp" value="car" /><img src="/resources/imgs/car.png">자동차</label></li>'
                              + '  <li class="b"><label><input type="checkbox" id="taxi_'
                              + index
                              + '" name="tp" value="taxi" /><img src="/resources/imgs/taxi.png">택 시</label></li>'
                              + ' <li class="a"><label><input type="checkbox" id="bike_'
                              + index
                              + '" name="tp" value="bike" /><img src="/resources/imgs/bike.png">자전거</label></li>'
                              + ' <li class="a"><label><input type="checkbox" id="scooter_'
                              + index
                              + '" name="tp" value="scooter" /><img src="/resources/imgs/scooter.png">스쿠터</label></li></ul></div></div></div></div>'
                              +'<div class="down"><button type="button" id="b_'
                              + index
                              + '" onclick="del('
                              + index
                              + ')">삭제</button></div>'

                        $(".m").remove();
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

function tpAdd(index){
   if(document.querySelector("#tp_"+index).style.display == "none"){
      $("#tp_"+index).css("display","");
   } else{
      $("#tp_"+index).css("display","none");
   }
}

function del(index) {
   // sel_files.splice(index, 1);

   $("#middle_" + index).css("opacity", 0.5);
   $("#b_" + index).attr("onclick", "undel(" + index + ")");
}

function undel(index) {
   $("#middle_" + index).css("opacity", "");
   $("#b_" + index).attr("onclick", "del(" + index + ")");
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
            var loc = [];
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
                  loc.push($("input[name='loc']")[i].value);
                  time.push($("input[name='time']")[i].value);
                  content.push($("textarea[name='content']")[i].value);
                  var tp_sub = [];
                  $("#tp_" + [ i ] + " input:checked").each(function() {
                     tp_sub.push($(this).val());
                  });
                  tp.push(tp_sub);
               }

            }
            
            if (size != 0) {

               var query = {
                  title : $("#title").val().trim(),
                  userID : $("#userID").val(),
                  pNum : $("input[name='pNum']:checked").val(),
                  id : id,
                  lat : lat,
                  lon : lon,
                  loc : loc,
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
               alert("사진을 골라주세요");
            }
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
      getLoc(obj[j].latitude, obj[j].longitude, j);

      j++;
   }
}

function getLoc(x, y, jIndex) {
   var coord = new kakao.maps.LatLng(parseFloat(x), parseFloat(y));

   var geocoder = new kakao.maps.services.Geocoder();

   var callback = function(result, status) {
      if (status === kakao.maps.services.Status.OK) {

         console.log('지역 명칭 : ' + result[0].address.address_name);
         document.getElementById("loc_" + jIndex).value = result[0].address.address_name;

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