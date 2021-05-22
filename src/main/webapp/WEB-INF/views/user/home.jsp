<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../common/header.jsp" %>
<head>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <script src="/resources/js/user/splide.min.js"></script>
    <link rel="stylesheet" href="/resources/css/user/home.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/splide.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/gifticon/prod.css" type="text/css">
</head>

<!--광고 삽입-->
<div id="advertiser">
    <div class="splide" style="margin: 0px auto; width: 1400px; ">
        <div class="splide__track">
            <ul class="splide__list">
                <%-- 추가 배너는 li 태그 추가해주시면 됩니다. --%>
                <li class="splide__slide">
                    <img src="/resources/img/banner001.png">
                </li>
                <li class="splide__slide">
                    <img src="/resources/img/banner002.png">
                </li>
                <li class="splide__slide">
                    <img src="/resources/img/banner003.png">
                </li>
            </ul>
        </div>
    </div>
</div>


<div id="container">
    <div class="space"></div> <!--광고 위 여백-->
    <!-- 광고 아래 메인 컨텐츠-->
    <div class="space"></div>

    <!-- 첫번째줄 (지도 + 관심상품)-->
    <div class="prdlist">
        <!--카테고리 이름 삽입-->
        <div class="listname_first">
            <div class='listnamefirst'>
                <h3><i class="fas fa-map-marked-alt"></i>&nbsp;지도로 찾는 기쁘티콘</h3>
            </div>
            <!--지도 삽입-->
            <div class="maps">
                <div class="mapicon">
                    <a href="/user/gifticon/map"><p><img src="/resources/img/map.png"></p></a> <!--db에서 상품 이미지불러오기-->
                </div>
                <div class="mapinfo">
                    <span>현재 위치에서 기쁘티콘 찾기</span>
                </div>
            </div>
        </div>

        <div class='listnamelast'>
            <div class="wishname">
                <h3><i class="far fa-heart"></i>&nbsp;나만의 관심상품</h3>
                <div class="categorycontroller">
                    <a href="/user/mypage/wishList" class="main-btn">전체보기</a>
                </div>
            </div>

            <%-- 관심상품 --%>
            <%-- 로그인이 안 되어 있을 때 --%>
            <div class="noWish" style="display: none">
                <p>${notice}</p>
            </div>

            <%-- 로그인이 되어 있을 때 --%>
            <div style="width: 750px">
                <table>
                    <tr>
                        <c:forEach items="${wishList}" var="wishList" end="2">
                            <td>
                                <a href="gifti_detail?code=${wishList.prodCode}">
                                    <div class="items">
                                        <div class="pic">
                                            <div class="img">
                                                <img src="${wishList.imgPath}">
                                            </div>
                                        </div>
                                        <div class="itemnameNprice">
                                            <div class="itembrand">
                                                <c:out value="${wishList.bname}"/>
                                            </div>
                                            <div class="itemname">
                                                <c:out value="${wishList.pname}"/>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </td>
                        </c:forEach>
                    </tr>
                </table>
            </div>
        </div>

    </div>

    <!-- 두번째줄 (인기상품)-->
    <div class="prdlists">
        <div class="listname">
            <div class='listnametotal'>
                <h3><i class="far fa-thumbs-up"></i>&nbsp;모두들 찾는 인기상품</h3>
            </div>
            <div class="categorycontroller">
                <a href="/user/gifti_list?keyword=&code=0&orderby=best" class="main-btn">전체보기</a>
            </div>
        </div>

        <div class="listcontent">
            <div class="splide" style="width: 1000px; margin-top: 3%;">
                <div class="splide__track">
                    <ul class="splide__list">
                        <c:set var="i" value="0"/>
                        <c:set var="j" value="4"/>
                        <c:forEach items="${bestList}" var="bestList">
                            <c:if test="${i%j==0}">
                                <li class="splide__slide">
                                <table>
                                <tr>
                            </c:if>
                            <td>
                                <div class="items">
                                    <div class="pic">
                                        <div class="img">
                                            <p class="best">NO. ${i+1}</p>
                                            <img src="${bestList.pimgPath}">
                                        </div>
                                    </div>
                                    <div class="itemnameNprice">
                                        <div class="itembrand">
                                            <c:out value="${bestList.bname}"/>
                                        </div>
                                        <div class="itemname">
                                            <c:out value="${bestList.pname}"/>
                                        </div>
                                        <div class="itemprice">
                                                <span><fmt:formatNumber value="${bestList.dcRate}"
                                                                        type="percent"/></span>&nbsp;&nbsp;
                                            <span><fmt:formatNumber type="number" maxFractionDigits="3"
                                                                    value="${bestList.dcPrc}"/> 원 ~</span>
                                        </div>
                                        <div class="itemoriginprice">
                                                <span><del><fmt:formatNumber type="number" maxFractionDigits="3"
                                                                             value="${bestList.prc}"/> 원</del></span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <c:if test="${i%j==j-1}">
                                </tr>
                                </table>
                                </li>
                            </c:if>
                            <c:set var="i" value="${i+1}"/>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- 세번째줄 (만료임박상품)-->
    <div class="prdlists">
        <div class="listname">
            <div class='listnametotal'>
                <h3><i class="far fa-clock"></i>&nbsp;초특가! 만료 임박 상품</h3>
            </div>
            <div class="categorycontroller">
                <a href="/user/gifti_list?keyword=&code=0&orderby=deadline" class="main-btn">전체보기</a>
            </div>
        </div>
        <div class="listcontent">
            <div class="splide" style="width: 1000px; margin-top: 3%;">
                <div class="splide__track">
                    <ul class="splide__list">
                        <c:set var="i" value="0"/>
                        <c:set var="j" value="4"/>
                        <c:forEach items="${deadlineList}" var="DL">
                            <c:if test="${i%j==0}">
                                <li class="splide__slide">
                                <table>
                                <tr>
                            </c:if>
                            <td>
                                <div class="items">
                                    <div class="pic">
                                        <div class="img">
                                            <img src="${DL.pimgPath}">
                                        </div>
                                        <p class="deadline">유효기간: ~ <fmt:formatDate value="${DL.expirDt}"
                                                                                    pattern="yyyy-MM-dd"/></p>
                                    </div>
                                    <div class="itemnameNprice">
                                        <div class="itembrand">
                                            <c:out value="${DL.bname}"/>
                                        </div>
                                        <div class="itemname" value="<c:out value="${DL.prodCode}"/>">
                                            <c:out value="${DL.pname}"/>
                                        </div>
                                        <div class="itemprice">
                                            <span><fmt:formatNumber value="${DL.dcRate}" type="percent"/></span>&nbsp;&nbsp;
                                            <span><fmt:formatNumber type="number" maxFractionDigits="3"
                                                                    value="${DL.dcPrc}"/> 원 ~</span>
                                        </div>
                                        <div class="itemoriginprice">
                                                <span><del><fmt:formatNumber type="number" maxFractionDigits="3"
                                                                             value="${DL.prc}"/> 원</del></span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <c:if test="${i%j==j-1}">
                                </tr>
                                </table>
                                </li>
                            </c:if>
                            <c:set var="i" value="${i+1}"/>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>


<script>
    <%--  슬라이드바   --%>
    let elms = document.getElementsByClassName('splide');
    for (let i = 0, len = elms.length; i < len; i++) {
        new Splide(elms[i], {
            rewind: true
        }).mount();
    }

    // 로그인 안 되어 있을 때 문구 출력
    let notice = "${notice}";

    if (notice.length > 0) {
        $('.noWish').show();
    }

    // 에러 메시지 처리
    let error = "${error}";

    if(error.length > 0){
        alert("error: " + error);
    }

    //물품 이름 클릭 시 해당 물품의 판매중인 기프티콘 조회. 판매중 있을 시 상품상세로 이동
    $(".itemname").on("click", function (e) {
        e.preventDefault();

        let prdCode = $(this).attr("value");

        $.ajax({
            url: '/gifticon/' + prdCode,
            type: 'get',
            success: function () {
                if (confirm("해당 상품 판매 페이지로 이동하시겠습니까?")) {
                    location.href = "/user/gifti_detail?code=" + prdCode;
                } else {
                    return;
                }
            },
            error: function () {
                alert("해당 물품의 구매가능한 기프티콘이 없습니다.")
            }
        })
    })
</script>
