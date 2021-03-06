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
<link rel="stylesheet" href="/resources/css/admin/cs/modified/admin_notice.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/modified/admin_faq.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/modified/admin_psnl_qust.css" type="text/css">


<h1>고객센터</h1>
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
        <label class="contentList" name="<c:out value="${status.index}"/>" for="<c:out value="${status.index+1}"/>">
            <span class="qna-q">Q. </span><c:out value="${qna.csCateCode == '001' ? '[구매]':'[판매]'}"/> <c:out
                value="${qna.title}"/>
            <span class="qna-user-id"><c:out value="${qna.userId}"/></span>
            <button class="btn-no btn-erase" id="<c:out value='${qna.id}'/>">
                <i class="fas fa-minus"></i></button>
            <button class="btn-no btn-modify <c:out value="${qna.stusCode == '001' ? 'finish':'wait'}"/>"
                    id="<c:out value='${qna.id}'/>">
                <c:out value="${qna.stusCode == '001' ? '답변완료':'답변대기'}"/>
            </button>
        </label>
        <div class="content" name="content_<c:out value="${status.index}"/>">

            <div class="inner psnlQinner">
                <div class="qna-a" name="cntnt"><c:out value="${qna.cntnt}"/>&nbsp;&nbsp;
                    <c:if test="${qna.atchFilePath != ''}">
                        <button class="btn img_show" value="<c:out value="${qna.atchFilePath}"/>">첨부파일</button>
                    </c:if>
                </div>
            </div>
            <div class="psnlAinner">
                <div class="qna-a"><c:out value="${qna.ansCntnt}"/></div>
            </div>
        </div>
    </c:forEach>

    <c:if test="${dealList.size() == 0}">
        <div class="noSearchResult">검색 결과가 없습니다.</div>
    </c:if>
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
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="modal-content">
                <div class="modal-header">
                    <input type="text" class="modal-modify-ans" value="" readonly>
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
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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

    //관리자 1:1문의 오류 메시지를 controller에서 보내줌.
    let error = "${error}";

    // error 발생 시 해당 에러 메시지를 alert
    if (error.length > 0) {
        alert("에러 발생. 담당자에게 문의해주세요. \n" + error);
        console.log(error);
    }


    //검색
    var searchForm = $("#searchForm");

    $(".search-button").on("click", function (e) {

        searchForm.find("input[name='pageNum']").val("1");
        e.preventDefault();

        searchForm.submit();

    });


    $(document).ready(function () {

        $(".contentList").on("click", function () {

            let listNum = "content_" + $(this).attr("name");
            let divDisplay = $("div[name=" + listNum + "]").css("display");

            if (divDisplay == "none") {
                $("div[name=" + listNum + "]").css("display", "block");
            } else {
                $("div[name=" + listNum + "]").css("display", "none");
            }

        })

        $(".img_show").on("click", function () {

            let imgPath = $(this).val();

            window.open($(this).val(), "gifticon img", "width=700, height=900");
        });


        document.getElementById("adminCs").className = 'active';

        //pagenation
        var actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });


        //stusCode == 001인 list들의 버튼 색상 변경.
        $(".finish").css({
            "background-color": "rgb(71, 71, 71)",
            "color": "white"
        });


        //파일 다운로드
        //파일경로 문제 --> 차후 수정필요
        $(".atch-file").on("click", function () {

            $.ajax({
                type: 'get',
                url: '/admin/adminPsnlQust/download?fileName=' + $(".atch-file")[0].value,
                async: false,
                success: function (result) {
                    console.log("download:" + result);
                },
                error: function (e) {
                    console.log(e);
                }
            });

        });


    });


    //ans modal
    $(".btn-modify").on("click", function (e) {

        e.stopPropagation();
        var ansForm = $("form");

        console.log("this id: " + this.id);

        let psnl = '';


        //list id를 함께 보내서 해당 list의 CsPsnlQustVO를 가져옴.
        //list의 id는 status.index+1
        $.ajax({
            type: 'get',
            url: '/psnl?id=' + this.id,
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

        $(".ans-content").val(psnl.ansCntnt);

        $("#ansModal").fadeIn();
        $(".modal-modify-ans").val(psnl.title);

        $('#btn-modify').on("click", function () {      //확인 버튼 클릭 시

            console.log("userId : " + userId);

            $(".ans-admin-id").val(userId);
            $(".ans-stus-code").val("001");     //stusCode가 001로 변경되면 list에서 finish class name을 갖게됌.


            ansForm.attr("action", "/admin/adminPsnlQust/modify");
            ansForm.submit();
        });

        $("#closeModifyModalBtn").on('click', function (e) {    //삭제 취소 눌렀을 떄 모달창 닫기.

            e.preventDefault();
            $("#ansModal").fadeOut();
        });

    }); //end ans


    //delete
    $(".btn-erase").on("click", function (e) {

        e.stopPropagation();
        var formObj = $("form");
        console.log(this.id);

        let psnl = '';

        //list id를 함께 보내서 해당 list의 CsPsnlQustVO를 가져옴.
        //list의 id는 status.index+1
        $.ajax({
            type: 'get',
            url: '/psnl?id=' + this.id,
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

        $("#btn-delete").on("click", function (e) {      //확인 버튼 클릭 시

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