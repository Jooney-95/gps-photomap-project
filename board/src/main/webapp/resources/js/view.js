var kateObj = {
  a1: "피크닉",
  b1: "전시회",
  c1: "박물관",
  d1: "맛집투어",
  e1: "사진명소",
  f1: "드라이브",
  g1: "데이트",
  h1: "등산",
  i1: "바다",
  j1: "강",
  k1: "낚시",
  l1: "액티비티",
  m1: "호캉스",
  a2: "서울특별시",
  b2: "경기도",
  c2: "인천광역시",
  d2: "강원도",
  e2: "대구광역시",
  f2: "경상북도",
  g2: "부산광역시",
  h2: "울산광역시",
  i2: "경상남도",
  j2: "충청북도",
  k2: "세종특별자치시",
  l2: "대전광역시",
  m2: "충청남도",
  n2: "전라북도",
  o2: "광주광역시",
  p2: "전라남도",
  q2: "제주특별시",
  a3: "가족",
  b3: "연인",
  c3: "친구",
  d3: "대학교",
  e3: "동아리",
  f3: "동호회",
  g3: "회사"
};

$(document).ready(function () {
  lightbox.option({
    disableScrolling: true,
    fadeDuration: 0,
    imageFadeDuration: 0,
    resizeDuration: 0,
    wrapAround: true
  });
  countLike();
  likeCheck();
  likeImg();
  setKate();
  saveCheck();
  setNumber();
});

function setKate() {
	
  var kate = kateObj[$(".kate").val()];
  $("#kate").html(kate);
	
}

//console.log($("#a > .a-a > .kate > #kate").val());

function countLike() {
  var query = {
    tblBno: $("#tblBno").val()
  };
  $.ajax({
    url: "/board/likeCount",
    type: "post",
    data: query,
    success: function (count) {
      $("#like").text(number(count));
    },
    error: function (request, status, error) {
      alert(
        "code:" +
          request.status +
          "\n" +
          "message:" +
          request.responseText +
          "\n" +
          "error:" +
          error
      );
    }
  });
}

function setNumber(){
	var number = 1;
	for(var index = 1; index<=$("input[name='loc']").length;index++){
		
		if($("#place_"+index).val()){
			console.log(index)
			$("#number_"+index).text(number);
			$("#number2_"+index).text(number++);
			
		}
	}
}

function likeImg() {
  for (var i = 0; i < likeImgArr.length; i++) {
    $("#selectLikeImg_" + likeImgArr[i]).removeClass("hidden");
  }
}

$(document).on("click", "#bLike", function () {
  if ($("#userID") != "") {
    var query = {
      userID: $("#userID").val(),
      tblBno: $("#tblBno").val()
    };
    $.ajax({
      url: "/board/likeClick",
      type: "post",
      data: query,
      success: function (count) {
        countLike();
        likeCheck();
      },
      error: function (request, status, error) {
        alert(
          "code:" +
            request.status +
            "\n" +
            "message:" +
            request.responseText +
            "\n" +
            "error:" +
            error
        );
      }
    });
  } else {
    alert("로그인 후 이용해주세요");
  }
});

function imgList(i) {
  if (i == 1) {
    $(".gallery").css("display", "");
    $(".original").css("display", "none");
    $(".type1").css("border-bottom", "1px solid #7f7e7e");
    $(".type2").css("border-bottom", "1px solid #f2f0f0");
    $("#gg").css("color", "#7f7e7e");
    $("#ll").css("color", "#ccc");
  } else {
    $(".original").css("display", "");
    $(".gallery").css("display", "none");
    $(".type2").css("border-bottom", "1px solid #7f7e7e");
    $(".type1").css("border-bottom", "1px solid #f2f0f0");
    $("#ll").css("color", "#7f7e7e");
    $("#gg").css("color", "#ccc");
  }
}

function likeCheck() {
  if ($("#userID").val() != "") {
    var query = {
      userID: $("#userID").val(),
      tblBno: $("#tblBno").val()
    };
    $.ajax({
      url: "/board/likeCheck",
      type: "post",
      data: query,
      success: function (check) {
        if (check == 1) {
          $("#bLike").css("color", "#fdb330");
        } else {
          $("#bLike").css("color", "#e8dfe2");
        }
      },
      error: function (request, status, error) {
        alert(
          "code:" +
            request.status +
            "\n" +
            "message:" +
            request.responseText +
            "\n" +
            "error:" +
            error
        );
      }
    });
  }
}

function saveCheck() {
  if ($("#userID").val() != "") {
    var query = {
      userID: $("#userID").val(),
      tblBno: $("#tblBno").val()
    };
    $.ajax({
      url: "/board/saveCheck",
      type: "post",
      data: query,
      success: function (save) {
        console.log(`save:`, save);
      },
      success: function (check) {
        if (check == 1) {
          $("#bsave").css("color", "#94ce9f");
        } else {
          $("#bsave").css("color", "#e8dfe2");
        }
      },
      error: function (request, status, error) {
        alert(
          "code:" +
            request.status +
            "\n" +
            "message:" +
            request.responseText +
            "\n" +
            "error:" +
            error
        );
      }
    });
  }
}

$(document).on("click", "#bsave", function () {
  if ($("#userID").val() != "") {
    var query = {
      userID: $("#userID").val(),
      tblBno: $("#tblBno").val()
    };
    $.ajax({
      url: "/board/savePage",
      type: "post",
      data: query,
      success: function () {
        saveCheck();
      },
      error: function (request, status, error) {
        alert(
          "code:" +
            request.status +
            "\n" +
            "message:" +
            request.responseText +
            "\n" +
            "error:" +
            error
        );
      }
    });
  } else {
    alert("로그인이 필요합니다.");
  }
});

function number(count) {
  var number = parseFloat(count);
  if (number > 1000000000) {
    return (
      parseInt(number / 1000000000) +
      "." +
      parseInt((number % 1000000000) / 100000000) +
      "B"
    );
    // break;
  } else if (number > 1000000) {
    return (
      parseInt(number / 1000000) +
      "." +
      parseInt((number % 1000000) / 100000) +
      "M"
    );
    // break;
  } else if (number > 1000) {
    return (
      parseInt(number / 1000) + "." + parseInt((number % 1000) / 100) + "K"
    );
    // break;
  } else {
    return number;
  }
}

function loginPopup() {
  if (document.getElementById("loginPopup").style.display == "none") {
    document.getElementById("loginPopup").style.display = "";
  } else {
    document.getElementById("loginPopup").style.display = "none";
  }
}

function alamPopup() {
  if (document.getElementById("alamPopup").style.display == "none") {
    document.getElementById("alamPopup").style.display = "";
  } else {
    document.getElementById("alamPopup").style.display = "none";
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

$(document).on("click", "#delBtn", function () {
  if (confirm("삭제하시겠습니까?")) {
    location.href = "/board/delete?bno=" + $("#tblBno").val();
  }
});
