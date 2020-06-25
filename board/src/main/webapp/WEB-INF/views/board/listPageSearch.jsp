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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/listPage.js"></script>
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
               	  <img src="${session.mImg }" onclick="loginPopup()"/>
                  <p>${session.mNickname }님</p>
               </div>
               <div id="loginPopup" style="display:none">
                  <a href="/member/myPage?num=1&userID=${session.id }">마이페이지</a>
                  <a href="/member/logout">로그아웃</a>
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
      <span>인기순</span> | 
      <span id="new" onclick="getPageList(1)">최신순</span> | 
      <span>이웃게시물</span>
      
   </div>
   </div>
   <script>
   document.getElementById("searchBtn").onclick = function() {

       let searchType = document.getElementsByName("searchType")[0].value;
       let keyword = document.getElementsByName("keyword")[0].value;

       location.href = "/board/listPageSearch?num=1" + "&searchType="
             + searchType + "&keyword=" + keyword;
    };
   </script>


</body>

</html>