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
                    <input type="text" class="info_newName" placeholder="<c:out value="${user.name}"/>">
                </div>
            </div>
            <div class="message" id="msg-info_validateName">

            </div>
        </div>

        <div class="info_section">
            <div>
                <h3>생년월일</h3>
                <div class="input_text">
                    <input type="text" class="info_newBirthDt" id="datepicker" readonly="readonly" placeholder="<c:out value="${user.birthDt}"/>">
                </div>
            </div>
            <div class="message" id="msg-info_validateBirthDt">

            </div>
        </div>

        <div class="info_section">
            <div>
                <h3>현재 비밀번호</h3>
                <div class="input_text">
                    <input type="password" class="info_originPwd" placeholder="기존 비밀번호를 입력해주세요">
                </div>
                <button class="btn btn-submit" id="btn-info_confirmPwd">인증</button>
            </div>
            <div class="message" id="msg-info_confirmPwd">

            </div>
        </div>

    </div>
    <div id="reg-btn-area">
        <button class="btn btn-active" id="btn_info_register">등록</button>
        <button class="btn btn-dark cancel" id="btn_info_cancel">취소</button>
    </div>
</div>
</body>

<script type="text/javascript" src="/resources/js/user/userInfoValidator.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript" src="/resources/js/user/calendar.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script type="text/javascript">

    $("#datepicker").datepicker({
        changeYear: true,
        changeMonth: true,
        yearRange: 'c-100:c+100',
        minDate: '-100y',
        maxDate: '0',
        dateFormat:'yy/mm/dd'
    });


</script>
<script type="text/javascript">
    $(document).ready(function () {

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let oriEmail = "<c:out value="${user.email}"/>";

        //기존 비밀번호 확인 버튼
        let btnOriginPwd = $("#btn-info_confirmPwd");

        //input 칸
        let newName = $(".info_newName");
        let newBirthDt = $(".info_newBirthDt");
        let insertPwd = $(".info_originPwd");

        let nameMsg = $("#msg-info_validateName");
        let pwdMsg = $("#msg-info_confirmPwd");
        let birthDtMsg = $("#msg-info_validateBirthDt");

        let birthDt = "<c:out value="${user.birthDt}"/>";
        birthDt = birthDt.slice(0,4)+"/"+birthDt.slice(4,6)+"/"+birthDt.slice(6,birthDt.length);
        newBirthDt.attr("placeholder",birthDt);

        let checkPwdForEditInfo = [false,false];

        newName.on("keyup", function(){
            let msg = "";

           if(nameChecker($(this).val())){
               msg += "사용가능한 이름입니다.";
               checkIsCorrect(nameMsg,msg,true);
               checkPwdForEditInfo[0] = true;
           }else{
               msg += "올바르지 않은 이름입니다.";
               checkIsCorrect(nameMsg,msg,false);
               checkPwdForEditInfo[0] = false;
           }

           if($(this).val()==""){
               nameMsg.html("");
           }
        })

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
                    insertPwd.attr("readonly", true);
                    checkPwdForEditInfo[1] = true;

                },
                error: function () {

                    msg += "<i class='fas fa-exclamation-circle'></i>";
                    msg += "<p>&nbsp;비밀번호가 다릅니다.</p>";
                    pwdMsg.html(msg);
                    checkPwdForEditInfo[1] = false;

                }

            })

        })

        //수정 확인 버튼 클릭
        $("#btn_info_register").on("click", function (e) {

            if(newName.val() == "" && newBirthDt.val() == ""){
                alert("수정 정보를 입력해주세요");
                return;
            }

            //비밀번호 통과 시
            if (checkPwdForEditInfo[0] == true && checkPwdForEditInfo[1] == true) {

                //바꾸기 전에 한번 물어보자
                if (!confirm("회원정보를 수정하시겠습니까?")) {
                    return;
                }

                //입력된 생일 저장형식에 맞게 변경
                let birthArray = newBirthDt.val().split("/");
                let birthDt = "";
                for(let i=0; i<birthArray.length; i++){
                    birthDt += birthArray[i];
                }

                let updateInfo = {
                    name: newName.val(),
                    birthDt: birthDt
                }

                console.log(updateInfo);

                $.ajax({
                    url: '/user/mypage/updateInfo',
                    method: 'post',
                    data: JSON.stringify(updateInfo),
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                    },
                    success: function (result) {
                        alert("회원정보가 수정되었습니다.");
                        window.location.reload();
                    },
                    error: function (error) {
                        alert("회원정보 수정에 실패했습니다. 관리자에게 문의해주세요.");
                        return;
                    }
                })

                //비밀번호 인증 안했을때
            } else {
                alert("정보를 정확히 입력해주세요.");
                return;
            }
        })

        //취소 버튼 클릭 시 모든 입력값 초기화
        $('#btn_info_cancel').on("click", function (e) {


        })

    })
</script>