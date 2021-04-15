<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
<title>Document</title>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
</style>
<jsp:include page="../../common/header.jsp"/>
<body>


<div id="container">
    <div class="space"></div>
    <div class="main">
        <div class="menuhead">
        </div>
        <div class="menubody">
            <div class="sidebarspace">
                <div class="menuname">MY PAGE</div><!--메뉴 이름 (사이드바 위)-->
                <div class="sidebar"> <!--사이드 바 영역 (필요한만큼 영역 늘리기)-->
                    <!--필요한만큼 아래 추가해서 사용 (개당 간격70px)-->
                    <a href="/user/mypage/deal">
                        <div class="bar">
                            <div>구매 내역</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="/user/mypage/sells">
                        <div class="bar">
                            <div>판매 내역</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div>회원 정보</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div>1:1 문의</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div>포인트 충전</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                </div>
            </div>
            <div class="content"><!--메인컨텐츠 (이하 각자 내용 작성)-->
                <div class='abstracts'>
                    <div class='abs stus004'>
                        <div class="abs_name">확정 대기</div>
                        <div class="abs_num"><c:out value="${countStus004}"/></div>
                    </div>
                    <div class='abs stus001'>
                        <div class="abs_name">판매 대기</div>
                        <div class="abs_num"><c:out value="${countStus001}"/></div>
                    </div>
                    <div class='abs stus002'>
                        <div class="abs_name">판매 중</div>
                        <div class="abs_num"><c:out value="${countStus002}"/></div>
                    </div>
                    <div class='abs curentPnt'>
                        <div class="abs_name">현재 포인트</div>
                        <div class="abs_pnt"><c:out value="${userPnt}"/>p</div>
                    </div>
                    <form class="abs-search" action="/user/mypage/deal" method="get">
                        <input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum}"/>">
                        <input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount}"/>">
                        <input type="hidden" name="keyword" value=""/>
                        <input type="hidden" name="type" value=""/>
                    </form>
                </div>
                <div class="space50"></div>


<script>
    $(document).ready(function () {

        var absSearch = $(".abs-search");

        $(".stus004").on("click", function (e) {

            absSearch.find("input[name='keyword']").val("거래확정대기");
            absSearch.find("input[name='type']").val("S");
            absSearch.find("input[name='pageNum']").val("1");
            e.preventDefault();
            absSearch.submit();
        })

    })
</script>