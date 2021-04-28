<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--isELIgnored="false"--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/history/con_history.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<h1>콘관리</h1>
<div id="menu">
    <div>
        <a href="/admin/con-history" style="color: rgb(255, 88, 93);">콘내역관리</a>
    </div>
    <div>
        <a href="#">콘수수료관리</a>
    </div>
</div>

<!-- search area -->
<form id='searchForm' action="/admin/con-history" method="get">
    <div class="search-area">
        <span id="period">거래 기간</span>
        <div class="date-search">
            <input type="date" id="dateFrom" name="dateFrom"
                   value="<c:out value="${pageMaker.cri.dateFrom}"/>">
            <span style="font-size:20px">~</span>
            <input type="date" id="dateTo" name="dateTo"
                   value="<c:out value="${pageMaker.cri.dateTo}"/>">
        </div>
        <select name="type" class="search-select">
            <option value="EN"
            <c:out value="${pageMaker.cri.type eq 'EN'?'selected':''}"/>>전체
            <option value="E"
                    <c:out value="${pageMaker.cri.type eq 'E'?'selected':''}"/>>Email
            </option>
            <option value="N"
                    <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>주문번호
            </option>
        </select>

        <div>
            <input type="text" name="keyword" class="search-input"
                   value='<c:out value="${pageMaker.cri.keyword}"/>'/>
            <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
            <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>

            <button type="submit" class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>

    </div>
</form>
<!-- search area end -->
<div id="checkbutton">
    <form>
        <input type="checkbox">입금
        <input type="checkbox">출금
        <input type="checkbox">구매
        <input type="checkbox">판매
    </form>
</div>


<br>
<div>
    <table id="t1" width="100%">
        <tr>
            <th style="width:26%">회원 Email</th>
            <th style="width:12%">거래종류</th>
            <th style="width:12%">금액</th>
            <th style="width:15%">주문번호</th>
            <th style="width:20%">거래일시</th>
            <th style="width:15%">잔여 포인트</th>
        </tr>
        <c:forEach items="${list}" var="conL">
            <tr>
                <td>${conL.email}</td>
                <td>${conL.codeName}</td>
                <td>${conL.chgQuty}</td>
                <td>${conL.dealId}</td>
                <td>${conL.chgDt}</td>
                <td>${conL.balance}</td>
            </tr>
        </c:forEach>

    </table>

</div>

<!-- pagination container -->
<div class="pagination-container">
    <div class="pagination">

        <c:if test="${pageMaker.prev}">
            <li>
                <a class="paginate_button previous" href="${pageMaker.startPage -1}">&lt;</a></li>
        </c:if>

        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li>
                <a class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}" href="${num}">${num}</a>
            </li>
        </c:forEach>

        <c:if test="${pageMaker.next}">
            <li>
                <a class="paginate_button next" href="${pageMaker.endPage +1 }">&gt;</a></li>
        </c:if>
    </div>
</div>
<!-- pagination container end -->

<form id='actionForm' action="/admin/con-history" method='get'>
    <input type="hidden" name="dateFrom" value="<c:out value="${pageMaker.cri.dateFrom}"/>">
    <input type="hidden" name="dateTo" value="<c:out value="${pageMaker.cri.dateTo}"/>">
    <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
    <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
    <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type}"/>'>
    <input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword}"/>'>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>

</div>
</div>
</div>


<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>
<script type="text/javascript" src="/resources/js/user/calendar.js"></script>

<script type="text/javascript">
    $(document).ready(function () {

        document.getElementById("conAdministration").className = 'active';

        let actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {

            e.preventDefault();

            console.log("click");

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();

        });

        //search 버튼 누를 시 날짜조건이 정확한지 체크 후 검색 실행
        $(".search-button").on("click", function (e) {

            let dateFrom = $("#dateFrom").val();
            let dateTo = $("#dateTo").val();

            if (!calendarCheck(dateFrom, dateTo)) {
                alert("날짜 선택이 올바르지 않습니다.");
                e.preventDefault();
            } else {

                searchForm.find("input[name='pageNum']").val("1");
                searchForm.submit();
            }
        });
    });

</script>

