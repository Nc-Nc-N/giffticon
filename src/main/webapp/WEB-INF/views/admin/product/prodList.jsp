<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/request/requestList.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/request/requestDetail.css" type="text/css">

<h1>상품관리</h1>

<!-- menu -->
<div id="submenu"></div>
<!-- menu end -->

<!-- search area -->
<div class="search-area">
    <form id="search-form">
        <select name="type" class="search-select">
            <option value="CBPD" <c:out value="${pageMaker.cri.type eq 'CBPD' ? 'selected' : ''}"/>>전체</option>
            <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>카테고리명</option>
            <option value="B" <c:out value="${pageMaker.cri.type eq 'B' ? 'selected' : ''}"/>>브랜드명</option>
            <option value="P" <c:out value="${pageMaker.cri.type eq 'P' ? 'selected' : ''}"/>>상품명</option>
            <option value="D" <c:out value="${pageMaker.cri.type eq 'D' ? 'selected' : ''}"/>>상품코드</option>
        </select>
        <div class="search-form">
            <div>
                <input type="text" name="keyword" class="search-input"
                       value="<c:out value='${pageMaker.cri.keyword}'/>"/>
                <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
                <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>

                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>
</div>
<!-- search area end -->

<!-- request list -->
<div id="rqust-div">
    <table id="rqust-tb">
        <thead>
        <tr>
            <td class="w45">&nbsp;</td>
            <td class="w100">상품 이미지</td>
            <td class="w45">상품코드</td>
            <td class="w100">카테고리</td>
            <td class="w100">브랜드</td>
            <td class="w125">상품명</td>
            <td class="w45">사용여부</td>
            <td class="w45">&nbsp;</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="prod" items="${prodList}" varStatus="status">
            <tr class="rqust-tr">
                <td><input type="checkbox" name="isRemove"/></td>
                <td>
                    <div class="rqust-img"><img src="<c:out value='${prod.imgPath}'/>"></div>
                </td>
                <td>
                    <div><c:out value="${prod.prodCode}"/></div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${prod.cateName}"/></div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${prod.brdName}"/></div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${prod.prodName}"/></div>
                </td>
                <td>
                    <div><c:out value="${prod.enabled.toString() eq '1' ? '사용' : '미사용'}" /></div>
                </td>
                <td>
                    <div><a href="${prod.prodCode}" class="detail-link">상세</a></div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
<!-- request list end -->

<c:if test="${empty prodList}">
    <div class="nothing">판매요청이 없습니다.</div>
</c:if>

<div class="main-footer">
    <button class="btn btn-disabled">선택삭제</button>
    <div class="pagination">
        <c:if test="${pageMaker.prev}">
            <a class="paginate_button prev" href="${pageMaker.startPage - 1}">&lt;</a>
        </c:if>
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <a class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}" href="${num}">${num}</a>
        </c:forEach>
        <c:if test="${pageMaker.next}">
            <a class="paginate_button next" href="${pageMaker.endPage + 1}">&gt;</a>
        </c:if>
    </div>
</div>

<form id="actionForm" action='/admin/product/prodList' method="get">
    <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
    <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
    <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
    <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
</form>

</div>
<!-- main content end -->

<script>
    $(document).ready(function (e) {
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // 사이드바 판매요청관리 active
        $("a[id='prodAdministration']").attr('class', 'active');

        function submitAction(form, pageNum) {
            form.find("input[name='pageNum']").val(pageNum);
            form.submit();
        }

        // 페이지 이동
        let actionForm = $("#actionForm");
        $(".paginate_button").on("click", function (e) {
            e.preventDefault();
            let pageNum = $(this).attr("href");
            submitAction(actionForm, pageNum);
        });

        // 검색
        let searchForm = $("#search-form");
        $("#search-form button").on("click", function (e) {
            e.preventDefault();
            submitAction(searchForm, "1");
        });
    });
</script>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>

