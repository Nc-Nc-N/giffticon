<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/login/socialAccLink.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<div class="container">

    <div class="imgcontainer">
        <a href="/user/home">
            <img id="imgtohome" src="/resources/img/logo.png">
        </a>
    </div>

    <div class="content">
        <h2>소셜계정연동</h2>
        <div class="title"></div>
        <div class="element_name">기존 회원 정보</div>

        <div class="element">
            <div class="label">이메일</div>
            <div class="input-div">
                <div><c:out value="${user.email}"/></div>
            </div>
        </div>

        <div class="element">
            <div class="label">이름</div>
            <div class="input-div">
                <div class="name_received">
                    <div><c:out value="${user.name}"/></div>
                </div>
            </div>
        </div>

        <div class="title"></div>
        <div class="element_name"><span>소셜 계정 정보</span><span class="guide_msg">*아래 정보로 계정이 변경되며, 이외의 정보는 변경되지 않습니다.</span></div>
        <div class="element">
            <div class="label">이메일</div>
            <div class="input-div">
                <div><c:out value="${soclEmail}"/></div>
            </div>
        </div>
        <div class="element">
            <div class="label">이름</div>
            <div class="input-div">
                <div class="name_received">
                    <div><c:out value="${soclName}"/></div>
                </div>
            </div>
        </div>
        <div class="title"></div>
        <div class="element" id="btn">
            <div class="password_section">
                <div class="input_pwd">
                <input type="password" class="originPwd" placeholder="기존비밀번호 입력">
                </div>
            </div>
            <div class="msg_output">
                <div id="validateMsg"></div>
            </div>
            <div class="btn_section"><button id="accConBtn" class="btn001">연동하기</button></div>
        </div>
    </div>

    <!-- social login-form -->
    <form class="form-socialLogin" action="/login" method="post">
        <input type="hidden" name="username" value=""/>
        <input type="hidden" name="password" value=""/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>

</div>
</body>
</html>

<script>
    $(document).ready(function () {

        let socialLoginForm = $(".form-socialLogin");

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let email = "<c:out value='${user.email}'/>";
        let userId = "<c:out value='${user.id}'/>";
        let name = "<c:out value='${soclName}'/>";
        let soclTypeCode = "<c:out value="${soclTypeCode}"/>";

        // 연동하기
        $('#accConBtn').on('click', function (e) {

            let pwd = $(".originPwd").val();

            let checkUser = {
                email: email,
                pwd: pwd,
                soclType: soclTypeCode,
                userId : userId,
                name: name
            }

            $.ajax({
                url: '/account/soclCheckOriPwd',
                data: checkUser,
                type: 'post',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function (result) {
                    alert("소셜계정으로 변경되었습니다. 소셜로그인을 다시 진행해주세요");
                    window.location.replace("/account/signIn");

                },
                error: function (error) {

                    if(error.status == 406){
                        $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> " + "비밀번호가 일치하지 않습니다.");
                    }else if(error.status == 500){
                        $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> " + "연동에 실패했습니다. 관리자에게 문의해주세요");
                    }
                }
            });
        });

    });

</script>