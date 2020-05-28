<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>

<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/common.css">
</head>
<body>
	<div id="nav">
		<c:if test="${member != null }">
			<%@ include file="./include/navLogin.jsp"%>
		</c:if>
		<c:if test="${member == null }">
			<%@ include file="./include/navLogout.jsp"%>
		</c:if>
	</div>
	
	<header id="header">
        <section class="inner">

            <h1 class="logo">
                <a href="index.html">
                    <div class="sprite_insta_icon"></div>
                    <div class="sprite_write_logo"></div>
                </a>
            </h1>

            <div class="search_box">
                <input type="text" placeholder="검색" id="search-field">

                <div class="fake_field">
                    <span class="sprite_small_search_icon"></span>
                    <span>검색</span>
                </div>
            </div>

            <div class="right_icons">
                <a href="new_post.html"><div class="sprite_camera_icon"></div></a>
                <a href="login.html"><div class="sprite_compass_icon"></div></a>
                <a href="follow.html"><div class="sprite_heart_icon_outline"></div></a>
                <a href="profile.html"><div class="sprite_user_icon_outline"></div></a>
            </div>

        </section>
    </header>
    
	<p><a href="/board/list">게시물 목록</a>
	<a href="/board/write">게시물 작성</a>
	</p>
	<p>${member.mNickname }</p>
</body>
</html>
