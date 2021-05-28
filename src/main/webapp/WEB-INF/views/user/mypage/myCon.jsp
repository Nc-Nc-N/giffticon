<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="templete.jsp"/>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<link rel="stylesheet" href="/resources/css/user/mypage/myCon.css" type="text/css">

<div class="contentheader">
    <span> 마이 콘</span>
</div>
<div class="viewConList">
    <div class="con-info">
        <div class="con-tit">
            <div class="con-tit_txt">
                <div class="giffticon-txt">기쁘티콘</div>
                <div class="con-txt">콘 잔액</div>
            </div>
        </div>
        <div class="info-right">
            <div class="con-amount-info">
                <span class="con-amount"><fmt:formatNumber value="${user.pnt}" type="number" maxFractionDigits="3"/></span>
                <span class="con-amount-won">콘</span>
            </div>
            <ul class="con-btns">
                <li class="btn-li">
                    <a href="/user/mypage/addCon" class="home-summary-buttons__alink--topUp">
                        <span class="btns-txt"><i class="fas fa-plus"></i> 충전하기</span>
                    </a>
                </li>
                <li class="btn-li">
                    <button class="withdraw-btn"><i class="fas fa-minus"></i> 인출하기</button>
                </li>
            </ul>
        </div>
    </div>

    <div class="contentsearch">
        <form class="search-spec" action="/user/mypage/myCon" method="get">
            <div class="search-area">
                <select class="search-select" name="type">
                    <option value="">
                        전체
                    </option>
                    <option value="A"
                            <c:out value="${pageMaker.cri.type eq 'A' ? 'selected' : ''}"/>> 충전
                    </option>
                    <option value="W"
                            <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}"/>> 인출
                    </option>
                    <option value="B"
                            <c:out value="${pageMaker.cri.type eq 'B' ? 'selected' : ''}"/>> 구매
                    </option>
                    <option value="S"
                            <c:out value="${pageMaker.cri.type eq 'S' ? 'selected' : ''}"/>> 판매
                    </option>
                </select>

                <div class="date-search">
                    <input type="text" id="dateFrom" name="dateFrom" value="<c:out value="${pageMaker.cri.dateFrom}"/>" readonly>
                    <span>~</span>
                    <input type="text" id="dateTo" name="dateTo" value="<c:out value="${pageMaker.cri.dateTo}"/>" readonly>
                </div>
                <div class="search-form">
                    <input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum}"/>">
                    <input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount}"/>">
                    <button type="submit" class="search-button"><i class="fas fa-search"></i></button>
                </div>
            </div>
        </form>
    </div>
    <table class="tbl tbl_type1">
        <colgroup>
            <col style="width: 120px;">
            <col style="width: auto;">
            <col style="width: 122px;">
            <col style="width: 140px;">
        </colgroup>
        <thead>
        <tr>
            <th>거래종류</th>
            <th>거래일시</th>
            <th>금액</th>
            <th>잔여 콘</th>
        </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${not empty conHist}">
                <c:forEach items="${conHist}" var="conH">
                    <tr>
                        <td>${conH.codeName}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${conH.chgDt}"/></td>
                        <td>${conH.chgQuty}</td>
                        <td>${conH.balance}</td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr class="no_data_tr">
                    <td colspan="4" class="no_data">콘 내역이 존재하지 않습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>
        </tbody>
    </table>
</div>
<div class="contentfooter">
    <div class="pagination">
        <c:if test="${pageMaker.prev}">
            <a class="paginate_btn prev" href="${pageMaker.startPage - 1}"><</a>
        </c:if>
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <a class="paginate_btn ${pageMaker.cri.pageNum == num ? "active" : ""}" href="${num}" }>${num}</a>
        </c:forEach>
        <c:if test="${pageMaker.next}">
            <a class="paginate_btn next" href="${pageMaker.endPage + 1}">></a>
        </c:if>
    </div>

    <form id="actionForm" action="/user/mypage/myCon" method="get">
        <input type="hidden" name="dateFrom" value="<c:out value="${pageMaker.cri.dateFrom}"/>">
        <input type="hidden" name="dateTo" value="<c:out value="${pageMaker.cri.dateTo}"/>">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
    </form>
</div>

</div>
</div>
</div>
</div>
<div class="space100"></div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>

<script>
    $(document).ready(function () {
        $("#con-link").attr("class", "menu active");

        let actionForm = $("#actionForm");
        let searchSpec = $(".search-spec");

        $(".withdraw-btn").on("click", function () {
            $.ajax({
                type: "GET",
                url: "/user/mypage/checkAccount",
                success: function () {
                    location.href = "/user/mypage/withdrawCon";
                },
                error: function () {
                    let result = confirm("등록된 계좌가 존재하지 않습니다. 계좌 등록 페이지로 이동하시겠습니까?");
                    if (result) {
                        $(location).attr('href', '/user/mypage/userInfo');
                    }
                }
            });
        })

        // 에러 메시지 처리
        let error = "${error}";

        if (error.length > 0) {
            alert("error: " + error);
        }

        // 페이지네이션 이벤트 처리
        $(".paginate_btn").on("click", function (e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        //search 버튼 누를 시 날짜조건이 정확한지 체크 후 검색 실행
        $(".search-button").on("click", function (e) {
            let dateFrom = $("#dateFrom").val();
            let dateTo = $("#dateTo").val();

            if ((dateFrom !== "" && dateTo === "") || (dateFrom === "" && dateTo !== "")) {
                alert("날짜 선택이 올바르지 않습니다.");
                e.preventDefault();
            } else {
                searchSpec.find("input[name='pageNum']").val("1");
                searchSpec.submit();
            }
        })

        $("#dateFrom").datepicker({
            dateFormat: 'yy-mm-dd',
            maxDate: 0,
            onClose: function (selectedDate) {
                $("#dateTo").datepicker("option", "minDate", selectedDate);
            }
        });

        $("#dateTo").datepicker({
            dateFormat: 'yy-mm-dd',
            maxDate: 0,
            onClose: function (selectedDate) {
                $("#dateFrom").datepicker("option", "maxDate", selectedDate);
            }
        });
    });
</script>