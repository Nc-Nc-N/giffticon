<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/header.jsp" %>

<%
    int userId = (int) request.getSession().getAttribute("userId");
%>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>--%>
<%--<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>--%>
<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--%>

<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">

<title>Document</title>

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
                    <ul>
                        <li id="deal-link" class="menu">
                            <a href="/user/mypage/deal">
                                <div class="bar">
                                    <div>구매 내역</div>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        <li id="sell-link" class="menu">
                            <a href="/user/mypage/sells">
                                <div class="bar">
                                    <div>판매 내역</div>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        <li id="info-link" class="menu">
                            <a href="/user/mypage/userInfo">
                                <div class="bar">
                                    <div>회원 정보</div>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        <li id="psnlQust-link" class="menu">
                            <a href="/user/mypage/psnlQustBoard">
                                <div class="bar">
                                    <div>1:1 문의</div>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        <li id="con-link" class="menu">
                            <a href="/user/mypage/myCon">
                                <div class="bar">
                                    <div>마이 콘</div>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                        <li id="wish-link" class="menu">
                            <a href="/user/mypage/wishList">
                                <div class="bar">
                                    <div>관심 상품</div>
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </a>
                        </li>
                    </ul>
                    <!--필요한만큼 아래 추가해서 사용 (개당 간격70px)-->
                </div>
            </div>
            <div class="content"><!--메인컨텐츠 (이하 각자 내용 작성)-->
                <div class='abstracts'>
                    <div class='abs stus004'>
                        <div class="abs_name">확정 대기</div>
                        <div class="abs_num" id="stus004">
                            <%--                            <c:out value="${countStus004}"/>--%>
                        </div>
                    </div>
                    <div class='abs stus001'>
                        <div class="abs_name">판매 대기</div>
                        <div class="abs_num" id="stus001">
                            <%--                            <c:out value="${countStus001}"/>--%>
                        </div>
                    </div>
                    <div class='abs stus002'>
                        <div class="abs_name">판매 중</div>
                        <div class="abs_num" id="stus002">
                            <%--                            <c:out value="${countStus002}"/>--%>
                        </div>
                    </div>
                    <div class='abs curentPnt'>
                        <div class="abs_name">보유 콘</div>
                        <div class="abs_pnt" id="userPnt">
                            <%--                            <c:out value="${userPnt}"/>p--%>
                        </div>
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
                    let userId = <%=userId%>;

                    //요약창 정보 불러오기
                    absLoader(userId);

                    function absLoader(userId) {
                        console.log("userId type : " + typeof (userId));

                        $.ajax({
                            url: '/user/mypage/absLoader',
                            type: 'get',
                            data: {userId: userId},
                            dataType: 'json',
                            success: function (result) {

                                $("#stus004").html(result[0]);
                                $("#stus001").html(result[1]);
                                $("#stus002").html(result[2]);
                                $("#userPnt").html(result[3]);
                            },
                            error: function () {
                                alert("요약 창 정보 불러오기에 실패했습니다.");
                            }
                        });
                    }
                </script>
                <script>
                    $(document).ready(function () {
                        var absSearch = $(".abs-search");

                        //요약 - 확정대기 검색 바로가기
                        $(".stus004").on("click", function (e) {
                            absSearch.find("input[name='keyword']").val("거래확정대기");
                            absSearch.find("input[name='type']").val("S");
                            absSearch.find("input[name='pageNum']").val("1");
                            absSearch.find("input[name='amount']").val("4");

                            absSearch.submit();
                        });

                        //요약 - 판매대기 검색 바로가기
                        $(".stus001").on("click", function (e) {
                            absSearch.find("input[name='keyword']").val("판매대기");
                            absSearch.find("input[name='type']").val("S");
                            absSearch.find("input[name='pageNum']").val("1");
                            absSearch.find("input[name='amount']").val("4");
                            absSearch.attr("action", "/user/mypage/sells").attr("method", "get");

                            absSearch.submit();
                        });

                        //요약 - 판매중 검색 바로가기
                        $(".stus002").on("click", function (e) {
                            absSearch.find("input[name='keyword']").val("판매중");
                            absSearch.find("input[name='type']").val("S");
                            absSearch.find("input[name='pageNum']").val("1");
                            absSearch.find("input[name='amount']").val("4");
                            absSearch.attr("action", "/user/mypage/sells").attr("method", "get");

                            absSearch.submit();
                        });

                        //요약 - 보유콘 바로가기
                        $(".curentPnt").on("click", function (e) {
                            absSearch.attr("action", "/user/mypage/myCon").attr("method", "get");
                            absSearch.find("input[name='amount']").val("10");

                            absSearch.submit();
                        });
                    });
                </script>