<%--
  Created by IntelliJ IDEA.
  User: heeyoung
  Date: 2021/04/12
  Time: 11:27 오전
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../common/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <script src="/resources/js/user/splide.min.js"></script>
    <link rel="stylesheet" href="/resources/css/user/home.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/splide.min.css" type="text/css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>
</head>

<!--여기서부터 home body-->
<div id="advertiser"> <!--광고판테두리-->
    <div class="advertise"> <!--광고 삽입-->

    </div>
    <span>
            <i class="fas fa-chevron-left"></i>
            &nbsp;&nbsp;&nbsp;
            <i class="fas fa-chevron-right"></i>
        </span>

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
            <div class='listnamelast'>
                <div class="wishname">
                    <h3><i class="far fa-heart"></i>&nbsp;나만의 관심상품</h3>
                </div>
                <div class="categorycontroller">
                    <a href="/user/mypage/wishList" class="main-btn">전체보기</a>
                </div>
            </div>
        </div>

        <!--카테고리 컨텐츠 삽입-->
        <div class="listcontent">

            <!--지도 삽입-->
            <div class="maps">
                <div class="mapicon">
                    <a href="(위치찾기)"><p><img src="img/map.png"></p></a> <!--db에서 상품 이미지불러오기-->
                </div>
                <div class="mapinfo">
                    <span>현재 위치에서 기쁘티콘 찾기</span>
                </div>
            </div>

            <%-- 관심상품 --%>
            <div class="splide" style="width: 735px; height: 300px; margin-left: 20px; margin-top: 20px;">
                <div class="splide__track">
                    <ul class="splide__list" style="height: 300px;">
                        <c:set var="i" value="0"/>
                        <c:set var="j" value="3"/>
                        <c:forEach items="${wishList}" var="wishList" end="5">
                            <c:if test="${i%j==0}">
                                <li class="splide__slide">
                                <table>
                                <tr>
                            </c:if>
                                    <td>
                                        <a href="prod_detail?code=${wishList.prodCode}">
                                        <div class="items">
                                            <div class="itemimg">
                                                <img src="${wishList.imgPath}">
                                            </div>
                                            <div class="itemnameNprice">
                                                <div class="itembrand">
                                                    <c:out value="${wishList.bname}"/>
                                                </div>
                                                <div class="itemname">
                                                    <c:out value="${wishList.pname}"/>
                                                </div>
                                                <div class="itemprice">
                                                    <span><fmt:formatNumber value="${wishList.dcRate}" type="percent" /></span>&nbsp;&nbsp;
                                                    <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${wishList.dcPrc}" /> 원 ~</span>
                                                </div>
                                                <div class="itemoriginprice">
                                                    <span><del><fmt:formatNumber type="number" maxFractionDigits="3" value="${wishList.prc}"/> 원</del></span>
                                                </div>
                                            </div>
                                        </div>
                                        </a>
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

    <!-- 두번째줄 (인기상품)-->
    <div class="prdlist">
        <div class="listname">
            <div class='listnametotal'>
                <h3><i class="far fa-thumbs-up"></i>&nbsp;모두들 찾는 인기상품</h3>
            </div>
            <div class="categorycontroller">
                <a href="/user/prod_list?orderby=best" class="main-btn">전체보기</a>
            </div>
        </div>

        <div class="listcontent">
            <div class="splide" style="width: 1000px; margin-top: 20px;">
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
                            <a href="prod_detail?code=${bestList.prodCode}">
                                <div class="items">
                                    <strong class="num">NO. ${i+1}</strong>
                                    <div class="itemimg">
                                        <img src="${bestList.pimgPath}">
                                    </div>
                                    <div class="itemnameNprice">
                                        <div class="itembrand">
                                            <c:out value="${bestList.bname}"/>
                                        </div>
                                        <div class="itemname">
                                            <c:out value="${bestList.pname}"/>
                                        </div>
                                        <div class="itemprice">
                                            <span><fmt:formatNumber value="${bestList.dcRate}" type="percent" /></span>&nbsp;&nbsp;
                                            <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${bestList.dcPrc}" /> 원 ~</span>
                                        </div>
                                        <div class="itemoriginprice">
                                            <span><del><fmt:formatNumber type="number" maxFractionDigits="3" value="${bestList.prc}"/> 원</del></span>
                                        </div>
                                    </div>
                                </div>
                            </a>
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
    <div class="prdlist">
        <div class="listname">
            <div class='listnametotal'>
                <h3><i class="far fa-clock"></i>&nbsp;초특가! 만료 임박 상품</h3>
            </div>
            <div class="categorycontroller">
                <a href="/user/prod_list?keyword=&code=0&orderby=deadline" class="main-btn">전체보기</a>
            </div>
        </div>
        <div class="listcontent">
            <div class="splide" style="width: 1000px; margin-top: 20px;">
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
                                <a href="prod_detail?code=${DL.prodCode}">
                                    <div class="items">
                                        <div class="itemimg">
                                            <img src="${DL.pimgPath}">
                                        </div>
                                        <div class="itemnameNprice">
                                            <div class="itembrand">
                                                <c:out value="${DL.bname}"/>
                                            </div>
                                            <div class="itemname">
                                                <c:out value="${DL.pname}"/>
                                            </div>
                                            <div class="itemprice">
                                                <span><fmt:formatNumber value="${DL.dcRate}" type="percent" /></span>&nbsp;&nbsp;
                                                <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${DL.dcPrc}" /> 원 ~</span>
                                            </div>
                                            <div class="itemoriginprice">
                                                <span><del><fmt:formatNumber type="number" maxFractionDigits="3" value="${DL.prc}"/> 원</del></span>
                                            </div>
                                        </div>
                                    </div>
                                </a>
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
</html>

<script>
    <%--  슬라이드바   --%>
    let elms = document.getElementsByClassName( 'splide' );
    for (let i = 0, len = elms.length; i < len; i++ ) {
        new Splide( elms[ i ] ).mount();
    }
</script>
