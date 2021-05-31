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
                    <a class="cateAll" href="gifti_list?code=${category.code}&orderby=best">전체보기</a>
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
                    <div class="right-detail">
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
                    </div>

                    <div class="option-group">
                        <div class="group">
                            <button type="button" id="like-button">
                                <svg class="heart-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M91.6 13A28.7 28.7 0 0 0 51 13l-1 1-1-1A28.7 28.7 0 0 0 8.4 53.8l1 1L50 95.3l40.5-40.6 1-1a28.6 28.6 0 0 0 0-40.6z"/></svg>
                                관심상품
                            </button>

                            <form class="opt-order" action="/user/gifti_order" method="get">
                            <select name="gifti" class="option-select">
                                <option value=""> 옵션 선택하기 </option>
                                <c:forEach items="${giftiList}" var="gifti">
                                    <option value="${gifti.id}">
                                        할인가:<fmt:formatNumber type="number" maxFractionDigits="3" value="${gifti.dcPrc}" />(<fmt:formatNumber value="${gifti.dcRate}" type="percent" />) /
                                        유효기간: <fmt:formatDate value="${gifti.expirDt}" pattern="yyyy-MM-dd"/> 까지
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="button" id="order-btn" class="btn-active">
                            구매하기
                        </button>
                            </form>

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
</body>
<script type="text/javascript" src="/resources/js/user/wishList.js"></script>
<script>
    $(document).ready(function (){
        // url 이동
        function common_goUrl(url){
            if(url != ""){
                location.href = url;
            }
        }

        // 에러 메시지 처리
        let error = "${error}";

        if(error.length > 0){
            alert("error: " + error);
        }
    });
</script>

<%--관심상품, 구매하기--%>
<script>
    $(document).ready(function (){
        let has = ${hasWish};
        const userId = ${userId};

        // 관심상품 등록, 삭제
        function isWishList(){

            let wish = {userId: userId, prodCode:"${gifticon.prodCode}"};

            if($("#like-button").hasClass('selected')){
                wishListService.remove(wish)
            }else{
                wishListService.add(wish)
            }

        }

        // '관심상품' 버튼 상태 표시
        if(has === 1){
            $("#like-button").addClass('selected')
        }else{
            $("#like-button").removeClass('selected')
        }

        // '관심상품', '구매하기' 버튼 클릭하면 이벤트 발생
        $("#like-button, #order-btn").on("click", function (e) {

            // 로그인이 안 되어 있을 때
            if(userId === 0) {
                let result = confirm("회원전용 서비스 입니다. 로그인/회원가입 페이지로 이동하시겠습니까?");
                if(result){
                    $(location).attr('href', "/account/signIn");
                }

            }else{

                // 관심상품
                if($(this).attr("id") ==="like-button"){

                    isWishList();

                }else{  // 구매하기

                    let orderForm = $(".opt-order");
                    let gftId = $(".option-select option:selected").val();

                    e.preventDefault();

                    if (!gftId) {
                        alert("옵션을 선택해 주세요");
                        return false;
                    }
                    $.ajax({
                        url: '/gifticon/gftId/'+gftId,
                        type: 'get',
                        success: function (){
                            orderForm.submit();
                        },
                        error: function (){
                            alert("본인이 등록한 기프티콘입니다. " +
                                "판매취소를 원하시는 경우 마이페이지 - 판매내역으로 이동해 주세요.");
                        }

                    })
                }
            }
        })
    });
</script>

<%@include file="/WEB-INF/views/common/footer.jsp"%>
