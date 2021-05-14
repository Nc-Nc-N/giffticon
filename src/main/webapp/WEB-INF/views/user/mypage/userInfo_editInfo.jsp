<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<link rel="stylesheet" href="/resources/css/user/mypage/mypage_info_editInfo.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
</style>


<body>
<div id="register-content">
    <h2>회원정보 수정</h2>

    <div id="content">

        <div class="info_section">
            <div>
                <h3>이름</h3>
                <div class="input_text">
                    <input type="text" class="newName" placeholder="기존 비밀번호를 입력해주세요">
                </div>
            </div>
        </div>

        <div class="info_section">
            <div>
                <h3>생년월일</h3>
                <div class="input_text">
                    <input type="date" class="newBirthDt" placeholder="새 비밀번호를 입력해주세요">
                </div>
            </div>
        </div>

        <div class="info_section">
            <div>
                <h3>현재 비밀번호</h3>
                <div class="input_text">
                    <input type="password" class="originPwd" placeholder="기존 비밀번호를 입력해주세요">
                </div>
                <button class="btn btn-submit" id="btn-confirmPwdEditInfo">인증</button>
            </div>
            <div class="message" id="msg-confirmPwdEditInfo">

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

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let oriEmail = "<c:out value="${user.email}"/>";

        //기존 비밀번호 확인 버튼
        let btnOriginPwd = $("#btn-confirmPwdEditInfo");

        //input 칸
        let newName = $(".newName");
        let newBirthDt = $(".newBirthDt");
        let insertPwd = $(".originPwd");

        let pwdMsg = $("#msg-confirmPwdEditInfo");


        //기존 비밀번호 인증
        btnOriginPwd.on("click", function (e) {

            var msg = "";
            let pwdVal = insertPwd.val();

            let checkUser = {
                email: oriEmail,
                pwd: pwdVal
            }

            pwdMsg.html("");

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
                    pwdMsg.html(msg);

                    //기존 비밀번호 인증 시 새로운 비밀번호 입력 가능, 인증 된 비밀번호는 수정 불가
                    insertOriginPwd.attr("readonly", true);

                },
                error: function () {

                    msg += "<i class='fas fa-exclamation-circle'></i>";
                    msg += "<p>&nbsp;비밀번호가 다릅니다.</p>";
                    pwdMsg.html(msg);

                }

            })

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


        })

    })
</script>