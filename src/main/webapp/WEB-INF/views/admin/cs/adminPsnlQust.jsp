<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"></jsp:include>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="/resources/css/admin/adminLayout.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_faq.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_psnl_qust.css" type="text/css">


    <h2>고객센터</h2>
    <div id="submenu">
        <div class="menu-item">
            <a href="/admin/adminNotice">공지사항</a>
        </div>
        <div class="menu-item">
            <a href="/admin/adminFaq">자주묻는질문</a>
        </div>
        <div class="menu-item">
            <a href="/admin/adminPsnlQust" style="color: rgb(255, 88, 93);">1:1문의</a>
        </div>
    </div>

    <!-- search area -->
    <div class="search-area">
        <form class="search-form" id='searchForm' action="/admin/adminPsnlQust" method="get">
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
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <input type="checkbox" class="list-id" name="trg1" id="<c:out value="${status.index+1}"/>">
                <label for="<c:out value="${status.index+1}"/>">
                    <span class="qna-q">Q. </span><c:out value="${qna.csCateCode == '001' ? '[구매]':'[판매]'}"/> <c:out
                        value="${qna.title}"/>
                    <button class="btn-no btn-erase" id="<c:out value='${qna.id}'/>">
                        <i class="fas fa-minus"></i></button>
                    <button class="btn-no btn-modify <c:out value="${qna.stusCode == '001' ? 'finish':'wait'}"/>"
                            id="<c:out value='${qna.id}'/>">
                        <c:out value="${qna.stusCode == '001' ? '답변완료':'답변대기'}"/>
                    </button>
                </label>
                <div class="content">
                    <div class="inner">
                        <p class="qna-a">Q. </p>
                        <p><c:out value="${qna.cntnt}"/></p>
                    </div>
                    <div class="admin-inner">
                        <p class="qna-a">A. </p>
                        <p class="ans-cntnt" name="ansCntnt" id="ans<c:out value="${status.index+1}"/>">
                            <c:out value="${qna.ansCntnt}"/>
                        </p>


                    </div>
                </div>
        </c:forEach>
    </div>
    <!-- end accordionMenu-->

    <div id="notion-write">

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

        <form ID='actionForm' action="/admin/adminPsnlQust" method="get">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
            <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
            <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
        </form>

    </div>

</div>
<!--end main-->


<!-- ans Modal -->
<div class="modal fade" id="ansModal" tabindex="-1" role="dialog" aria-labelledby="ansModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="modal-content">
                <div class="modal-header">
                    <h2>답변</h2>
                    <input class="ans-id" type="hidden" name="id" value="">
                    <input class="ans-admin-id" type="hidden" name="adminId" value="">
                    <input class="ans-stus-code" type="hidden" name="stusCode" value="">

                </div>
                <div class="modal-body">

                    <textarea class="ans-content" name="ansCntnt"></textarea>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-register" id="btn-modify">OK</button>
                    <button class="btn btn-cancel" id="closeModifyModalBtn">CANCEL</button>
                </div>
            </div>
            <!--/.modal-content -->
        </form>
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->



<!-- delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="modal-content">
                <div class="modal-header">
                    <input class="del-id" type="hidden" name="id" value=''>
                    <p class="delete-question" id="ModalLabel">정말 삭제하시겠습니까?</p>
                </div>
                <div class="modal-body">
                    <span class="search-selected"></span>
                    <span class="de-title"></span>
                    <p class="de-cntnt"></p>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-register" id="btn-delete">OK</button>
                    <button class="btn btn-cancel" id="closeModalBtn">CANCEL</button>
                </div>
            </div>
            <!--/.modal-content -->
        </form>
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->





<script type="text/javascript">

    let userId = "<c:out value="${userId}"/>";


    //검색
    var searchForm = $("#searchForm");

    $(".search-button").on("click", function (e) {

        searchForm.find("input[name='pageNum']").val("1");
        e.preventDefault();

        searchForm.submit();

    });


    $(document).ready(function () {


        document.getElementById("adminCs").className = 'active';

        //pagenation
        var actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });


            $(".finish").css({
                "background-color" : "rgb(71, 71, 71)",
                "color" : "white"
            });




    });


    //ans modal
    $(".btn-modify").on("click", function () {


        var ansForm = $("form");

        console.log(this.id);

        let psnl = '';

        $.ajax({
            type: 'get',
            url: '/admin/psnl?id=' + this.id,
            async: false,
            success: function (result) {
                psnl = result;
                console.log("ajax result:" + result);
                console.log(psnl);
            },
            error: function () {

            }
        });


        // 모달창 안에 psnl 객체 값으로 채우기.

        console.log("psnl.id : " + psnl.id);
        $(".ans-id").val(psnl.id);

        $("#ansModal").fadeIn();


        $('#btn-modify').on("click", function () {


            $(".ans-admin-id").val(userId);
            $(".ans-stus-code").val("001");
            console.log("userId : " + userId);
            ansForm.attr("action", "/admin/adminPsnlQust/modify");
            ansForm.submit();
        });

        $("#closeModifyModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.

            e.preventDefault();
            $("#ansModal").fadeOut();
        });

    }); //end ans


    //delete
    $(".btn-erase").on("click", function () {


        var formObj = $("form");
        console.log(this.id);

        let psnl = '';

        $.ajax({
            type: 'get',
            url: '/admin/psnl?id=' + this.id,
            async: false,
            success: function (result) {
                psnl = result;
                console.log(psnl);
            },
            error: function () {

            }
        });


        // 모달창 안에 Notice 객체 값으로 채우기.
        $(".del-id").val(psnl.id);

        if (psnl.csCateCode == "001") {

            $(".search-selected").html("[구매]");

        } else {

            $(".search-selected").html("[판매]");
        }

        $(".del-id").html(psnl.id);

        $(".de-title").html(psnl.title);

        $(".de-cntnt").html(psnl.cntnt);

        $("#deleteModal").fadeIn();

        $("#btn-delete").on("click", function (e) {

            formObj.attr("action", "/admin/adminPsnlQust/remove");
            formObj.submit();


        });


        $("#closeModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.

            e.preventDefault();
            $("#deleteModal").fadeOut();
        });

    }); //end delete




</script>


<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"></jsp:include>