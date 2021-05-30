<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="csTemplete.jsp"/>
<meta charset="UTF-8">

<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_faq.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/notice_board.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/faq_board.css" type="text/css">

<h3>자주묻는 질문</h3>

<div class="line-117"></div>

<div class="sub-category-area">
    <button class="sub sub-category-btn-all" value="NE" name="type"
            onclick="location.href='/user/cs/faqBoard?pageNum=1&amount=10&type=NE&keyword=';">
        전체
    </button>
    <button class="sub sub-category-btn-notice" value="N" name="type"
            onclick="location.href='/user/cs/faqBoard?pageNum=1&amount=10&type=N&keyword=';">
        구매
    </button>
    <button class="sub sub-category-btn-event" value="E" name="type"
            onclick="location.href='/user/cs/faqBoard?pageNum=1&amount=10&type=E&keyword=';">
        판매
    </button>
</div>

<!-- search area -->
<form class="search-form" id='searchForm' action="/user/cs/faqBoard" method="get">
    <div class="search-area">
        <div class="search-input-area">
            <input type="text" class="search-input" name="keyword"
                   value='<c:out value="${pageMaker.cri.keyword}"/>'>
            <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
            <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
            <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
            <button type="submit" class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </div>
</form>
<!-- search area end -->

<!--accordionMenu-->
<div class="accordionMenu">
    <c:forEach items="${list}" var="faq" varStatus="status">
        <!-- 1st menu-->
        <input type="checkbox" name="trg1" id="acc<c:out value="${status.index+1}"/>">
        <label class="contentList" name="<c:out value="${status.index}"/>" for="acc<c:out value="${status.index+1}"/>">
            <span class="qna-q">Q. </span><c:out value="${faq.csCateCode == '001' ? '[구매]':'[판매]'}"/>
            <c:out value="${faq.qust}"/>

        </label>
        <div class="content" name="content_<c:out value="${status.index}"/>">
            <div class="inner">
                <p><span class="qna-a"></span> <c:out value="${faq.ans}"/></p>
            </div>

        </div>
    </c:forEach>
    <c:if test="${list.size() == 0}">
        <div class="noSearchResult">검색 결과가 없습니다.</div>
    </c:if>
</div>
<!-- end accordionMenu-->

<div class="space50"></div>

<!-- pagenation-->
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
<!-- end pagenation-->

<form id='actionForm' action="/user/cs/faqBoard" method="get">
    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
    <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
    <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
</form>
</div>
<!-- end content -->
</div>
</div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp"%>

</body>
</html>

<script type="text/javascript" src="/resources/js/etc/screenHeight.js"></script>
<script type="text/javascript">
    //검색
    var searchForm = $("#searchForm");

    $(".search-button").on("click", function (e) {
        e.preventDefault();

        searchForm.find("input[name='pageNum']").val("1");
        searchForm.submit();
    });


    $(document).ready(function () {

        let type = "${pageMaker.cri.type}";

        let activeMenu = type === 'NE' ? ".sub-category-btn-all" : type === 'N' ? ".sub-category-btn-notice" : ".sub-category-btn-event";
        $(activeMenu).css("color", "rgb(255, 88, 93)");

        $(".contentList").on("click", function(){

            let listNum = "content_" + $(this).attr("name");
            let divDisplay = $("div[name=" + listNum + "]").css("display");

            if(divDisplay == "none"){
                $("div[name=" + listNum + "]").css("display","block");
            }else{
                $("div[name=" + listNum + "]").css("display","none");
            }

            calculateContentLength();
        })

        $("#faq-link").attr("class", "menu active");

        //사용자 Faq 오류 메시지를 controller에서 보내줌.
        let error = "${error}";

        // error 발생 시 해당 에러 메시지를 alert
        if (error.length > 0) {
            alert("에러 발생. 담당자에게 문의해주세요. \n" + error);
        }

        //pagenation
        var actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });
    });

</script>

