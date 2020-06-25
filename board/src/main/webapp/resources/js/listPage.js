var list;
var file;
var member;
var page;
var pageNumber;
window.onload = function() {
		getPageList(1);
}

function getPageList(pageNum) {
	
	var query = {
		pageNum : pageNum
	};

	$.ajax({
		type : "post",
		url : "/board/getListPage",
		data : query,
		success : function(data) {

			list = JSON.parse(data.board);
			file = JSON.parse(data.file);
			member = JSON.parse(data.member);
			page = JSON.parse(data.page);
			pageNumber = page.num;
			console.log(pageNumber);
			addListPage(data)
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

function addListPage(data) {
	$(".listPage").empty();
	pageNumber = page.num;
	var count = 0;
	for (var i = 0; i < list.length; i++) {
		var innerList;
		innerList = '<div id="table"><div id="up"><div id="left"><div class="writer" id="writer_'
				+ list[i].bno
				+ '"></div></div><div id="right"><ul><!--  날짜 or 시간    --><li><div class="r-1"><div id="date_'
				+ list[i].bno
				+ '" class="date">'
				+ getTimeStamp(list[i].regDate)
				+ '</div></div></li><li><!-- 아이디 & 공감수 & 조회수 & 공개 범위 --><div class="r-2"><div class="name" id="nickname_'
				+ list[i].bno
				+ '"></div><div id ="likeCnt"><i class="fas fa-paw" ></i>'
				+ list[i].likeCnt
				+ '</div><div id="viewCnt">'
				+ list[i].viewCnt
				+ '</div><div class="pNum" id="pNum_'
				+ list[i].bno
				+ '"></div></div></li><li><!-- 제목 --><div id="title"><i class="fas fa-caret-right fa-2x"></i> <a href="/board/view?bno='
				+ list[i].bno
				+ '">'
				+ list[i].title
				+ '</a></div></li></ul></div></div><div class="downimg" id="img_'
				+ list[i].bno + '"></div></div>';
		$(".listPage").append(innerList);
		getPNum(list[i].pNum, list[i].bno);
		getMember(list[i].bno, count);
		getImg(list[i].bno, count);
		count++;
	}
	var pageList;
	pageList = ' <div id="pagelist"></div>';
	$(".listPage").append(pageList);
	getPagePrev(page.prev);
	getPageNumList(page.startPageNum, page.endPageNum);
	getPageNext(page.next);
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

function getPagePrev(prev) {
	if (prev) {
		$("#pagelist").append('<span onclick="getPageList('+page.startPageNum - 1+')">◀</span>');
	}
}

function getPageNumList(start, end) {
	for (var i = start; i <= end; i++) {
		if (pageNumber != i) {
			$("#pagelist").append(
					'<span onclick="getPageList('+i+')">' + i + '</span>');
		} else {
			$("#pagelist").append('<span><b>' + i + '</b></span>');
		}
	}
}

function getPageNext(next) {
	if (next) {
		$("#pagelist").append('<span onclick="getPageList('+page.endPageNum + 1+')">▶</span>');
	}
}

function loginPopup() {
	if (document.getElementById("loginPopup").style.display == "none") {
		document.getElementById("loginPopup").style.display = "";
	} else {
		document.getElementById("loginPopup").style.display = "none";
	}
}