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
    <link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/adminLayout.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/cs/admin_notice_detail.css" type="text/css">


            <h2>고객센터</h2>
            <div id="submenu">
                <div class="menu-item">
                    <a href="/admin/adminNotice" style="color: rgb(255, 88, 93);">공지사항</a>
                </div>
                <div class="menu-item">
                    <a href="/admin/adminFaq">자주묻는질문</a>
                </div>
                <div class="menu-item">
                    <a href="/admin/adminPsnlQust">1:1문의</a>
                </div>
            </div>


            <!-- search area -->

            <div class="search-area">
                <form class="search-form" id='searchForm' action="/admin/adminNotice" method="get">
                    <select class="search-select" name='type'>
                        <option value="NE"
                                <c:out value="${pageMaker.cri.type eq 'NE'?'selected':''}"/>>전체
                        </option>
                        <option value="N"
                                <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>공지
                        </option>
                        <option value="E"
                                <c:out value="${pageMaker.cri.type eq 'E'?'selected':''}"/>>이벤트
                        </option>
                    </select>

                    <div class="search-input-area">
                        <input type="text" class="search-input" name="keyword"
                               value='<c:out value="${pageMaker.cri.keyword}"/>'/>
                        <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
                        <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'/>
                        <button type="submit" class="search-button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>

            <!-- search area end -->


            <!--accordionMenu-->
            <div class="accordionMenu">

                <c:forEach items="${list}" var="notice" varStatus="status">
                    <!-- 1st menu-->
                    <input type="checkbox" name="trg1" id="acc<c:out value="${status.index+1}"/>">
                    <label for="acc<c:out value="${status.index+1}"/>"><c:out
                            value="${notice.csCateCode == '003' ? '[공지]':'[이벤트]'}"/> <c:out value="${notice.title}"/>
                        <span class="no-date"><fmt:formatDate value="${notice.startDt}" pattern="yyyy-MM-dd"/></span>
                        <button id="<c:out value='${notice.id}'/>" class="btn-no btn-erase">
                            <i class="fas fa-minus"></i></button>
                        <button class="btn-no btn-modify" id="<c:out value='${notice.id}'/>" onclick="">수정</button>
                    </label>
                    <div class="content">
                        <div class="inner">
                            <p><c:out value="${notice.cntnt}"/></p>
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

            </div>

            <form ID='actionForm' action="/admin/adminNotice" method="get">
                <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
            </form>


        </div>
        <!--end main-->




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

                </div>
                <div class="modal-footer">
                    <button class="btn btn-cancel" id="closeModalBtn">CANCEL</button>
                    <button class="btn btn-register" id="btn-delete">OK</button>
                </div>
            </div>
            <!--/.modal-content -->
        </form>
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->


<!-- Modify Modal -->
<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="modal-content">
                <div class="modal-header">
                    <p class="search-selected" id="modifyModalLabel"></p>
                    <input class="modify-id" type="hidden" name="id" value=''>
                    <input type="checkbox" class="modify-fixed" name="isFixed" checked="checked" value=''>상위 고정
                    <input class="modify-end-dt" type="date" name="endDt" placeholder="endDt" value=''>
                    <textarea class="modify-title" name="title"></textarea>

                </div>
                <div class="modal-body">

                    <textarea class="modify-content" name="cntnt"></textarea>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-cancel" id="closeModifyModalBtn">CANCEL</button>
                    <button class="btn btn-register" id="btn-modify">OK</button>
                </div>
            </div>
            <!--/.modal-content -->
        </form>
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->


<!-- register Modal -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="modal-content">
                <div class="modal-header">

                    <div class="modal-search-area">
                        <select class="modal-search-select" name="csCateCode">
                            <option value="003">공지</option>
                            <option value="004">이벤트</option>
                        </select>
                        <input type="checkbox" class="register-fixed" name="isFixed" checked="checked" value=''>상위 고정
                        <input class="register-end-dt" type="date" name="endDt" placeholder="endDt" value=''>
                    </div>
                    <input class="register-user-id" type="hidden" name="userId" value=''>
                    <textarea class="register-title" name="title"></textarea>
                </div>
                <div class="modal-body">
                    <textarea class="register-content" name="cntnt"></textarea>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-cancel" id="closeRegisterModalBtn">CANCEL</button>
                    <button class="btn btn-register" id="btn-register">OK</button>
                </div>
            </div>
            <!--/.modal-content -->
        </form>
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->


<script type="text/javascript">


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


        document.getElementById("adminCs").className = 'active';


        //page번호 클릭했을때 처
        var actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });


    });


    //delete
    $(".btn-erase").on("click", function () {


        var formObj = $("form");
        console.log(this.id);

        let notice = '';

        $.ajax({
            type: 'get',
            url: '/admin/notice?id=' + this.id,
            async: false,
            success: function (result) {
                notice = result;
                console.log(notice);
            },
            error: function () {

            }
        });


        // 모달창 안에 Notice 객체 값으로 채우기.
        $(".del-id").val(notice.id);

        if (notice.csCateCode == "3") {

            $(".search-selected").html("[공지]");

        } else {

            $(".search-selected").html("[이벤트]");
        }

        $(".del-id").html(notice.id);

        $(".de-title").html(notice.title);


        $("#deleteModal").modal("show");

        $("#btn-delete").on("click", function (e) {

            formObj.attr("action", "/admin/adminNotice/remove");
            formObj.submit();


        });


        $("#closeModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.

            e.preventDefault();
            $("#deleteModal").modal("hide");
        });

    }); //end btn-erase


    //modify
    $(".btn-modify").on("click", function () {

        var modifyForm = $("form");
        console.log(this.id);
        let date;

        let notice = '';

        $.ajax({
            type: 'get',
            url: '/admin/notice?id=' + this.id,
            async: false,
            success: function (result) {
                notice = result;
                console.log(notice);
            },
            error: function () {

            }
        });


        // 모달창 안에 Notice 객체 값으로 채우기.

        $(".modify-id").val(notice.id);

        $(".modify-fixed").val(notice.isFixed);

        date = new Date(notice.endDt);

        $(".modify-end-dt").val(
            date.getFullYear()+
            "-"+("0" + (date.getMonth() + 1)).slice(-2)+
            "-"+("0" + date.getDate()).slice(-2));



        if (notice.csCateCode == "003") {

            $(".search-selected").html("[공지]");

        } else {

            $(".search-selected").html("[이벤트]");
        }

        $(".modify-title").html(notice.title);

        $(".modify-content").html(notice.cntnt);

        $("#modifyModal").modal("show");


        $('#btn-modify').on("click", function () {

                modifyForm.attr("action", "/admin/adminNotice/modify");
                modifyForm.submit();

        });

        $("#closeModifyModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.

            e.preventDefault();
            $("#modifyModal").modal("hide");
        });

    });


    //register
    $(".btn-active").on("click", function () {

        registerForm = $("form");

        let userId = "<c:out value="${userId}"/>";

        $("#registerModal").modal("show");

        //register 값 채우기
        if ($('input:checkbox[name="isFixed"]').is(":checked") == true) {

            $(".register-fixed").val('1');

        } else {

            $(".register-fixed").val('0');

        }

        $(".register-user-id").val(userId);



        $("#btn-register").on("click", function () {

            if($(".register-end-dt").val() == ''){
                alert("날짜를 입력해주세요");
                return false;
            }else {
                registerForm.attr("action", "/admin/adminNotice/register");
                registerForm.submit();
            }
        });

        $("#closeRegisterModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.

            e.preventDefault();
            $("#registerModal").modal("hide");
        });
    });


</script>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"></jsp:include>