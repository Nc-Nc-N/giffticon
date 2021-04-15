<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%--    <meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
    <%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">

    <link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/cs/faq_board.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/cs/notice_board.css" type="text/css">



    <title>Document</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>

    <div id="header">
        <div class="top_menu">
            <span><a href="#" class="login-panel">로그인</a></span>
            <span class="header_divider">|</span>
            <span><a href="#" class="login-panel">회원가입</a></span>
            <span class="header_divider">|</span>
            <span><a href="#" class="login-panel">고객센터</a></span>
        </div>
        <div class="main-logo">
            <div class="home-logo"><img src="/resources/img/logo.png" width="80%"></div>
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
                        <div class="bar" style="background-color:rgb(240, 240, 240);">
                            <div style="color: rgb(255, 88, 93); background-color:rgb(240, 240, 240);">공지사항</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="http://localhost:8087/cs/faqBoard">
                        <div class="bar">
                            <div>자주묻는 질문</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="http://localhost:8087/cs/qnaBoard">
                        <div class="bar">
                            <div>1:1문의</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>

                </div>
            </div>
            <div class="emptyspace">

            </div>
            <div class="content"><!--메인컨텐츠 (이하 각자 내용 작성)-->

                <h3>공지사항</h3>
                    <div class="sub1 sub-category-area">
                        <button class="sub2 sub-category-btn-all" value="NE" name="type"
                                onclick="location.href='http://localhost:8087/cs/noticeBoard?pageNum=1&amount=10&type=NE&keyword=';">전체</button>
                        <button class="sub2 sub-category-btn-notice" value="N" name="type"
                                onclick="location.href='http://localhost:8087/cs/noticeBoard?pageNum=1&amount=10&type=N&keyword=';">공지</button>
                        <button class="sub2 sub-category-btn-event" value="E" name="type"
                                onclick="location.href='http://localhost:8087/cs/noticeBoard?pageNum=1&amount=10&type=E&keyword=';">이벤트</button>
                    </div>


                <form class="search-form" id='searchForm' action="/cs/noticeBoard" method="get">
                    <!-- search area -->
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

                    <c:forEach items="${list}" var="notice" varStatus="status">
                        <!-- 1st menu-->
                        <input type="checkbox" name="trg1" id="acc<c:out value="${status.index+1}"/>">
                        <label for="acc<c:out value="${status.index+1}"/>"><c:out
                                value="${notice.csCateCode == '003' ? '[공지]':'[이벤트]'}"/> <c:out value="${notice.title}"/>
                            <span class="no-date"><fmt:formatDate value="${notice.startDt}" pattern="yyyy-MM-dd"/></span>

                        </label>
                        <div class="content">
                            <div class="inner">
                                <p><c:out value="${notice.cntnt}"/></p>
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

                <form ID='actionForm' action="/cs/noticeBoard" method="get">
                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                    <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                    <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
                </form>

            </div>
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


        // var sub2 = document.getElementsByClassName("sub2");
        //
        // function handleClick(event){
        //
        //     console.log(event.target);
        //     console.log(event.target.classList);
        //     if (event.target.classList[1] === "clicked"){
        //         event.target.classList.remove("clicked");
        //     }else{
        //         for(let i = 0; i < sub2.length; i++){
        //             sub2[i].classList.remove("clicked");
        //         }
        //
        //         event.target.classList.add("clicked");
        //     }
        // }
        //
        // function init(){
        //     for (let i = 0; i < sub2.length; i++){
        //         sub2[i].addEventListener("click", handleClick);
        //     }
        // }
        //
        // init();
    });

</script>


</body>
</html>