<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<link rel="stylesheet" href="/resources/css/user/mypage/mypage_info_edit_user.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
</style>


<body>
<div id="register-content">
    <h2>비밀번호 변경</h2>

    <div id="content">
    <c:if test="${pwdExist == true}">
        <div class="info_section">
            <div>
                <h3>현재 비밀번호</h3>
                <div class="input_text">
                    <input type="password" class="originPwd" placeholder="기존 비밀번호를 입력해주세요">
                </div>
                <button class="btn btn-submit" id="btn-confirmOriginPwd">인증</button>
            </div>
            <div class="message" id="msg-originPwd">

            </div>
        </div>
    </c:if>
        <div class="info_section">
            <div>
                <h3>새 비밀번호</h3>
                <div class="input_text">
                    <input type="password" class="insertNewPwd" placeholder="새 비밀번호를 입력해주세요" disabled>
                </div>
            </div>
            <div class="message" id="msg-newPwd">

            </div>
        </div>
        <div class="info_section">
            <div>
                <h3>새 비밀번호 확인</h3>
                <div class="input_text">
                    <input type="password" class="confirmNewPwd" placeholder="새 비밀번호를 한번 더 입력해주세요" disabled>
                </div>
            </div>
            <div class="message" id="msg-confirmNewPwd">

            </div>
        </div>
    </div>
    <div id="reg-btn-area">
        <button class="btn btn-active" id="modifyMyInfo">등록</button>
        <button class="btn btn-dark cancel" id="cancelMyInfo">취소</button>
    </div>
</div>
</body>

<script type="text/javascript" src="/resources/js/user/userInfoValidator.js"></script>
<script type="text/javascript">

    $(document).ready(function () {

        let pwdExist = "<c:out value="${pwdExist}"/>";

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let oriEmail = "<c:out value="${user.email}"/>";

        //[기존비밀번호, 새 비밀번호, 새 비밀번호 확인] 모두 true 가 되어야 수정 가능
        let checkAllConfirmed = [false, false, false];

        //기존 비밀번호 확인 버튼
        let btnOriginPwd = $("#btn-confirmOriginPwd");

        //input 칸
        let insertOriginPwd = $(".originPwd");
        let insertNewPwd = $(".insertNewPwd");
        let confirmNewPwd = $(".confirmNewPwd");

        //msg 출력칸
        let originPwdMsg = $("#msg-originPwd");
        let newPwdMsg = $("#msg-newPwd");
        let confirmNewPwdMsg = $("#msg-confirmNewPwd");

        if(!pwdExist){
            checkAllConfirmed[0] = true;
            insertNewPwd.removeAttr("disabled");
            console.log(checkAllConfirmed);
        }

        //기존 비밀번호 인증
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

                    //기존 비밀번호 인증 시 새로운 비밀번호 입력 가능, 인증 된 비밀번호는 수정 불가
                    insertOriginPwd.attr("readonly", true);
                    insertNewPwd.removeAttr("disabled");

                    checkAllConfirmed[0] = true;
                },
                error: function () {

                    msg += "<i class='fas fa-exclamation-circle'></i>";
                    msg += "<p>&nbsp;비밀번호가 다릅니다.</p>";
                    originPwdMsg.html(msg);

                    checkAllConfirmed[0] = false;
                }

            })

        })

        //새로운 비밀번호 변경 시 메세지 출력 및 확인
        insertNewPwd.keyup(function (e) {

            checkAllConfirmed[2] = false;

            let newPwdVal = insertNewPwd.val();
            let oriPwdVal = insertOriginPwd.val();
            let msg = "";
            let checkCondition = false;

            confirmNewPwd.val("");
            confirmNewPwd.attr("disabled", true);

            //기존 비밀번호와 동일여부 체크
            if (newPwdVal != oriPwdVal) {

                checkCondition = pwdChecker(newPwdVal);

                //비밀번호 양식 일치 여부 확인
                if (!checkCondition) {

                    msg += "<i class='fas fa-exclamation-circle'></i>";
                    msg += "<p>&nbsp;비밀번호 조건을 확인하세요</p>";
                    newPwdMsg.html(msg);

                    checkAllConfirmed[1] = false;
                } else {

                    //새로운 비밀번호가 양식에 맞으면 새로운 비밀번호 재입력 가능
                    newPwdMsg.html("");
                    confirmNewPwd.removeAttr("disabled");

                    checkAllConfirmed[1] = true;
                }
            } else {

                msg += "<i class='fas fa-exclamation-circle'></i>";
                msg += "<p>&nbsp;기존과 다른 비밀번호로 설정해주세요.</p>";
                newPwdMsg.html(msg);

                checkAllConfirmed[1] = false;
            }

        })

        //새로운 비밀번호 재확인
        confirmNewPwd.keyup(function (e) {

            let newPwdVal = insertNewPwd.val();
            let confirmNewPwdVal = confirmNewPwd.val();
            let msg = "";

            if (!(newPwdVal == confirmNewPwdVal)) {

                msg += "<i class='fas fa-exclamation-circle'></i>";
                msg += "<p>&nbsp;비밀번호가 일치하지 않습니다.</p>";
                confirmNewPwdMsg.html(msg);

                checkAllConfirmed[2] = false;
            } else {

                confirmNewPwdMsg.html("");

                checkAllConfirmed[2] = true;
            }
        })

        //수정 확인 버튼 클릭
        $("#modifyMyInfo").on("click", function (e) {
            console.log(checkAllConfirmed);

            //기존 비밀번호, 새 비밀번호, 새 비밀번호 확인 모두 true이면
            if (checkAllConfirmed[0] == true &&
                checkAllConfirmed[1] == true &&
                checkAllConfirmed[2] == true) {

                //바꾸기 전에 한번 물어보자
                if (!confirm("비밀번호를 변경하시겠습니까?")) {
                    return;
                }

                let newPwdVal = insertNewPwd.val();

                $.ajax({
                    url: '/user/mypage/userUpdate',
                    method: 'post',
                    data: {"newPwd": newPwdVal, "email": oriEmail},
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                    },
                    success: function () {

                        alert("비밀번호가 변경되었습니다.");
                        //모달 닫고 input 정보 지우기
                        $('#cancelMyInfo').trigger("click");

                    },
                    error: function () {
                        alert("실패");
                        return;
                    }
                })

                //정보가 정확히 입력 안되었을때
            } else {
                alert("정보를 정확히 입력하세요");
                return;
            }
        })

        //취소 버튼 클릭 시 모든 입력값 초기화
        $('#cancelMyInfo').on("click", function (e) {

            insertOriginPwd.val("");
            insertNewPwd.val("");
            confirmNewPwd.val("");

            originPwdMsg.html("");
            newPwdMsg.html("");
            confirmNewPwdMsg.html("");

            insertOriginPwd.removeAttr("readonly");
            insertNewPwd.attr("disabled", true);
            confirmNewPwd.attr("disabled", true);

            checkAllConfirmed = [false, false, false];

        })

    })
</script>