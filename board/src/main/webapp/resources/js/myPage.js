var list;
var file;
var member;
var page;
var following;
var pageNumber;

// color:#feec77;
// text-shadow: 0 0 24px;

window.onload = function() {
   sessionStorage.setItem("nav", "list");
   setNav(1);
   unSetNav(1);
   /*
    * switch (sessionStorage.getItem("nav")) { case "list": $(".myPageNav > a >
    * i")[0].style.color = "#feec77"; $(".myPageNav > a >
    * i")[0].style.textShadow = "0 0 24px"; break; case "fforf": $(".myPageNav >
    * a > i")[1].style.color = "#feec77"; $(".myPageNav > a >
    * i")[1].style.textShadow = "0 0 24px"; break; case "fol": if
    * ($("#userID").val() == "") { sessionStorage.setItem("nav", "list");
    * $(".myPageNav > a > i")[0].style.color = "#feec77"; $(".myPageNav > a >
    * i")[0].style.textShadow = "0 0 24px"; } else { $(".myPageNav > a >
    * i")[2].style.color = "#feec77"; $(".myPageNav > a >
    * i")[2].style.textShadow = "0 0 24px"; } break; default:
    * sessionStorage.setItem("nav", "list"); $(".myPageNav > a >
    * i")[0].style.color = "#feec77"; $(".myPageNav > a >
    * i")[0].style.textShadow = "0 0 24px"; }
    */
   getMyPageList(1);
   followCheck();
}

$(window).scroll(
         function() {
            if ($(window).scrollTop() >= ($(document).height()
                  - $(window).height() - 10)
                  && pageNumber < page.endPageNum) {
               getMyPageList(++pageNumber);
            }
         });

function setNav(nav) {
   $(".myPageNav > a > i")[nav - 1].style.color = "#feec77";
   $(".myPageNav > a > i")[nav - 1].style.textShadow = "0 0 24px";
}
function unSetNav(nav) {
   switch (nav) {
   case 1:
      if ($("#userID").val() == $("#sessionID").val()) {
         $(".myPageNav > a > i")[2].style.color = "";
         $(".myPageNav > a > i")[2].style.textShadow = "";
      }
      $(".myPageNav > a > i")[1].style.color = "";
      $(".myPageNav > a > i")[1].style.textShadow = "";
      break;
   case 2:
      if ($("#userID").val() == $("#sessionID").val()) {
         $(".myPageNav > a > i")[2].style.color = "";
         $(".myPageNav > a > i")[2].style.textShadow = "";
      }
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
   if ($("#sessionID").val() != "") {
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
         case "fol":
            if (Object.keys(data).includes('member')) {
               member = JSON.parse(data.member);
               page = JSON.parse(data.page);
               following = JSON.parse(data.following);
               pageNumber = page.num;
               addListMyFol(data);
            }
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
            + '</div></div></li><li><!-- 아이디 & 공감수 & 조회수 & 공개 범위 --><div class="r-2"><!-- 제목 --><div id="title" title="'
            + list[i].title
            + '"><i class="fas fa-caret-right fa-2x"></i> <a href="/board/view?bno='
            + list[i].bno
            + '">'
            + textOverCut(list[i].title, "title")
            + '</a></div><div class="pNum" id="pNum_'
            + list[i].bno
            + '"></div><div id ="likeCnt"><i class="far fa-thumbs-up"></i>'
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
         innerList = '<div class="neighbor"><div class="pro"><a href="/member/myPage?num=1&userID='+member[i].id+'"><img width="100" height="100" alt="" src='
               + member[i].mImg
               + ' /></a></div><div class="nickname">'
               + textOverCut(member[i].mNickname,"nickname") + '님</div></div>';
         $(".in").append(innerList);
      }
   }

   function addListMyFol(data) {
      for (var i = 0; i < member.length; i++) {
         var innerList;
         innerList = '<div id="member_'+i+'" class="nplus"><input type="hidden" id="folUserID_'+i+'" value="'+member[i].id+'"><div class="prof"><a href="/member/myPage?num=1&userID='+member[i].id+'"><img width="100" height="100" alt="" src='
               + member[i].mImg
               + ' /></a></div><div class="dh"><div class="ti">'
               + getTimeStamp(following[i].folDate)
               + '</div><div class="nicknamee">'
               + textOverCut(member[i].mNickname,"nickname")
               + '님</div><p>회원님에게 이웃 요청을 보냈습니다</p><div class="check"><button class="yes" type="button" onclick="follow('+i+')">수락</button><button class="no" type="button" onclick="unFollow('+i+')">거절</button></div></div>';
         $(".in").append(innerList);
      }
   }
   
function follow(i){
   if ($("#sessionID").val() != "") {
         var query = {
            sessionID : $("#sessionID").val(),
            userID : $("#folUserID_"+i).val()
         };
         $.ajax({
            url : "/member/follow",
            type : "post",
            data : query,
            success : function() {
               $("#member_"+i).remove();
            },
            error : function(request, status, error) {
               alert("code:" + request.status + "\n" + "message:"
                     + request.responseText + "\n" + "error:" + error);
            }
         });
      }
}

function unFollow(i){
   if ($("#sessionID").val() != "") {
         var query = {
            sessionID : $("#sessionID").val(),
            userID : $("#folUserID_"+i).val()
         };
         $.ajax({
            url : "/member/unFollow",
            type : "post",
            data : query,
            success : function() {
               $("#member_"+i).remove();
            },
            error : function(request, status, error) {
               alert("code:" + request.status + "\n" + "message:"
                     + request.responseText + "\n" + "error:" + error);
            }
         });
      }
}

function textOverCut(text, type) {
   var lastText = "...";

   if(type == "title"){
      var len = 12;
   } else{
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
   if(sessionStorage.getItem("nav") == "list"){
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
   } else{
      if((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) < 1){
         if ((curTime.getTime() - d.getTime()) / (1000 * 60 * 60) >= 1) {
            return Math.round((curTime.getTime() - d.getTime())
                  / (1000 * 60 * 60))
                  + "시간전";
         } else {
            return Math.round((curTime.getTime() - d.getTime()) / (1000 * 60))
                  + "분전";
         }
      } else if((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) < 7) {
         return Math.floor((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24)) + "일전";
      } else {
         return Math.floor((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) / 7) + "주전";
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
   for (var i = 0; i < 4; i++) {
      if (file[count][i] != undefined) {
         $("#img_" + bno).append(
               '<a href="/board/view?bno=' + bno
               + '"><img width="100" height="100" id="img_' + bno
               + '_' + i + '" alt="" src=' + file[count][i].path
               + '></a>');
      } else {
         break;
      }
      if(file[count].length > 4){
         console.log("+"+ (file[count].length - 4));
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