<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_wish.css" type="text/css">

<jsp:include page="templete.jsp"/>
<head>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
<div class="contentheader">
    <span>관심 상품</span>
</div>

<div class="space30"></div>
<div class="item">
    <c:forEach items="${wishList}" var="list" varStatus="num">

        <div class='item_info'>
            <span class="item_img"><img src="<c:out value='${list.imgPath}'/>"></span>
            <span class="item_brdNname">
                                <div class="item_brd"><c:out value="${list.bname}"/></div>
            <a href="/user/prod_detail?code=${list.prodCode}">
                                <div class="item_name"><c:out value="${list.pname}"/></div>
            </a>
            </span>

            <div class="itemprice">
                <span><del><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.prc}"/> 원</del></span>&nbsp;&nbsp;
                <span><fmt:formatNumber value="${list.dcRate}" type="percent" /></span>&nbsp;&nbsp;
                <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.dcPrc}"/>원</span>
            </div>

            <button type="button" class="delete-btn" value="<c:out value="${list.prodCode}"/>">
                삭제
            </button>

        </div>
    </c:forEach>

    <div class="noResult" style="display: none">
        관심 상품이 존재하지 않습니다.
    </div>
</div>

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

        <form id="actionForm" action="/user/mypage/wishList" method="get">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        </form>

    </div>
</div>
</div>
</div>
</body>

<script type="text/javascript" src="/resources/js/user/wishList.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var actionForm = $("#actionForm");

        // 페이지네이션 이벤트 처리
        $(".paginate_btn").on("click", function (e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        // 삭제 버튼 이벤트 처리
        $(".delete-btn").on("click", function (e){
            console.log("delete-btn 클릭!")
            // 상품 코드
            let prodCode = $(this).attr("value");

           wishListService.remove(
                {userId: "${userId}",
                    prodCode: prodCode},
                function (result){
                    alert("관심상품에서 삭제되었습니다.");
                });

           actionForm.find("input[name='pageNum']").val(1);
           actionForm.submit();
        })

        if(${pageMaker.total}===0){
            $('.noResult').show();
        }
    })
</script>
