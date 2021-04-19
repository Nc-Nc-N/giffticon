<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"></jsp:include>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
      integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="/resources/css/admin/adminLayout.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_faq.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_one-on-one.css" type="text/css">


    <h2>고객센터</h2>
    <div id="submenu">
        <div class="menu-item">
            <a href="http://localhost:8087/cs/adminNotice">공지사항</a>
        </div>
        <div class="menu-item">
            <a href="http://localhost:8087/cs/adminFaq">자주묻는질문</a>
        </div>
        <div class="menu-item">
            <a href="http://localhost:8087/cs/adminOneOnOne" style="color: rgb(255, 88, 93);">1:1문의</a>
        </div>
    </div>

    <!-- search area -->
    <div class="search-area">
        <form class="search-form" id='searchForm' action="/cs/adminPsnlQues" method="get">
            <select class="search-select" name='type'>
                <option value="NE"
                        <c:out value="${pageMaker.cri.type eq 'NE'?'selected':''}"/>>전체
                </option>
                <option value="N"
                        <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>구매
                </option>
                <option value="E"
                        <c:out value="${pageMaker.cri.type eq 'E'?'selected':''}"/>>판매
                </option>
            </select>

            <div class="search-input-area">
                <input type="text" class="search-input" name="keyword"
                       value='<c:out value="${pageMaker.cri.keyword}"/>'>
                <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
                <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </form>
    </div>
    <!-- search area end -->


    <!--accordionMenu-->
    <div class="accordionMenu">

        <c:forEach items="${list}" var="qna" varStatus="status">
            <!-- 1st menu-->
            <input type="checkbox" name="trg1" id="acc<c:out value="${status.index+1}"/>">
            <label for="acc<c:out value="${status.index+1}"/>">
                <span class="qna-q">Q. </span><c:out value="${qna.csCateCode == '001' ? '[구매]':'[판매]'}"/> <c:out
                    value="${qna.title}"/>
                <button id="<c:out value='${qna.id}'/>" class="btn-no btn-erase">
                    <i class="fas fa-minus"></i></button>
                <button class="btn-no btn-modify" id="<c:out value='${qna.id}'/>" onclick="">수정</button>
            </label>
            <div class="content">
                <div class="inner">
                    <p><span class="qna-a">A. </span> <c:out value="${qna.cntnt}"/></p>
                </div>

            </div>
        </c:forEach>
    </div>
    <!-- end accordionMenu-->

    <div id="notion-write">

        <button class="btn btn-active">글쓰기</button>

        <!-- pagenation-->
        <div class="pagination">
            <c:if test="${pageMaker.prev}">
                <li class="paginate_button previous"><a href="${pageMaker.startPage -1}"><</a></li>

            </c:if>

            <c:forEach var="num" begin="${pageMaker.startPage}"
                       end="${pageMaker.endPage}">
                <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}">
                    <a href="${num}">${num}</a></li>
            </c:forEach>

            <c:if test="${pageMaker.next}">
                <li class="paginate_button next"><a href="${pageMaker.endPage + 1}">&gt;</a></li>
            </c:if>

        </div>
        <!-- end pagenation-->

        <form ID='actionForm' action="/cs/adminPsmlQues" method="get">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
            <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
        </form>

    </div>

</div>
<!--end main-->



<script type="text/javascript">

    //검색
    var searchForm = $("#searchForm");

    $(".search-button").on("click", function (e) {

        if (!searchForm.find("input[name='keyword']").val()) {
            alert("키워드를 입력하세요");
            return false;
        }

        searchForm.find("input[name='pageNum']").val("1");
        e.preventDefault();

        searchForm.submit();

    });


    $(document).ready(function () {

        //page번호 클릭했을때 처
        var actionForm = $("#actionForm");

        $(".paginate_button a").on("click", function (e) {

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });


    });

</script>




<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"></jsp:include>