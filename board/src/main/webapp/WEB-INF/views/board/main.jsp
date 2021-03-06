<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Plus+</title>
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
   <div class="list">
      <div class="listBold" id="best" onclick="getList(1)">
         <i class="far fa-thumbs-up"></i><a>인기순 </a>
      </div>
       
      <div class="listBold" id="latest" onclick="getList(2)">
         <i class="fas fa-history"></i><a>최신순</a>
      </div>
       
      <div class="listBold" id="neighbor" onclick="getList(3)">
         <i class="fas fa-users"></i><a>이웃게시물</a>
      </div>
            
      <div class="listBold" id="category" onclick="divShow();">
         <i class="fas fa-list"></i><a>카테고리 </a>
      </div>
   </div>
   <span id="katetext"></span>  
     <div class="ttop" id="ttop" style="display:none;">
         <p class="set">카테고리</p>
         <p class="set2">원하는 분야별로 게시물을 정렬하여 볼 수 있습니다.<br></p>           
      </div>
   
   <div class="kategorie hidden" id="kategorie" style="display:none;">
        <p><i class="fas fa-caret-right"></i> 테마별</p>
         <div class="thema">
         <div class="kate">
               <input type="radio" name="kategorie" id="a1" value="a1" >
               <label for="a1"><img src="/resources/imgs/kkk1.png"><br>피크닉</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="b1" value="b1" >
               <label for="b1"><img src="/resources/imgs/kkk2.png"><br>전시회</label>
            </div> 
         <div class="kate">
               <input type="radio" name="kategorie" id="c1" value="c1" >
               <label for="c1"><img src="/resources/imgs/kkk3.png"><br>박물관</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="d1" value="d1" >
               <label for="d1"><img src="/resources/imgs/kkk4.png"><br>맛집투어</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="e1" value="e1" >
               <label for="e1"><img src="/resources/imgs/kkk5.png"><br>사진명소</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="f1" value="f1" >
               <label for="f1"><img src="/resources/imgs/kkk6.png"><br>드라이브</label>
            </div>
                     <div class="kate">
               <input type="radio" name="kategorie" id="g1" value="g1" >
               <label for="g1"><img src="/resources/imgs/kkk7.png"><br>데이트</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="h1" value="h1" >
               <label for="h1"><img src="/resources/imgs/kkk8.png"><br>등산</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="i1" value="i1" >
               <label for="i1"><img src="/resources/imgs/kkk9.png"><br>바다</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="j1" value="j1" >
               <label for="j1"><img src="/resources/imgs/kkk10.png"><br>강</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="k1" value="k1" >
               <label for="k1"><img src="/resources/imgs/kkk11.png"><br>낚시</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="l1" value="l1" >
               <label for="l1"><img src="/resources/imgs/kkk12.png"><br>엑티비티</label>
            </div> 
         <div class="kate">
               <input type="radio" name="kategorie" id="m1" value="m1" >
               <label for="m1"><img src="/resources/imgs/kkk13.png"><br>호캉스</label>
            </div>                                                             
         </div>
         
        <p><i class="fas fa-caret-right"></i> 지역별</p>
         <div class="area">
         <div class="kate">
               <input type="radio" name="kategorie" id="a2" value="a2" >
               <label for="a2"><img src="/resources/imgs/k1.png"><br>서울특별시</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="b2" value="b2" >
               <label for="b2"><img src="/resources/imgs/k2.png"><br>경기도</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="c2" value="c2" >
               <label for="c2"><img src="/resources/imgs/k3.png"><br>인천광역시</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="d2" value="d2" >
               <label for="d2"><img src="/resources/imgs/k4.png"><br>강원도</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="e2" value="e2" >
               <label for="e2"><img src="/resources/imgs/k5.png"><br>대구광역시</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="f2" value="f2" >
               <label for="f2"><img src="/resources/imgs/k6.png"><br>경상북도</label>
            </div>
                     <div class="kate">
               <input type="radio" name="kategorie" id="g2" value="g2" >
               <label for="g2"><img src="/resources/imgs/k7.png"><br>부산광역시</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="h2" value="h2" >
               <label for="h2"><img src="/resources/imgs/k8.png"><br>울산광역시</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="i2" value="i2" >
               <label for="i2"><img src="/resources/imgs/k9.png"><br>경상남도</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="j2" value="j2" >
               <label for="j2"><img src="/resources/imgs/k10.png"><br>충청북도</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="k2" value="k2" >
               <label for="k2"><img src="/resources/imgs/k11.png"><br>세종특별자치시</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="l2" value="l2" >
               <label for="l2"><img src="/resources/imgs/k12.png"><br>대전광역시</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="m2" value="m2" >
               <label for="m2"><img src="/resources/imgs/k13.png"><br>충청남도</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="n2" value="n2" >
               <label for="n2"><img src="/resources/imgs/k14.png"><br>전라북도</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="o2" value="o2" >
               <label for="o2"><img src="/resources/imgs/k15.png"><br>광주광역시</label>
            </div>  
         <div class="kate">
               <input type="radio" name="kategorie" id="p2" value="p2" >
               <label for="p2"><img src="/resources/imgs/k16.png"><br>전라남도</label>
            </div> 
         <div class="kate">
               <input type="radio" name="kategorie" id="q2" value="q2" >
               <label for="q2"><img src="/resources/imgs/k17.png"><br>제주특별시</label>
            </div>                                                                                                                    
         </div>
         
       <p><i class="fas fa-caret-right"></i> 모임/단체별</p>
         <div class="group">
         <div class="kate">
               <input type="radio" name="kategorie" id="a3" value="a3" >
               <label for="a3"><img src="/resources/imgs/kk1.png"><br>가족</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="b3" value="b3" >
               <label for="b3"><img src="/resources/imgs/kk2.png"><br>연인</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="c3" value="c3" >
               <label for="c3"><img src="/resources/imgs/kk3.png"><br>우정</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="d3" value="d3" >
               <label for="d3"><img src="/resources/imgs/kk4.png"><br>대학교</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="e3" value="e3" >
               <label for="e3"><img src="/resources/imgs/kk5.png"><br>동아리</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="f3" value="f3" >
               <label for="f3"><img src="/resources/imgs/kk6.png"><br>동호회</label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="g3" value="g3" >
               <label for="g3"><img src="/resources/imgs/kk7.png"><br>회사</label>
            </div>                                                  
         </div>                  
         
         <div class="kateall">
            <input type="radio" name="kategorie" id="all" value="" checked >
          <label for="all">카테고리 설정 안함</label>
         </div>
         
         <div class="check">
            <button type="button" onclick="divHide();">확인</button>
         </div>
      </div>

   
   <div id="pageList">
   </div>
   </div>
   <input type="hidden" id="userID" value="${session.id }" />

</body>

</html>