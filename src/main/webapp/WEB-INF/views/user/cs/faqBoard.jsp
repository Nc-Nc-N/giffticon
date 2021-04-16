<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">

    <link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/cs/admin_faq.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/cs/notice_board.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/cs/faq_board.css" type="text/css">




    <title>Document</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>

    <div id="header">
        <div class= "top_menu">
            <span><a href="#" class="login-panel">로그인</a></span>
            <span class="header_divider">|</span>
            <span><a href="#" class="login-panel">회원가입</a></span>
            <span class="header_divider">|</span>
            <span><a href="http://localhost:8087/cs/faqBoard" class="login-panel">고객센터</a></span>
        </div>
        <div class="main-logo">
            <div class="home-logo"><img src="/resources/img/logo.png" width="80%" ></div>
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
                <form action="(login)" >
                    <input type="text" class="searchbar" placeholder="기쁘티콘">
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
<body>

<div id="container">
    <div class="space"></div>
    <div class="main">

        <div class="menuhead">
            <div class="menuname">고객센터</div><!--메뉴 이름 (사이드바 위)-->
        </div>

        <div class="menubody">
            <div class="sidebarspace">
                <div class="sidebar"> <!--사이드 바 영역 (필요한만큼 영역 세로로늘리기)-->
                    <!--필요한만큼 아래 추가해서 사용 (개당 세로크기70px)-->
                    <a href="http://localhost:8087/cs/noticeBoard">
                        <div class="bar">
                            <div>공지사항</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="http://localhost:8087/cs/faqBoard">
                        <div class="bar" style="background-color:rgb(240, 240, 240);">
                            <div style="color: rgb(255, 88, 93); background-color:rgb(240, 240, 240);">자주묻는 질문</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="http://localhost:8087/cs/qnaBoard">
                        <div class="bar">
                            <div>1:1문의</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>

                </div>
            </div>

            <div class="emptyspace"></div>

            <div class="content"><!--메인컨텐츠 (이하 각자 내용 작성)-->

                <h3>자주묻는 질문</h3>

                <div class="sub-category-area">
                    <button class="sub sub-category-btn-all" value="NE" name="type"
                            onclick="location.href='http://localhost:8087/cs/faqBoard?pageNum=1&amount=10&type=NE&keyword=';">
                        전체
                    </button>
                    <button class="sub sub-category-btn-notice" value="N" name="type"
                            onclick="location.href='http://localhost:8087/cs/faqBoard?pageNum=1&amount=10&type=N&keyword=';">
                        구매
                    </button>
                    <button class="sub sub-category-btn-event" value="E" name="type"
                            onclick="location.href='http://localhost:8087/cs/faqBoard?pageNum=1&amount=10&type=E&keyword=';">
                        판매
                    </button>
                </div>

                <!-- search area -->

                <form class="search-form" id='searchForm' action="/cs/faqBoard" method="get">
                    <div class="search-area">


                        <div class="search-input-area">
                            <input type="text" class="search-input" name="keyword"
                                   value='<c:out value="${pageMaker.cri.keyword}"/>'>
                            <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
                            <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
                            <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                            <button type="submit" class="search-button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                </form>

                <!-- search area end -->


                <!--accordionMenu-->
                <div class="accordionMenu">

                    <c:forEach items="${list}" var="faq" varStatus="status">
                        <!-- 1st menu-->
                        <input type="checkbox" name="trg1" id="acc<c:out value="${status.index+1}"/>">
                        <label for="acc<c:out value="${status.index+1}"/>">
                            <span class="qna-q">Q. </span><c:out value="${faq.csCateCode == '001' ? '[구매]':'[판매]'}"/>
                            <c:out value="${faq.qust}"/>
                                <%--                            <button id="<c:out value='${faq.id}'/>" class="btn-no btn-erase">--%>
                                <%--                                <i class="fas fa-minus"></i></button>--%>
                                <%--                            <button class="btn-no btn-modify" id="<c:out value='${faq.id}'/>" onclick="">수정</button>--%>
                        </label>
                        <div class="content">
                            <div class="inner">
                                <p><span class="qna-a">A. </span> <c:out value="${faq.ans}"/></p>
                            </div>

                        </div>
                    </c:forEach>
                </div>
                <!-- end accordionMenu-->


                <!-- pagenation-->
                <div class="pagination">
                    <c:if test="${pageMaker.prev}">
                        <li class="paginate_button previous"><a href="${pageMaker.startPage -1}"><</a></li>

                    </c:if>

                    <c:forEach var="num" begin="${pageMaker.startPage}"
                               end="${pageMaker.endPage}">
                        <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} "><a
                                href="${num}">${num}</a></li>
                    </c:forEach>

                    <c:if test="${pageMaker.next}">
                        <li class="paginate_button next"><a href="${pageMaker.endPage + 1}">&gt;</a></li>
                    </c:if>

                </div>
                <!-- end pagenation-->

                <form ID='actionForm' action="/cs/faqBoard" method="get">
                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                    <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                    <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
                </form>

            </div>
            <!-- end content -->

        </div>
    </div>
</div>


<script type="text/javascript">

    //검색
    var searchForm = $("#searchForm");

    $(".search-button").on("click", function (e) {

        if (!searchForm.find("input[name='keyword']").val()) {
            // $(".search-input").val("");
            alert("keyword null");
        }

        searchForm.find("input[name='pageNum']").val("1");
        e.preventDefault();

        searchForm.submit();

    });


    $(document).ready(function () {

        //page번호 클릭했을때 처
        var actionForm = $("#actionForm");

        $(".paginate_button a").on("click", function (e) {

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });


    });

</script>



</body>
</html>