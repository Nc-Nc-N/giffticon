<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="templete.jsp"/>

<head>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

    <link rel="stylesheet" href="/resources/css/user/mypage/withdrawCon.css" type="text/css">
</head>

<div class="contents">
    <div class="contentheader">
        <span> 콘 인출</span>
    </div>
    <div class="tbl-group">
        <table class="type02">
            <tr>
                <th scope="row">이름</th>
                <td><c:out value="${user.name}"/></td>
            </tr>
            <tr>
                <th scope="row">계좌</th>
                <td class="myAcc"><c:out value="${user.bnkName}"/>&nbsp;<c:out value="${user.acc}"/></td>
            </tr>
        </table>
    </div>
    <div class="pnt_info_column">
        <div class="con_info"> 인출 가능 콘 <span class="userPnt"><fmt:formatNumber value="${user.pnt}" type="number" maxFractionDigits="3"/> 콘</span></div>
        <div class="con_info"> 인출할 충전 콘 <input type="number" id="wdCon"/></div>
        <div class="con_info"> 인출 후 콘 <span class="afterAdd"></span></div>
        <span class="money"></span>
        <div class="space50"></div>
        <div class="pnt_bought_btn_section">
            <button id="withdraw-btn" class="btn btn-active">인출하기</button>
        </div>
    </div>
</div>

</div>
</div>
</div>
</div>
<div class="space100"></div>

<div class="modal">
    <div class="screen">
        <button type="button" value="close" class="btn modal--close">X</button>
        <div class="layerpop">
            <div class="pwd_group">
                <div class="withdraw_con">
                    <span class="con_txt"></span> 콘을 인출하시겠습니까? 인출을 위해 비밀번호를 입력해 주세요.
                </div>
                <div class="input_text">
                    비밀번호 확인 &ensp;<input type="password" class="originPwd" placeholder="기존 비밀번호를 입력해주세요">
                    <button class="btn btn-submit" id="btn-confirmOriginPwd">인증</button>
                </div>
            </div>
            <div class="message" id="msg-originPwd"></div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script type="text/javascript" src="/resources/js/banking/openBanking.js"></script>
<script>
    $(document).ready(function () {
        $("#con-link").attr("class", "menu active");

        // 문자열에서 앞 0 제거하는 함수
        let trimFrontZero = function (String) {
            return String.replace(/(^0+)/, "");
        }

        // 문자열에서 숫자만 남기는 함수
        let trimString = function (string) {
            return string.trim().replace(/[^0-9]/g, "");
        }

        // 인출할 콘 input box를 벗어날 때
        function isNotInMyArea($targetObj) {
            let isIn = true;
            let $objArr = Array();
            let opts = {
                left: 99999, right: 0, top: 99999, bottom: 0
            }

            if ($targetObj) {
                if ($targetObj.length === 1) {
                    $objArr.push($targetObj);
                } else {
                    $objArr = $targetObj;
                }

                $.each($objArr, function (i, $obj) {
                    let obj_position = $obj.offset();
                    obj_position.right = parseInt(obj_position.left) + ($obj.width());
                    obj_position.bottom = parseInt(obj_position.top) + parseInt($obj.height());

                    if (obj_position.left < opts.left) opts.left = obj_position.left;
                    if (obj_position.right > opts.right) opts.right = obj_position.right;
                    if (obj_position.top < opts.top) opts.top = obj_position.top;
                    if (obj_position.bottom > opts.bottom) opts.bottom = obj_position.bottom;
                });

                if ((opts.left <= event.pageX && event.pageX <= opts.right)
                    && (opts.top <= event.pageY && event.pageY <= opts.bottom)) {
                    isIn = false;
                }
            }
            return isIn;
        }

        let userCon = ${user.pnt};
        let oldVal = 0;
        let inputBox = $("#wdCon");

        // 인출할 충전 콘이 변할 때마다 인출 후 콘 변경
        inputBox.on("propertychange change keyup paste input", function () {
            let currentVal = $(this).val();
            $(this).val(trimFrontZero(trimString(currentVal)));

            if (currentVal === oldVal) {
                return;
            }

            oldVal = currentVal;

            if (oldVal !== "") {

                $('.afterAdd').html(userCon - parseInt(oldVal)).append(" 콘");
            } else {
                $('.afterAdd').html("");
            }

            // 인출할 충전 콘이 보유 콘보다 클 때
            if (oldVal > userCon) {
                $(this).val(userCon);
                oldVal = userCon;
                $('.afterAdd').html(userCon - parseInt(oldVal)).append(" 콘");
            }
        });

        // 인출할 충전 콘이 1000원 미만일 때 1000원으로 처리
        $(document).mousedown(function () {
            if (isNotInMyArea([$("button"), $("#wdCon")])) {
                if (parseInt(inputBox.val()) < 1000) {
                    alert("충전 콘은 1,000원 이상부터 1원 단위로 인출하실 수 있습니다.");
                    inputBox.val(1000);
                    $('.afterAdd').html(userCon - 1000).append(" 콘");
                }
            }
        });

        $modal = $(".modal");

        // '인출하기' 버튼 클릭시
        $("#withdraw-btn").on("click", function () {
            if (!inputBox.val()) {
                alert("인출할 충전 콘을 입력해주세요.");
                return false;
            }
            $(".con_txt").html(inputBox.val());
            $modal.show();
        });

        $(".modal--close").click(function () {
            $modal.hide();
        });

        <%-- modal 비밀번호 확인, 인출--%>
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        const oriEmail = "<c:out value="${user.email}"/>";
        const accountVal = "<c:out value="${user.acc}"/>";
        const bnkCodeVal = "<c:out value="${user.bnkCode}"/>";
        const holderVal = "<c:out value="${user.holder}"/>";
        const userNameVal = "<c:out value="${user.name}"/>";
        const idVal = "<c:out value="${user.id}"/>";

        //비밀번호 확인 버튼
        let btnOriginPwd = $("#btn-confirmOriginPwd");

        //input 칸
        let insertOriginPwd = $(".originPwd");

        //msg 출력칸
        let originPwdMsg = $("#msg-originPwd");

        //기존 비밀번호 인증
        btnOriginPwd.on("click", function (e) {

            var msg = "";
            let oriPwdVal = insertOriginPwd.val();
            const conVal = $(".con_txt").text();

            let checkUser = {
                email: oriEmail,
                pwd: oriPwdVal,
            }

            originPwdMsg.html("");

            $.ajax({
                url: '/user/mypage/checkPassword',
                contentType: "application/json",
                data: JSON.stringify(checkUser),
                type: 'post',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {  // 비밀번호 확인 성공

                    userInfo = {
                        acc: accountVal,
                        bnkCode: bnkCodeVal,
                        conAmt: conVal,
                        name: userNameVal,
                        holder: holderVal,
                        id: idVal
                    }

                    //promise_ 토큰 획득 후
                    getBankingAccTkn()
                        .then(accTkn => deposit(accTkn, userInfo)
                            .then(con => conUpdate(con)
                                .then(msg => alert(msg))))
                        .catch(error => alert(error))
                },
                error: function () {

                    msg += "<i class='fas fa-exclamation-circle'></i>";
                    msg += "<p>&nbsp;비밀번호가 다릅니다.</p>";
                    originPwdMsg.html(msg);

                }
            })
        })

        // 에러 메시지 처리
        let error = "${error}";

        if (error.length > 0) {
            alert("error: " + error);
        }
    });
</script>