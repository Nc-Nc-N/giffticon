<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="csTemplete.jsp"/>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_faq.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_psnl_qust.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/notice_board.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/faq_board.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/common/modal.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/psnl_qust_board.css" type="text/css">

<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>

<h3>1:1문의</h3>
<div class="line-117"></div>

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
        <label class="contentList" name="<c:out value="${status.index}"/>" for="acc<c:out value="${status.index+1}"/>">
            <span class="qna-q">Q. </span><c:out value="${qna.csCateCode == '001' ? '[구매]':'[판매]'}"/>
            <c:out value="${qna.title}"/>
            <button id="<c:out value='${qna.id}'/>" class="btn-no btn-erase">
                <i class="fas fa-minus"></i></button>
            <button class="btn-no btn-modify <c:out value="${qna.stusCode == '001' ? 'finish':'wait'}"/>"
                    id="<c:out value='${qna.id}'/>">
                <c:out value="${qna.stusCode == '001' ? '답변완료':'답변대기'}"/>
            </button>

            <c:if test="${qna.stusCode == '000'}">
                <button class="btn-ans-modify modify" id="<c:out value='${qna.id}'/>">수정</button>
            </c:if>
        </label>

        <div class="content" name="content_<c:out value="${status.index}"/>">
            <div class="inner userQstInner">
                <div class="qna-q">문의내용</div>
                <div class="ans-cntnt" name="cntnt"><c:out value="${qna.cntnt}"/></div>
                <div>
                    <c:if test="${qna.atchFilePath != ''}">
                        <button class="btn img_show" value="<c:out value="${qna.atchFilePath}"/>">첨부파일</button>
                    </c:if>
                </div>
            </div>
            <c:if test="${qna.ansCntnt ne null}">
                <div class="admin-inner">
                    <div class="qna-a">답변내용</div>
                    <div class="ans-cntnt"><c:out value="${qna.ansCntnt}"/></div>
                </div>
            </c:if>
        </div>
    </c:forEach>
    <c:if test="${list.size() == 0}">
        <div class="noSearchResult">검색 결과가 없습니다.</div>
    </c:if>
</div>
<!-- end accordionMenu-->

<div class="space50"></div>

<div id="notion-write">
    <%--1:1 문의 register btn--%>
    <button class="btn btn-active" id="reg-psnQust">1:1문의</button>

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

    <form id='actionForm' action="/user/mypage/psnlQustBoard" method="get">
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

<div class="modal modify-modal" id="deleteModal">
    <div class="detail-modal">
        <div class="modal-title">삭제하시겠습니까?</div>
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input class="del-id" type="hidden" name="id" value=''>
            <table id="delete-td">
                <tr class="under-line">
                    <td class="td-title">제목</td>
                    <td colspan="5">
                        <div class="td-cntnt text-input"><input type="text" name="title" readonly/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td-title">문의내용</td>
                    <td colspan="5">
                        <div class="td-cntnt psnl-content text-input">
                            <textarea name="cntnt" readonly></textarea>
                        </div>
                    </td>
                </tr>
            </table>
            <div class="detail-btn-area">
                <button class="btn btn-active psnl-delete" id="btn-delete">확인</button>
                <button class="btn btn-disabled cancel">취소</button>
            </div>
        </form>
    </div>
</div>

<div class="modal modify-modal" id="modifyModal">
    <div class="detail-modal">
        <div class="modal-title">1:1문의 수정</div>
        <form role="form" action="" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input class="modify-id" type="hidden" name="id" value=''>
            <table id="modify-td">
                <tr class="under-line">
                    <td class="td-title">제목</td>
                    <td colspan="5">
                        <div class="td-cntnt text-input"><input type="text" name="title" placeholder="제목을 입력해주세요."/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td-title">문의내용</td>
                    <td colspan="5">
                        <div class="td-cntnt psnl-content text-input">
                            <textarea name="cntnt" placeholder="상품 설명을 입력해주세요."></textarea>
                        </div>
                    </td>
                </tr>
            </table>
            <div class="detail-btn-area">
                <button class="btn btn-active psnl-modify">등록</button>
                <button class="btn btn-disabled cancel">취소</button>
            </div>
        </form>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>

<script type="text/javascript" src="/resources/js/etc/screenHeight.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(".contentList").on("click", function () {
            let listNum = "content_" + $(this).attr("name");
            let divDisplay = $("div[name=" + listNum + "]").css("display");

            if (divDisplay == "none") {
                $("div[name=" + listNum + "]").css("display", "block");
            } else {
                $("div[name=" + listNum + "]").css("display", "none");
            }

            calculateContentLength();
        })

        $("#psnlQ-link").attr("class", "menu active");

        //사용자 1:1문의 오류 메시지를 controller에서 보내줌.
        let error = "${error}";

        // error 발생 시 해당 에러 메시지를 alert
        if (error.length > 0) {
            alert("에러 발생. 담당자에게 문의해주세요. \n" + error);
        }

        //pagination
        var actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });
    });

    //1:1문의 register 이동
    $("#reg-psnQust").on("click", function () {
        self.location = "/user/mypage/psnlQustBoard/register";
    });

    //modify modal
    $(".modify").on("click", function () {
        let modifyForm = $("form");
        let psnl = '';

        //list id를 함께 보내서 해당 list의 CsPsnlQustVO를 가져옴.
        //list의 id는 status.index+1
        $.ajax({
            type: 'get',
            url: '/psnl?id=' + this.id,
            async: false,
            success: function (result) {
                psnl = result;
            }
        });

        // 모달창 안에 psnl 객체 값으로 채우기.
        $(".modify-id").val(psnl.id);
        if (psnl.csCateCode === "001") {
            $(".search-selected").html("[구매]");
        } else {
            $(".search-selected").html("[판매]");
        }

        $("input[name='title']").val(psnl.title);
        $(".psnl-content textarea").html(psnl.cntnt);

        $(".modify-modal").css("visibility", "visible");     //모달창 열기.

        $('.psnl-modify').on("click", function () {  //확인 버튼 클릭 시
            modifyForm.attr("action", "/user/mypage/psnlQustBoard/modify");
            modifyForm.submit();
        });

        $(".cancel").on('click', function (e) {    //취소 눌렀을 떄 모달창 닫기.
            e.preventDefault();
            $(".modify-modal").css("visibility", "hidden");     //모달창 열기.
        });
    }); //end ans

    //delete
    $(".btn-erase").on("click", function () {
        let formObj = $("form");
        let psnl = '';

        //list id를 함께 보내서 해당 list의 CsPsnlQustVO를 가져옴.
        $.ajax({
            type: 'get',
            url: '/psnl?id=' + this.id,
            async: false,
            success: function (result) {
                psnl = result;
            }
        });

        // 모달창 안에 Notice 객체 값으로 채우기.
        $(".del-id").val(psnl.id);

        if (psnl.csCateCode === "001") {
            $(".search-selected").html("[구매]");
        } else {
            $(".search-selected").html("[판매]");
        }

        $(".del-id").html(psnl.id);
        $("input[name='title']").val(psnl.title);
        $(".psnl-content textarea").html(psnl.cntnt);

        $("#deleteModal").css("visibility", "visible");

        $("#btn-delete").on("click", function (e) {     //확인 버튼 클릭 시
            formObj.attr("action", "/user/mypage/psnlQustBoard/remove");
            formObj.submit();
        });

        $(".cancel").on('click', function (e) {    //취소 눌렀을 떄 모달창 닫기.
            e.preventDefault();
            $("#deleteModal").css("visibility", "hidden");
        });
    }); //end delete
</script>
<script>
    $(document).ready(function () {
        $(".img_show").on("click", function () {
            let imgPath = $(this).val();

            window.open($(this).val(), "gifticon img", "width=700, height=900");
        });
    });
</script>