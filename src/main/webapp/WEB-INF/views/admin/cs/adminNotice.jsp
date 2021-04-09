<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <title></title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/stat/admin_layout.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">

    <link rel="stylesheet" href="/resources/css/admin/cs/admin_notice_detail.css" type="text/css">

</head>
<body>

<div id="container">
    <!-- header-->
    <div class="header">
        <div class="top_menu">
            <span><a href="#" class="login-panel">로그인</a></span>
            <span class="header_divider">|</span>
            <span><a href="#" class="login-panel">회원가입</a></span>
            <span class="header_divider">|</span>
            <span><a href="http://localhost:8087/adminNotice" class="login-panel">고객센터</a></span>
        </div>
        <div class="main-logo">
            <div class="home-logo"><img src="/resources/img/logo.png" width="230px" height="100px"></div>
        </div>
    </div>
    <!-- end header-->


    <div id="content">

        <!-- sidebar -->
        <div id="sidebar">
            <div id="admin-menu">
                <h2>회원관리</h2>
                <h2>상품관리</h2>
                <h2>배너관리</h2>
                <h2>판매요청관리</h2>
                <h2>거래내역관리</h2>
                <h2>포인트관리</h2>
                <h2>고객센터</h2>
                <h2>통계분석</h2>
            </div>
            <div id="admin-memo">
                <span class="span">Memo</span>
                <textarea id="memo">2021-03-25 관리자 메모내용</textarea>
            </div>
        </div>

        <!-- list-->
        <div id="main">
            <h2>고객센터</h2>
            <div id="menu">
                <div>
                    <a href="http://localhost:8087/adminNotice" style="color: rgb(255, 88, 93);">공지사항</a>
                </div>
                <div>
                    <a href="http://localhost:8087/adminFaq">자주묻는질문</a>
                </div>
                <div>
                    <a href="http://localhost:8087/adminOneOnOne">1:1문의</a>
                </div>
            </div>




            <!-- search area -->
            <div class="search-area">
                <select class="search-select">
                    <option>전체</option>
                    <option>공지</option>
                    <option>이벤트</option>
                </select>
                <form class="search-form">
                    <div>
                        <input type="text" class="search-input"/>

                        <button type="submit" class="search-button" onclick="">
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
                    <label for="acc<c:out value="${status.index+1}"/>"><c:out value="${notice.title}"/>
                        <span class="no-date"><c:out value="${notice.startDt}"/></span>
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
                        <li class="paginate_button previous"><a href="${pageMaker.startPage -1}"><</a></li>

                    </c:if>

                    <c:forEach var="num" begin="${pageMaker.startPage}"
                        end="${pageMaker.endPage}">
                        <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""} "><a href="${num}">${num}</a></li>
                    </c:forEach>

                    <c:if test="${pageMaker.next}">
                        <li class="paginate_button next"><a href="${pageMaker.endPage + 1}">&gt;</a></li>
                    </c:if>

                </div>
                <!-- end pagenation-->

            </div>

            <form ID='actionForm' action="/cs/adminNotice" method="get">
                <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                <input type="hidden" name="amount" value="${pageMaker.cri.amount}">

                <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
            </form>





        </div>
        <!--end jb-content-->

    </div>
    <!-- end content-->

</div>
<!-- end jb-container-->

<!-- delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <p class="delete-question" id="ModalLabel">정말 삭제하시겠습니까?</p>
            </div>
            <div class="modal-body">
                <span class="search-selected"></span>
                <span class="de-title"></span>

            </div>
            <div class="modal-footer">
                <button class="btn btn-cancel" id="closeModalBtn">CANCEL</button>
                <button class="btn btn-register">OK</button>
            </div>
        </div>
        <!--/.modal-content -->
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->

<!-- Modify Modal -->
<div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <p class="search-selected" id="modifyModalLabel"></p>
                <p class="modify-title"></p>

            </div>
            <div class="modal-body">

                <span class="modify-content"></span>

            </div>
            <div class="modal-footer">
                <button class="btn btn-cancel" id="closeModifyModalBtn">CANCEL</button>
                <button class="btn btn-register">OK</button>
            </div>
        </div>
        <!--/.modal-content -->
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->


<!-- register Modal -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="search-area">
                    <select class="search-select">
                        <option>전체</option>
                        <option>공지</option>
                        <option>이벤트</option>
                    </select>
                </div>
                <p class="modify-title"></p>
            </div>
            <div class="modal-body">
                <p class="modify-content"></p>

            </div>
            <div class="modal-footer">
                <button class="btn btn-cancel" id="closeRegisterModalBtn">CANCEL</button>
                <button class="btn btn-register">OK</button>
            </div>
        </div>
        <!--/.modal-content -->
    </div>
    <!--/.modal-dialog -->
</div>
<!-- end Modal -->



<script type="text/javascript">

    $(document).ready(function () {

        var actionForm = $("#actionForm");

        $(".paginate_button a").on("click", function (e){

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

    });



    //delete
    $(".btn-erase").on("click", function () {

        console.log(this.id);

        let notice = '';

        $.ajax({
            type: 'get',
            url: '/cs/notice?id=' + this.id,
            async: false,
            success: function (result) {
                notice = result;
            },
            error: function () {

            }
        });

        // 모달창 안에 Notice 객체 값으로 채우기.
        if (notice.csCateCode == "3") {

            $(".search-selected").html("[공지]");

        } else {

            $(".search-selected").html("[이벤트]");
        }

        $(".de-title").html(notice.title);

        $("#deleteModal").modal("show");

        $("#closeModalBtn").on('click', function () {    //삭제 취소 눌렀을 떄 모달창 닫기.
            $("#deleteModal").modal("hide");
        })

    }); //end btn-erase


    //modify
    $(".btn-modify").on("click", function (){

        console.log(this.id);

        let notice = '';

        $.ajax({
            type: 'get',
            url: '/cs/notice?id=' + this.id,
            async: false,
            success: function (result) {
                notice = result;
            },
            error: function () {

            }
        });

        // 모달창 안에 Notice 객체 값으로 채우기.
        if (notice.csCateCode == "3") {

            $(".search-selected").html("[공지]");

        } else {

            $(".search-selected").html("[이벤트]");
        }

        $(".modify-title").html(notice.title);

        $(".modify-content").html(notice.cntnt);

        $("#modifyModal").modal("show");

        $("#closeModifyModalBtn").on('click', function () {    //삭제 취소 눌렀을 떄 모달창 닫기.
            $("#modifyModal").modal("hide");
        });

    });


    //register
    $(".btn-active").on("click",function (){

        $("#registerModal").modal("show");

        $("#closeRegisterModalBtn").on('click', function () {    //삭제 취소 눌렀을 떄 모달창 닫기.
            $("#registerModal").modal("hide");
        });
    });


</script>