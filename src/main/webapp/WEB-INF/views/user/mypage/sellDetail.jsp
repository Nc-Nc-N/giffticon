<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="templete.jsp"/>

<link rel="stylesheet" href="/resources/css/user/mypage/user_info_modal.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_deals_detail.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_selling_products_detail.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_selling_products_detail_modify.css" type="text/css">

<div class="contentheader">
    <span>상품상세</span>
</div>
<div class="contentinfo">
    판매대기&nbsp;<i class="fas fa-caret-right"></i>&nbsp;판매중&nbsp;<i class="fas fa-caret-right"></i>
    &nbsp;거래확정대기&nbsp;<i class="fas fa-caret-right"></i>&nbsp;거래확정완료
</div>
<div class="item_info">
    <div class="item_img gifticon-img">
        <img src="<c:out value="${gftInfo.brcdImgPath}"/>">
    </div>
    <div class="item_nameNcode">
        <div class="item_name">
            <div>브랜드</div>
            <c:out value="${gftInfo.brdName}"/>
        </div>
        <div class="item_code">
            <div>상품명</div>
            <c:out value="${gftInfo.prdName}"/>
        </div>
        <div class="item_name">
            <div>상품 번호</div>
            <c:out value="${gftInfo.prdCode}"/><c:out value="${gftInfo.id}"/>
        </div>
        <div class="item_name">
            <div>등록일자</div>
            <c:choose>
                <c:when test="${gftInfo.aprvDt != null}">
                    <fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.aprvDt}"/>
                </c:when>
                <c:otherwise>
                    미승인
                </c:otherwise>
            </c:choose>
        </div>
        <div class="item_name">
            <div>추천할인율</div>
            <c:out value="${gftInfo.isAutoPrc eq '1'.charAt(0) ? '적용' : '판매자 제시가격'}"/>
        </div>
        <div class="item_name">
            <div>판매가격</div>
            <c:out value="${gftInfo.dcPrc}"/>원 &nbsp;
            <sapn style="color: rgb(255, 88, 93)"><fmt:formatNumber value="${gftInfo.finalDcRate}" type="percent" pattern="0%"/></sapn>&nbsp;
        </div>
        <div class="item_name">
            <div>유효기간</div>
            <fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.expirDt}"/>
        </div>
        <div class="item_name">
            <div>바코드</div>
            <c:out value="${gftInfo.brcd}"/>
        </div>
        <div class="item_name">
            <div>상태</div>
            <c:out value="${gftInfo.codeName}"/>
        </div>
    </div>
    <div class="item_btn_seller">
        <c:choose>
            <c:when test="${gftInfo.codeName eq '판매대기' || gftInfo.codeName eq '판매중'}">
                <button id="modifyGift" class="btn btn-active" value="<c:out value="${gftInfo.id}"/>">상품수정</button>
                <button id="deleteGift" class="btn btn-remove" value="<c:out value="${gftInfo.id}"/>">내역삭제</button>
            </c:when>
            <c:when test="${gftInfo.codeName eq '판매불가'}">
                <button class="btn btn-disabled">판매불가</button>
                <button class="btn btn-disabled">수정불가</button>
            </c:when>
            <c:otherwise>
                <button class="btn btn-disabled">판매완료</button>
                <button class="btn btn-disabled">수정불가</button>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="space50"></div>

<div class="toListbtn">
    <form id="actionForm" action="/user/mypage/sells" method="get">
        <input type="hidden" name="dateFrom" value="<c:out value="${cri.dateFrom}"/>">
        <input type="hidden" name="dateTo" value="<c:out value="${cri.dateTo}"/>">
        <input type="hidden" name="pageNum" value="${cri.pageNum}">
        <input type="hidden" name="amount" value="${cri.amount}">
        <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
        <input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button id="toListbtn">목록</button>
    </form>
</div>

</div>
</div>
</div>
</div>

<div class="modalOn">
    <jsp:include page="mypage_selling_products_detail_modify.jsp"/>
</div>
<div class="space100"></div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>

<script> //actionForm , 기프티콘 수정 및 삭제
$(".document").ready(function () {
    $("#sell-link").attr("class", "menu active");

    var actionForm = $("#actionForm");

    //기프티콘 삭제 버튼
    $('#deleteGift').on("click", function (e) {

        if (confirm("삭제하시겠습니까? 삭제 후 재등록 가능합니다.")) {
            actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
            actionForm.attr("action", "/gifticon/delGft").attr("method", "post");
            actionForm.submit();
        } else {
            return;
        }
    });

    //수정 버튼 클릭시 모달 띄우기
    $("#modifyGift").on("click", function (e) {
        let h = $("body").css("height");
        $(".modalOn").css("height", h);
        $(".modalOn").css("visibility", "visible");
    });

    //닫기 버튼 클릭 시 모달 닫기
    $("#modal-close").on("click", function (e) {

        $(".modalOn").css("visibility", "hidden");
    });

});

</script>