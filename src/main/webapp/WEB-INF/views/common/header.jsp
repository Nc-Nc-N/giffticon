<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
<html>

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
                <button type="submit" class="logout">로그아웃</button></form>
            </span>
                <span class="header_divider">|</span>
                <span><a class="user-email"><sec:authentication property="principal.username"/></a></span>
            </sec:authorize>


            <span class="header_divider">|</span>
            <span><a href="/user/cs/noticeBoard" class="login-panel">고객센터</a></span>

        </div>


        <div class="main-logo">
            <div class="home-logo"><a href="/user/home"><img src="/resources/img/logo.png"></a></div>
        </div>


        <div class="main-bar">

            <div class="bar-left">
                <div class="category-drop">
                    <ul class="exo-menu">
                        <li class="drop-down">
                            <a href="#"><i class="fas fa-bars"></i>&nbsp;전체 카테고리</a>
                            <%-- Drop Down --%>
                            <ul class="drop-down-ul animated fadeIn">
                            <%-- ajax로 불러옴 --%>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="leftmenus">
                    <div class="leftmenu"><a href="#">충전하기</a></div>
                    <div class="leftmenu"><a href="#"><i class="fas fa-map-marker-alt"></i></a></div>
                </div>

            </div>

            <!-- search area -->
            <div class="search-bar-container">
                <form id="h-search-form" action="/user/prod_list" method="get">
                    <input type="text" class="h-search-input" name="keyword" value='<c:out value="${headerPageMaker.cri.keyword}"/>' placeholder=" 브랜드 또는 상품을 검색해보세요." />
                    <input type="hidden" name="code" value='<c:out value="${headerPageMaker.cri.code}"/>'/>
                    <button class="h-search-button"><i class="fas fa-search"></i> </button>
                </form>
            </div>

            <div class="bar-right">
                <span class="rightmenu"><a href="#"><i class="fas fa-ticket-alt"></i></a></span>
                <span class="rightmenu"><a href="/user/deal/saleGifticon">판매하기</a></span>
                <span class="rightmenu"><a href="/user/mypage/deal">마이페이지</a></span>
            </div>
        </div>
    </div>
</body>

<script>
    // 검색 버튼 이벤트 처리
    let headerSearchForm = $('#h-search-form');

    $("#h-search-form button").on("click", function (e){

        headerSearchForm.find("input[name='code']").val("0");
        e.preventDefault();

        if(!headerSearchForm.find("input[name='keyword']").val()){
            alert("검색어를 입력해주세요");
            return false;
        }
        headerSearchForm.submit();
    });

    // 전체카테고리 메뉴 불러오기
    $(document).ready(function () {
        menuLoader();

        // 카테고리
        function menuLoader() {
            let menu = $('.drop-down-ul');
            $.ajax({
                url: '/user/menuLoader',
                type: 'get',
                async: false,
                success: function (result){

                    for(let i=0; i<result.length; i++){
                        menu.append('<li class="flyout-right"><a href="/user/prod_list?code='+result[i].code+'">'+result[i].name+'</a>' +
                            '<div class="brdBox"><ul class="animated-'+result[i].code+'"></ul></div></li>');
                    }
                },
                error: function (){
                    alert("카테고리 불러오기에 실패했습니다. 다시 시도해주세요.")
                }
            })
        }

        // 카테고리 마우스오버 -> 브랜드 목록
        $('.flyout-right a').mouseover(function (){

            // 마우스오버한 카테고리 이름 가져오기
            let cateName = $(this).text();
            let name = escape(encodeURIComponent(cateName));    // 한글 인코딩

            $.ajax({
                url: '/user/getBrand?name='+name,
                type: 'get',
                contentType: "application/json; charset=UTF-8",
                async: false,
                success: function (result){

                    let cate= $('.animated-'.concat(result[0].cateCode));
                    cate.empty();   // 기존 브랜드 목록 지우기

                    // 브랜드 목록 추가
                    for(let i=0; i<result.length; i++){
                        cate.append('<li><a href="#">'+result[i].name+'</a></li>');
                    }
                },
                error: function (){
                    alert("카테고리 불러오기에 실패했습니다. 다시 시도해주세요.")
                }

            })


        })

    })
</script>

