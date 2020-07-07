var list;
var file;
var member;
var page;
var pageNumber;
var likeImg;

window.onload = function () {
   switch (sessionStorage.getItem("flag")) {
      case "like":
         $(".listBold")[0].style.fontWeight = "bold";
         break;
      case "new":
         $(".listBold")[1].style.fontWeight = "bold";
         break;
      case "fol":
         if ($("#userID").val() == "") {
            sessionStorage.setItem("flag", "new");
            $(".listBold")[1].style.fontWeight = "bold";
         } else {
            $(".listBold")[2].style.fontWeight = "bold";
         }
         break;
      default:
         sessionStorage.setItem("flag", "new");
         $(".listBold")[1].style.fontWeight = "bold";
   }

   getPageList(1, sessionStorage.getItem("flag"));
}
$(document).on('click', '.listBold', function () {
   $(this).css('font-weight', 'bold')
   $(".listBold").not($(this)).css('font-weight', '400');
});

$(window).scroll(
   function () {
      if ($(window).scrollTop() >= ($(document).height()
         - $(window).height() - 10)
         && pageNumber < page.endPageNum) {
         getPageList(++pageNumber);
      }
   });

function getList(value) {
   $("#pageList").empty();
   switch (value) {
      case 1:
         sessionStorage.setItem("flag", "like");
         break;
      case 2:
         sessionStorage.setItem("flag", "new");
         break;
      default:
         if ($("#userID").val() != "") {
            sessionStorage.setItem("flag", "fol");
         } else {
            alert("로그인하세요");
            location.href = "/member/login"
         }
   }
   getPageList(1);
}

function getPageList(pageNum) {

   var query = {
      pageNum: pageNum,
      flag: sessionStorage.getItem("flag")
   };

   $.ajax({
      type: "post",
      url: "/board/getPage",
      data: query,
      success: function (data) {

         if (Object.keys(data).includes('board')) {
            list = JSON.parse(data.board);
            file = JSON.parse(data.file);
            member = JSON.parse(data.member);
            page = JSON.parse(data.page);
            likeImg = JSON.parse(data.likeImg);
            pageNumber = page.num;
            addListPage(data)
         }
      },
      error: function (request, status, error) {
         alert("code:" + request.status + "\n" + "message:"
            + request.responseText + "\n" + "error:" + error);
      }
   });
}

function addListPage(data) {
   // $(".main").empty();
   pageNumber = page.num;
   var count = 0;
   for (var i = 0; i < list.length; i++) {
      var innerList;
      innerList = '  <div id="table">';
      innerList += '    <div id="up">';
      innerList += '       <div id="left">';
      innerList += '          <div class="writer" id="writer_' + list[i].bno + '"></div>';
      innerList += '       </div>';
      innerList += '       <div id="right">';
      innerList += '          <ul>';
      innerList += '             <!--  날짜 or 시간    -->';
      innerList += '             <li>';
      innerList += '                <div class="r-1">';
      innerList += '                   <div id="date_' + list[i].bno + '" class="date">' + getTimeStamp(list[i].regDate) + '</div>';
      innerList += '                </div>';
      innerList += '             </li>';
      innerList += '             <li>';
      innerList += '                <!-- 아이디 & 공감수 & 조회수 & 공개 범위 -->';
      innerList += '                <div class="r-2">';
      innerList += '                   <div class="name" id="nickname_' + list[i].bno + '"></div>';
      innerList += '                   <div class="pNum" id="pNum_' + list[i].bno + '"></div>';
      innerList += '                   <div id ="likeCnt"><i class="far fa-thumbs-up"></i>' + list[i].likeCnt + '</div>';
      innerList += '                </div>';
      innerList += '             </li>';
      innerList += '             <li>';
      innerList += '                <!-- 제목 -->';
      innerList += '                <div id="title" title="' + list[i].title + '">';
      innerList += '                   <i class="fas fa-caret-right fa-2x"></i>';
      innerList += '                   <a href="/board/view?bno=' + list[i].bno + '">' + textOverCut(list[i].title, "title") + '</a>';
      innerList += '                   <div id="viewCnt">조회수 ' + list[i].viewCnt + '회</div>';
      innerList += '                </div>';
      innerList += '             </li>';
      innerList += '          </ul>';
      innerList += '       </div>';
      innerList += '    </div>';
      innerList += '    <div class="downimg" id="img_' + list[i].bno + '"></div>';
      innerList += ' </div>';

      $("#pageList").append(innerList);

      getPNum(list[i].pNum, list[i].bno);
      getMember(list[i].bno, count);
      getImg(list[i].bno, count);

      count++;
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
   var writerInner;
   var nicknameInner;

   writerInner = '   <a href="/member/myPage?num=1&userID=' + member[count].id + '">';
   writerInner += '     <img alt="" src=' + member[count].mImg + '>';
   writerInner += '  </a>';

   nicknameInner = textOverCut(member[count].mNickname, "nickname") + ' 님';

   $("#writer_" + bno).append(writerInner);
   $("#nickname_" + bno).append(nicknameInner);
}

function getImg(bno, count) {
   var iCount;
   var imgFlag = true;
   for (var i = 0; i < 4; i++) {
      iCount = i;
      if (likeImg[count][i] != undefined) {
         var imgObj = file[count].filter(function (obj) { return obj.id == likeImg[count][i].imgBno });
         printImg(bno, i, imgObj[0].path)

      } else {
         var j = 0;
         while (imgFlag) {
            if ((file[count][j] != undefined) && (likeImg[count].filter(function (obj) { return obj.imgBno == file[count][j].id })[0] == undefined)) {
               printImg(bno, iCount, file[count][j].path)
               iCount++;
            }
            j++;
            if (j >= file[count].length || iCount >= 4) {
               imgFlag = false;
            }
         }
      }

   }
   if (file[count].length > 4) {
      $("#img_" + bno).append("+" + (file[count].length - 4));
   }
}

function printImg(bno, index, path){
   var imgInner;
   imgInner = '   <a href="/board/view?bno=' + bno + '">';
   imgInner += '     <img width="100" height="100" id="img_' + bno + '_' + index + '" alt="" src=' + path + '>';
   imgInner += '  </a>';
   $("#img_" + bno).append(imgInner);
}

function loginPopup() {
   if (document.getElementById("loginPopup").style.display == "none") {
      document.getElementById("loginPopup").style.display = "";
   } else {
      document.getElementById("loginPopup").style.display = "none";
   }
}