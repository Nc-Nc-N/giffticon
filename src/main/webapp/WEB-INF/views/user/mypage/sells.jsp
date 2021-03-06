<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="templete.jsp"/>

<link rel="stylesheet" href="/resources/css/user/mypage/mypage_deals.css" type="text/css">

<div class="contentheader">
    <span>판매 내역</span>
</div>
<div class="contentinfo">
    판매대기&nbsp;<i class="fas fa-caret-right"></i>&nbsp;판매중&nbsp;<i class="fas fa-caret-right"></i>
    &nbsp;거래확정대기&nbsp;<i class="fas fa-caret-right"></i>&nbsp;거래확정완료
</div>
<div class="contentsearch">
    <form class="search-spec" action="/user/mypage/sells" method="get">
        <div class="date-search">
            <input type="date" id="dateFrom" name="dateFrom"
                   value="<c:out value="${pageMaker.cri.dateFrom}"/>">
            <span>~</span>
            <input type="date" id="dateTo" name="dateTo"
                   value="<c:out value="${pageMaker.cri.dateTo}"/>">
        </div>

        <div class="search-area">
            <select class="search-select" name="type">
                <option value="BPS"
                        <c:out value="${pageMaker.cri.type == 'BPS' ? 'selected' : ''}"/>>전체
                </option>
                <option value="B"
                        <c:out value="${pageMaker.cri.type eq 'B' ? 'selected' : ''}"/>>브랜드
                </option>
                <option value="P"
                        <c:out value="${pageMaker.cri.type eq 'P' ? 'selected' : ''}"/>>상품명
                </option>
                <option value="S"
                        <c:out value="${pageMaker.cri.type eq 'S' ? 'selected' : ''}"/>>상태
                </option>
            </select>

            <div class="search-form">
                <input type="text" class="search-input" name="keyword"
                       value="<c:out value="${pageMaker.cri.keyword}"/>"/>
                <input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum}"/>">
                <input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount}"/>">
                <button type="submit" class="search-button"><i class="fas fa-search"></i></button>
            </div>

        </div>
    </form>
</div>
<div class="space30"></div>
<div class="item">
    <c:forEach items="${sellList}" var="list" varStatus="num">
        <div class='item_purdate'>
            <fmt:formatDate value="${list.inDt}"/>
        </div>
        <div class='item_info'>
            <span class="item_img"><img src="<c:out value='${list.prdImgPath}'/>"></span>
            <span class="item_brdNname">
                <div class="item_brd"><c:out value="${list.brdName}"/></div>
                <div class="item_name" name="prdLink" value="<c:out value="${list.prdCode}"/>">
                    <c:choose>
                        <c:when test="${fn:length(list.prdName) > 14}">
                            <c:out value="${fn:substring(list.prdName, 0, 14)}"/>..
                        </c:when>
                        <c:otherwise>
                            <c:out value="${list.prdName}"/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="item_code">상품코드: <c:out value="${list.prdCode}"/><c:out value="${list.id}"/></div>
            </span>
            <span class="item_prc"><fmt:formatNumber value="${list.dcPrc}" type="number" maxFractionDigits="3"/>원</span>
            <span class="item_status">
                <div><c:out value="${list.codeName}"/></div>
                <div class="expr_dt">
                    (유효기간: <fmt:formatDate pattern="yyyy-MM-dd" value="${list.expirDt}"/>)
                </div>
            </span>
            <div class="item_buttons">
                <c:choose>
                    <c:when test="${list.codeName eq '판매대기' || list.codeName eq '판매중'}">
                        <button name="deleteGift" class="btn btn-cancel" value="<c:out value="${list.id}"/>">판매 취소
                        </button>
                    </c:when>
                    <c:when test="${list.codeName eq '판매불가'}">
                        <button class="btn btn-disabled">판매 불가</button>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-disabled">판매 완료</button>
                    </c:otherwise>
                </c:choose>
                <button name="sellDetailBtn" class="btn btn-active" value="<c:out value="${list.id}"/>">판매 상세
                </button>
            </div>
        </div>
    </c:forEach>
    <c:if test="${sellList.size() == 0}">
        <div class="noSearchResult">검색 결과가 없습니다.</div>
    </c:if>

    <div class="space50"></div>
    <div class="contentfooter">
        <div class="pagination">
            <c:if test="${pageMaker.prev}">
                <a class="paginate_btn prev" href="${pageMaker.startPage - 1}"><</a>
            </c:if>
            <c:forEach var="num" begin="${pageMaker.startPage}"
                       end="${pageMaker.endPage}">
                <a class="paginate_btn ${pageMaker.cri.pageNum == num ? "active" : ""}" href="${num}" }>${num}</a>
            </c:forEach>
            <c:if test="${pageMaker.next}">
                <a class="paginate_btn next" href="${pageMaker.endPage + 1}">></a>
            </c:if>
        </div>
        <form id="actionForm" action="/user/mypage/sells" method="get">
            <input type="hidden" name="dateFrom" value="<c:out value="${pageMaker.cri.dateFrom}"/>">
            <input type="hidden" name="dateTo" value="<c:out value="${pageMaker.cri.dateTo}"/>">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            <input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>"/>
            <input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>"/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </div>
</div>
</div>
</div>
</div>
</div>
<div class="space100"></div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>

<script type="text/javascript" src="/resources/js/user/calendar.js"></script>
<script>
    $(".document").ready(function () {
        $("#sell-link").attr("class", "menu active");

        var actionForm = $("#actionForm");

        //페이지네이션
        $(".paginate_btn").on("click", function (e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        var searchSpec = $(".search-spec");

        //검색버튼 클릭 시 날짜 조건 일치하면 검색 실행
        $(".search-button").on("click", function (e) {
            let dateFrom = $("#dateFrom").val();
            let dateTo = $("#dateTo").val();

            if (!calendarCheck(dateFrom, dateTo)) {
                alert("날짜 선택이 올바르지 않습니다.");
                e.preventDefault();
            } else {
                searchSpec.find("input[name='pageNum']").val("1");
                searchSpec.submit();
            }
        })

        //물품 이름 클릭 시 해당 물품의 판매중인 기프티콘 조회. 판매중 있을 시 상품상세로 이동
        $(".item_name").on("click", function (e) {
            e.preventDefault();

            let prdCode = $(this).attr("value");

            $.ajax({
                url: '/gifticon/' + prdCode,
                type: 'get',
                success: function () {
                    if (confirm("해당 상품 판매 페이지로 이동하시겠습니까?")) {
                        location.href = "/user/gifti_detail?code=" + prdCode;
                    }
                },
                error: function () {
                    alert("해당 물품의 구매가능한 기프티콘이 없습니다.")
                }
            });
        });

        //기프티콘 삭제 버튼
        $("button[name='deleteGift']").on("click", function (e) {
            if (confirm("삭제하시겠습니까? 삭제 후 재등록 가능합니다.")) {
                actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
                actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
                actionForm.attr("action", "/gifticon/delGft").attr("method", "post");

                actionForm.submit();
            }
        });

        //기프티콘 상세 페이지 이동
        $("button[name='sellDetailBtn']").on("click", function (e) {
            actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
            actionForm.attr("action", "/user/mypage/sellDetail").attr("method", "get");

            actionForm.submit();
        });
    });
</script>