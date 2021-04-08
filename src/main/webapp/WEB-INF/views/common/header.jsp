<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>

    <div id="header">
        <div class="top_menu">

            <sec:authorize access="isAnonymous()">
                <span><a href="/account/signIn" class="login-panel">로그인</a></span>
                <span class="header_divider">|</span>
                <span><a href="/account/signUp" class="login-panel">회원가입</a></span>
            </sec:authorize>

            <sec:authorize access="isAuthenticated()">
            <span><form action="/account/logOut" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="btn003">로그아웃</button></form>
            </span>
                <span class="header_divider">|</span>
                <span><sec:authentication property="principal.username"/></span>
            </sec:authorize>

            <span class="header_divider">|</span>
            <span><a href="#" class="login-panel">고객센터</a></span>
        </div>
        <div class="main-logo">
            <div class="home-logo"><a href="/user/home"><img src="/resources/img/logo.png"></a></div>
        </div>
        <div class="main-bar">

            <div class="bar-left">
                <div class="category-drop">
                    <div class="category-btn"><i class="fas fa-bars"></i>&nbsp;전체 카테고리</div>
                </div>
                <div class="leftmenus">
                    <div class="leftmenu">충전하기</div>
                    <div class="leftmenu"><i class="fas fa-map-marker-alt"></i></div>
                </div>
            </div>

            <div class="search">
                <form action="(login)">
                    <input type="text" class="searchbar" placeholder="기쁘티콘">
                    <button class="searchbutton"><i class="fas fa-search"></i></button>
                </form>
            </div>

            <div class="bar-right">

                <span class="rightmenu"><i class="fas fa-ticket-alt"></i></span>

                <span class="rightmenu">판매하기</span>
                <span class="rightmenu"><a href="/user/mypage/mypageDeals">마이페이지</a></span>
            </div>


        </div>
    </div>
</head>

</html>