<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_deals.css?after" type="text/css">

<jsp:include page="templete.jsp"/>

<div class="contentheader">
    <span>구매 내역</span>
</div>
<div class="contentinfo">
    거래확정대기&nbsp;>&nbsp;거래확정완료
</div>
<div class="contentsearch">

    <form class="search-spec" action="/user/mypage/deal" method="get">
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
    <c:forEach items="${dealList}" var="list" varStatus="num">
        <div class='item_purdate'>
            <fmt:formatDate pattern="yyyy-MM-dd" value="${list.dealDt}"/>
        </div>
        <div class='item_info'>
            <span class="item_img"><img src="<c:out value='${list.prdImgPath}'/>"></span>
            <span class="item_brdNname">
                                <div class="item_brd"><c:out value="${list.brdName}"/></div>
                                <div class="item_name"><a href="/user/prod_detail?code="><c:out
                                        value="${list.prdName}"/></a></div>
                            </span>
            <span class="item_prc"><c:out value="${list.pymtPrc}"/>원</span>
            <span class="item_status">
                                <div><c:out value="${list.stusCode}"/></div>
                                <div class="expr_dt">
                                (유효기간: <fmt:formatDate pattern="yyyy-MM-dd" value="${list.exprDt}"/>)
                                </div>
                            </span>
            <div class="item_buttons">

                <c:if test="${list.stusCode eq '거래확정대기'}">
                    <button name="dealCmplBtn" class="btn btn-cmpl" value="<c:out value="${list.gftId}"/>">거래 확정
                    </button>
                </c:if>
                <c:if test="${list.stusCode eq '거래확정완료'}">
                    <button class="btn btn-disabled">확정 완료</button>
                </c:if>
                <button name="dealDetailBtn" class="btn btn-active" value="<c:out value="${list.gftId}"/>">구매 상세
                </button>
            </div>
        </div>
    </c:forEach>
    <c:if test="${dealList.size() == 0}">
        <div class="noSearchResult">검색 결과가 없습니다.</div>
    </c:if>
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
        <form id="actionForm" action="/user/mypage/deal" method="get">
            <input type="hidden" name="dateFrom" value="<c:out value="${pageMaker.cri.dateFrom}"/>">
            <input type="hidden" name="dateTo" value="<c:out value="${pageMaker.cri.dateTo}"/>">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            <input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>"/>
            <input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type}"/>"/>
        </form>
    </div>
</div>

</div>
</div>
</div>
</div>

</body>
</html>
<script type="text/javascript">
    $(document).ready(function () {

        var actionForm = $("#actionForm");

        $(".paginate_btn").on("click", function (e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        $("button[name='dealDetailBtn']").on("click", function (k) {

            actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
            actionForm.attr("action", "/user/mypage/dealDetail").attr("method", "get");

            actionForm.submit();
        });

        $("button[name='dealCmplBtn']").on("click", function (i) {
            if (confirm("구매확정하시겠습니까? 확정 후 변경 불가합니다.")) {
                actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
                actionForm.attr("action", "/gifticon/stus005").attr("method", "get");
                actionForm.submit();
            } else {
                return;
            }
        });

        var searchSpec = $(".search-spec");

        $(".search-button").on("click", function (e) {

            searchSpec.find("input[name='pageNum']").val("1");
            e.preventDefault();
            searchSpec.submit();
        })

    })
</script>
