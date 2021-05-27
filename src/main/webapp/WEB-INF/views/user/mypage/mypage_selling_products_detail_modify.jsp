<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="/resources/css/user/mypage/mypage_selling_products_detail_modify.css" type="text/css">

<div id="register-content" tabindex="-1" role="dialog" aria-hidden="true">
    <h2>상품 정보 수정</h2>

    <div id="content">
        <div class="email_section">
            <h3>브랜드 / 상품명</h3>
            <h4><c:out value="${gftInfo.brdName}"/></h4>&nbsp;>&nbsp;
            <h4>
                <c:choose>
                    <c:when test="${fn:length(gftInfo.prdName) > 18}">
                        <c:out value="${fn:substring(gftInfo.prdName, 0, 18)}"/>..
                    </c:when>
                    <c:otherwise>
                        <c:out value="${gftInfo.prdName}"/>
                    </c:otherwise>
                </c:choose>
            </h4>
        </div>
        <div class="img_section">
            <h3>상품 정보</h3>
            <div>
                <div class="img_container">
                    <img class="modal-img" src="<c:out value="${gftInfo.prdImgPath}"/>">
                </div>
            </div>
        </div>

        <div class="date_section">
            <h3>바코드 번호</h3>
            <div class="date-search">
                <h4><c:out value="${gftInfo.brcd}"/></h4>
            </div>
        </div>

        <div class="date_section">
            <h3>유효기간</h3>
            <div class="date-search">
                <h4><fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.expirDt}"/></h4>
            </div>
        </div>

        <div class="date_section">
            <h3>정가</h3>
            <div class="date-search">
                <h4><c:out value="${gftInfo.listPrc}"/>원</h4>
            </div>
        </div>

        <div class="price_section">
            <h3>가격 수정</h3>
            <div class="price_modify">
                <form class="select">

                    <label>
                        <input type="radio" name="price_select" class="price_select"
                               id="prc_auto" value="1">자동</label><br>
                    <label>
                        <input type="radio" name="price_select" class="price_select"
                               id="prc_manual" value="0">수동</label>
                </form>
                <div class="input_prc">
                    <input type="number" placeholder="가격표시" id="prcinput" value="<c:out value="${gftInfo.dcPrc}"/>">
                </div>
                <div class="input_rt">
                    <input type="text" id="rateinput"
                           value="<fmt:formatNumber value="${gftInfo.finalDcRate}" type="percent" pattern="0.0%"/>"
                           readonly="readonly">
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

<script>
    $(".document").ready(function () {

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        //모달내 수정 버튼 클릭
        $("#modal-register").on("click", function (e) {

            let userPwd = $("#userPwd").val();
            let userEmail = "<sec:authentication property="principal.username" htmlEscape="false"/>";
            let gftId = "<c:out value="${gftInfo.id}"/>";
            let isAutoPrc = $("input[name='price_select']:checked").val();
            let dcPrc = $("#prcinput").val();
            let finalDcRate = $("#rateinput").val();

            //가격 입력 없이 클릭 시 alert 발생
            if (dcPrc == null || dcPrc == "") {
                alert("판매가격을 입력하세요");
                return;
            }
            finalDcRate = finalDcRate.slice(0, -1);

            //가격할인 DTO
            let prcUpdate = {
                email: userEmail,
                password: userPwd,
                gftId: gftId,
                isAutoPrc: isAutoPrc,
                dcPrc: dcPrc,
                dcRate: finalDcRate / 100
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

                    //반환된 error 코드가 406 (비밀번호 불일치)
                    if (request.status == 406) {
                        alert("비밀번호를 확인하세요.");
                        //반환된 error 코드가 500 (가격 수정 실패)
                    } else {
                        alert("가격 수정 실패. 관리자에게 문의하세요");
                    }
                }
            })
        })
    })
</script>

<script type="text/javascript" src="/resources/js/user/autoPrc.js"></script>
<script> //자동가격 설정 script

$(".document").ready(function () {

    let prc = "<c:out value="${gftInfo.listPrc}"/>";
    let startDcRate = "<c:out value="${gftInfo.startDcRate}"/>";
    let expirDt = "<fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.expirDt}"/>";
    let autoPrc = "<c:out value="${gftInfo.isAutoPrc}"/>";

    //남은 날짜와 정가에 따른 할인가,할인율 구하기
    let finalPnR = calAutoPrc(prc, startDcRate, expirDt);

    //최초 페이지 로딩 시 자동/수동 라디오 버튼 설정된 값 뿌려주기
    if (autoPrc == 1) {

        $("#prc_auto").attr("checked", true);
        $("#prcinput").attr("readonly", true);

    } else {

        $("#prc_manual").attr("checked", true);
        $("#prcinput").attr("readonly", false);

    }

    //자동 클릭 시 계산된 가격 입력
    $("#prc_auto").on("click", function (e) {

        $("#prcinput").val(finalPnR[0]).attr("readonly", true);
        $("#prc_manual").prop("disabled", false);
        $("#rateinput").val((finalPnR[1] * 100).toFixed(2) + "%");
    })

    //수동 클릭 시 직접 입력 가능
    $("#prc_manual").on("click", function (e) {

        $("#prcinput").attr("readonly", false).val("");
        $(this).prop("disabled", true);
        $("#rateinput").val("");
    })

    //수동 가격 입력 시 할인율 계산하여 즉시 출력
    $("#prcinput").keyup(function (e) {

        $("#rateinput").val("");

        //정가보다 높은 가격 입력 시 alert 출력 후 input 지우기
        if (parseInt($("#prcinput").val()) > prc) {
            alert("정가보다 높은 가격에 팔 수 없습니다.");
            $("#prcinput").val("");
            $("#rateinput").val("");

            //올바르지 않은 가격 입력 시 alert 출력 후 input 지우기
        } else if (parseInt($("#prcinput").val()) <= 0) {
            alert("가격이 올바르지 않습니다.");
            $("#prcinput").val("");
            $("#rateinput").val("");
        }

        //입력한 가격이 몇% 할인 된 것인지 출력
        setTimeout(function () {
            $("#rateinput").val(((prc - $("#prcinput").val()) / prc * 100).toFixed(2) + "%");
        }, 1000)
    })

})
</script>