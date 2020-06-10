var sel_files;
var MAX_W = 300;
var MAX_H = 300;
var j;
var index;
var del_files;
var checkLoad = true;

$(document).ready(
		function() {
			sel_files = [];
			del_files = [];
			j = 0;
			index = 0;
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
						var img_html = '<div id="div'
								+ index
								+ '" name="imgDiv"><input type="hidden" id="id'
								+ index
								+ '" name="id"><img onclick="del('
								+ index
								+ ')" id="img'
								+ index
								+ '" name="filesList" src="'
								+ dataURI
								+ '" />위도 : <input type="text" id="lat'
								+ index
								+ '" name="lat" />경도 : <input type="text" id="lon'
								+ index
								+ '" name="lon" />시간 : <input type="text" id="time'
								+ index
								+ '" name="time" />내용 : <textarea cols="50" rows="5" id="textarea'
								+ index
								+ '" name="content" ></textarea><br/><div>'

						$(".img_box").append(img_html);
						index++;

					}
				}
				reader.readAsDataURL(f);

			});
}

function del(index) {
	// sel_files.splice(index, 1);

	$("#div" + index).css("opacity", 0.5);
	$("#img" + index).attr("onclick", "undel("+index+")");
}

function undel(index){
	$("#div" + index).css("opacity", "");
	$("#img" + index).attr("onclick", "del("+index+")");
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
		'#bWrite',
		function() {
			if ($("#title").val().trim() != "") {
				var id = [];
				var lat = [];
				var lon = [];
				var time = [];
				var content = [];

				for (var i = 0; i < $("input[name='id']").length; i++) {
					if($("div[name='imgDiv']")[i].style.opacity == 0.5 && $("input[name='id']")[i].value != ""){
						del_files.push($("input[name='id']")[i].value);
					}
					if($("div[name='imgDiv']")[i].style.opacity == "" && $("input[name='id']")[i].value != ""){
						id.push($("input[name='id']")[i].value);
						lat.push($("input[name='lat']")[i].value);
						lon.push($("input[name='lon']")[i].value);
						time.push($("input[name='time']")[i].value);
						content.push($("textarea[name='content']")[i].value);
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
					del : del_files
				};
				$.ajax({
					type : "post",
					url : "/board/writeClick",
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
		j++;
	}
}