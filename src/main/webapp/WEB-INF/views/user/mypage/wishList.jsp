<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="templete.jsp"/>
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_wish.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/gifticon/prod.css" type="text/css">

<head>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>
<div class="contentheader">
    <span>관심 상품</span>
</div>

<div class="space30"></div>
<c:set var="i" value="0"/>
<c:set var="j" value="3"/>
<div class="item">
    <table>
        <c:forEach items="${wishList}" var="list" varStatus="num">
        <c:if test="${i%j==0}">
        <tr>
        </c:if>
        <td>
            <div class="items">
                <div class="pic">
                    <div class="img">
                        <img src="<c:out value='${list.imgPath}'/>">
                    </div>
                </div>
                <div class="itembrand">
                    <c:out value="${list.bname}"/>
                </div>
                <div class="itemname" value="<c:out value="${list.prodCode}"/>">
                    <c:out value="${list.pname}"/>
                </div>
                <button type="button" class="delete-btn" value="<c:out value="${list.prodCode}"/>">
                    삭제
                </button>
            </div>
        </td>
        <c:if test="${i%j == j-1}">
        </tr>
        </c:if>
        <c:set var="i" value="${i+1}"/>
        </c:forEach>
    </table>

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
                <a class="paginate_btn ${pageMaker.cri.pageNum == num ? "active" : ""}" href="${num}">${num}</a>
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
    <div class="space50"></div>
</div>
</div>
</div>
</div>
</body>

<script type="text/javascript" src="/resources/js/user/wishList.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#wish-link").attr("class", "menu active");

        let actionForm = $("#actionForm");

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
                    prodCode: prodCode});

            location.href = "/user/mypage/wishList"
        })

        if(${pageMaker.total} === 0) {

            $('.noResult').show();
        }

        //물품 이름 클릭 시 해당 물품의 판매중인 기프티콘 조회. 판매중 있을 시 상품상세로 이동
        $(".itemname").on("click", function (e) {
            e.preventDefault();

            let prdCode = $(this).attr("value");

            $.ajax({
                url: '/gifticon/' + prdCode,
                type: 'get',
                success: function () {
                    if (confirm("해당 상품 판매 페이지로 이동하시겠습니까?")) {
                        location.href = "/user/gifti_detail?code=" + prdCode;
                    } else {
                        return;
                    }
                },
                error: function () {
                    alert("해당 물품의 구매가능한 기프티콘이 없습니다.")
                }
            });
        });
    });
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>