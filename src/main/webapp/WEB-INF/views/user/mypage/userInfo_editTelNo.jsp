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
    <h2>휴대전화 인증</h2>

    <div id="content">

        <div class="info_section">
            <div>
                <h3>전화번호</h3>
                <div class="input_text">
                    <input type="text" class="input_telNo" placeholder="<c:out value="${user.telNo}"/>">
                </div>
                <button class="btn btn-submit" id="btn-confirmTelNo">인증</button>
            </div>
            <div class="verifyCode">
                <div class="code_section">
                    <span>인증코드 : </span>
                    <input type="text" class="input_code"placeholder="">
                </div>
                <span class="msg_code_verify">인증완료</span>
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

        let btnConfimTelNo = $("#btn-confirmTelNo");
        let btnOriginPwd = $("#btn-confirmOriginPwd-telno");


        let inputPwd = $(".originPwd-telno");
        let inputTelNo = $(".input_telNo");
        let inputCode = $(".input_code");

        let msgPwd = $("#msg-tel-confirmPwd");

        let checkAllConfimedForTelNo = [false,false];

        //sms 인증 버튼 -- 전화인증 완료 후 code 추가 예정
        btnConfimTelNo.on("click",function(e){

            //전화번호 input
            let telNo = inputTelNo.val();
            console.log("telNo: " + telNo);

            //전화번호 유효성 검사
            if(!checkTelNo(telNo)){
                alert("유효한 전화번호가 아닙니다.");
                return;
            }

            //sms 보내기 ajax

            //타이핑한 인증코드값
            let code = inputCode.val();
            console.log("code : " + code);

            checkAllConfimedForTelNo[0] = true;

        })


        btnOriginPwd.on("click", function (e) {

            var msg = "";
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
                    checkIsCorrect(msgPwd,msg,true)
                    checkAllConfimedForTelNo[1] = true

                },
                error: function () {

                    msg += "비밀번호가 다릅니다.";
                    checkIsCorrect(msgPwd,msg,false)
                    checkAllConfimedForTelNo[1] = false

                }

            })

        })

        $("#modifyMyInfo-telno").on("click", function(){

            console.log(checkAllConfimedForTelNo);

            let telNo = inputTelNo.val();

            if(checkAllConfimedForTelNo[0] == true && checkAllConfimedForTelNo[1] == true) {

                console.log("send telNo: " + telNo);

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
                })
            }else{
                alert("인증을 완료해주세요.");
                return;
            }
        })
    })
</script>
<script>
    function checkTelNo(telNo) {
        return telNo.match(/^[0-9]{11}$/);
    }
</script>