<%--
  Created by IntelliJ IDEA.
  User: lwiii
  Date: 2021-04-28
  Time: 오후 17:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/common/list.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/common/modal.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/gifticon/gifticonList.css" type="text/css">

<h1>기프티콘관리</h1>

<!-- menu -->
<div id="submenu">
    <div>
        <a href="/admin/request/list"><span>판매요청관리</span></a>
    </div>
    <div>
        <a href="/admin/gifticon/list" class="active"><span>기프티콘관리</span></a>
    </div>
</div>
<!-- menu end -->

<!-- search area -->
<div class="s-area">
    <form id="s-form">
        <div class="s-form">
            <select name="type" class="search-select">
                <option value="ENCG" <c:out value="${pageMaker.cri.type eq 'ENCG' ? 'selected' : ''}"/>>전체</option>
                <option value="E" <c:out value="${pageMaker.cri.type eq 'E' ? 'selected' : ''}"/>>판매자</option>
                <option value="N" <c:out value="${pageMaker.cri.type eq 'N' ? 'selected' : ''}"/>>상품명</option>
                <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>상품코드</option>
                <option value="G" <c:out value="${pageMaker.cri.type eq 'G' ? 'selected' : ''}"/>>기프티콘ID</option>
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
        </div>

        <div class="order-area">
            <select name="order" class="order-select">
                <option value="SJWC" <c:out value="${pageMaker.cri.order eq 'SJWC' ? 'selected' : ''}"/>>전체</option>
                <option value="S" <c:out value="${pageMaker.cri.order eq 'S' ? 'selected' : ''}"/>>판매중</option>
                <option value="J" <c:out value="${pageMaker.cri.order eq 'J' ? 'selected' : ''}"/>>핀매불가</option>
                <option value="W" <c:out value="${pageMaker.cri.order eq 'W' ? 'selected' : ''}"/>>거래확정대기</option>
                <option value="C" <c:out value="${pageMaker.cri.order eq 'C' ? 'selected' : ''}"/>>거래확정완료</option>
            </select>
        </div>
    </form>
</div>
<!-- search area end -->

<!-- request list -->
<div id="list-div">
    <table id="list-tb">
        <thead>
        <tr>
            <td class="w125">기프티콘 이미지</td>
            <td class="w45">No.</td>
            <td class="w125">상품</td>
            <td class="w100">바코드 번호</td>
            <td class="w100">유효기간</td>
            <td class="w125">판매자</td>
            <td class="w100">기프티콘상태</td>
            <td class="w45">&nbsp;</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="gft" items="${gftList}" varStatus="status">
            <tr class="list-tr">
                <td>
                    <div class="list-img"><img src="<c:out value='${gft.imgPath}'/>"></div>
                </td>
                <td>
                    <div><c:out value="${gft.gftId}"/></div>
                </td>
                <td>
                    <div class="ellipsis">
                        <c:out value="${gft.cateName}"/>&nbsp;&gt;&nbsp;<c:out value="${gft.brdName}"/> <br>
                        <c:out value="${gft.prodCode} ${gft.prodName}"/>
                    </div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${gft.brcd}"/></div>
                </td>
                <td>
                    <div>&#126;&nbsp;<c:out value="${gft.expirDt}"/></div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${gft.requester}"/></div>
                </td>
                <td>
                    <div><c:out value="${gft.gftStus}"/></div>
                </td>
                <td>
                    <div><a href="${gft.gftId}" class="detail-link">상세</a></div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
<!-- request list end -->

<c:if test="${empty gftList}">
    <div class="nothing">조회할 기프티콘이 없습니다.</div>
</c:if>

<div class="main-footer">
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

<form id="actionForm" action='/admin/gifticon/list' method="get">
    <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
    <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
    <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
    <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
    <input type="hidden" name="order" value='<c:out value="${pageMaker.cri.order}"/>'>
</form>

</div>
<!-- main content end -->

<div class="modal detail">
    <!-- detail modal -->
    <div class="detail-modal">
        <h2>기프티콘상세</h2>

        <table>
            <tr class="under-line">
                <td class="td-title">
                    <div>기프티콘번호</div>
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
                <td colspan="4">
                    <div class="td-cntnt requester"></div>
                </td>
                <td>
                    <div class="td-cntnt mail-btn">
                        <button id="mail-btn">메일전송</button>
                    </div>
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
                    <div class="td-cntnt prc-td">
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
                <td class="td-title">기프티콘상태</td>
                <td colspan="5">
                    <div class="td-cntnt">
                        <select name="stus" class="stus-select">
                            <option name="002" value="002">판매중</option>
                            <option name="003" value="003">핀매불가</option>
                            <option name="004" value="004">거래확정대기</option>
                            <option name="005" value="005">거래확정완료</option>
                        </select>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="td-title">&nbsp;</td>
                <td colspan="5">
                    <div class="td-cntnt">
                        <a class="img-btn">기프티콘 이미지 확인</a>
                    </div>
                </td>
            </tr>
        </table>

        <div class="detail-btn-area">
            <button class="btn btn-disabled cancel">취소</button>
        </div>
    </div>
</div>
<!-- detail modal end -->

<script>
    $(document).ready(function (e) {
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
        let searchForm = $("#s-form");
        $("#search-form button").on("click", function (e) {
            e.preventDefault();
            submitAction(searchForm, "1");
        });

        $(".order-select").on("change", function (e) {
            $("#actionForm").find("input[name='order']").val($(".order-select option:selected").val());
            submitAction(actionForm, "1");
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
        let modalExpirDt = modal.find(".expirDt");
        let modalBrcd = modal.find(".brcd");
        let modalDescn = modal.find(".descn");
        let modalImgBtn = modal.find(".img-btn");
        let modalStus = modal.find(".stus-select");
        // 모달에 포함된 버튼
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
            let gft = {};

            let errorFlag = false;

            // id에 해당하는 기프티콘 한 개를 조회
            $.ajax({
                type: 'get',
                url: '/admin/gifticon/' + gftId,
                async: false,
                success: function (result) {
                    gft = result;
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
                modalgftId.text(gft.gftId);
                modalCate.text(gft.cateName + " > " + gft.brdName);
                modalProdName.text(gft.prodName)
                modalRequester.text(gft.requester);
                modalDcPrc.text(gft.dcPrc + "  원");
                modalProdPrc.text(gft.prodPrc + "  원  ").append("<span class='rq-rate'>" + parseInt(parseFloat(gft.dcRate) * 100) + "%</span>");
                if (gft.isAuto === '1') {
                    modalIsAuto.prop("checked", true);
                } else {
                    modalIsNotAuto.prop("checked", true);
                }
                modalExpirDt.text("~  " + gft.expirDt);
                modalBrcd.text(gft.brcd);
                modalDescn.text(gft.descn);
                modalStus.find("option[name='" + gft.stusCode + "']").prop("selected", "true");
                modalImgBtn.on("click", function (e) {
                    e.preventDefault();
                    // 기프티콘 이미지를 새창에 띄워줌
                    window.open(gft.imgPath, "gfticon img", "width=700, height=900");
                });

                let pre = '';
                modalStus.on("focus", function (e) {
                    pre = $(this).find("option:selected").val();
                });
                modalStus.on("change", function (e) {
                    let stus = $(this).find("option:selected").val();

                    if (confirm("기프티콘 상태를 수정하시겠습니까?")) {
                        $.ajax({
                            url: '/admin/gifticon/' + gftId,
                            type: 'patch',
                            contentType: 'text/plain',
                            async: false,
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                            },
                            data: stus,
                            success: function (result) {
                                hideModal();
                                let pageNum = parseInt("${pageMaker.cri.pageNum}");
                                submitAction(searchForm, pageNum);
                                alert("기프티콘 상태 수정에 성공했습니다.");
                            },
                            error: function (result) {
                                alert("기프티콘 상태 수정에 실패했습니다. 새로고침 후 다시 시도해주세요.\n문제가 반복되면 담당자에게 문의해주세요.");
                                $(this).find("option[name='" + pre + "']").prop("selected", "true");
                            }
                        });
                    } else {
                        $(this).find("option[name='" + pre + "']").prop("selected", "true");
                    }
                });

                // 모달 show
                showModal();
            }
        });

        function showModal() {
            $(".detail").css("visibility", "visible");
            $('html').css("overflow", "hidden");
        }

        function hideModal() {
            $(".detail").css("visibility", "hidden");
            $('html').css("overflow", "visible");
            // 기존 이벤트를 삭제
            modalStus.off();
        }
    });
</script>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>

