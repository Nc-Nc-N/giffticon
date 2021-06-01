<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"></jsp:include>

    <link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/cs/modified/admin_notice.css" type="text/css">

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
            <div class="accordionMenu">
                <c:forEach items="${list}" var="notice" varStatus="status">
                    <!-- 1st menu-->
                    <input type="checkbox" name="trg1" id="acc<c:out value="${status.index+1}"/>">
                    <label class="contentList" name="<c:out value="${status.index}"/>"
                           for="acc<c:out value="${status.index+1}"/>"><c:out
                            value="${notice.csCateCode == '003' ? '[공지]':'[이벤트]'}"/> <c:out value="${notice.title}"/>
                        <span class="no-date"><fmt:formatDate value="${notice.startDt}" pattern="yyyy-MM-dd"/></span>
                        <button id="<c:out value='${notice.id}'/>" class="btn-no btn-erase">
                            <i class="fas fa-minus"></i></button>
                        <button class="btn-no modify" id="<c:out value='${notice.id}'/>" onclick="">수정</button>
                    </label>
                    <div class="content" name="content_<c:out value="${status.index}"/>">
                        <div class="inner">
                            <div><c:out value="${notice.cntnt}"/></div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${list.size() == 0}">
                    <div class="noSearchResult">검색 결과가 없습니다.</div>
                </c:if>
            </div>

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
            <div class="modal-content" id="delete-content">
                <div class="modal-header" id="delete-header">
                    <input class="del-id" type="hidden" name="id" value=''>
                    <p class="delete-question" id="ModalLabel">정말 삭제하시겠습니까?</p>
                </div>
                <div class="modal-body" id="delete-body">
                    <span class="search-selected"></span>
                    <span class="de-title"></span>

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


<!-- Modify Modal -->
<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="modal-content" id="modify-content">
                <div class="modal-header" id="modify-header">
                    <p class="search-selected" id="modifyModalLabel"></p>
                    <input class="modify-id" type="hidden" name="id" value=''>
                    <input type="checkbox" class="modify-fixed" name="isFixed" checked="checked" value=''>상위 고정
                    <input class="modify-end-dt" type="text" name="endDt" value=''>
                    <textarea class="modify-title" name="title"></textarea>

                </div>
                <div class="modal-body" id="modify-body">

                    <textarea class="modify-content" name="cntnt"></textarea>

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

<!-- register Modal -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="modal-content" id="register-content">
                <div class="modal-header" id="register-header">

                    <div class="modal-search-area">
                        <select class="modal-search-select" name="csCateCode">
                            <option value="003">공지</option>
                            <option value="004">이벤트</option>
                        </select><br>
                        <input type="checkbox" class="register-fixed" name="isFixed" checked="checked" value=''>상위 고정
                        <input class="register-end-dt" type="text" name="endDt" placeholder="종료날짜" value=''>
                    </div>
                    <input class="register-user-id" type="hidden" name="userId" value=''>
                    <textarea class="register-title" placeholder="제목" name="title"></textarea>
                </div>
                <div class="modal-body" id="register-body">
                    <textarea class="register-content" placeholder="내용" name="cntnt"></textarea>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-register" id="btn-register">OK</button>
                    <button class="btn btn-cancel" id="closeRegisterModalBtn">CANCEL</button>
                </div>
            </div>
            <!--/.modal-content -->
        </form>
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->

<script>
    $(document).ready(function () {;

        $(".contentList").on("click", function () {
            let listNum = "content_" + $(this).attr("name");
            let divDisplay = $("div[name=" + listNum + "]").css("display");

            if (divDisplay == "none") {
                $("div[name=" + listNum + "]").css("display", "block");
            } else {
                $("div[name=" + listNum + "]").css("display", "none");
            }

            // calculateContentLength();
        });
    });
</script>

<script type="text/javascript">
    //검색
    var searchForm = $("#searchForm");

    $(".search-button").on("click", function (e) {
        searchForm.find("input[name='pageNum']").val("1");
        e.preventDefault();

        searchForm.submit();
    });

    $(document).ready(function () {
        //관리자 공지사항 오류 메시지를 controller에서 보내줌.
        let error = "${error}";

        // error 발생 시 해당 에러 메시지를 alert
        if (error.length > 0) {
            alert("에러 발생. 담당자에게 문의해주세요. \n" + error);
        }

        document.getElementById("adminCs").className = 'active';

        //page번호 클릭 시
        var actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });
    });

    //delete
    $(".btn-erase").on("click", function (e) {
        e.stopPropagation();

        var formObj = $("form");
        let notice = '';

        $.ajax({
            type: 'get',
            url: '/admin/notice?id=' + this.id,
            async: false,
            success: function (result) {
                notice = result;
            }
        });

        // 모달창 안에 Notice 객체 값으로 채우기.
        $(".del-id").val(notice.id);

        if (notice.csCateCode == "003") {
            $(".search-selected").html("[공지]");
        } else {
            $(".search-selected").html("[이벤트]");
        }

        $(".del-id").html(notice.id);
        $(".de-title").html(notice.title);

        $("#deleteModal").fadeIn();

        $("#btn-delete").on("click", function (e) {
            formObj.attr("action", "/admin/adminNotice/remove");
            formObj.submit();
        });

        $("#closeModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.
            e.preventDefault();
            $("#deleteModal").fadeOut();
        });
    }); //end btn-erase

    //modify
    $(".modify").on("click", function (e) {
        e.stopPropagation();

        var modifyForm = $("form");
        let date;

        let notice = '';

        $.ajax({
            type: 'get',
            url: '/admin/notice?id=' + this.id,
            async: false,
            success: function (result) {
                notice = result;
            }
        });

        // 모달창 안에 Notice 객체 값으로 채우기.

        $(".modify-id").val(notice.id);
        $(".modify-fixed").val(notice.isFixed);

        date = new Date(notice.endDt);

        $(".modify-end-dt").datepicker({
            dateFormat: 'yy-mm-dd',
            minDate: 0
        });

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

        $("#modifyModal").fadeIn();

        $('#btn-modify').on("click", function () {
                if ($(".modify-end-dt").val() == ''){
                    alert("종료날짜를 선택해주세요");
                    return false;
                }else if($(".modify-title").val() == ''){
                    alert("제목을 입력해주세요");
                    return false;
                }else if ($(".modify-content").val() == ''){
                    alert("내용을 입력해주세요");
                    return false;
                }else {
                    modifyForm.attr("action", "/admin/adminNotice/modify");
                    modifyForm.submit();
                }
        });

        $("#closeModifyModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.
            e.preventDefault();
            $("#modifyModal").fadeOut();
        });
    });

    //register
    $(".btn-active").on("click", function () {
        registerForm = $("form");

        let userId = "<c:out value="${userId}"/>";

        $("#registerModal").fadeIn();

        $(".register-end-dt").datepicker({
            dateFormat: 'yy-mm-dd',
            minDate: 0
        });

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
            }else if($(".register-title").val() == ''){
                alert("제목을 입력해주세요");
                return false;
            }else if($(".register-content").val() == ''){
                alert("내용을 입력해주세요");
                return false;
            }else {
                registerForm.attr("action", "/admin/adminNotice/register");
                registerForm.submit();
            }
        });

        $("#closeRegisterModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.
            e.preventDefault();

            $("#registerModal").fadeOut();
        });
    });


</script>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"></jsp:include>