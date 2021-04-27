<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--isELIgnored="false"--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/history/deal_history.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<h1>거래내역관리</h1>

<!-- search area -->
<form id='searchForm' action="/admin/deal-history" method="get">
<div class="search-area">
    <div class="period-container">
        <span id="period">거래 기간</span>
        <div class="date-search">
            <input type="date" id="dateFrom" name="dateFrom"
                   value="<c:out value="${pageMaker.cri.dateFrom}"/>">
            <span style="font-size:20px">~</span>
            <input type="date" id="dateTo" name="dateTo"
            value="<c:out value="${pageMaker.cri.dateTo}"/>">
        </div>
    </div>
    <div class="search-container">

        <select name='type' class="search-select">
            <option value="BSCNEPL"
                    <c:out value="${pageMaker.cri.type eq 'BSCNEPL'?'selected':''}"/>>전체
            </option>
            <option value="B"
                    <c:out value="${pageMaker.cri.type eq 'B'?'selected':''}"/>>구매자 Email
            </option>
            <option value="S"
                    <c:out value="${pageMaker.cri.type eq 'S'?'selected':''}"/>>판매자 Email
            </option>
            <option value="C"
                    <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>주문번호
            </option>
            <option value="N"
                    <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>상품일련번호
            </option>
            <option value="E"
                    <c:out value="${pageMaker.cri.type eq 'E'?'selected':''}"/>>브랜드명
            </option>
            <option value="P"
                    <c:out value="${pageMaker.cri.type eq 'P'?'selected':''}"/>>상품명
            </option>
            <option value="L"
                    <c:out value="${pageMaker.cri.type eq 'L'?'selected':''}"/>>상태
            </option>
        </select>

            <div id='search-bar-container'>
                <input type="text" name="keyword" class="search-input"
                       value='<c:out value="${pageMaker.cri.keyword}"/>'/>
                <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
                <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>

                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </div>

    </div>
</div>
</form>
<!-- search area end -->
<div>
    <table id="t1" width="100%">
        <tr>
            <th style="width:9%">주문번호</th>
            <th style="width:23%">
                <p>구매자 Email</p>
                <p>판매자 Email</p>
            </th>
            <th style="width:9%">상품일련번호</th>
            <th style="width:20%">
                <p>브랜드명</p>
                <p>상품명</p>
            </th>
            <th style="width:9%">금액</th>
            <th style="width:20%">
                <p>구매일시</p>
                <p>구매확정일시</p>
            </th>
            <th style="width:10%">상태</th>
        </tr>
        <c:forEach items="${list}" var="dealL">
            <tr>
                <td>${dealL.id}</td>
                <td>
                    <p>${dealL.buyerEmail}</p>
                    <p>${dealL.sellerEmail}</p>
                </td>
                <td>${dealL.gifticonId}</td>
                <td>
                    <p>${dealL.brdName}</p>
                    <p>${dealL.prodName}</p>
                </td>
                <td>${dealL.prc}</td>
                <td>
                    <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                       value="${dealL.dealDt}"/></p>
                    <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                       value="${dealL.cmplDt}"/></p>
                <td>${dealL.codeName}</td>
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

<form id='actionForm' action="/admin/deal-history" method='get'>
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

        document.getElementById("dealHistAdministration").className = 'active';

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

    }); //end of $(document).ready



</script>