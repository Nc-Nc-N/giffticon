<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_info_edit_user.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_deals_detail.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_selling_products_detail.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_selling_products_detail_modify.css" type="text/css">

<jsp:include page="templete.jsp"/>

<div class="contentheader">
    <span>판매 내역 > 상품 상세</span>
</div>
<div class="item_info">
    <div class="item_img">
        <img src="<c:out value="${gftInfo.prdImgPath}"/>">
    </div>
    <div class="item_nameNcode">
        <div class="item_name">
            <div>콘 번호</div>
            No.<c:out value="${gftInfo.prdCode}"/><c:out value="${gftInfo.id}"/>
        </div>
        <div class="item_name">
            <div>브랜드</div>
            <c:out value="${gftInfo.brdName}"/>
        </div>
        <div class="item_code">
            <div>상품명</div>
            <c:out value="${gftInfo.prdName}"/>
        </div>
    </div>
    <div class="item_btn_seller">
        <c:choose>
            <c:when test="${gftInfo.codeName == '판매대기' || gftInfo.codeName == '판매중'}">
                <button id="modifyGift" class="btn btn-dark" value="<c:out value="${gftInfo.id}"/>">상품수정</button>
                <button id="deleteGift" class="btn btn-dark" value="<c:out value="${gftInfo.id}"/>">내역삭제</button>
            </c:when>
            <c:otherwise>
                <button class="btn btn-disabled">판매 완료</button>
                <button class="btn btn-disabled">수정 불가</button>
            </c:otherwise>
        </c:choose>

    </div>
</div>
<div class="item_info">
    <div class="item_img">
        <img src="<c:out value="${gftInfo.brcdImgPath}"/>">
    </div>
    <div class="item_nameNcode">
        <div class="item_name">
            <div>등록일자</div>
            <fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.aprvDt}"/>
        </div>
        <div class="item_name">
            <div>유효기간</div>
            <fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.expirDt}"/>
        </div>
        <div class="item_name">
            <div>바코드</div>
            <c:out value="${gftInfo.brcd}"/>
        </div>
        <div class="item_name">
            <div>상태</div>
            <c:out value="${gftInfo.codeName}"/>
        </div>
    </div>
    <div class="item_btn">
    </div>
</div>
<div class="item_prc">
    <div class="item_prc_left">
        <div class="prc_column">
            <div class="prc_column_left">자동할인</div>
            <div class="isAutoPrc">
                <c:out value="${gftInfo.isAutoPrc eq '1'.charAt(0) ? 'O' : 'X'}"/></div>
        </div>
        <div class="prc_column"></div>
    </div>
    <div class="item_prc_right">
        <div class="prc_column">
            <div class="prc_column_right">할인률</div>
            <c:out value="${gftInfo.dcRate * 100}"/>%
        </div>
        <div class="prc_column">
            <div class="prc_column_right">판매가격</div>
            <c:out value="${gftInfo.dcPrc}"/>원
        </div>
    </div>
</div>
<div class="toListbtn">
    <form id="actionForm" action="/user/mypage/sells" method="get">
        <input type="hidden" name="dateFrom" value="<c:out value="${cri.dateFrom}"/>">
        <input type="hidden" name="dateTo" value="<c:out value="${cri.dateTo}"/>">
        <input type="hidden" name="pageNum" value="${cri.pageNum}">
        <input type="hidden" name="amount" value="${cri.amount}">
        <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>"/>
        <input type="hidden" name="type" value="<c:out value="${cri.type}"/>"/>
        <button class="btn btn-active" id="toListbtn">목록</button>
    </form>

</div>
</div>
</div>
</div>
</div>
</body>
<div id="modal-fade">
    <div id="register-content" tabindex="-1" role="dialog" aria-hidden="true">
        <h2>상품 정보 수정</h2>

        <div id="content">
            <div class="email_section">
                <h3>브랜드 / 상품명</h3>
                <h4><c:out value="${gftInfo.brdName}"/></h4>&nbsp;>&nbsp;
                <h4><c:out value="${gftInfo.prdName}"/></h4>
            </div>
            <div class="img_section">
                <h3>상품 정보</h3>
                <div>
                    <div class="img_container">
                        <img class="modal-img" src="<c:out value="${gftInfo.prdImgPath}"/>">
                    </div>
                    <div class="img_container">
                        <img class="modal-img" src="<c:out value="${gftInfo.brcdImgPath}"/>">
                    </div>
                </div>
            </div>

            <div class="info_section">
                <div>
                    <h3>바코드 번호</h3>
                    <h4><c:out value="${gftInfo.brcd}"/></h4>
                </div>
            </div>

            <div class="date_section">
                <h3>유효기간</h3>
                <div class="date-search">
                    <input type="date" id="end-date"
                           value="<fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.expirDt}"/>"
                           readonly="readonly">
                </div>

            </div>

            <div class="price_section">
                <h3>가격 수정</h3>
                <div class="price_modify">
                    <form class="select">

                        <label>
                            <input type="radio" name="price_select" class="price_select" id="prc_auto" value="1"
                            <c:if test="${gftInfo.isAutoPrc eq '1'.charAt(0)}"> checked </c:if>
                            >자동</label><br>
                        <label>
                            <input type="radio" name="price_select" class="price_select" id="prc_manual" value="0"
                            <c:if test="${gftInfo.isAutoPrc eq '0'.charAt(0)}"> checked </c:if>
                            >수동</label>
                    </form>
                    <div class="input_text">
                        <input type="number" placeholder="가격표시" id="prcinput" value="<c:out value="${gftInfo.dcPrc}"/>">
                    </div>
                </div>

            </div>
            <div class="info_section">
                <div>
                    <h3>비밀번호 입력</h3>
                    <div class="input_text">
                        <input type="password" id="userPwd" placeholder="">
                    </div>
                </div>
                <div class="message"><h5></h5></div>
            </div>

        </div>

        <div id="reg-btn-area">
            <button class="btn btn-submit" id="modal-register">수정</button>
            <button class="btn btn-dark" id="modal-close">취소</button>
        </div>
        <form id="modalAction">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="gftId" value="<c:out value="${gftInfo.id}"/>">
        </form>
    </div>
</div>
</html>

<script>


    $(".document").ready(function () {

        let isAutoPrc = '<c:out value="gftInfo.isAutoPrc"/>';

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        var actionForm = $("#actionForm");
        var modal = $(".register-content");
        let modalAction = $("#modalAction");

        $('#deleteGift').on("click", function (e) {

            if (confirm("삭제하시겠습니까? 삭제 후 재등록 가능합니다.")) {
                actionForm.append("<input type='hidden' name='gftId' value='" + $(this).attr("value") + "'>");
                actionForm.attr("action", "/gifticon/delGft").attr("method", "get");
                actionForm.submit();
            } else {
                return;
            }
        })

        $("#modifyGift").on("click", function (e) {

            $("#modal-fade").css("visibility", "visible");
        })

        $("#modal-close").on("click", function (e) {

            $("#modal-fade").css("visibility", "hidden");
        })

        $("#modal-register").on("click", function (e) {

            let userPwd = $("#userPwd").val();
            let userEmail = '${principal.name}';
            let gftId = "<c:out value="${gftInfo.id}"/>";
            let isAutoPrc = $("input[name='price_select']:checked").val();
            let dcPrc = $("#prcinput").val();

            let prcUpdate = {
                email: userEmail,
                password: userPwd,
                gftId: gftId,
                isAutoPrc: isAutoPrc,
                dcPrc: dcPrc
            }

            $.ajax({
                url: '/gifticon/updateGft',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(prcUpdate),
                type: 'post',
                dataType: 'text',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {
                    alert("가격이 수정되었습니다.");
                    window.location.reload();
                },
                error: function (request) {

                    if (request.status == 406) {
                        alert("비밀번호를 확인하세요.");
                    } else {
                        alert("가격 수정 실패. 관리자에게 문의하세요");
                    }
                }
            })

        })

        if ($("#prc_auto").attr("checked")) {
            console.log("autoPrc checked");
            $("#prcinput").attr("readonly", true);
        }

        $("#prc_auto").on("click", function (e) {

            $("#prcinput").val("<c:out value="${gftInfo.dcPrc}"/>").attr("readonly", true);
        })

        $("#prc_manual").on("click", function (e) {

            $("#prcinput").attr("readonly", false).val("");
        })


    })

</script>