<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/css/user/mypage/user_info_modal.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/userInfo_editTelNo.css" type="text/css">

<body>
<div id="register-content">
    <h2>전화번호 변경</h2>

    <div id="content">
        <div class="info_section">
            <div>
                <h3>전화번호</h3>
                <div class="input_text">
                    <input type="text" class="input_telNo" placeholder="전화번호를 입력해주세요.">
                </div>
                <button class="btn btn-submit" id="btn-confirmTelNo">인증</button>
            </div>
            <div class="verifyCode">
                <div class="code_section">
                    <span>인증코드 : </span>
                    <input type="text" class="input_code" placeholder="">
                </div>
                <span class="msg_code_verify">인증코드 일치</span>
            </div>
        </div>

        <div class="info_section">
            <div>
                <h3>현재 비밀번호</h3>
                <div class="input_text">
                    <input type="password" class="originPwd-telno" placeholder="기존 비밀번호를 입력해주세요">
                </div>
                <button class="btn btn-submit" id="btn-confirmOriginPwd-telno">인증</button>
            </div>
            <div class="message" id="msg-tel-confirmPwd">

            </div>
        </div>

    </div>

    <div id="reg-btn-area">
        <button class="btn btn-active" id="modifyMyInfo-telno">등록</button>
        <button class="btn btn-dark cancel" id="cancelMyInfo-telno">취소</button>
    </div>
</div>
</body>

<script type="text/javascript" src="/resources/js/user/userInfoValidator.js"></script>
<script>
    $(document).ready(function () {
        let oriEmail = "<c:out value="${user.email}"/>";

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let btnConfirmTelNo = $("#btn-confirmTelNo");
        let btnOriginPwd = $("#btn-confirmOriginPwd-telno");

        let inputPwd = $(".originPwd-telno");
        let inputTelNo = $(".input_telNo");
        let inputCode = $(".input_code");

        let msgPwd = $("#msg-tel-confirmPwd");

        let telAuthCode = '';
        let telNoConfirmMsg = $(".msg_code_verify");
        let checkAllConfirmedForTelNo = [false, false];


        //sms 인증 버튼 -- 전화인증 완료 후 code 추가 예정
        btnConfirmTelNo.on("click", function (e) {
            //전화번호 input
            let telNo = inputTelNo.val();

            //전화번호 유효성 검사
            if (!checkTelNo(telNo)) {
                alert("유효한 전화번호가 아닙니다.");
                return;
            }

            btnConfirmTelNo.attr("class", "btn btn-disabled");

            //sms 보내기 ajax
            $.ajax({
                type: 'get',
                url: '/account/telNoConfirm?telNo=' + telNo,
                success: function (result) {
                    telAuthCode = result.code;   // 인증코드 메일 전송을 성공하면 해당 코드값을 받아옴
                }, error: function (result) {
                    btnConfirmTelNo.attr("class", "btn btn-submit");
                    alert("인증코드 전송에 실패했습니다. 다시 시도해주세요.\n문제가 반복되면 문의남겨주시면 빠르게 해결하겠습니다. (" + result.error + ")");
                }
            });

        });

        inputCode.on("propertychange change keyup paste input", function (e) {
            if (telAuthCode === $(this).val()) {            // 입력 값과 인증코드가 같으면
                telNoConfirmMsg.css("display", "block");
                checkAllConfirmedForTelNo[0] = true;        // 휴대폰 인증여부 true
                return;
            }
            telNoConfirmMsg.css("display", "none");
            checkAllConfirmedForTelNo[0] = false;           // 휴대폰 인증여부 false
        });

        btnOriginPwd.on("click", function (e) {
            let msg = "";
            let pwdVal = inputPwd.val();

            let checkUser = {
                email: oriEmail,
                pwd: pwdVal
            }

            msgPwd.html("");

            $.ajax({
                url: '/user/mypage/checkPassword',
                contentType: "application/json",
                data: JSON.stringify(checkUser),
                type: 'post',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {
                    msg += "비밀번호가 일치합니다.";
                    checkIsCorrect(msgPwd, msg, true)
                    checkAllConfirmedForTelNo[1] = true
                },
                error: function () {
                    msg += "비밀번호가 다릅니다.";
                    checkIsCorrect(msgPwd, msg, false)
                    checkAllConfirmedForTelNo[1] = false
                }
            });
        });

        $("#modifyMyInfo-telno").on("click", function () {
            let telNo = inputTelNo.val();

            if (!checkAllConfirmedForTelNo[0]) {
                alert("인증번호가 다릅니다. 다시 입력해주세요.");
                return;
            }

            if (checkAllConfirmedForTelNo[0] === true && checkAllConfirmedForTelNo[1] === true) {
                $.ajax({
                    url: '/user/mypage/updateTelNo/' + telNo,
                    type: 'patch',
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                    },
                    success: function () {
                        alert("전화번호가 변경되었습니다.");
                        window.location.reload();
                    },
                    error: function (error) {
                        alert("수정불가, 관리자에게 문의하세요.");
                        return;
                    }
                });
            } else {
                alert("인증을 완료해주세요.");
                return;
            }
        });

        $("#cancelMyInfo-telno").on("click",function(){
            inputPwd.val("");
            inputTelNo.val("");
            inputCode.val("");
            btnConfirmTelNo.attr("class", "btn btn-submit");
            msgPwd.html("");
            telAuthCode='';
            telNoConfirmMsg.css("display", "none");
            checkAllConfirmedForTelNo = [false,false];
        })
    });

    function checkTelNo(telNo) {
        return telNo.match(/^[0-9]{11}$/);
    }
</script>