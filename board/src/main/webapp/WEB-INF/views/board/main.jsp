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
<link rel="stylesheet" href="/resources/dist/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/resources/js/jquery.bxslider.min.js"></script>
<!--<script src="http://code.jquery.com/jquery-latest.min.js"></script>  -->
<script src="/resources/js/listPage.js?var=2"></script>
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
         <a href="/board/main">Plus+</a>
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
             </div>
                  <p id="sessionNickname">${session.mNickname }</p>
            </div>

            <div id="alam">
               <i class="fas fa-bell" onclick="alamPopup()"></i>
            </div>
         
            <div id="writebutton">
               <!-- 게시물 작성 버튼-->
               <a href="/board/write" title="게시물 작성"><i class="far fa-edit"></i></a>
            </div>
         </c:if>
         

         <c:if test="${session == null }">
            <!-- 로그인 안했을때 -->
            <div id="rr">
               <a href="/member/login"><img src="/resources/imgs/p1.png"></a>
            </div>
         </c:if>         
      </div>
            <div class="pop" id="loginPopup" style="display:none">               
                <div class="pi"><a href="/member/myPage?num=1&userID=${session.id }"><i class="fas fa-user-cog"></i>  마이페이지</a></div>
                <div class="pii"><a href="/member/logout"><i class="fas fa-power-off"></i>  로그아웃</a></div>
            </div>
            
            <div class="apop" id="alamPopup" style="display:none">               
                <div class="ai"> <a>알람 내용</a></div>
            </div>
  </div>



   <div class="main">
   <div id="list">
      <span class="listBold" onclick="getList(1)">인기순</span> | 
      <span class="listBold" onclick="getList(2)">최신순</span> | 
      <span class="listBold" onclick="getList(3)">이웃게시물</span>
      
   </div>
   
   <div id="pageList">
   </div>
   </div>
   <input type="hidden" id="userID" value="${session.id }" />

</body>

</html>