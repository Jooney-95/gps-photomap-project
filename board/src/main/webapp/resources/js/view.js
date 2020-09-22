
$(document).ready(function () {
   lightbox.option({
      disableScrolling: true,
      fadeDuration: 0,
      imageFadeDuration: 0,
      resizeDuration: 0,
      wrapAround: true
   })
   countLike();
   likeCheck();
   likeImg();
});

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
         alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
      }
   });
}

function likeImg() {
   for (var i = 0; i < likeImgArr.length; i++) {
      $("#selectLikeImg_" + likeImgArr[i]).removeClass("hidden")
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
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
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
      $(".type1").css('border-bottom', '1px solid #7f7e7e');
      $(".type2").css('border-bottom', '1px solid #f2f0f0');
      $("#gg").css('color', '#7f7e7e');
      $("#ll").css('color', '#ccc');

   } else {
      $(".original").css("display", "");
      $(".gallery").css("display", "none");
      $(".type2").css('border-bottom', '1px solid #7f7e7e');
      $(".type1").css('border-bottom', '1px solid #f2f0f0');
      $("#ll").css('color', '#7f7e7e');
      $("#gg").css('color', '#ccc');
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
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
         }
      });
   }
}

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