<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<div class="main">
      <c:if test="${session != null }">
         <%@ include file="../include/navLogin.jsp"%>
      </c:if>
      <c:if test="${session == null }">
         <%@ include file="../include/navLogout.jsp"%>
      </c:if>
      
      <div class="modify">
         <c:if test="${session.id eq userID }"><a href="/member/profile"><i class="fas fa-cog fa-3x"></i></a></c:if>
      </div>
      
      <div class="ff">
            <img alt="" src="<spring:url value='${session.mImg }'/>">
      </div>
      
      
      <div class="one">${session.mNickname } 님</div>
      
      게시글 : ${count } 서로이웃 : ${countFollow } 이웃신청 : ${countFollowing }
      <br/>
      <c:if test="${session.id ne userID }"><button id="bFollow"></button></c:if>
   
   
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
   
   
   
<div class="in">
      <nav id="nav">
          <ul>
              <li><a href="#">나의 게시물</a></li>
              <li><a href="#">이웃 목록</a></li>
              <li><a href="#">이웃 요청</a></li>
           </ul>
    </nav>
   <c:forEach items="${list}" var="list">
 
   
      <div id="table">
         <div id="ttt">                           
               
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

</div>
   
<script>
      
   var mImg = new Array();
   var mNickname = new Array();
   var bno = new Array();
         
   <c:forEach items="${member }" var="member">
      mImg.push("${member.mImg }");
      mNickname.push("${member.mNickname }");
   </c:forEach>
   <c:forEach items="${list}" var="list">
      bno.push("writer${list.bno }");
   </c:forEach>
      
   for(i=0;i<bno.length;i++){
      document.getElementById(bno[i]).innerHTML = '<img width="100" height="100" alt="" src=' + mImg[i] + '><br/>' + mNickname[i] + '';   
   }
      document.getElementById("searchBtn").onclick = function() {

      let searchType = document.getElementsByName("searchType")[0].value;
      let keyword = document.getElementsByName("keyword")[0].value;

      location.href = "/board/listPageSearch?num=1" + "&searchType="
            + searchType + "&keyword=" + keyword;
   };
         
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
         
</script>

</body>

</html>