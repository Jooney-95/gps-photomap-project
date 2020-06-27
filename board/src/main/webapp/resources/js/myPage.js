var list;
var file;
var member;
var page;
var pageNumber;

// color:#feec77;
// text-shadow: 0 0 24px;

window.onload = function() {
	switch (sessionStorage.getItem("nav")) {
	case "list":
		$(".myPageNav > a > i")[0].style.color = "#feec77";
		$(".myPageNav > a > i")[0].style.textShadow = "0 0 24px";
		break;
	case "fforf":
		$(".myPageNav > a > i")[1].style.color = "#feec77";
		$(".myPageNav > a > i")[1].style.textShadow = "0 0 24px";
		break;
	case "fol":
		if ($("#userID").val() == "") {
			sessionStorage.setItem("nav", "list");
			$(".myPageNav > a > i")[0].style.color = "#feec77";
			$(".myPageNav > a > i")[0].style.textShadow = "0 0 24px";
		} else {
			$(".myPageNav > a > i")[3].style.color = "#feec77";
			$(".myPageNav > a > i")[3].style.textShadow = "0 0 24px";
		}
		break;
	default:
		sessionStorage.setItem("nav", "list");
		$(".myPageNav > a > i")[0].style.color = "#feec77";
		$(".myPageNav > a > i")[0].style.textShadow = "0 0 24px";
	}

	getMyPageList(1);
	followCheck();
}

function setNav(nav) {
	$(".myPageNav > a > i")[nav - 1].style.color = "#feec77";
	$(".myPageNav > a > i")[nav - 1].style.textShadow = "0 0 24px";
}
function unSetNav(nav) {
	switch (nav) {
	case 1:
		$(".myPageNav > a > i")[2].style.color = "";
		$(".myPageNav > a > i")[2].style.textShadow = "";
		$(".myPageNav > a > i")[1].style.color = "";
		$(".myPageNav > a > i")[1].style.textShadow = "";
		break;
	case 2:
		$(".myPageNav > a > i")[2].style.color = "";
		$(".myPageNav > a > i")[2].style.textShadow = "";
		$(".myPageNav > a > i")[0].style.color = "";
		$(".myPageNav > a > i")[0].style.textShadow = "";
		break;
	default:
		$(".myPageNav > a > i")[1].style.color = "";
		$(".myPageNav > a > i")[1].style.textShadow = "";
		$(".myPageNav > a > i")[0].style.color = "";
		$(".myPageNav > a > i")[0].style.textShadow = "";
		break;

	}
}

$(document).on(
		'click',
		'#bFollow',
		function() {
			var query = {
				sessionID : $("#sessionID").val(),
				userID : $("#userID").val()
			};
			$.ajax({
				url : "/member/followClick",
				type : "post",
				data : query,
				success : function() {
					followCheck();
				},
				error : function(request, status, error) {
					alert("code:" + request.status + "\n" + "message:"
							+ request.responseText + "\n" + "error:" + error);
				}
			});
		});

function followCheck() {
	if ("${session }" != "") {
		var query = {
			sessionID : $("#sessionID").val(),
			userID : $("#userID").val()
		};
		$.ajax({
			url : "/member/followingCheck",
			type : "post",
			data : query,
			success : function(check) {
				if (check == 1) {
					$("#bFollow").attr("class", "fas fa-user-clock fa-2x");
				} else if (check == 2) {
					$("#bFollow").attr("class", "fas fa-user-check fa-2x");
				} else {
					$("#bFollow").attr("class", "fas fa-user-plus fa-2x");
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
}

function getMyPageNav(nav) {
	$(".in").empty();
	switch (nav) {
	case 1:
		sessionStorage.setItem("nav", "list");
		setNav(nav);
		unSetNav(nav);
		break;
	case 2:
		sessionStorage.setItem("nav", "fforf");
		setNav(nav);
		unSetNav(nav);
		break;
	default:
		sessionStorage.setItem("nav", "fol");
		setNav(nav);
		unSetNav(nav);
		break;
	}
	getMyPageList(1);
}

function getMyPageList(pageNum) {
	var query = {
		pageNum : pageNum,
		userID : $("#userID").val()
	};
	var URL = {
		list : "/member/getMyPage",
		fforf : "/member/getFforf",
		fol : "/member/getFol"
	}
	console.log(URL[sessionStorage.getItem("nav")])
	$.ajax({
		type : "post",
		url : URL[sessionStorage.getItem("nav")],
		data : query,
		success : function(data) {
			switch (sessionStorage.getItem("nav")) {
			case "list":
				if (Object.keys(data).includes('board')) {
					list = JSON.parse(data.board);
					file = JSON.parse(data.file);
					page = JSON.parse(data.page);
					pageNumber = page.num;
					addListMyPage(data);
				}
				break;
			case "fforf":
				if (Object.keys(data).includes('member')) {
					member = JSON.parse(data.member);
					page = JSON.parse(data.page);
					pageNumber = page.num;
					addListMyFforf(data);
				}
				break;
			}

		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

function addListMyPage(data) {
	var count = 0;
	for (var i = 0; i < list.length; i++) {
		var innerList;
		innerList = '<div id="table"><div id="up"<div id="right"><ul><!--  날짜 or 시간    --><li><div class="r-1"><div id="date_'
				+ list[i].bno
				+ '" class="date">'
				+ getTimeStamp(list[i].regDate)
				+ '</div></div></li><li><!-- 아이디 & 공감수 & 조회수 & 공개 범위 --><div class="r-2"><!-- 제목 --><div id="title"><i class="fas fa-caret-right fa-2x"></i> <a href="/board/view?bno='
				+ list[i].bno
				+ '">'
				+ list[i].title
				+ '</a></div><div class="pNum" id="pNum_'
				+ list[i].bno
				+ '"></div><div id ="likeCnt"><i class="fas fa-paw" ></i>'
				+ list[i].likeCnt
				+ '</div></div></li><li></ul><div id="r-3"><div id="viewCnt">조회수 '
				+ list[i].viewCnt
				+ '회</div></div></div><div class="downimg" id="img_'
				+ list[i].bno + '"></div></div>';
		$(".in").append(innerList);
		getPNum(list[i].pNum, list[i].bno);
		getImg(list[i].bno, count);
		count++;
	}
}

function addListMyFforf(data) {
	for (var i = 0; i < member.length; i++) {
		var innerList;
		innerList = '<div class="neighbor"><div class="pro"><img width="100" height="100" alt="" src=' + member[i].mImg
				+ ' /></div><div class="nickname">' + member[i].mNickname
				+ '</div></div>';
		$(".in").append(innerList);
	}
}

function getTimeStamp(time) {

	var curTime = new Date();
	var d = new Date(time);
	var year;
	var month;
	var day;

	if ((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) >= 1) {

		year = d.getFullYear() + '-';

		if (d.getMonth() < 10) {
			month = "0" + d.getMonth() + '-';
		} else {
			month = d.getMonth() + '-';
		}

		if (d.getDate() < 10) {
			day = "0" + d.getDate();
		} else {
			day = d.getDate();
		}

		return year + month + day;

	} else {
		if ((curTime.getTime() - d.getTime()) / (1000 * 60 * 60) >= 1) {
			return Math.round((curTime.getTime() - d.getTime())
					/ (1000 * 60 * 60))
					+ "시간전";
		} else {
			return Math.round((curTime.getTime() - d.getTime()) / (1000 * 60))
					+ "분전";
		}
	}
}

function getPNum(pNum, bno) {
	switch (pNum) {
	case -1:
		$("#pNum_" + bno).append('<i class="fas fa-globe-americas"></i>');
		break;
	case -2:
		$("#pNum_" + bno).append('<i class="fas fa-lock"></i>');
		break;
	default:
		$("#pNum_" + bno).append('<i class="fas fa-user-friends"></i>');
	}
}

function getImg(bno, count) {
	for (var i = 0; i < 3; i++) {
		if (file[count][i] != undefined) {
			$("#img_" + bno).append(
					'<img width="100" height="100" alt="" src='
							+ file[count][i].path + '>');
		} else {
			break;
		}
	}
}

function loginPopup() {
	if (document.getElementById("loginPopup").style.display == "none") {
		document.getElementById("loginPopup").style.display = "";
	} else {
		document.getElementById("loginPopup").style.display = "none";
	}
}