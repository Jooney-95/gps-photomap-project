var testData;

window.onload = function() {
	console.log("start");
	getMyPageList(1);
}

function getMyPageList(pageNum) {
	var query = {
		pageNum : pageNum,
		userID : $("#userID").val()
	};

	$.ajax({
		type : "post",
		url : "/member/getMyPage",
		data : query,
		success : function(data) {
			console.log("성공");
			console.log(data);
			if(Object.keys(data).includes('board')){
				testData = data;
				list = JSON.parse(data.board);
				file = JSON.parse(data.file);
				page = JSON.parse(data.page);
				pageNumber = page.num;
				addListMyPage(data);
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
				+ '</a><div class="pNum" id="pNum_'
				+ list[i].bno
				+ '"></div><div id ="likeCnt"><i class="fas fa-paw" ></i>'
				+ list[i].likeCnt
				+ '</div></div></li><li><div id="r-3">조회수 '
				+ list[i].viewCnt
				+ '회</div></div></li></ul></div></div><div class="downimg" id="img_'
				+ list[i].bno + '"></div></div>';
		$(".in").append(innerList);
		getPNum(list[i].pNum, list[i].bno);
		getMember(list[i].bno, count);
		getImg(list[i].bno, count);
		count++;
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

function getMember(bno, count) {
	$("#writer_" + bno).append(
			'<a href="/member/myPage?num=1&userID=' + member[count].id
					+ '"><img alt="" src=' + member[count].mImg + '></a>');
	$("#nickname_" + bno).append(member[count].mNickname + ' 님');
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