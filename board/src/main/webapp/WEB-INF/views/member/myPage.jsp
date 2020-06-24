<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
   <meta charset="UTF-8">
   <title>insert title here</title>
   <link rel="stylesheet" href="/resources/css/top.css">
   <link rel="stylesheet" href="/resources/css/mypage.css">
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
   <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body>

<!-- 상단 바 -->
<div id="header">
   <!-- 로고 -->
     <div class="logo">
       <a href="/board/listPageSearch?num=1">SAMPLE</a>
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

<div class="out">
       <c:if test="${session != null }">
         <%@ include file="../include/navLogin.jsp"%>
      </c:if>
      <c:if test="${session == null }">
         <%@ include file="../include/navLogout.jsp"%>
      </c:if>
</div> 
  
<div class="main"> 
             
      <div class="modify">
         <c:if test="${session.id eq userID }"><a href="/member/profile"><i class="fas fa-cog fa-3x"></i></a></c:if>
      </div>
      
      <div class="ff">
            <img alt="" src="<spring:url value='${member.mImg }'/>">
      </div>
      
      
      <div class="one">${member.mNickname } 님</div>
      
      <div class="show">게시글 : ${count } 서로이웃 : ${countFollow } <c:if test="${session.id eq userID }">이웃신청 : ${countFollowing }</c:if></div>

      <c:if test="${session.id ne userID }"><button id="bFollow"></button></c:if>
<!--     
   <div>
      서로이웃
      <c:forEach items="${follow }" var="follow">
      <a href="/member/myPage?num=1&userID=${follow.id }"><img width="100" height="100" alt="" src="<spring:url value='${follow.mImg }'/>"></a>
      <a href="/member/myPage?num=1&userID=${follow.id }">${follow.mNickname }</a>
   </c:forEach>

   </div>
   <div>
   이웃신청
   
   <c:forEach items="${following }" var="following">
      <a href="/member/myPage?num=1&userID=${following.id }"><img width="100" height="100" alt="" src="<spring:url value='${following.mImg }'/>"></a>
      <a href="/member/myPage?num=1&userID=${following.id }">${following.mNickname }</a>
   </c:forEach>   
   </div>
-->
   
<div class="all">
   <div class="nav">
              <div class="o"><a href="#"><i class="fas fa-clipboard fa-2x"></i></a></div>
              <div class="t"><a href="#"><i class="fas fa-users fa-2x"></i></a></div>
              <c:if test="${session.id eq userID }"><div class="th"><a href="#"><i class="fas fa-user-plus fa-2x"></i></a></div></c:if>
    </div>
<div class="in">
      
   <c:forEach items="${list}" var="list">
   
 <div id="table">
         <div id="up">       
         
                  
         
         
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
            
            <div id="title">
               <i class="fas fa-caret-right fa-2x"></i> 
               <a href="/board/view?bno=${list.bno}">${list.title}</a>
              </div>
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
               <div id="viewCnt">${list.viewCnt}</div>                             
               <div id ="likeCnt"><i class="fas fa-paw" ></i>${list.likeCnt}</div>
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
</div>
</div>
   
<script>
      
   var bno = new Array();
         
   <c:forEach items="${list}" var="list">
      bno.push("${list.bno }");
   </c:forEach>
      
   for (i = 0; i < bno.length; i++) {
       
      
       document.getElementById("date" + bno[i]).innerHTML = getTimeStamp(document
             .getElementById("time" + bno[i]).value);
    }

      /* document.getElementById("searchBtn").onclick = function() {

      let searchType = document.getElementsByName("searchType")[0].value;
      let keyword = document.getElementsByName("keyword")[0].value;

      location.href = "/board/listPageSearch?num=1" + "&searchType="
            + searchType + "&keyword=" + keyword;
   }; */
         
    window.onload = function(){
       followCheck();
    }
   $("#bFollow").click(function(){
      var query = {
             sessionID : "${session.id}",
                    userID : "${userID}"
      };
      $.ajax({
               url : "/member/followClick",
                type : "post",
                data : query,
                success : function() {
                   followCheck();
                },
                 error:function(request,status,error){
                       alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                 }
            });
      });
          
          
   function followCheck(){
             if("${session }" != ""){
              var query = {
                    sessionID : "${session.id}",
                    userID : "${userID}"
              };
              $.ajax({
                url : "/member/followingCheck",
                type : "post",
                 data : query,
                 success : function(check) {
                   if(check == 1){
                       $("#bFollow").text("요청됨");
                    } else if(check == 2){
                       $("#bFollow").text("서로이웃");
                    } else{
                       $("#bFollow").text("이웃추가");
                    }
                 },
                 error:function(request,status,error){
                       alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                  }
              });
              }
    }
   
   
   
   
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