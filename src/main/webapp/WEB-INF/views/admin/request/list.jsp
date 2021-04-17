<%--
  Created by IntelliJ IDEA.
  User: lwiii
  Date: 2021-04-13
  Time: 오전 11:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/request/requestList.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/request/requestDetail.css" type="text/css">

<h1>판매요청관리</h1>

<!-- menu -->
<div id="submenu"></div>
<!-- menu end -->

<!-- search area -->
<div class="search-area">
    <form id="search-form">
        <select name="type" class="search-select">
            <option value="ENC" <c:out value="${pageMaker.cri.type eq 'ENC' ? 'selected' : ''}"/>>전체</option>
            <option value="E" <c:out value="${pageMaker.cri.type eq 'E' ? 'selected' : ''}"/>>판매자</option>
            <option value="N" <c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}"/>>상품명</option>
            <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>상품코드</option>
        </select>
        <div class="search-form">
            <div>
                <input type="text" name="keyword" class="search-input"
                       value="<c:out value='${pageMaker.cri.keyword}'/>"/>
                <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
                <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>

                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>
</div>
<!-- search area end -->

<!-- request list -->
<div id="rqust-div">
    <table id="rqust-tb">
        <thead>
        <tr>
            <td class="w15">&nbsp;</td>
            <td class="w125">기프티콘 이미지</td>
            <td class="w45">No.</td>
            <td class="w200">상품</td>
            <td class="w100">바코드 번호</td>
            <td class="w100">유효기간</td>
            <td class="w125">판매자</td>
            <td class="w100">요청일</td>
            <td class="w45">&nbsp;</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="rqust" items="${rqustList}" varStatus="status">
            <tr class="rqust-tr">
                <td><input type="checkbox" name="isRemove"/></td>
                <td>
                    <div class="rqust-img"><img src="<c:out value='${rqust .imgPath}'/>"></div>
                </td>
                <td>
                    <div><c:out value="${rqust.gftId}"/></div>
                </td>
                <td>
                    <div class="ellipsis">
                        <c:out value="${rqust.cateName}"/>&nbsp;&gt;&nbsp;<c:out value="${rqust.brdName}"/> <br>
                        <c:out value="${rqust.prodCode} ${rqust.prodName}"/>
                    </div>
                </td>
                <td>
                    <div><c:out value="${rqust.brcd}"/></div>
                </td>
                <td>
                    <div>&#126;&nbsp;<fmt:formatDate value="${rqust.expirDt}" pattern="yyyy-MM-dd"/></div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${rqust.requester}"/></div>
                </td>
                <td>
                    <div><fmt:formatDate value="${rqust.inDate}" pattern="yyyy-MM-dd"/></div>
                </td>
                <td>
                    <div><a href="${rqust.gftId}" class="detail-link">상세</a></div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
<!-- request list end -->

<c:if test="${empty rqustList}">
    <div class="nothing">판매요청이 없습니다.</div>
</c:if>

<div class="main-footer">
    <button class="btn btn-diabled">선택삭제</button>
    <div class="pagination">
        <c:if test="${pageMaker.prev}">
            <a class="pagination_btn prev">&lt;</a>
        </c:if>
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <a class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}" href="${num}">${num}</a>
        </c:forEach>
        <c:if test="${pageMaker.next}">
            <a class="pagination_btn next">&gt;</a>
        </c:if>
    </div>
</div>

<form id="actionForm" action='/admin/request/list' method="get">
    <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
    <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
    <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
    <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
</form>

</div>
<!-- main content end -->

<div class="modal">
    <!-- detail modal -->
    <div id="detail-modal">
        <h2>판매요청상세</h2>

        <table id="rq-td">
            <tr class="under-line">
                <td class="td-title">
                    <div>요청번호</div>
                </td>
                <td colspan="5" class="w90">
                    <div class="td-cntnt gftId"></div>
                </td>
            </tr>
            <tr class="under-line">
                <td class="td-title">
                    <div>상품분류</div>
                </td>
                <td colspan="5" class="w90">
                    <div class="td-cntnt cate"></div>
                </td>
            </tr>
            <tr class="under-line">
                <td class="td-title">
                    <div>상품명</div>
                </td>
                <td colspan="5">
                    <div class="td-cntnt prodName"></div>
                </td>
            </tr>
            <tr class="under-line">
                <td class="td-title">
                    <div>판매자</div>
                </td>
                <td colspan="5">
                    <div class="td-cntnt requester"></div>
                </td>
            </tr>
            <tr>
                <td class="td-title">
                    <div>판매가</div>
                </td>
                <td class="w90" colspan="2">
                    <div class="td-cntnt dcPrc"></div>
                </td>
                <td class="td-title">
                    <div>정가</div>
                </td>
                <td colspan="2">
                    <div class="td-cntnt prodPrc"><span class="rq-rate dc-rate"></span></div>
                </td>
            </tr>
            <tr class="under-line">
                <td class="td-title">&nbsp;</td>
                <td colspan="5">
                    <div class="prc-td">
                        <input type="radio" name="isAuto" value="1" disabled>추천가격
                        <input type="radio" name="isNotAuto" value="0" disabled>직접입력
                    </div>
                </td>
            </tr>
            <tr class="under-line">
                <td class="td-title">
                    <div>유효기간</div>
                </td>
                <td colspan="2">
                    <div class="td-cntnt expirDt"></div>
                </td>
                <td class="td-title">
                    <div>바코드번호</div>
                </td>
                <td colspan="2">
                    <div class="td-cntnt brcd"></div>
                </td>
            </tr>
            <tr class="under-line">
                <td class="td-title">판매자메모</td>
                <td colspan="5">
                    <div class="td-cntnt descn"></div>
                </td>
            </tr>
            <tr>
                <td class="td-title">&nbsp;</td>
                <td colspan="5">
                    <a class="img-btn">기프티콘 이미지 확인</a>
                </td>
            </tr>
        </table>

        <div id="rq-btn-area">
            <button class="btn btn-active rq-aprv">승인</button>
            <button class="btn btn-disabled cancel">취소</button>
            <button class="btn dark rq-delete">삭제</button>
        </div>
    </div>
    <!-- detail modal end -->
</div>

<script>
    $(document).ready(function (e) {
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // 사이드바 판매요청관리 active 
        $("a[name='rqust-list']").attr('class', 'active');

        function submitAction(form, pageNum) {
            form.find("input[name='pageNum']").val(pageNum);
            form.submit();
        }

        // 페이지 이동
        let actionForm = $("#actionForm");
        $(".paginate_button").on("click", function (e) {
            e.preventDefault();
            let pageNum = $(this).attr("href");
            submitAction(actionForm, pageNum);
        });

        // 검색
        let searchForm = $("#search-form");
        $("#search-form button").on("click", function (e) {
            e.preventDefault();
            submitAction(searchForm, "1");
        });

        // modal에 값을 추가하기 위한 변수
        let modal = $("#detail-modal");
        let modalgftId = modal.find(".gftId");
        let modalCate = modal.find(".cate");
        let modalProdName = modal.find(".prodName");
        let modalRequester = modal.find(".requester");
        let modalDcPrc = modal.find(".dcPrc");
        let modalProdPrc = modal.find(".prodPrc");
        let modalIsAuto = modal.find("input[name='isAuto']");
        let modalIsNotAuto = modal.find("input[name='isNotAuto']");
        let modalExpirDt = modal.find(".expirDt");
        let modalBrcd = modal.find(".brcd");
        let modalDescn = modal.find(".descn");
        let modalImgBtn = modal.find(".img-btn");
        // 모달에 포함된 버튼
        let aprvBtn = modal.find(".rq-aprv");
        let deleteBtn = modal.find(".rq-delete");
        let cancleBtn = modal.find(".cancel");
        // 취소버튼 클릭시 모달 숨김
        cancleBtn.on("click", function (e) {
            e.preventDefault();
            hideModal();
        });

        // 목록에서 상세를 누르면 실행
        $(".detail-link").on("click", function (e) {
            e.preventDefault();

            let gftId = $(this).attr("href");
            let rqust = {};

            let errorFlag = false;

            // id에 해당하는 기프티콘 한 개를 조회
            $.ajax({
                type: 'get',
                url: '/admin/request/' + gftId,
                async: false,
                success: function (result) {
                    rqust = result;
                },
                error: function (result) {
                    alert("다시 한 번 시도해주세요.");

                    hideModal();
                    submitAction(searchForm, "1");
                    errorFlag = true;
                }
            });

            if (!errorFlag) {
                // 모달에 기프티콘 정보를 출력
                modalgftId.html(rqust.gftId);
                modalCate.html(rqust.cateName + "&nbsp;&gt;&nbsp;" + rqust.brdName);
                modalProdName.html(rqust.prodCode + "&nbsp;&nbsp;" + rqust.prodName);
                modalRequester.html(rqust.requester);
                modalDcPrc.html(rqust.dcPrc + "&nbsp;&nbsp;원");
                modalProdPrc.html(rqust.prodPrc + "&nbsp;&nbsp;원&nbsp;&nbsp;<span class='rq-rate'>" + parseInt(parseFloat(rqust.dcRate) * 100) + "%</span>");
                if (rqust.isAuto === '1') {
                    modalIsAuto.prop("checked", true);
                } else {
                    modalIsNotAuto.prop("checked", true);
                }
                modalExpirDt.html("~&nbsp;&nbsp;" + rqust.expirDt);
                modalBrcd.html(rqust.brcd);
                modalDescn.html("<p>" + rqust.descn + "</p>");

                modalImgBtn.on("click", function (e) {
                    e.preventDefault();
                    // 기프티콘 이미지를 새창에 띄워줌
                    window.open("http://localhost:8088" + rqust.imgPath, "gfticon img", "width=700, height=900");
                });

                // modal 승인버튼을 클릭하면 실행될 함수
                aprvBtn.on("click", function (e) {
                    e.preventDefault();

                    $.ajax({
                        type: 'patch',
                        url: '/admin/request/' + gftId,
                        async: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                        },
                        success: function () {
                            alert("승인 완료");
                            hideModal();

                            let pageNum = parseInt("${pageMaker.cri.pageNum}");
                            let realEnd = getRealEnd("${pageMaker.total}", "${pageMaker.cri.amount}");
                            submitAction(searchForm, pageNum > realEnd ? realEnd : pageNum);
                        },
                        error: function () {
                            alert("다시 한 번 시도해주세요.");
                        }
                    });
                });

                // 삭제버튼을 클릭하면 실행될 함수
                deleteBtn.on("click", function (e) {
                    e.preventDefault();

                    let cause = prompt("요청반려 사유를 입력해주세요.");

                    if (cause !== null) {
                        $.ajax({
                            type: 'delete',
                            url: '/admin/request/' + gftId,
                            contentType: "application/json",
                            data: JSON.stringify({email: rqust.requester, cause: cause}),
                            async: false,
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                            },
                            success: function () {
                                alert("삭제 완료");
                                hideModal();

                                let pageNum = parseInt("${pageMaker.cri.pageNum}");
                                let realEnd = getRealEnd("${pageMaker.total}", "${pageMaker.cri.amount}");
                                submitAction(searchForm, pageNum > realEnd ? realEnd : pageNum);
                            },
                            error: function () {
                                alert("다시 한 번 시도해주세요.");
                            }
                        });
                    }
                });

                // 모달 show
                showModal();
            }
        });

        function showModal() {
            $(".modal").css("visibility", "visible");
            $('html').css("overflow", "hidden");
        }

        function hideModal() {
            $(".modal").css("visibility", "hidden");
            $('html').css("overflow", "visible");
            // 기존 이벤트를 삭제
            aprvBtn.off();
            deleteBtn.off();
        }

        function getRealEnd(t, a) {
            let total = parseInt(t) - 1;
            let amount = parseInt(a);
            return parseInt(Math.ceil((total * 1.0) / amount));
        }
    });
</script>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>

