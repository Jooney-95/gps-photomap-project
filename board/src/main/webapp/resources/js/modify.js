var sel_files;
var selFiles;
var MAX_W = 300;
var MAX_H = 300;
var i;
var j;
var index;
var del_files;
var checkLoad = true;

$(document).ready(
      function() {
         sel_files = [];
         selFiles = [];
         del_files = [ -1 ];
         index = document.getElementsByName("imgDiv").length;
         i = 0;
         j = index;
         console.log(j);
         $("#input_imgs").on("change", handleImgFileSelect);
         $(window).bind("beforeunload", function() {
            if (checkLoad == true) {
               delImg();
            }
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

function handleImgFileSelect(e) {

   var files = e.target.files;
   var filesArr = Array.prototype.slice.call(files);

   filesArr
         .forEach(function(f) {

            if (f.type.match('image/jpg' || 'image/jpeg')) {
               alert("이미지만 업로드 가능합니다.");
               return;
            }

            var reader = new FileReader();
            reader.onload = function(e) {
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

                  canvasContext.drawImage(this, 0, 0, canvas.width,
                        canvas.height);
                  var dataURI = canvas.toDataURL('image/jpeg');
                  var img_html = '<div class="middle" id="middle_'
                        + index
                        + '" name="imgDiv"><div class="left"><input type="hidden" id="id_'
                        + index
                        + '" name="id"><img onclick="del('
                        + index
                        + ')" id="img_'
                        + index
                        + '" name="filesList" src="'
                        + dataURI
                        + '" /></div><div class="right"><div class="one"><input type="text" id="lat_'
                        + index
                        + '" name="lat" /><input type="text" id="lon_'
                        + index
                        + '" name="lon" /><input type="text" id="time_'
                        + index
                        + '" name="time" /></div><div class="two"><textarea cols="50" rows="5" id="textarea_'
                        + index
                        + '" name="content" ></textarea><br/><div><div id="three"><div class="t-1"></div><div class="t-2" id="tp_'
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
      '#bModify',
      function() {
         if ($("#title").val().trim() != "") {
            
      
            var id = [];
            var lat = [];
            var lon = [];
            var time = [];
            var content = [];
            var tp = [];
            var bno = $("#bno").val();
            var size = 0;
               
            for (var i = 0; i < $("input[name='id']").length; i++) {
               if ($("div[name='imgDiv']")[i].style.opacity == 0.5
                     && $("input[name='id']")[i].value != "") {
                  del_files.push($("input[name='id']")[i].value);
                  console.log(del_files);
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
            console.log(tp);
            console.log(id);
            var query = {
               bno : bno,
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
               url : "/board/modifyClick",
               traditional : true,
               data : query,
               success : function(data) {
                  checkLoad = false;
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
      lat[j].value = obj[i].latitude;
      lon[j].value = obj[i].longitude;
      time[j].value = obj[i].timeView;
      id[j].value = obj[i].id;
      j++;
      i++;
   }
}/**
 * 
 */