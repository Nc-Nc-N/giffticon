<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
    <div class= "top_menu">
        <span><a href="#" class="login-panel">로그인</a></span>
        <span class="header_divider">|</span>
        <span><a href="#" class="login-panel">회원가입</a></span>
        <span class="header_divider">|</span>
        <span><a href="#" class="login-panel">고객센터</a></span>
    </div>
    <div class="main-logo">
        <div class="home-logo"><img src="/resources/img/logo.png" ></div>
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
            <form id="searchForm" action="/user/prod_list" method="get">
                <input type="text" class="searchbar" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' />
                <input type="hidden" name="code" value="${pageMaker.cri.code}"/>
                <input type="hidden" name="orderby" value="best"/>
                <input type="hidden" name="pageNum" value="1"/>
                <input type="hidden" name="amount" value="${pageMaker.cri.amount}"/>
                <button class="searchbutton"><i class="fas fa-search"></i> </button>
            </form>
        </div>
        
        <div class="bar-right">
           
            <span class="rightmenu"><i class="fas fa-ticket-alt"></i></span>
           
            <span class="rightmenu">판매하기</span>
            <span class="rightmenu">마이페이지</span>
        </div>

    </div>
</div>
</head>

</html>