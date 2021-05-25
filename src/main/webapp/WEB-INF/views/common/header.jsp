<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
    //userId 변수명이 mypage와 겹쳐서 header 전용으로 userId 지정
    Integer headerUid;
    try {
        headerUid = (int) request.getSession().getAttribute("userId");
    } catch (Exception e) {
        //비회원인경우 userId = 0으로 초기화
        headerUid = 0;
    }

    //소셜로그인 타입으로 logout handling
    String soclType;
    try {
        soclType = (String) request.getSession().getAttribute("social");
        System.out.println("socltype scriptlet: " + soclType);
    } catch (Exception e) {
        soclType = "";
    }

%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>

    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>Kakao.init('ac51465d91bcae237e6703842ae5d0c5');</script>

    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
</head>
<body>
<div id="header">

    <div class="top_menu">
        <sec:authorize access="isAnonymous()">
            <span><a href="/account/signIn" class="login-panel">로그인</a></span>
            <span class="header_divider">.</span>
            <span><a href="/account/signUp" class="login-panel">회원가입</a></span>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <span><a class="user-email"><sec:authentication property="principal.username"/></a></span>
            <span class="header_divider">.</span>
            <span>
                <button type="submit" class="logout">로그아웃</button>
                <form class="form-logout" action="/account/logOut" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
            </span>
        </sec:authorize>

        <span class="header_divider">.</span>
        <span><a href="/user/cs/noticeBoard" class="login-panel">고객센터</a></span>
    </div>

    <div class="main-logo">
        <div class="home-logo"><a href="/user/home"><img src="/resources/img/logo.png"></a></div>
    </div>

    <div class="main-bar">
            <div class="category-drop">
                <ul class="exo-menu">
                    <li class="drop-down">
                        <a class="nonclick"><i class="fas fa-bars"></i>&nbsp;전체 카테고리</a>
                        <%-- Drop Down --%>
                        <ul class="drop-down-ul animated fadeIn">
                        <%-- ajax로 불러옴 --%>
                        </ul>
                    </li>
                </ul>
            </div>
                <div class="leftmenu"><a href="/user/mypage/addCon">충전하기</a></div>
                <div class="leftmenu"><a href="/user/gifticon/map"><i class="fas fa-map-marker-alt"></i></a></div>
        <!-- search area -->
        <div class="search-bar-container">
            <form id="h-search-form" action="/user/gifti_list" method="get">
                <input type="text" class="h-search-input" name="keyword" value='<c:out value="${headerPageMaker.cri.keyword}"/>' placeholder=" 브랜드 또는 상품을 검색해보세요." />
                <input type="hidden" name="code" value='<c:out value="${headerPageMaker.cri.code}"/>'/>
                <button class="h-search-button"><i class="fas fa-search"></i></button>
            </form>
        </div>
            <div class="bubble">거래확정!</div>
            <div class="rightmenu" id="alarm-ticket">
                    <a><i class="fas fa-ticket-alt"></i></a>
                </div>
            <div class="rightmenu"><a href="/user/deal/saleGifticon">판매하기</a></div>
            <div class="rightmenu"><a href="/user/mypage/deal">마이페이지</a></div>
    </div>

</div>
</div>
</body>
<!-- 티켓 클릭 이동 form -->
<form class="ticket-alarm" action="/user/mypage/deal" method="get">
    <input type="hidden" name="pageNum" value="">
    <input type="hidden" name="amount" value="">
    <input type="hidden" name="keyword" value=""/>
    <input type="hidden" name="type" value=""/>
</form>

<script>
    // 검색 버튼 이벤트 처리
    let headerSearchForm = $('#h-search-form');

    $("#h-search-form button").on("click", function (e) {
        headerSearchForm.find("input[name='code']").val("0");
        e.preventDefault();

        if (!headerSearchForm.find("input[name='keyword']").val()) {
            alert("검색어를 입력해주세요");
            return false;
        }
        headerSearchForm.submit();
    });

    // 전체카테고리 메뉴 불러오기
    $(document).ready(function () {
        $(".nonclick").on("click", function (e) {
            e.preventDefault();
        });

        menuLoader();

        // 카테고리
        function menuLoader() {
            let menu = $('.drop-down-ul');
            $.ajax({
                url: '/user/menuLoader',
                type: 'get',
                async: false,
                success: function (result) {
                    for(let i=0; i<result.length-1; i++){
                        menu.append('<li class="flyout-right"><a href="/user/gifti_list?code='+result[i].code+'">'+result[i].name+'</a>' +
                            '<div class="brdBox"><ul class="animated-'+result[i].code+'"></ul></div></li>');
                    }
                },
                error: function () {
                    alert("카테고리 불러오기에 실패했습니다. 다시 시도해주세요.")
                }
            })
        }

        // 카테고리 마우스오버 -> 브랜드 목록
        $('.flyout-right a').mouseover(function () {

            // 마우스오버한 카테고리 이름 가져오기
            let cateName = $(this).text();
            let name = escape(encodeURIComponent(cateName));    // 한글 인코딩

            // 마우스오버한 카테고리 배경화면 색 고정
            $('.flyout-right a').removeClass('on');
            $(this).addClass('on');

            $.ajax({
                url: '/user/getBrand?name=' + name,
                type: 'get',
                contentType: "application/json; charset=UTF-8",
                async: false,
                success: function (result) {

                    let cate = $('.animated-'.concat(result[0].cateCode));
                    cate.empty();   // 기존 브랜드 목록 지우기

                    // 브랜드 목록 추가
                    for(let i=0; i<result.length; i++){
                        cate.append('<li><a href="/user/gifti_list?code='+result[i].code+'">'+result[i].name+'</a></li>');
                    }
                },
                error: function () {
                    alert("카테고리 불러오기에 실패했습니다. 다시 시도해주세요.")
                }
            });
        });

        // 전체 카테고리 마우스오버 색 고정
        $('.drop-down a').mouseover(function () {
            $(this).addClass('on');
        });

        // 전체 카테고리 글자색, 카테고리 배경화면 색 초기화
        $('.exo-menu').mouseleave(function () {
            $('.drop-down a').removeClass('on');
        });

        $('.drop-down-ul').mouseleave(function () {
            $('.flyout-right a').removeClass('on');
        });

    });
</script>

<!-- 티켓 아이콘 알림 버튼 적용 스크립트 -->
<script>

    $(document).ready(function () {

        ticketAlarm();

        $(".bubble").on("click", function (e) {
            ticketAlarmBtn();
        });

        $("#alarm-ticket").on("click", function (e) {
            ticketAlarmBtn();
        });

    });


    //티켓 클릭 시 마이페이지/구매내역 + 거래확정대기 검색 이동
    function ticketAlarmBtn() {
        let ticketAlarmBtn = $(".ticket-alarm")

        ticketAlarmBtn.find("input[name='keyword']").val("거래확정대기");
        ticketAlarmBtn.find("input[name='type']").val("S");
        ticketAlarmBtn.find("input[name='pageNum']").val("1");
        ticketAlarmBtn.find("input[name='amount']").val("4");

        ticketAlarmBtn.submit();
    }


    //user가 산 기프티콘 중 거래확정 대기 count, count가 0이 아니면 메세지 div 출력
    function ticketAlarm() {

        let headerUid = <%=headerUid%>;

        if (headerUid == 0) {
            return;
        }

        $.ajax({
            url: '/user/ticketAlarm',
            type: 'get',
            data: {userId: headerUid},
            contentType: 'json',
            dataType: 'json',
            success: function (result) {
                if (result === 0) {
                } else {
                    $(".bubble").css("visibility", "visible");
                }
            }
        });
    }
</script>

<script type="text/javascript" src="/resources/js/social/logout.js"></script>
<script>

    var logoutForm = $(".form-logout");

    $(".logout").on("click", function (e) {

        let soclLoginName = "<%=soclType%>";

        if (soclLoginName == null) {
            logoutForm.submit();
        } else if (soclLoginName == '카카오') {
            logoutWithKakao();
        } else { //향후 추가되는 소셜로그인은 여기에 차례대로 추가해주세요
            logoutForm.submit();
        }
    });

</script>

