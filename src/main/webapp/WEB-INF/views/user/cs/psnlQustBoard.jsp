<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="/WEB-INF/views/common/header.jsp" %>

<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_faq.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_psnl_qust.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/notice_board.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/faq_board.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/psnl_qust_board.css" type="text/css">

<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>

<body>

<div id="container">
    <div class="space"></div>
    <div class="main">

        <div class="menuhead">
        </div>

        <div class="menubody">
            <div class="sidebarspace">
                <div class="menuname">고객센터</div>
                <div class="sidebar">

                    <a href="/user/cs/noticeBoard">
                        <div class="bar">
                            <div>공지사항</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="/user/cs/faqBoard">
                        <div class="bar">
                            <div>자주묻는질문</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="/user/mypage/psnlQustBoard">
                        <div class="bar" style="background-color:rgb(240, 240, 240);">
                            <div style="color: rgb(255, 88, 93); background-color:rgb(240, 240, 240);">1:1문의</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>

                </div>
            </div>
            <div class="emptyspace">

            </div>
            <div class="content">

                <h3>1:1문의</h3>
                <div class="sub-category-area">
                    <button class="sub sub-category-btn-all" value="NE" name="type"
                            onclick="location.href='/user/mypage/psnlQustBoard?pageNum=1&amount=10&type=NE&keyword=';">
                        전체
                    </button>
                    <button class="sub sub-category-btn-notice" value="N" name="type"
                            onclick="location.href='/user/mypage/psnlQustBoard?pageNum=1&amount=10&type=N&keyword=';">구매
                    </button>
                    <button class="sub sub-category-btn-event" value="E" name="type"
                            onclick="location.href='/user/mypage/psnlQustBoard?pageNum=1&amount=10&type=E&keyword=';">판매
                    </button>
                </div>

                <!-- search area end -->

                <!--accordionMenu-->
                <div class="accordionMenu">

                    <c:forEach items="${list}" var="qna" varStatus="status">
                        <!-- 1st menu-->
                        <input type="checkbox" class="list-id" name="trg1" id="acc<c:out value="${status.index+1}"/>">
                        <label for="acc<c:out value="${status.index+1}"/>">
                            <span class="qna-q">Q. </span><c:out value="${qna.csCateCode == '001' ? '[구매]':'[판매]'}"/>
                            <c:out value="${qna.title}"/>
                            <button id="<c:out value='${qna.id}'/>" class="btn-no btn-erase">
                                <i class="fas fa-minus"></i></button>
                            <button class="btn-no btn-modify <c:out value="${qna.stusCode == '001' ? 'finish':'wait'}"/>"
                                    id="<c:out value='${qna.id}'/>">
                                <c:out value="${qna.stusCode == '001' ? '답변완료':'답변대기'}"/>
                            </button>
                            <button class="btn-ans-modify <c:out value="${qna.stusCode == '001' ? 'finish':'wait'}"/>"
                                    id="<c:out value='${qna.id}'/>">수정
                            </button>
                        </label>

                        <div class="content">
                            <div class="inner">
                                <p class="qna-a">Q. </p>
                                <p class="ans-cntnt" name="cntnt"><c:out value="${qna.cntnt}"/></p>
                                <a href="<c:out value="${qna.atchFilePath}"/>" download="<c:out value="${qna.atchFilePath}"/>" class="atch-file" name="atchFilePath">
                                    <c:out value="${qna.atchFilePath}"/></a>

                            </div>
                            <div class="admin-inner">
                                <p class="qna-a">A. </p>
                                <p><c:out value="${qna.ansCntnt}"/></p>


                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${list.size() == 0}">
                        <div class="noSearchResult">검색 결과가 없습니다.</div>
                    </c:if>
                </div>
                <!-- end accordionMenu-->


                <div id="notion-write">

                    <%--1:1 문의 register btn--%>
                    <button class="btn btn-active">1:1문의</button>

                    <!-- pagenation-->
                    <div class="pagination">

                        <c:if test="${pageMaker.prev}">
                            <li>
                                <a class="paginate_button previous" href="${pageMaker.startPage -1}">&lt;</a></li>
                        </c:if>

                        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            <li>
                                <a class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}"
                                   href="${num}">${num}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${pageMaker.next}">
                            <li>
                                <a class="paginate_button next" href="${pageMaker.endPage +1 }">&gt;</a></li>
                        </c:if>
                    </div>
                    <!-- end pagenation-->

                    <form ID='actionForm' action="/user/mypage/psnlQustBoard" method="get">
                        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                        <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                        <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
                    </form>

                </div>

            </div>
        </div>
    </div>
</div>



<!-- Modify Modal -->
<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <div class="modal-content">
                <div class="modal-header">
                    <input class="modify-id" type="hidden" name="id" value=''>
                    <textarea class="modify-title" name="title"></textarea>
                </div>

                <div class="modal-body">
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

    $(document).ready(function () {

        //사용자 1:1문의 오류 메시지를 controller에서 보내줌.
        let error = "${error}";

        // error 발생 시 해당 에러 메시지를 alert
        if (error.length > 0) {
            alert("에러 발생. 담당자에게 문의해주세요. \n" + error);
            console.log(error);
        }

        //pagination
        var actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });


        //답변상태, 수정 css 변경
        $(".finish").css({
            "background-color": "rgb(71, 71, 71)",
            "color": "white"
        });


    });

    //1:1문의 register 이동
    $(".btn-active").on("click", function () {
        console.log("1:1문의");
        self.location = "/user/mypage/psnlQustBoard/register";
    });



    //modify modal
    $(".wait").on("click", function () {


        var modifyForm = $("form");

        console.log("this id:" + this.id);

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
        $(".modify-id").val(psnl.id);

        if (psnl.csCateCode == "001") {

            $(".search-selected").html("[구매]");

        } else {

            $(".search-selected").html("[판매]");
        }

        $(".modify-title").html(psnl.title);

        $(".modify-content").html(psnl.cntnt);


        $("#modifyModal").fadeIn();     //모달창 열기.


        $('#btn-modify').on("click", function () {  //확인 버튼 클릭 시

            modifyForm.attr("action", "/user/mypage/psnlQustBoard/modify");
            modifyForm.submit();
        });

        $("#closeModifyModalBtn").on('click', function (e) {    //취소 눌렀을 떄 모달창 닫기.

            e.preventDefault();
            $("#modifyModal").fadeOut();
        });

    }); //end ans


    //delete
    $(".btn-erase").on("click", function () {


        var formObj = $("form");
        console.log(this.id);

        let psnl = '';

        //list id를 함께 보내서 해당 list의 CsPsnlQustVO를 가져옴.
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

        $("#btn-delete").on("click", function (e) {     //확인 버튼 클릭 시

            formObj.attr("action", "/user/mypage/psnlQustBoard/remove");
            formObj.submit();


        });


        $("#closeModalBtn").on('click', function (e) {    //취소 눌렀을 떄 모달창 닫기.

            e.preventDefault();
            $("#deleteModal").fadeOut();
        });

    }); //end delete




</script>

</body>
</html>