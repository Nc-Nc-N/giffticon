<%--
  Created by IntelliJ IDEA.
  User: lee hyeji
  Date: 2021-04-04
  Time: 오후 3:10
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/common/button.css"/>
    <link rel="stylesheet" href="/resources/css/user/sign_up.css"/>
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

    <div role="form">
        <div class="element_email">
            <div class="email_input">
                <input type="text" class="input001" name="email" placeholder="Email">
            </div>
            <button name="email-auth-btn" class="btn btn-active">인증</button>
        </div>
        <!-- 이메일 인증코드 입력 -->
        <div class="element">
            <input type="text" class="input001" name="emlAuthTkn" placeholder="인증코드">
        </div>
        <div class="element">
            <input type="password" class="input001" name="pwd" placeholder="비밀번호">
        </div>
        <div class="element">
            <input type="password" class="input001" name="confirmPassword" placeholder="비밀번호 재입력">
        </div>
        <div class="element">
            <input type="text" class="input001" name="name" placeholder="이름">
        </div>
        <div class="element">
            <input type="text" class="input001" name="telNo" placeholder="전화번호">
        </div>

        <div class="element">
            <div id="validateMsg"></div>
        </div>

        <div class="element" id="btn">
            <button type="submit" class="btn001">가입하기</button>
        </div>
    </div>

</div>
</body>
</html>

<script>
    $(document).ready(function (e) {
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // 인증 코드를 저장
        let emlAuthTkn = '';
        // 인증 여부를 저장
        let isEmailConfirm = false;

        let emailAuthBtn = $('button[name="email-auth-btn"]');

        emailAuthBtn.on('click', function (e) {
            e.preventDefault();

            let email = $('input[name="email"]').val();

            // 이메일 형식 확인
            if (!checkEmail(email)) {
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> 잘못된 이메일 형식입니다.");
                return;
            }

            // 이미 존재하는 이메일인지 확인
            if (checkEmailAlreadyExists(email)) {
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> 이미 가입된 이메일입니다.");
                return;
            }

            alert("인증코드가 메일로 전송되었습니다.");

            // 이메일 인증을 하면 인증 버튼을 비활성화 시킴
            emailAuthBtn.css('background-color', 'gray');
            emailAuthBtn.prop('disabled', true);

            $.ajax({
                type: 'get',
                url: '/account/emailConfirm?email=' + email,
                success: function (result) {
                    // 인증코드 메일 전송을 성공하면 해당 코드값을 받아옴
                    // 사용자가 입력하는 코드 값과 비교하여 이메일 인증을 진행
                    emlAuthTkn = result.code;
                    // 인증여부를 ture로 변경
                    isEmailConfirm = true;
                }, error: function () {
                    alert("인증 오류입니다. 다시 시도해주세요.");
                }
            });
        });

        // 사용자가 이메일을 수정하면 다시 인증을 받도록 함
        $('input[name="email"]').on('keyup', function (e) {
            // 인증 여부를 false로 변경
            isEmailConfirm = false;

            // 인증 버튼을 다시 활성화 시킴
            emailAuthBtn.css('background-color', "rgb(255,88,93)");
            emailAuthBtn.prop('disabled', false);
        });

        $('button[type="submit"]').on('click', function (e) {
            e.preventDefault();

            let email = $('input[name="email"]').val();
            let tkn = $('input[name="emlAuthTkn"]').val();
            let confirmPwd = $('input[name="confirmPassword"]').val();
            let telNo = $('input[name="telNo"]').val();
            let name = $('input[name="name"]').val();
            let pwd = $('input[name="pwd"]').val();

            // 이메일 인증을 진행하지 않은 경우
            if (!isEmailConfirm) {
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> 이메일 인증이 필요합니다.");
                return;
            }

            // 메일로 전송된 인증코드와 사용자가 입력한 인증코드가 다르면
            if (emlAuthTkn !== tkn) {
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> 잘못된 인증코드입니다.");
                return;
            }

            // 비밀번호를 적었는지 확인
            if (!checkPassword(pwd)) {
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> 비밀번호는 영문, 숫자, 특수문자를 포함한 최소 8자리 ~ 최대 16자리로 설정해야 합니다.");
                return;
            }

            // 비밀번호 확인 값이 일치하는지 확인
            if (confirmPwd !== pwd) {
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> 비밀번호가 다릅니다. 다시 확인해주세요.");
                return;
            }

            // 이름 길이가 2보다 작은지 확인
            if (!(name.length >= 2)) {
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> 이름은 최소 2자리 이상이어야 합니다.");
                return;
            }

            // 전화번호를 적었는지 확인
            if (!checkTelNo(telNo)) {
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> 잘못된 휴대전화번호 형식입니다.");
                return;
            }

            let user = {
                email: email,
                pwd: pwd,
                name: name,
                telNo: telNo,
                emlAuthTkn: emlAuthTkn
            };

            $.ajax({
                type: 'post',
                url: '/account/register',
                data: JSON.stringify(user),
                contentType: 'application/json; charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {
                    // 사용자 등록에 성공하면 로그인 페이지로 이동
                    window.location.replace("/account/signIn");
                },
                error: function () {
                    alert("다시 시도해주세요.");
                }
            });
        });
    });

    function checkEmail(email) {
        let regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

        return regExp.test(email);
    }

    // 사용자가 입력한 이메일이 이미 사용중인지 확인
    function checkEmailAlreadyExists(email) {
        let count = '';

        $.ajax({
            type: 'get',
            url: '/account/checkExists?email=' + email,
            async: false,
            success: function (result) {
                // 이미 존재하는 이메일이면 1
                count = result;
            },
            error: function (result) {
                // 사용중인 이메일이 아니면 0
                count = result;
            }
        });

        return parseInt(count) === 1;
    }

    // 영어 대,소문자와 특수문자를 포함한 최소 8자리 ~ 최대 16자리 비밀번호
    function checkPassword(pwd) {
        let regExp = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,16}$/;

        return regExp.test(pwd);
    }

    // 휴대전화 번호 형식과 일치하는지 확인
    function checkTelNo(telNo) {
        let regExp = /^\d{3}-\d{3,4}-\d{4}$/;

        return regExp.test(telNo);
    }

</script>