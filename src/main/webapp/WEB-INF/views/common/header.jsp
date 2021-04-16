<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>
</head>
<body>
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

            <!-- search area -->
            <div class="search-bar-container">
                <form id="h-search-form" action="/user/prod_list" method="get">
                    <input type="text" class="h-search-input" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' placeholder=" 브랜드 또는 상품을 검색해보세요." />
                    <input type="hidden" name="code" value='<c:out value="${pageMaker.cri.code}"/>'/>
                    <input type="hidden" name="orderby" value='<c:out value="${pageMaker.cri.orderby}"/>'/>
                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}"/>
                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
                    <button class="h-search-button"><i class="fas fa-search"></i> </button>
                </form>
            </div>

            <div class="bar-right">
                <span class="rightmenu"><i class="fas fa-ticket-alt"></i></span>
                <span class="rightmenu">판매하기</span>
                <span class="rightmenu"><a href="/user/mypage/mypageDeals">마이페이지</a></span>
            </div>
          
        </div>
    </div>
<script>
    // 검색 버튼 이벤트 처리
    let headerSearchForm = $('#h-search-form');

    $("#h-search-form button").on("click", function (e){

        // 다시 생각해보기
        headerSearchForm.find("input[name='code']").val("0");
        headerSearchForm.find("input[name='orderby']").val("best");
        headerSearchForm.find("input[name='pageNum']").val(1);
        headerSearchForm.find("input[name='amount']").val(12);
        e.preventDefault();

        if(!headerSearchForm.find("input[name='keyword']").val()){
            alert("검색어를 입력해주세요");
            return false;
        }
        headerSearchForm.submit();
    });
</script>
</body>
