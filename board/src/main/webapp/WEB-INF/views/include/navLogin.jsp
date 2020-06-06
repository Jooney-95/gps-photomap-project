<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<ul>
	<li><a href="/board/listPageSearch?num=1">메인화면</a></li>
	<li><a href="/board/write">게시물 작성</a></li>
	<li><a href="/board/listPageSearch?num=1">게시물 목록</a></li>
	<li><a href="/member/logout">로그아웃</a></li>
	<li><a href="/member/myPage?num=1&userID=${session.id }">마이페이지</a></li>
</ul>