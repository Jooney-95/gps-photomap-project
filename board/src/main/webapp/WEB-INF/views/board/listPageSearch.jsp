<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
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
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
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
         </select>
        <input type="text" class="searchTerm" name="keyword" placeholder="어떤 곳을 찾으시나요?">
        <button type="button" class="searchButton" id="searchBtn">
           <i class="fa fa-search"></i>
        </button>
    </div>
</div>

     <!-- 사용자 로그인 현황 -->
      <div class="log">
            <c:if test="${session != null }"> <!-- 로그인했을때 -->
               <div id="r">
               <div class="profile">
                   <a href="/member/myPage?num=1&userID=${session.id }"><img src="${session.mImg }"/>
                    </a>
                    <p>${session.mNickname } 님</p>
                  </div>       
               </div>
            
            <div id="writebutton"> <!-- 게시물 작성 버튼-->
                   <a href="/board/write"><img src="/resources/imgs/w1.png"/></a>
            </div>  
            </c:if>
            
            <c:if test="${session == null }"> <!-- 로그인 안했을때 -->
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
         <div id="ttt">
            <div id="l">               
               <div class="writer" id="writer${list.bno }"></div>
            </div>
                           
            <div id="rrr">   
               <div class="name" id="nickname${list.bno }"></div>
               
               <div class="pNum" id="pNum${list.pNum }">               
                  <c:choose>
                           <c:when test="${list.pNum eq -1 }"> [공개]
                          </c:when>
                           <c:when test="${list.pNum eq -2 }"> [비공개]
                           </c:when>
                          <c:otherwise>
                          [맞팔공개]   
                          </c:otherwise>
                        </c:choose>                     
               </div>                     
                              
               <div id="date">${list.regDate}</div>               
               <div id="viewCnt">${list.viewCnt}</div>               
               <div id ="likeCnt">${list.likeCnt}</div>
               
               <div id="title"><a href="/board/view?bno=${list.bno}">${list.title}</a></div>
            </div>
            
         </div>         
               
         <div id="inimg">
            <c:forEach items="${fileList }" var="fileList">
               <c:forEach items="${fileList }" var="fileList" end="2">
                  <c:if test="${fileList.fileBno == list.bno}">
                     <img width="100" height="100" alt="" src="<spring:url value='${fileList.path }'/>">                  
                  </c:if>
               </c:forEach>
            </c:forEach>
         </div>
                  

      </div>                           
   </c:forEach>



   <div>
      <c:if test="${page.prev}">
         <span>[ <a href="/board/listPageSearch?num=${page.startPageNum - 1}">이전</a> ]</span>
      </c:if>

      <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
         <span>

            <c:if test="${select != num}">
               <a href="/board/listPageSearch?num=${num}">${num}</a>
            </c:if>

            <c:if test="${select == num}">
               <b>${num}</b>
            </c:if>

         </span>
      </c:forEach>

      <c:if test="${page.next}">
         <span>[ <a href="/board/listPageSearch?num=${page.endPageNum + 1}">다음</a> ]</span>
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
         
         for(i=0;i<bno.length;i++){
             document.getElementById("writer"+bno[i]).innerHTML = '<a href="/member/myPage?num=1&userID=' + userID[i] + '"><img alt="" src=' + mImg[i] + '></a>';
             document.getElementById("nickname"+bno[i]).innerHTML = '<a href="/member/myPage?num=1&userID=' + userID[i] + '">' + mNickname[i] + '</a>';
          }

         document.getElementById("searchBtn").onclick = function() {

            let searchType = document.getElementsByName("searchType")[0].value;
            let keyword = document.getElementsByName("keyword")[0].value;

            location.href = "/board/listPageSearch?num=1" + "&searchType="
                  + searchType + "&keyword=" + keyword;
         };
      </script>
   

</body>

</html>