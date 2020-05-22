<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">  
<title>Main</title>

<link rel="stylesheet" href="${Path}/resources/css/style.css">
<link rel="stylesheet" href="${Path}/resources/css/common.css">
</head>
<body>
<!-- 네비게이션 바 -->
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
                <a href="/board/listPageSearch?num=1"><div class="sprite_camera_icon"></div></a>
                <a href="login.html"><div class="sprite_compass_icon"></div></a>
                <a href="follow.html"><div class="sprite_heart_icon_outline"></div></a>
                <a href="profile.html"><div class="sprite_user_icon_outline"></div></a>
            </div>
        </section>
    </header>
	
	
	<div id="nav">
		<%@ include file="./include/nav.jsp"%>
	</div>
	
	<p><a href="/board/listPageSearch?num=1">게시물 목록</a>
	<a href="/board/write">게시물 작성</a>
	</p>
</body>
</html>
