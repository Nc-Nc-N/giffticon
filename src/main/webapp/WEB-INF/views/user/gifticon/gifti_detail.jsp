<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../common/header.jsp"%>

<head>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
    <link rel="stylesheet" href="/resources/css/user/gifticon/gifti_list.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/gifticon/gifti_detail.css" type="text/css">
</head>

<!-- 컨테이너 전체 -->
    <div id="container">
        <div class="space"></div>
        <div class="main">

            <!-- 카테고리바 -->
            <nav>
                <div class="catename"><i class="<c:out value="${category.iconPath}"/>"></i> &nbsp;<c:out value="${category.name}"/></div>
                <ul>
                    <a class="cateAll href="gifti_list?code=${category.code}&orderby=best">전체보기</a>
                    <c:forEach items="${brandList}" var="brandList">
                        <a class="brandList ${gifticon.brdCode == brandList.code ? "active":""}" href="gifti_list?code=${brandList.code}&orderby=best"><c:out value="${brandList.name}"/></a>
                    </c:forEach>
                </ul>
            </nav>

            <!-- 현재 위치-->
            <h2 class="titArea">
                <span class="nav">
                    <span class="icoHome" onclick="javascript:common_goUrl('/user/home');" style="cursor: pointer;">홈</span>
                        &gt; <a onclick="javascript:common_goUrl('gifti_list?code=${category.code}');" style="cursor: pointer;"><c:out value="${category.name}"/></a>
                        &gt; <a onclick="javascript:common_goUrl('gifti_list?code=${gifticon.brdCode}');" style="cursor: pointer;"><c:out value="${gifticon.bname}"/></a>
                        &gt; <span class="state"><c:out value="${gifticon.pname}"/></span>
                </span>
            </h2>
            <!-- 상품 -->
            <div class="product_detail_top">
                <!-- 왼쪽 사진 -->
                <div class="pic">
                    <div class="img"><img style="width: 250px;" src="${gifticon.pimgPath}" alt=""></div>
                </div>
                <!-- 오른쪽 상품 정보 -->
                <div class="detail">
                    <div class="product">
                        <p class="brand"><c:out value="${gifticon.bname}"/></p>
                        <p class="name"><c:out value="${gifticon.pname}"/></p>
                        <p class="price">
                            <b><span><fmt:formatNumber value="${gifticon.dcRate}" type="percent" /></span>&nbsp;&nbsp;
                                <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${gifticon.dcPrc}" /></span>
                                <span>원 ~</span></b>
                                <del><fmt:formatNumber type="number" maxFractionDigits="3" value="${gifticon.prc}"/> 원</del>
                        </p>
                    </div>
                    <%--  기본 주의사항 --%>
                    <div class="exp">
                        <p class="desc">기본 주의사항</p>
                        <p class="desc">쿠폰 사용처에서 유효기간 내 사용이 가능합니다.</p>
                        <p class="desc">바코드 인식이 안 될 경우, 바코드 번호를 입력하여 결제할 수 있습니다.</p>
                        <p class="desc">공항 백화점, 대형 쇼핑몰, 휴게소 등 일부 특수매장에서는 사용이 제한될 수 있습니다.</p>
                        <p class="desc">판매되는 쿠폰은 개인 간 거래를 통해 리셀링되는 상품으로 <span class="fc_red">유효기간 연장 및 환불이 불가</span>합니다.</p>
                        <p class="desc">쿠폰 사용과 관련한 불편은 1:1 문의로 문의바랍니다.</p>
                    </div>

                    <div class="option-group">
                        <div class="group">
                            <button type="button" id="like-button">
                                <svg class="heart-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M91.6 13A28.7 28.7 0 0 0 51 13l-1 1-1-1A28.7 28.7 0 0 0 8.4 53.8l1 1L50 95.3l40.5-40.6 1-1a28.6 28.6 0 0 0 0-40.6z"/></svg>
                                관심상품
                            </button>
                            <select class="option-select">
                                <option> 옵션 선택하기 </option>
                                <c:forEach items="${giftiList}" var="gifti">
                                    <option>
                                        할인가:<fmt:formatNumber type="number" maxFractionDigits="3" value="${gifti.dcPrc}" />(<fmt:formatNumber value="${gifti.dcRate}" type="percent" />) /
                                        유효기간: <fmt:formatDate value="${gifti.expirDt}" pattern="yyyy-MM-dd"/> 까지
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <button type="button" class="btn-active">
                            구매하기
                        </button>

                    </div>
                </div>
            </div>
            <!-- 상품 설명 -->
            <div class="product_detail_exp">
                <p class="title">상품설명</p>
                <p class="t_exp">
                    <c:out value="${gifticon.descn}"/>
                </p>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="/resources/js/user/wishList.js"></script>
    <script>
        // url 이동
        function common_goUrl(url){
            if(url != ""){
                location.href = url;
            }
        }

        $(document).ready(function (){

            let has = ${hasWish};       // 관심상품으로 등록되어 있는지 확인
            let userId = ${userId};

            // '관심상품' 버튼 상태 표시
            if(has === 1){
                $("#like-button").addClass('selected')
            }else{
                $("#like-button").removeClass('selected')
            }

            // 관심 상품 버튼 클릭하면 이벤트 발생
            $("#like-button").on("click", function (e){

                if(userId === 0){    // 로그인이 안 되어 있을 때
                    alert("로그인 후에 이용가능한 메뉴입니다.")
                    $(location).attr('href', "/account/signIn");

                }else{
                    if(has === 0){ // 관심상품 미등록 상태일때 추가
                        wishListService.add(
                            {userId: userId,
                            prodCode: "${gifticon.prodCode}"},
                            function (result){
                                $("#like-button").addClass('selected');
                                has = 1;
                                alert("관심상품으로 등록되었습니다.");
                            });
                    }else{ // 관심상품 등록 상태일때 삭제
                        wishListService.remove(
                            {userId: userId,
                            prodCode: "${gifticon.prodCode}"},
                            function (result){
                                $("#like-button").removeClass('selected');
                                has = 0
                                alert("관심상품에서 삭제되었습니다.");
                            });
                        }
                    }
            })
        });

    </script>
</body>
