var list;
var file;
var member;
var page;
var pageNumber;
var likeImg;
var listFlag;

$(document).ready(function () {
  sessionStorage.clear();
  pageNumber = 1;
  sessionStorage.setItem("like", "/board/getPage");
  sessionStorage.setItem("new", "/board/getPage");
  sessionStorage.setItem("fol", "/board/getPage");
  sessionStorage.setItem("likeSearch", "/board/getPageSearch");
  sessionStorage.setItem("newSearch", "/board/getPageSearch");
  sessionStorage.setItem("folSearch", "/board/getPageSearch");

  getFlag();
  getPageList(pageNumber);
});

function getFlag() {
  sessionStorage.removeItem("flag");
  sessionStorage.setItem("flag", "like");

  var flag = sessionStorage.getItem("flag");

  if (flag == "like" || flag == "likeSearch") {
    $(".listBold")[0].style.color = "black";
    return;
  } else if (flag == "new" || flag == "newSearch") {
    $(".listBold")[1].style.color = "black";
    return;
  } else {
    $(".listBold")[2].style.color = "black";
  }
}

$(document).on("click", ".listBold", function () {
  $(this).css("font-weight", "bold");
  $(this).css("color", "#000");
  $(".listBold").not($(this)).css("font-weight", "400");
  $(".listBold").not($(this)).css("color", "#bbb");
});

$(document).on("click", "#searchBtn", function () {
  var flag = sessionStorage.getItem("flag");
  var searchType = document.getElementsByName("searchType")[0].value;
  var keyword = document.getElementsByName("keyword")[0].value;

  if (flag == "like" || flag == "new" || flag == "fol") {
    sessionStorage.setItem("flag", sessionStorage.getItem("flag") + "Search");
  }
  if (listFlag == true) {
    listFlag = false;
    sessionStorage.setItem("searchType", searchType);
    sessionStorage.setItem("keyword", keyword);
    $("#pageList").empty();
    getPageList(pageNumber);
  }
});

$(document).on("keypress", ".searchTerm", function (e) {
  if (e.which == 13) {
    $("#searchBtn").click();
  }
});

$(window).scroll(function () {
  //      console.log("$(window).scrollTop() : " + $(window).scrollTop() + ", $(document).height() : " + $(document).height() + ", $(window).height() : " + $(window).height())
  if (
    $(document).height() <= $(window).scrollTop() + $(window).height() + 500 &&
    pageNumber < page.endPageNum
  ) {
    getPageList(++pageNumber);
  }
});

function getList(value) {
  var flag = sessionStorage.getItem("flag");
  var keyword = document.getElementsByName("keyword")[0];
  sessionStorage.removeItem("keyword");
  keyword.value = "";
  pageNumber = 1;

  switch (value) {
    case 1:
      sessionStorage.setItem("flag", "like");
      break;
    case 2:
      sessionStorage.setItem("flag", "new");
      break;
    default:
      sessionStorage.setItem("flag", "fol");
      break;
  }

  if (listFlag == true) {
    listFlag = false;
    $("#pageList").empty();
    getPageList(pageNumber);
  }
}

function getPageList(pageNum) {
  var flag = sessionStorage.getItem("flag");
  var URL = sessionStorage.getItem(flag);
  var kategorie = $("input[name='kategorie']:checked");
  var kategorieArr = [];

  for (var i = 0; i < kategorie.length; i++) {
    kategorieArr.push(kategorie[i].value);
  }

  console.log(``, URL, kategorieArr);
  if (flag == "like" || flag == "new" || flag == "fol") {
    var query = {
      pageNum: pageNum,
      flag: flag,
      kate: kategorieArr
    };
  } else {
    var query = {
      pageNum: pageNum,
      flag: flag,
      kate: kategorieArr,
      searchType: sessionStorage.getItem("searchType"),
      keyword: sessionStorage.getItem("keyword")
    };
  }

  $.ajax({
    type: "post",
    url: URL,
    data: query,
    traditional: true,
    success: function (data) {
      if (Object.keys(data).includes("board")) {
        list = JSON.parse(data.board);
        file = JSON.parse(data.file);
        member = JSON.parse(data.member);
        page = JSON.parse(data.page);
        likeImg = JSON.parse(data.likeImg);
        pageNumber = page.num;
        addListPage(data);
      } else {
        listFlag = true;
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

function addListPage(data) {
  pageNumber = page.num;
  var count = 0;
  for (var i = 0; i < list.length; i++) {
    var innerList;
    innerList = '  <div id="table">';

    innerList += "     <ul>";
    innerList += "        <li>";
    innerList += '       <div id="left">';
    innerList +=
      '          <div class="writer" id="writer_' + list[i].bno + '"></div>';
    innerList += "      </div>";
    innerList +=
      '          <div class="name" id="nickname_' + list[i].bno + '">';
    innerList += "       </div>";
    innerList += "        </li>";

    innerList += "        <li>";
    innerList += '        <div class="r-1">';
    innerList +=
      '            <div class="pNum" id="pNum_' + list[i].bno + '"></div>';
    innerList +=
      '             <div id="date_' +
      list[i].bno +
      '" class="date">' +
      getTimeStamp(list[i].regDate) +
      "</div>";
    innerList +=
      '            <div id="viewCnt">조회수 ' +
      number(list[i].viewCnt) +
      "회</div>";
    innerList += "         </div>";
    innerList += "        </li>";
    innerList += "      </ul>";

    innerList += "      <ul>";
    innerList += "        <li>";
    innerList += '       <div class="downimg" id="img_' + list[i].bno + '">';
    innerList +=
      '             <div class="imgContainer" id="imgContainer_' +
      list[i].bno +
      '">';
    innerList +=
      '                <ul class="slider" id="slider_' + list[i].bno + '">';
    innerList += "                </ul>";
    innerList += "           </div>";
    innerList += "       </div>";
    innerList += "        </li>";
    innerList += "       </ul>";

    innerList += "       <ul>";
    innerList += "        <li>";
    innerList += '            <div id="title" title="' + list[i].title + '">';
    innerList += '                <div id="ta">';
    innerList += '                   <i class="fas fa-caret-right fa-2x"></i>';
    innerList +=
      '                   <a href="/board/view?bno=' +
      list[i].bno +
      '">' +
      list[i].title +
      "</a>";
    innerList += "                </div>";
    innerList +=
      '                <div id ="likeCnt"><i class="far fa-thumbs-up"></i>' +
      number(list[i].likeCnt) +
      "</div>";
    innerList += "            </div>";
    innerList += "          </li>";
    innerList += "        </ul>";
    innerList += "    </div>";
    innerList += " </div>";

    $("#pageList").append(innerList);

    getPNum(list[i].pNum, list[i].bno);
    getMember(list[i].bno, count);
    getImg(list[i].bno, count);
    //getImgSlider(list[i].bno, count);

    count++;
  }
  listFlag = true;
  $(".slider").bxSlider({
    speed: 300,
    touchEnabled: navigator.maxTouchPoints > 0,
    onSliderLoad: function () {
      //         console.log("sliderLoad");
    },
    onSlideAfter: function () {
      $(".bx-next, .bx-prev").css("pointer-events", "auto");
      $("a").attr("onclick", "return true");
    }
  });
}

$(document).on("click", ".bx-next, .bx-prev", function () {
  $(".bx-next, .bx-prev").css("pointer-events", "none");
  $("a").attr("onclick", "return false");
});

function getTimeStamp(time) {
  var curTime = new Date();
  var d = new Date(time);
  var year;
  var month;
  var day;

  if ((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) >= 1) {
    year = d.getFullYear() + "-";

    if (d.getMonth() < 9) {
      month = "0" + (d.getMonth() + 1) + "-";
    } else {
      month = d.getMonth() + 1 + "-";
    }

    if (d.getDate() < 10) {
      day = "0" + d.getDate();
    } else {
      day = d.getDate();
    }

    return year + month + day;
  } else {
    if ((curTime.getTime() - d.getTime()) / (1000 * 60 * 60) >= 1) {
      return (
        Math.round((curTime.getTime() - d.getTime()) / (1000 * 60 * 60)) +
        "시간전"
      );
    } else {
      if (Math.round((curTime.getTime() - d.getTime()) / (1000 * 60)) == 0) {
        return "방금 전";
      } else {
        return (
          Math.round((curTime.getTime() - d.getTime()) / (1000 * 60)) + "분전"
        );
      }
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
  var writerInner;
  var nicknameInner;

  writerInner =
    '   <a href="/member/myPage?num=1&userID=' + member[count].id + '">';
  writerInner += '     <img alt="" src=' + member[count].mImg + ">";
  writerInner += "   <a>";

  nicknameInner =
    '   <a href="/member/myPage?num=1&userID=' + member[count].id + '">';
  nicknameInner += member[count].mNickname;
  nicknameInner += "   <a>";

  $("#writer_" + bno).append(writerInner);
  $("#nickname_" + bno).append(nicknameInner);
}

function getImg(bno, count) {
  var iCount;
  var imgFlag = true;
  for (var i = 0; i < 4; i++) {
    iCount = i;
    if (likeImg[count][i] != undefined) {
      var imgObj = file[count].filter(function (obj) {
        return obj.id == likeImg[count][i].imgBno;
      });
      //printImg(bno, i, imgObj[0].fileName)
      imgSlider(bno, i, imgObj[0].fileName);
    } else {
      var j = 0;
      while (imgFlag) {
        if (
          file[count][j] != undefined &&
          likeImg[count].filter(function (obj) {
            return obj.imgBno == file[count][j].id;
          })[0] == undefined
        ) {
          imgSlider(bno, iCount, file[count][j].fileName);
          iCount++;
        }
        j++;
        if (j >= file[count].length || iCount >= 4) {
          imgFlag = false;
        }
      }
    }
  }
  // if (file[count].length > 4) {
  //    $("#img_" + bno).append("+" + (file[count].length - 4));
  // }
}

function printImg(bno, index, path) {
  var imgInner;
  imgInner = '   <a href="/board/view?bno=' + bno + '">';
  imgInner +=
    '     <img width="100" height="100" id="img_' +
    bno +
    "_" +
    index +
    '" alt="" src=' +
    path +
    ">";
  imgInner += "  </a>";
  $("#img_" + bno).append(imgInner);
}

function getImgSlider(bno, count) {
  for (var i = 0; i < file[count].length; i++) {
    imgSlider(bno, i, file[count][i].fileName);
  }
}

function imgSlider(bno, index, fileName) {
  var imgInner;
  imgInner = '   <li class="sliderItem">';
  imgInner += '     <a href="/board/view?bno=' + bno + '">';
  imgInner +=
    '        <img id="img_' +
    bno +
    "_" +
    index +
    '" alt="" src=' +
    "/img/thumb/" +
    fileName +
    ">";
  imgInner += "     </a>";
  imgInner += "  </li>";
  $("#slider_" + bno).append(imgInner);
}

function loginPopup() {
  if (document.getElementById("loginPopup").style.display == "none") {
    document.getElementById("loginPopup").style.display = "";
  } else {
    document.getElementById("loginPopup").style.display = "none";
  }
}

function number(n) {
  var number = parseFloat(n);
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

function alamPopup() {
  if (document.getElementById("alamPopup").style.display == "none") {
    document.getElementById("alamPopup").style.display = "";
  } else {
    document.getElementById("alamPopup").style.display = "none";
  }
}
