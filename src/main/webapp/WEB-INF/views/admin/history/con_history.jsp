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
<div id="submenu">
    <div>
        <a href="/admin/con-history" class="active"><span>콘내역관리</span></a>
    </div>
    <div>
        <a href="#"><span>콘수수료관리</span></a>
    </div>
</div>

<!-- search area -->
<form id='searchForm' action="/admin/con-history" method="get">
    <div class="search-area">
        <div class="period-container">
            <span id="period">거래 기간</span>
            <div class="date-search">
                <input type="date" id="dateFrom" name="dateFrom"
                       value="<c:out value="${pageMaker.cri.dateFrom}"/>">
                <span id="tilde">~</span>
                <input type="date" id="dateTo" name="dateTo"
                       value="<c:out value="${pageMaker.cri.dateTo}"/>">
            </div>
        </div>
        <div class="search-container">
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
    </div>

    <!-- search area end -->
    <div id="checkbox-container">
        <input type="checkbox" id="k1" name="deposit"
        <c:out value="${pageMaker.cri.deposit eq 'on'?'checked=\"checked\"':''}"/>>입금
        <input type="checkbox" id="k2" name="withdraw"
        <c:out value="${pageMaker.cri.withdraw eq 'on'?'checked=\"checked\"':''}"/>>출금
        <input type="checkbox" id="k3" name="buy"
        <c:out value="${pageMaker.cri.buy eq 'on'?'checked=\"checked\"':''}"/>>구매
        <input type="checkbox" id="k4" name="sell"
        <c:out value="${pageMaker.cri.sell eq 'on'?'checked=\"checked\"':''}"/>>판매
    </div>
</form>


<br>
<div>
    <c:choose>
        <c:when test="${not empty list}">
            <table id="t1" width="100%">
                <tr>
                    <th style="width:26%">회원 Email</th>
                    <th style="width:12%">거래종류</th>
                    <th style="width:12%">금액</th>
                    <th style="width:15%">주문번호</th>
                    <th style="width:20%">거래일시</th>
                    <th style="width:15%">잔여 콘</th>
                </tr>
                <c:forEach items="${list}" var="conL">
                    <tr>
                        <td>${conL.email}</td>
                        <td>${conL.codeName}</td>
                        <td>${conL.chgQuty}</td>
                        <td>${conL.dealId}</td>
                        <td>
                            <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                            value="${conL.chgDt}"/>
                        </td>
                        <td>${conL.balance}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <div>
                <p id="nonresultmessage">검색조건에 해당하는 콘내역을 찾을 수 없습니다.</p>
            </div>
        </c:otherwise>
    </c:choose>
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
    <input type='hidden' name='deposit' value='<c:out value="${ pageMaker.cri.deposit}"/>'>
    <input type='hidden' name='withdraw' value='<c:out value="${ pageMaker.cri.withdraw}"/>'>
    <input type='hidden' name='buy' value='<c:out value="${ pageMaker.cri.buy}"/>'>
    <input type='hidden' name='sell' value='<c:out value="${ pageMaker.cri.sell}"/>'>
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
        let searchForm = $("#searchForm");

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


    $("#checkbox-container input").change(function () {
        $(".search-button").click();
    });

</script>

