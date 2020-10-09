<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="/resources/dist/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="/resources/js/jquery.bxslider.min.js"></script>
<script src="/resources/js/myPage.js"></script>
<title>Plus+</title>
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="/resources/css/mypage.css">
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

         <c:if test="${session == null }">
            <!-- 로그인 안했을때 -->
            <div id="rr">
               <a href="/member/login"><img src="/resources/imgs/p1.png"></a>
            </div>
         </c:if>
      </div>

   <div class="main">
<input type="hidden" id="userID" value="${member.id }"/>
<input type="hidden" id="sessionID" value="${session.id }"/>
      <div class="ff">
         <img alt="" src="<spring:url value='${member.mImg }'/>">
      </div>
      <div class="modify">
         <c:if test="${session.id eq userID }">
            <a href="/member/profile"><i class="fas fa-cog fa-3x"></i></a>
         </c:if>
      </div>
      <div class="bFollow">
         <c:if test="${session.id ne userID }">
            <i class="fas fa-user-plus fa-2x" id="bFollow"></i>
         </c:if>
      </div>

      


      <div class="one">${member.mNickname }</div>

      <div class="show">게시글 : ${count } 서로이웃 : ${countFollow }</div>

   <div class="wrapper">
      <div class="all">
      <div class="nav" >

            <div class="listBold" id="o" onclick="getMyPageNav(1)">
               <i class="fas fa-clipboard"></i><a>게시물 </a>
            </div>
            
			<c:if test="${session.id eq userID }">
            <div class="listBold" id="save" onclick="getMyPageNav(2)">
               <i class="fas fa-bookmark"></i><a>저장 목록</a>
            </div>
			</c:if>
			
            <div class="listBold" id="s" onclick="getMyPageNav(3)">
               <i class="fas fa-users"></i><a>이웃 목록</a>
            </div>

              <c:if test="${session.id eq userID }">
            <div class="listBold" id="yesno"  onclick="getMyPageNav(4)">
                <i class="fas fa-user-plus fa-2x"></i><a>이웃 요청</a>
            </div>
            </c:if>
         </div>        
         <div class="in">
         
         </div>
      </div>
    </div>
   </div>

   <script>
      
   </script>

</body>

</html>