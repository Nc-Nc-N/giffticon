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
        <h2>회원정보 수정</h2>
        
        <div id="content">
            <div class="email_section">
                <h3>Email</h3>
                <h4><c:out value="${user.email}"/></h4>
               
            </div>
            <div class="info_section">
                <div>
                    <h3>현재 비밀번호</h3>
                    <div class="input_text">
                        <input type="text" id="originPwd" placeholder="">
                    </div>
                    <button class="btn btn-submit" id="confirmOriginPwd">인증</button>
                </div>
                <div class="message">

                    <input tvpe="text" id="originPwdMsg" value="" readonly="readonly"></div>
            </div>
            <div class="info_section">
                <div>
                    <h3>새 비밀번호</h3>
                    <div class="input_text">
                        <input type="text" class="newPwd1" placeholder="">
                    </div>
                </div>
                
            </div>
            <div class="info_section">
                <div>
                    <h3>새 비밀번호 재입력</h3>
                    <div class="input_text">
                        <input type="text" class="newPwd2" placeholder="">
                    </div>
                </div>
                <div class="message"></div>
            </div>
            <div class="info_section">
                <div>
                    <h3>이름</h3>
                    <div class="input_text">
                        <input type="text" class="name" value="<c:out value="${user.name}"/>">
                    </div>
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
            
        </div>

        <div id="reg-btn-area">
            <button class="btn btn-active">등록</button>
            <button class="btn btn-disabled cancel">취소</button>
        </div>
    </div>
</body>

<!-- 휴대번호 인증 script -->
<script>

</script>

<script type="text/javascript">

    $(document).ready(function(){

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let oriEmail = "<c:out value="${user.email}"/>";
        let oriName = "<c:out value="${user.name}"/>";
        let oriTelNo = "<c:out value="${user.telNo}"/>";

        let NewPwd = $(".newPwd").val();


        let checkAllConfirmed = [false, false, false];

        $("#confirmOriginPwd").on("click",function(e) {
            let oriPwd = $("#originPwd").val();
            var msg = "";

            let checkUser = {
                        email: oriEmail,
                        pwd: oriPwd}

            $.ajax({
                url: '/user/mypage/checkPassword',
                contentType: "application/json",
                data: JSON.stringify(checkUser),
                type: 'post',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {

                    msg = "비밀번호가 일치합니다.";
                    checkAllConfirmed[0] = true;
                    $("#originPwdMsg").val(msg);
                },
                error: function () {

                    msg = "비밀번호가 다릅니다.";
                    checkAllConfirmed[0] = false;
                    $("#originPwdMsg").val(msg);
                }

            })
        })

    })
</script>