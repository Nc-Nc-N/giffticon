<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--isELIgnored="false"--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/user/userList.css" type="text/css">

<h1>회원목록</h1>

<div id="submenu">
    <div>
        <a href="/admin/user/userlist" class="active"><span>회원목록</span></a>
    </div>
    <div>
        <a href="#"><span>탈퇴회원목록</span></a>
    </div>
</div>

<!-- search area -->
<div class="search-area">
    <form id='searchForm' action="/admin/user/userlist" method='get'>
        <select name='type' class="search-select">
            <option value="NET"
                    <c:out value="${pageMaker.cri.type eq 'NET'?'selected':''}"/>>전체
            </option>
            <option value="N"
                    <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>이름
            </option>
            <option value="E"
                    <c:out value="${pageMaker.cri.type eq 'E'?'selected':''}"/>>이메일
            </option>
            <option value="T"
                    <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>전화번호
            </option>
        </select>
        <div id='search-bar-container'>
            <input type="text" name='keyword' class="search-input"
                   value='<c:out value="${pageMaker.cri.keyword}"/>'/>
            <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
            <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>

            <button type="submit" class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </form>
</div>
<!-- search area end -->

<!-- table wrapper -->
<div id="tablewrapper">
    <table id="t1">
        <tr>
            <th>회원번호</th>
            <th>이메일</th>
            <th>이름</th>
            <th>가입일시</th>
            <th>전화번호</th>
            <th>회원상태</th>
        </tr>
        <c:forEach items="${list}" var="userL">
            <tr class="test11">
                <td>${userL.id}</td>
                <td>${userL.email}</td>
                <td>${userL.name}</td>
                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                    value="${userL.inDate}"/></td>
                <td>${userL.telNo}</td>
                <td>${userL.enabled}</td>
            </tr>
        </c:forEach>
    </table>
</div>
<!-- table wrapper end -->

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

<form id='actionForm' action="/admin/user/userlist" method='get'>
    <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
    <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
    <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type}"/>'>
    <input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword}"/>'>
</form>
</div>
<!-- main end -->


<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

        let actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {

            e.preventDefault();

            console.log("click");

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();

        });

        let searchForm = $("#searchForm");

        $("#searchForm button").on("click", function (e) {

            searchForm.find("input[name='pageNum']").val("1");
            e.preventDefault();

            searchForm.submit();

        });

    }); //end of $(document).ready

</script>