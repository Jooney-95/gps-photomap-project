var list;
var file;
var member;
var page;
var following;
var pageNumber;
var likeImg;

window.onload = function() {
   sessionStorage.setItem("nav", "list");
   getMyPageList(1);
   setNav(1);
   unSetNav(1);
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
   
   
   
}
function unSetNav(nav) {

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
      sessionStorage.setItem("nav", "like");
      setNav(nav);
      unSetNav(nav);
      break;
   case 3:
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
      like : "/member/getLikePage",
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
               page = JSON.parse(data.page);
               list = JSON.parse(data.board);
               file = JSON.parse(data.file);
               likeImg = JSON.parse(data.likeImg);
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
      innerList =  '  <div id="table">';
      
      innerList += '     <ul>';
      innerList += '        <li>';
      innerList += '       <div id="left">';
      innerList += '          <div class="writer" id="writer_' + list[i].bno + '"><a href="/member/myPage?num=1&userID=' + $("#userID").val() + '"><img alt="" src='+$(".ff > img").attr("src")+'></div><a>';
      innerList += '      </div>';
      innerList += '          <a href="/member/myPage?num=1&userID=' + $("#userID").val() + '"><div class="name">'+$(".one").text()+'</div></a>';
      innerList += '        </li>';
      
      innerList += '        <li>';      
      innerList += '        <div class="r-1">';
      innerList += '            <div class="pNum" id="pNum_' + list[i].bno + '"></div>';
      innerList += '             <div id="date_' + list[i].bno + '" class="date">' + getTimeStamp(list[i].regDate) + '</div>';
      innerList += '            <div id="viewCnt">조회수 ' + list[i].viewCnt + '회</div>';
      innerList += '         </div>';
      innerList += '        </li>';
      innerList += '      </ul>';
      
      innerList += '      <ul>';
      innerList += '        <li>';
      innerList += '       <div class="downimg" id="img_' + list[i].bno + '">';
      innerList += '             <div class="imgContainer" id="imgContainer_' + list[i].bno + '">';
      innerList += '                <ul class="slider" id="slider_' + list[i].bno + '">';
      innerList += '                </ul>';
      innerList += '           </div>';
      innerList += '       </div>';
      innerList += '        </li>';
      innerList += '       </ul>';
      
      innerList += '       <ul>';
      innerList += '        <li>';
      innerList += '            <div id="title" title="' + list[i].title + '">';
      innerList += '                <div id="ta">';
      innerList += '                   <i class="fas fa-caret-right fa-2x"></i>';
      innerList += '                   <a href="/board/view?bno=' + list[i].bno + '">' + list[i].title + '</a>';
      innerList += '                </div>';      
      innerList += '                <div id ="likeCnt"><i class="far fa-thumbs-up"></i>' + number(list[i].likeCnt) + '</div>';
      innerList += '            </div>';
      innerList += '          </li>';    
      innerList += '        </ul>';
      innerList += '    </div>';
      innerList += ' </div>';

      $(".in").append(innerList);
      getPNum(list[i].pNum, list[i].bno);
      // getImg(list[i].bno, count);
      getImg(list[i].bno, count);

      count++;
   }
   $('.slider').bxSlider({touchEnabled : (navigator.maxTouchPoints > 0)});

}

function addListMyFforf(data) {
      for (var i = 0; i < member.length; i++) {
         var innerList;
         innerList = '<div class="neighbor"><div class="pro"><a href="/member/myPage?num=1&userID='+member[i].id+'"><img width="100" height="100" alt="" src='
               + member[i].mImg
               + ' /></a></div><div class="nickname">'
               + member[i].mNickname + '</div></div>';
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
               + member[i].mNickname
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


function getTimeStamp(time) {

   var curTime = new Date();
   var d = new Date(time);
   var year;
   var month;
   var day;
   
   if(sessionStorage.getItem("nav") == "list"){
   if ((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) >= 1) {

      year = d.getFullYear() + '-';

      if (d.getMonth() < 9) {
         month = "0" + (d.getMonth() + 1) + '-';
      } else {
         month = (d.getMonth() + 1) + '-';
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
         if(Math.round((curTime.getTime() - d.getTime()) / (1000 * 60)) == 0){
            return "방금 전";   
         } else{
         return Math.round((curTime.getTime() - d.getTime()) / (1000 * 60))
            + "분전";
         }
      }
   }
   } else{
      if((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) < 1){
         if ((curTime.getTime() - d.getTime()) / (1000 * 60 * 60) >= 1) {
            return Math.round((curTime.getTime() - d.getTime())
                  / (1000 * 60 * 60))
                  + "시간전";
         } else {
            if(Math.round((curTime.getTime() - d.getTime()) / (1000 * 60)) == 0){
               return "방금 전";   
            } else{
            return Math.round((curTime.getTime() - d.getTime()) / (1000 * 60))
               + "분전";
            }
         }
      } else if((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) < 7) {
         return Math.floor((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24)) + "일전";
      } else {
         return Math.floor((curTime.getTime() - d.getTime()) / (1000 * 60 * 60 * 24) / 7) + "주전";
      }
   }
}


function getImgSlider(bno, count){
   for(var i=0; i<file[count].length;i++){
      imgSlider(bno, i, file[count][i].fileName);
   }
}

function imgSlider(bno, index, fileName){
   var imgInner;
   imgInner = '   <li class="sliderItem">';
   imgInner += '     <a href="/board/view?bno=' + bno + '">';
   imgInner += '        <img id="img_' + bno + '_' + index + '" alt="" src=' + "/img/thumb/" + fileName +  '>';
   imgInner += '     </a>';
   imgInner += '  </li>';
   $("#slider_" + bno).append(imgInner);
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
   var iCount;
   var imgFlag = true;
   for (var i = 0; i < 4; i++) {
      iCount = i;
      if (likeImg[count][i] != undefined) {
         var imgObj = file[count].filter(function (obj) { return obj.id == likeImg[count][i].imgBno });
         //printImg(bno, i, imgObj[0].fileName)
         imgSlider(bno, i, imgObj[0].fileName);

      } else {
         var j = 0;
         while (imgFlag) {
            if ((file[count][j] != undefined) && (likeImg[count].filter(function (obj) { return obj.imgBno == file[count][j].id })[0] == undefined)) {
               imgSlider(bno, iCount, file[count][j].fileName)
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
   imgInner += '     <img width="100" height="100" id="img_' + bno + '_' + index + '" alt="" src=' + path + '>';
   imgInner += '  </a>';
   $("#img_" + bno).append(imgInner);
}

function getImgSlider(bno, count){
   for(var i=0; i<file[count].length;i++){
      imgSlider(bno, i, file[count][i].fileName);
   }
}

function imgSlider(bno, index, fileName){
   var imgInner;
   imgInner = '   <li class="sliderItem">';
   imgInner += '     <a href="/board/view?bno=' + bno + '">';
   imgInner += '        <img id="img_' + bno + '_' + index + '" alt="" src=' + "/img/thumb/" + fileName + '>';
   imgInner += '     </a>';
   imgInner += '  </li>';
   $("#slider_" + bno).append(imgInner);
}

function number(n){
      var number = parseFloat(n);
      if(number > 1000000000){
         return parseInt(number / 1000000000) + "." + parseInt((number % 1000000000) / 100000000) + "B";
         // break;
      } else if(number > 1000000){
         return parseInt(number / 1000000) + "." + parseInt((number % 1000000) / 100000) + "M";
         // break;
      } else if(number > 1000){
         return parseInt(number / 1000) + "." + parseInt((number % 1000) / 100) + "K"
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