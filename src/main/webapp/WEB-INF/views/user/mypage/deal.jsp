<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/mypage/mypage_deals.css?after" type="text/css">
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
</head>
<body>

    <div id="container">
        <div class="space"></div>
        <div class="main">
            <div class="menuhead">
                <div class="menuname">MY PAGE</div><!--메뉴 이름 (사이드바 위)-->
            </div>
            <div class="menubody">
                <div class="sidebarspace">
                    <div class="sidebar"> <!--사이드 바 영역 (필요한만큼 영역 늘리기)-->
                        <!--필요한만큼 아래 추가해서 사용 (개당 간격70px)-->
                        <a href="(메뉴이동"><div class="bar"><div>구매 내역</div><i class="fas fa-chevron-right"></i></div></a>
                        <a href="(메뉴이동"><div class="bar"><div>판매 내역</div><i class="fas fa-chevron-right"></i></div></a>
                        <a href="(메뉴이동"><div class="bar"><div>회원 정보</div><i class="fas fa-chevron-right"></i></div></a>
                        <a href="(메뉴이동"><div class="bar"><div>1:1 문의</div><i class="fas fa-chevron-right"></i></div></a>
                        <a href="(메뉴이동"><div class="bar"><div>포인트 충전</div><i class="fas fa-chevron-right"></i></div></a>
                    </div>
                </div>
                <div class="content"><!--메인컨텐츠 (이하 각자 내용 작성)-->
                    <div class='abstracts'>
                        <div class='abs'>
                            <div class="abs_name">사용 대기</div>
                            <div class="abs_num">3</div>
                        </div>
                        <div class='abs'>
                            <div class="abs_name">판매 대기</div>
                            <div class="abs_num">3</div>
                        </div>
                        <div class='abs'>
                            <div class="abs_name">판매 중</div>
                            <div class="abs_num">3</div>
                        </div>
                        <div class='abs'>
                            <div class="abs_name">현재 포인트</div>
                            <div class="abs_pnt">10200p</div>
                        </div>
                    </div>
                    <div class="space30"></div>
                    <div class="contentheader">
                        <span>구매 내역</span>
                    </div>
                    <div class="contentinfo">
                        구매확정대기  >  구매확정완료
                    </div>
                    <div class="contentsearch">
                        <div class="date-search">
                            <input type="date" id="start-date">
                            <span>~</span>
                            <input type="date" id="end-date">
                        </div>
                        <div class="search-area">
                            <select class="search-select">
                                <option>전체</option>
                                <option>상품코드</option>
                                <option>상품명</option>
                            </select>
                        
                            <form class="search-form">
                                <div>
                                    <input type="text" class="search-input" />
                    
                                    <button type="submit" class="search-button">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="space30"></div>
                    <div class="item">
                        <c:forEach items="${dealList}" var="list" varStatus="num">
                        <div class='item_purdate'><fmt:formatDate pattern="yyyy-MM-dd" value="${list.dealDt}"/></div>
                        <div class='item_info'>
                            <span class="item_img"><img src="<c:out value='${list.prdImgPath}'/>"></span>
                            <span class="item_brdNname">
                                <div class="item_brd"><c:out value="${list.brdName}"/></div>
                                <div class="item_name"><c:out value="${list.prdName}"/></div>
                            </span>
                            <span class="item_prc"><c:out value="${list.pymtPrc}"/>원</span>
                            <span class="item_status"><c:out value="${list.stusCode}"/></span>
                            <div class="item_buttons">
                                <button name="dealCmplBtn" class="btn btn-active" value="<c:out value="${list.gftId}"/>">구매 확정</button>
<%--                                <form action="/user/mypage/dealDetail" method="post">--%>
<%--                                    <input type="hidden" name="gftId" value="<c:out value="${list.gftId}"/>">--%>
<%--                                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">--%>
<%--                                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">--%>
<%--                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>--%>

<%--                                    <button class="btn btn-active">구매 상세</button>--%>
<%--                                </form>--%>
                                <button name="dealDetailBtn" class="btn btn-active" value="<c:out value="${list.gftId}"/>">구매 상세</button>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                    <div class="contentfooter">
                        <div class="pagination">
                            <c:if test="${pageMaker.prev}">
                                <a class="paginate_btn prev" href="${pageMaker.startPage - 1}"><</a>
                            </c:if>
                            <c:forEach var="num" begin="${pageMaker.startPage}"
                            end="${pageMaker.endPage}">
                                <a class="paginate_btn" href="${num}">${num}</a>
                            </c:forEach>
                            <c:if test="${pageMaker.next}">
                                <a class="paginate_btn next" href="${pageMaker.endPage + 1}">></a>
                            </c:if>
                        </div>
                        <form id="actionForm" action="/user/mypage/deal" method="get">
                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
<script>
    $(document).ready(function(){

        var csrfName = "${_csrf.parameterName}";
        var csrfToken = "${_csrf.token}";
        var actionForm = $("#actionForm");

        $(".paginate_btn").on("click", function(e){
            e.preventDefault();
            console.log('paginate btn clicked');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        $("button[name='dealDetailBtn']").on("click", function(k){
            console.log("dealDetailBtn clicked");
            actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
            actionForm.append("<input type='hidden' name='" + csrfName + "' value='" + csrfToken + "'>");
            actionForm.attr("action","/user/mypage/dealDetail").attr("method","post");
            console.log("csrf: " + csrfName + "csrf ToKEN: " + csrfToken);
            console.log("actionForm attr: " + actionForm.attr("action"));
            console.log("gftId: " + $(this).attr("value") );
            alert("상세페이지 이동");
            actionForm.submit();
        });

        $("button[name='dealCmplBtn']").on("click", function (i){
            alert("구매확정하시겠습니까?");
            actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
            actionForm.append("<input type='hidden' name='" + csrfName + "' value='" + csrfToken + "'>");
            actionForm.attr("action","/gifticon/stus005").attr("method","post");
            actionForm.submit();
        });

    })
</script>