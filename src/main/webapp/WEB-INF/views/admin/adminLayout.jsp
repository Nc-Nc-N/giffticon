<%--
  Created by IntelliJ IDEA.
  User: lwiii
  Date: 2021-04-11
  Time: 오후 6:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <title></title>
    <link rel="stylesheet" href="/resources/css/admin/adminLayout.css" type="text/css">

    <!-- JQUERY -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- FONTAWESOME -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
<div class="main-container">
    <!-- sidebar -->
    <div id="sidebar">
        <div>
            <div class="logo">
                <a href="/admin/main"><img src="/resources/img/admin-logo.png"/></a>
            </div>
            <div id="admin-menu">
                <a href="/admin/user/userlist" id="userAdministration"><i class="fas fa-user-cog"></i>회원관리</a>
                <a href="/admin/product/prodList" id="prodAdministration"><i class="fas fa-boxes"></i>상품관리</a>
                <a href="#"><i class="fas fa-brush"></i>배너관리</a>
                <a href="/admin/request/list" id="rqustAdministration"><i class="far fa-check-circle"></i>판매요청관리</a>
                <a href="/admin/deal-history" id="dealHistAdministration"><i class="fas fa-exchange-alt"></i>거래내역관리</a>
                <a href="#"><i class="fas fa-coins"></i>포인트관리</a>
                <a href="/admin/adminNotice" id="adminCs"><i class="fas fa-bullhorn"></i>고객센터</a>
                <!-- <a href="#"><i class="fas fa-chart-pie"></i>통계</a> -->
            </div>
        </div>
    </div>
    <div id="container">

        <div id="content">

            <div id="main">

                <div class="header">
                    <div class="admin-info">
                        <sec:authorize access="isAuthenticated()">
                            <div><sec:authentication property="principal.username"/></div>
                        </sec:authorize>

                        <div class="sign-link">
                            <sec:authorize access="isAnonymous()">
                                <span><a href="/account/signIn" class="login-panel">로그인</a></span>
                            </sec:authorize>

                            <sec:authorize access="isAuthenticated()">
                                <form action="/account/logOut" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="logout-btn">로그아웃</button>
                                </form>
                            </sec:authorize>
                        </div>
                    </div>
                </div>