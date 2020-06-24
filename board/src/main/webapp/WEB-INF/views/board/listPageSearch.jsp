<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet"
   href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
</head>

<body>
   <!-- 상단 바 -->
   <div id="header">
      <!-- 로고 -->
      <div class="logo">
         <a href="/board/listPageSearch?num=1">SAMPLE</a>
      </div>
      <!-- 검색창 -->
      <div class="wrap">
         <div class="search">
            <select class="ss" name="searchType">
               <option value="title">제목</option>
               <option value="writer">작성자</option>
            </select> <input type="text" class="searchTerm" name="keyword"
               placeholder="어떤 곳을 찾으시나요?">
            <button type="button" class="searchButton" id="searchBtn">
               <i class="fa fa-search"></i>
            </button>
         </div>
      </div>

      <!-- 사용자 로그인 현황 -->
      <div class="log">
         <c:if test="${session != null }">
            <!-- 로그인했을때 -->
            <div id="r">
               <div class="profile">
                  <a href="/member/myPage?num=1&userID=${session.id }"><img
                     src="${session.mImg }" /> </a>
                  <p>${session.mNickname }님</p>
               </div>
            </div>

            <div id="writebutton">
               <!-- 게시물 작성 버튼-->
               <a href="/board/write"><img src="/resources/imgs/w1.png" /></a>
            </div>
         </c:if>

         <c:if test="${session == null }">
            <!-- 로그인 안했을때 -->
            <div id="rr">
               <a href="/member/login"><img src="/resources/imgs/p1.png"></a>
            </div>
         </c:if>
      </div>




   </div>


<div class="main">
   
   <div id="list">
      <a href="">인기순</a> | 
      <a href="">최신순</a> | 
      <a href="">이웃게시물</a>
   </div>


   <c:forEach items="${list}" var="list">
      <div id="table">
         <div id="up">
            <div id="left">               
               <div class="writer" id="writer${list.bno }"></div>
            </div>
          
            <div id="right">
            <ul>
            <!--  날짜 or 시간    -->
            <li>
            <div class="r-1">
               <input  type="hidden" id="time${list.bno }"
                     value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.regDate}" />' />
                  <div id="date${list.bno }" class="date"></div>
                       
            </div>
            </li>
            <li>
            <!-- 아이디 & 공감수 & 조회수 & 공개 범위 -->
            <div class="r-2">
               <div class="name" id="nickname${list.bno }"></div>
               <div id ="likeCnt"><i class="fas fa-paw" ></i>${list.likeCnt}</div>
               <div id="viewCnt">${list.viewCnt}</div>
               <div class="pNum" id="pNum${list.pNum }">               
                  <c:choose>
                           <c:when test="${list.pNum eq -1 }"><i class="fas fa-globe-americas"></i>
                          </c:when>
                           <c:when test="${list.pNum eq -2 }"><i class="fas fa-lock"></i>
                           </c:when>
                          <c:otherwise><i class="fas fa-user-friends"></i>   
                          </c:otherwise>
                        </c:choose>                     
               </div>
            </div> 
            </li>
            <li>  
            <!-- 제목 -->
              <div id="title">
               <i class="fas fa-caret-right fa-2x"></i> 
               <a href="/board/view?bno=${list.bno}">${list.title}</a>
              </div>
            </li>
            </ul>
            </div>
            
            
         </div>         
               
         <div id="downimg">
         
               <c:forEach items="${fileList }" var="fileList">
                  <c:forEach items="${fileList }" var="fileList" end="3">
                     <c:if test="${fileList.fileBno == list.bno}">
                        <img width="100" height="100" alt=""
                           src="<spring:url value='${fileList.path }'/>">
                     </c:if>
                  </c:forEach>
               </c:forEach>
               </div>


         </div>
      </c:forEach>




      <div id="pagelist">
         <c:if test="${page.prev}">
            <span><a
               href="/board/listPageSearch?num=${page.startPageNum - 1}">◀ </a></span>
         </c:if>

         <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}"
            var="num">
            <span> <c:if test="${select != num}">
                  <a href="/board/listPageSearch?num=${num}">${num}</a>
               </c:if> <c:if test="${select == num}">
                  <b>${num}</b>
               </c:if>

            </span>
         </c:forEach>

         <c:if test="${page.next}">
            <span><a
               href="/board/listPageSearch?num=${page.endPageNum + 1}">▶</a></span>
         </c:if>


      </div>
   </div>



   <script>
      var mImg = new Array();
      var mNickname = new Array();
      var bno = new Array();
      var userID = new Array();

      <c:forEach items="${member }" var="member">
      mImg.push("${member.mImg }");
      mNickname.push("${member.mNickname }");
      userID.push("${member.id}");
      </c:forEach>
      <c:forEach items="${list}" var="list">
      bno.push("${list.bno }");
      </c:forEach>
      console.log(bno.length);
      for (i = 0; i < bno.length; i++) {
         document.getElementById("writer" + bno[i]).innerHTML = '<a href="/member/myPage?num=1&userID='
               + userID[i] + '"><img alt="" src=' + mImg[i] + '></a>';
         document.getElementById("nickname" + bno[i]).innerHTML = '<a href="/member/myPage?num=1&userID='
               + userID[i] + '">' + mNickname[i] + ' 님</a>';
         document.getElementById("date" + bno[i]).innerHTML = getTimeStamp(document
               .getElementById("time" + bno[i]).value);
      }

      document.getElementById("searchBtn").onclick = function() {

         let searchType = document.getElementsByName("searchType")[0].value;
         let keyword = document.getElementsByName("keyword")[0].value;

         location.href = "/board/listPageSearch?num=1" + "&searchType="
               + searchType + "&keyword=" + keyword;
      };

      function getTimeStamp(time) {
         console.log(time)
         var curTime = new Date();
         var d = new Date(time);
         var year;
         var month;
         var day;
         console.log((curTime.getTime() - d.getTime())
               / (1000 * 60 * 60 * 24));
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
               return Math.round((curTime.getTime() - d.getTime())
                     / (1000 * 60))
                     + "분전";
            }
         }
      }
   </script>


</body>

</html>