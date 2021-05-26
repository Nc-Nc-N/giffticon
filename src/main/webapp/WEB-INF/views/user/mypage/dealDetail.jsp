<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="templete.jsp"/>

<link rel="stylesheet" href="/resources/css/user/mypage/mypage_deals_detail.css" type="text/css">

<div class="contentheader">
    <span>상품상세</span>
</div>
<div class="contentinfo">
    거래확정대기&nbsp;<i class="fas fa-caret-right"></i>&nbsp;거래확정완료
</div>
<div class="item_info">
    <div class="item_img gifticon-img">
        <img src="<c:out value='${gftInfo.gftImgPath}'/>">
    </div>
    <div class="item_nameNcode">
        <div class="item_code">
            <div>상품코드</div>
            <c:out value="${gftInfo.prdCode}"/><c:out value="${gftInfo.gftId}"/>
        </div>
        <div class="item_name">
            <div>상품명</div>
            <c:out value="${gftInfo.prdName}"/>
        </div>
        <div class="item_name">
            <div>구매일자</div>
            <fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.dealDt}"/>
        </div>
        <div class="item_name">
            <div>유효기간</div>
            <fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.exprDt}"/>
        </div>
        <div class="item_name">
            <div>바코드</div>
            <c:out value=" ${gftInfo.brcd}"/>
        </div>
        <div class="item_name">
            <div>상태</div>
            <c:out value="${gftInfo.stusCode}"/>
        </div>
    </div>
    <div class="item_btn">
        <c:if test="${gftInfo.stusCode eq '거래확정대기'}">
            <button name="dealCmplBtn" class="btn btn-cmpl" value="<c:out value="${gftInfo.gftId}"/>">거래확정</button>
        </c:if>
        <c:if test="${gftInfo.stusCode eq '거래확정완료'}">
            <button class="btn btn-disabled">확정완료</button>
        </c:if>
    </div>
</div>
<div class="space50"></div>
<div class="toListbtn">
    <form id="actionForm" action="/user/mypage/deal" method="get">
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
<div class="space100"></div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>

<script>
    $(document).ready(function () {
        $("#deal-link").attr("class", "menu active");

        var actionForm = $("#actionForm");

        //구매확정 버튼
        $("button[name='dealCmplBtn']").on("click", function (i) {
            if (confirm("구매확정하시겠습니까? 확정 후 변경 불가합니다.")) {
                actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
                actionForm.attr("action", "/gifticon/stus005").attr("method", "post");
                actionForm.submit();
            } else {
                return;
            }
        });
    });
</script>