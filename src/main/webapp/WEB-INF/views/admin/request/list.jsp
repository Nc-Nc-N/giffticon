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
<link rel="stylesheet" href="/resources/css/admin/common/list.css" typeof="text/css">
<link rel="stylesheet" href="/resources/css/admin/common/modal.css" typeof="text/css">
<link rel="stylesheet" href="/resources/css/admin/request/requestList.css" type="text/css">

<h1>판매요청관리</h1>

<!-- menu -->
<div id="submenu">
    <div>
        <a href="/admin/request/list" class="active"><span>판매요청관리</span></a>
    </div>
    <div>
        <a href="/admin/gifticon/list"><span>기프티콘관리</span></a>
    </div>
</div>
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
<div id="list-div">
    <table id="list-tb">
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
            <tr class="list-tr">
                <td><input type="checkbox" name="isRemove"/></td>
                <td>
                    <div class="list-img"><img src="<c:out value='${rqust .imgPath}'/>"></div>
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
                    <div class="ellipsis"><c:out value="${rqust.brcd}"/></div>
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
            <a class="paginate_button prev" href="${pageMaker.startPage - 1}">&lt;</a>
        </c:if>
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <a class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}" href="${num}">${num}</a>
        </c:forEach>
        <c:if test="${pageMaker.next}">
            <a class="paginate_button next" href="${pageMaker.endPage + 1}">&gt;</a>
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

<div class="modal detail">
    <!-- detail modal -->
    <div class="detail-modal">
        <div class="modal-title">판매요청상세</div>

        <table id="rq-td">
            <tr class="under-line">
                <td class="td-title">
                    <div>요청번호</div>
                </td>
                <td colspan="5">
                    <div class="td-cntnt gftId"></div>
                </td>
            </tr>
            <tr>
                <td class="td-title">
                    <div>상품</div>
                </td>
                <td colspan="5">
                    <div class="select-list">
                        <ul>
                            <li class="cate-list"></li>
                            <li class="brd-list"></li>
                            <li class="prod-list"></li>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr class="under-line">
                <td class="td-title">&nbsp;</td>
                <td colspan="5">
                    <div class="td-cntnt">
                        <span class="cate-name"></span>&nbsp;&nbsp;&gt;&nbsp;
                        <span class="brd-name"></span>&nbsp;&nbsp;&gt;&nbsp;
                        <span class="prod-name"></span>
                    </div>
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
                    <div class="prc-td td-cntnt">
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
                    <div class="td-cntnt text-input descn">
                        <textarea name="descn" readonly></textarea>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td-title">&nbsp;</td>
                <td colspan="5">
                    <div class="td-cntnt"><a class="img-btn">기프티콘 이미지 확인</a></div>
                </td>
            </tr>
        </table>

        <div class="detail-btn-area">
            <button class="btn btn-active rq-aprv">승인</button>
            <button class="btn btn-disabled cancel">취소</button>
            <button class="btn dark rq-delete">반려</button>
        </div>
    </div>
</div>
<!-- detail modal end -->

<!-- delete loading modal -->
<div class="modal delete">
    <div class="loading-delete">
        <img src="/resources/img/loading.gif"/>
        <div>판매반려중</div>
        <div>잠시만 기다려주세요.</div>
    </div>
</div>
<!-- delete loading modal end -->

<script src="/resources/js/user/autoPrc.js"></script>
<script>
    $(document).ready(function (e) {
        if ("${error}".length !== 0) {
            alert("판매요청 조회에 실패했습니다. 다시 시도해주세요.\n문제가 반복될 경우 담당자에게 문의해주세요.");
        }

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // 사이드바 판매요청관리 active
        $("#gifticonAdministration").attr('class', 'active');

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
        let modal = $(".detail-modal");
        let modalgftId = modal.find(".gftId");
        let modalCate = modal.find(".cate");
        let modalProdName = modal.find(".prodName");
        let modalRequester = modal.find(".requester");
        let modalDcPrc = modal.find(".dcPrc");
        let modalProdPrc = modal.find(".prodPrc");
        let modalIsAuto = modal.find("input[name='isAuto']");
        let modalIsNotAuto = modal.find("input[name='isNotAuto']");
        // 모달에 포함된 버튼
        let modalImgBtn = modal.find(".img-btn");
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
            let rqust = getRqust(gftId);
            if (rqust === null) return;        // 요청 조회에 실패하면 함수를 빠져나감

            let cateCode = rqust.prodCode.substr(0, 2);
            let brdCode = rqust.prodCode.substr(0, 4)

            getCategoryList();      // 카테고리 목록 조회 후 화면에 그줌
            $(".cate-list div button[id=" + cateCode + "]").attr("class", "active-prod-btn");
            $(".cate-name").text(rqust.cateName);
            $(".cate-list ").on("click", "div button", function (e) {   // 카테고리 선택시 실행될 이벤트 등록
                e.preventDefault();
                let isChanged = confirm("상품 카테고리를 변경하시겠습니까?");
                if (!isChanged) return;

                removeBrdList();        // 카테고리 선택 전 그렸던 브랜드 목록 초기화
                removeProdList();       // 상품목록 초기화
                // 추천가격을 선택한 경우 판매가 초기화
                if (rqust.isAutoPrc === '1') modalDcPrc.empty();
                modalProdPrc.empty();   // 정가 초기화

                $(".cate-list button.active-prod-btn").attr("class", "");
                e.target.classList.add("active-prod-btn");
                $(".cate-name").text(e.target.name);

                getBrdList(rqust.prodCode, e.target.id);    // 현재 카테고리에 해당하는 브랜드 목록을 그려줌
            });

            getBrdList(rqust.prodCode, cateCode);
            $(".brd-list div button[id=" + brdCode + "]").attr("class", "active-prod-btn");
            $(".brd-name").text(rqust.brdName);
            $(".brd-list ").on("click", "div button", function (e) {
                e.preventDefault();

                let isChanged = confirm("상품 브랜드를 변경하시겠습니까?");
                if (!isChanged) return;

                removeProdList();
                if (rqust.isAutoPrc === '1') modalDcPrc.empty();
                modalProdPrc.empty();

                $(".brd-list button.active-prod-btn").attr("class", "");
                e.target.classList.add("active-prod-btn");
                $(".brd-name").text(e.target.name);

                getProdList(rqust.prodCode, e.target.id);
            });

            getProdList(rqust.prodCode, brdCode);
            $(".prod-list div button[id=" + rqust.prodCode + "]").attr("class", "active-prod-btn");
            $(".prod-name").text(rqust.prodName);
            $(".prod-list ").on("click", "div button", function (e) {
                e.preventDefault();
                let isChanged = confirm("상품명을 변경하시겠습니까?");
                if (!isChanged) return;

                // 이전에 선택한 버튼의 클래스 값 초기화
                $(".prod-list button.active-prod-btn").attr("class", "");

                e.target.classList.add("active-prod-btn");
                $(".prod-name").text(e.target.name);

                let prod = getProd(e.target.id);
                if (rqust.isAutoPrc === '1') {
                    let autoDcPrcAndRate = calAutoPrc(prod.prc, prod.inDcRate, rqust.expirDt);
                    modalDcPrc.text(autoDcPrcAndRate[0] + "  원");
                    modalProdPrc.text(prod.prc + "  원  ")
                        .append("<span class='rq-rate'>" + parseInt(parseFloat(autoDcPrcAndRate[1]) * 100) + "%</span>");
                } else {
                    let newDcRate = (prod.prc - rqust.dcPrc) / parseFloat(prod.prc);
                    modalProdPrc.text(prod.prc + "  원  ")
                        .append("<span class='rq-rate'>" + parseInt(parseFloat(newDcRate) * 100) + "%</span>");
                }
            });

            // 모달에 기프티콘 정보를 출력
            modal.find(".gftId").text(rqust.gftId);                              // 요청번호
            modal.find(".requester").text(rqust.requester);                      // 판매자 이메일
            modalDcPrc.text(rqust.dcPrc + "  원");                               // 판매가
            modalProdPrc.text(rqust.prodPrc + "  원  ")                          // 정가, 할인율
                .append("<span class='rq-rate'>" + parseInt(rqust.dcRate * 100) + "%</span>");
            modal.find(".expirDt").text(rqust.expirDt + " 까지");                // 유효기간
            modal.find(".brcd").text(rqust.brcd);                                // 바코드번호
            modal.find("textarea[name='descn']").val(rqust.descn);               // 판매자 메모

            // 추천가격을 선택한 경우 남은 유효기간에 따라 가격변경
            if (rqust.isAutoPrc === '1') {
                // 정가, 기본할인율, 유효기간에 따라 할인가, 할인율을 계산
                let autoDcPrcAndRate = calAutoPrc(rqust.prodPrc, rqust.inDcRate, rqust.expirDt);
                modalDcPrc.text(autoDcPrcAndRate[0] + "  원");
                modalProdPrc.text(rqust.prodPrc + "  원  ").append("<span class='rq-rate'>" + parseInt(parseFloat(autoDcPrcAndRate[1]) * 100) + "%</span>");
                modalIsAuto.prop("checked", true);
            } else {
                modalIsNotAuto.prop("checked", true);
            }

            modalImgBtn.on("click", function (e) {
                e.preventDefault();
                // 기프티콘 이미지를 새창에 띄워줌
                window.open(rqust.imgPath, "gfticon img", "width=700, height=900");
            });

            // modal 승인버튼을 클릭하면 실행될 함수
            aprvBtn.on("click", function (e) {
                e.preventDefault();

                let prodCode = $(".prod-list button.active-prod-btn").attr("id");

                if (prodCode === undefined) {
                    alert("상품을 선택해주세요.");
                    return;
                }
                if (prodCode === "999999") {
                    alert("기타 상품은 승인 불가능합니다. 상품을 선택해주세요.\n기프티콘에 해당하는 상품이 존재하지 않으면 상품등록 후 승인을 진행해주세요.");
                    return;
                }

                let isAprv = confirm("No." + rqust.gftId + "  "
                    + $(".cate-name").text() + " > " + $(".brd-name").text() + " > " + $(".prod-name").text() + "\n\n"
                    + "판매 승인하시겠습니까? \n(상품명과 요청 정보가 정확한지 다시 한 번 확인해주세요.)");

                if (isAprv) {
                    let newDcPrc = modalDcPrc.text().replaceAll(/[^0-9]/g, "");
                    let newDcRate = parseInt($(".rq-rate").text().replaceAll(/[^0-9]/g, "")) * 0.01;
                    // 서버로 승인요청 전송
                    approveRqust(gftId, prodCode, newDcPrc, newDcRate)
                }
            });

            // 삭제버튼을 클릭하면 실행될 함수
            deleteBtn.on("click", function (e) {
                e.preventDefault();
                let cause = prompt("요청반려 사유를 입력해주세요.");

                if (cause !== null) {
                    hideModal();
                    $(".delete").css("visibility", "visible");
                    // 판매요청반려 요청
                    deleteRqust(gftId, rqust, cause);
                }
            });

            // 모달 show
            showModal();
        });

        function showModal() {
            $(".detail").css("visibility", "visible");
            $('html').css("overflow", "hidden");
        }

        function hideModal() {
            $(".detail").css("visibility", "hidden");
            $('html').css("overflow", "visible");
            // 체크박스 속성 초기화
            modalIsAuto.prop("checked", false);
            modalIsNotAuto.prop("checked", false);
            // 기존 이벤트를 삭제
            $(".cate-list").off();
            $(".cate-list div button").remove();
            $(".brd-list").off();
            $(".prod-list").off();
            modalImgBtn.off();
            aprvBtn.off();
            deleteBtn.off();
        }

        function getRealEnd(t, a) {
            let total = parseInt(t) - 1;
            let amount = parseInt(a);
            return parseInt(Math.ceil((total * 1.0) / amount));
        }

        function getCategoryList() {
            removeBrdList();
            removeProdList();

            let cateList = [];

            $.ajax({
                type: 'get',
                url: '/admin/request/getCateList',
                async: false,
                success: function (result) {
                    result.forEach(item => cateList.push({code: item.code, name: item.name}));
                },
                error: function (result) {
                    alert("다시 한 번 시도해주세요.");

                    hideModal();
                    submitAction(searchForm, "1");
                }
            });

            fillList(".cate-list", cateList);
        }

        function getBrdList(prodCode, cateCode) {
            let brdList = [];

            $.ajax({
                type: 'get',
                url: '/admin/request/getBrdList?cateCode=' + cateCode,
                async: false,
                success: function (result) {
                    result.forEach(item => brdList.push({code: item.code, name: item.name}));
                },
                error: function (result) {
                    alert("다시 한 번 시도해주세요.");

                    hideModal();
                    submitAction(searchForm, "1");
                }
            });

            fillList(".brd-list", brdList);
        }

        function getProdList(prodCode, brdCode) {
            let prodList = [];
            $.ajax({
                type: 'get',
                url: '/admin/request/getProdList?brdCode=' + brdCode,
                async: false,
                success: function (result) {
                    result.forEach(item => prodList.push(item));
                },
                error: function (result) {
                    alert("다시 한 번 시도해주세요.");
                    hideModal();
                    submitAction(searchForm, "1");
                }
            });

            // 상품목록을 채움
            fillList(".prod-list", prodList);
        }

        function fillList(listClass, list) {
            list.forEach(item => {
                $(listClass).append(
                    "<div><button id='" + item.code + "' name='" + item.name + "'>" + item.name + "</button></div>");
            });
        }

        function getRqust(gftId) {      // id에 해당하는 기프티콘 상세 조회
            let rqust = null;

            $.ajax({
                type: 'get',
                url: '/admin/request/' + gftId,
                async: false,
                success: function (result) {
                    rqust = result;
                },
                error: function (result) {
                    alert("상세정보를 조회하는데 실패했습니다.\n새로고침 후, 다시 시도해주세요.");
                    hideModal();
                    submitAction(searchForm, "1");
                }
            });

            return rqust;
        }

        function getProd(code) {        // code에 해당하는 상품 상세 조회
            let prod = {};

            $.ajax({
                type: 'get',
                url: '/admin/request/getProd?code=' + code,
                async: false,
                success: function (result) {
                    prod = result;
                },
                error: function (result) {
                    alert("새로고침 후, 다시 시도해주세요.");
                    hideModal();
                    submitAction(searchForm, "1");
                }
            });

            return prod;
        }

        function removeBrdList() {
            $(".brd-list div button").remove();
            $(".brd-name").empty();
        }

        function removeProdList() {
            $(".prod-list div button").remove();
            $(".prod-name").empty();
        }

        function approveRqust(gftId, prodCode, newDcPrc, newDcRate) {   // 판매승인요청 메서드
            $.ajax({
                type: 'patch',
                url: '/admin/request/' + gftId,
                contentType: 'application/json; charset=utf-8',
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                data: JSON.stringify({
                    prodCode: prodCode,
                    dcPrc: newDcPrc,
                    dcRate: newDcRate
                }),
                success: function (result) {
                    alert("승인 완료");
                    hideModal();
                    let pageNum = parseInt("${pageMaker.cri.pageNum}");
                    let realEnd = getRealEnd("${pageMaker.total}", "${pageMaker.cri.amount}");
                    submitAction(searchForm, pageNum > realEnd ? realEnd : pageNum);
                },
                error: function (result) {
                    alert("새로고침 후, 다시 시도해주세요.");
                }
            });
        }

        function deleteRqust(gftId, rqust, cause) {                     // 판매요청반려 메서드
            $.ajax({
                type: 'delete',
                url: '/admin/request/' + gftId,
                contentType: "application/json",
                data: JSON.stringify({email: rqust.requester, cause: cause}),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {
                    $(".delete").css("visibility", "hidden");
                    let pageNum = parseInt("${pageMaker.cri.pageNum}");
                    let realEnd = getRealEnd("${pageMaker.total}", "${pageMaker.cri.amount}");
                    submitAction(searchForm, pageNum > realEnd ? realEnd : pageNum);
                },
                error: function () {
                    alert("새로고침 후, 다시 시도해주세요.");
                }
            });
        }
    });
</script>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>

