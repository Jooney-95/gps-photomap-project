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
            
      <div class="listBold" id="category" onclick="getList(4)">
         <i class="fas fa-list"></i><a>카테고리 </a>
      </div>
   </div>
  
     <div class="ttop">
         <p class="set">카테고리 설정</p>
         <p class="set2">카테고리를 선택하면 선택한 주제의 인기순, 최신순으로 정렬할 수 있습니다.<br></p>           
      </div>
   
   <div class="kategorie hidden">
        <p><i class="fas fa-caret-right"></i> 테마별</p>
         <div class="thema">
         <div class="kate">
               <input type="radio" name="kategorie" id="a1" value="a1" >
               <label for="a1"><button type="button"><i class="fas fa-tree"></i> 피크닉</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="b1" value="b1" >
               <label for="b1"><button type="button"><i class="far fa-image"></i> 전시회</button></label>
            </div> 
         <div class="kate">
               <input type="radio" name="kategorie" id="c1" value="c1" >
               <label for="c1"><button type="button"><i class="fas fa-university"></i> 박물관</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="d1" value="d1" >
               <label for="d1"><button type="button"><i class="fas fa-utensils"></i> 맛집투어</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="e1" value="e1" >
               <label for="e1"><button type="button">사진명소</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="f1" value="f1" >
               <label for="f1"><button type="button"><i class="fas fa-car"></i> 드라이브</button></label>
            </div>
                     <div class="kate">
               <input type="radio" name="kategorie" id="g1" value="g1" >
               <label for="g1"><button type="button">데이트</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="h1" value="h1" >
               <label for="h1"><button type="button"><i class="fas fa-mountain"></i> 등산</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="i1" value="i1" >
               <label for="i1"><button type="button"><i class="fas fa-umbrella-beach"></i> 바다</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="j1" value="j1" >
               <label for="j1"><button type="button"><i class="fas fa-water"></i> 강</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="k1" value="k1" >
               <label for="k1"><button type="button"><i class="fas fa-fish"></i> 낚시</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="l1" value="l1" >
               <label for="l1"><button type="button">엑티비티</button></label>
            </div> 
         <div class="kate">
               <input type="radio" name="kategorie" id="m1" value="m1" >
               <label for="m1"><button type="button">호캉스</button></label>
            </div>                                                             
         </div>
         
        <p><i class="fas fa-caret-right"></i> 지역별</p>
         <div class="area">
         <div class="kate">
               <input type="radio" name="kategorie" id="a2" value="a2" >
               <label for="a2"><button type="button">서울특별시</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="b2" value="b2" >
               <label for="b2"><button type="button">경기도</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="c2" value="c2" >
               <label for="c2"><button type="button">인천광역시</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="d2" value="d2" >
               <label for="d2"><button type="button">강원도</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="e2" value="e2" >
               <label for="e2"><button type="button">대구광역시</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="f2" value="f2" >
               <label for="f2"><button type="button">경상북도</button></label>
            </div>
                     <div class="kate">
               <input type="radio" name="kategorie" id="g2" value="g2" >
               <label for="g2"><button type="button">부산광역시</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="h2" value="h2" >
               <label for="h2"><button type="button">울산광역시</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="i2" value="i2" >
               <label for="i2"><button type="button">경상남도</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="j2" value="j2" >
               <label for="j2"><button type="button">충청북도</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="k2" value="k2" >
               <label for="k2"><button type="button">세종특별자치시</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="l2" value="l2" >
               <label for="l2"><button type="button">대전광역시</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="m2" value="m2" >
               <label for="m2"><button type="button">충청남도</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="n2" value="n2" >
               <label for="n2"><button type="button">전라북도</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="o2" value="o2" >
               <label for="o2"><button type="button">광주광역시</button></label>
            </div>  
         <div class="kate">
               <input type="radio" name="kategorie" id="p2" value="p2" >
               <label for="p2"><button type="button">전라남도</button></label>
            </div> 
         <div class="kate">
               <input type="radio" name="kategorie" id="q2" value="q2" >
               <label for="q2"><button type="button">제주특별시</button></label>
            </div>                                                                                                                    
         </div>
         
       <p><i class="fas fa-caret-right"></i> 모임/단체별</p>
         <div class="group">
         <div class="kate">
               <input type="radio" name="kategorie" id="a3" value="a3" >
               <label for="a3"><button type="button">가족</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="b3" value="b3" >
               <label for="b3"><button type="button">연인</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="c3" value="c3" >
               <label for="c3"><button type="button">우정</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="d3" value="d3" >
               <label for="d3"><button type="button">대학교</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="e3" value="e3" >
               <label for="e3"><button type="button">동아리</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="f3" value="f3" >
               <label for="f3"><button type="button">동호회</button></label>
            </div>
         <div class="kate">
               <input type="radio" name="kategorie" id="g3" value="g3" >
               <label for="g3"><button type="button">회사</button></label>
            </div>                                                  
         </div>                  
         
         <div class="kateall">
            <input type="radio" name="kategorie" id="all" value="" checked >
          <label for="all">카테고리 설정 안함</label>
         </div>
         
         <div class="check">
            <button type="button">확인</button>
         </div>
      </div>
   
   <div id="pageList">
   </div>
   </div>
   <input type="hidden" id="userID" value="${session.id }" />

</body>

</html>