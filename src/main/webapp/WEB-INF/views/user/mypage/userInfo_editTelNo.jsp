<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<link rel="stylesheet" href="/resources/css/user/mypage/userInfo_editTelNo.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
</style>

<body>
<div id="register-content">
    <h2>휴대전화 인증</h2>

    <div id="content">

        <div class="info_section">
            <div>
                <h3>이름</h3>
                <div class="input_text">
                    <input type="text" class="name" value="<c:out value="${user.name}"/>">
                </div>
            </div>
            <div class="message" id="msg-name">

            </div>

        </div>

        <div class="info_section">
            <div>
                <h3>전화번호</h3>
                <div class="input_text">
                    <input type="text" class="telNo" value="<c:out value="${user.telNo}"/>">
                </div>
                <button class="btn btn-submit" id="confirmTelNo">인증</button>
            </div>
            <div class="message"><h5>인증 완료</h5></div>
        </div>

        <div class="info_section">
            <div>
                <h3>현재 비밀번호</h3>
                <div class="input_text">
                    <input type="password" class="originPwd-telno" placeholder="기존 비밀번호를 입력해주세요">
                </div>
                <button class="btn btn-submit" id="btn-confirmOriginPwd-telno">인증</button>
            </div>
            <div class="message" id="msg-originPwd-telno">

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

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let oriEmail = "<c:out value="${user.email}"/>";
        let oriName = "<c:out value="${user.name}"/>";
        let oriTelNo = "<c:out value="${user.telNo}"/>";

        let btnOriginPwd = $("#btn-confirmOriginPwd-telno");

        let newName = $(".name");
        let newNameMsg = $("#msg-name");

        let insertOriginPwd = $(".originPwd-telno");
        let originPwdMsg = $("#msg-originPwd-telno");

        //이름 변경시 메세지 출력 및 확인
        newName.keyup(function (e) {

            let newNameVal = newName.val();
            let msg = "";

            let checkCondition = false;

            checkCondition = nameChecker(newNameVal);

            if (!checkCondition) {
                msg += "<i class='fas fa-exclamation-circle'></i>";
                msg += "<p>&nbsp;이름이 올바르지 않습니다.</p>";
                newNameMsg.html(msg);

            } else {
                newNameMsg.html("");

            }
        })

        btnOriginPwd.on("click", function (e) {

            var msg = "";
            let oriPwdVal = insertOriginPwd.val();

            let checkUser = {
                email: oriEmail,
                pwd: oriPwdVal
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
                success: function () {

                    msg += "<i class='far fa-check-circle'></i>";
                    msg += "<p>&nbsp;비밀번호가 일치합니다.</p>";
                    originPwdMsg.html(msg);

                },
                error: function () {

                    msg += "<i class='fas fa-exclamation-circle'></i>";
                    msg += "<p>&nbsp;비밀번호가 다릅니다.</p>";
                    originPwdMsg.html(msg);

                }

            })

        })
    })
</script>