<%--
  Created by IntelliJ IDEA.
  User: lwiii
  Date: 2021-05-17
  Time: 오전 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/login/signUp.css"/><!--sign_up.css로 pwd/email css 사용-->
    <link rel="stylesheet" href="/resources/css/login/findPwd.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>

<div class="container">
    <div class="imgcontainer">
        <a href="/user/home">
            <img id="imgtohome" src="/resources/img/logo.png">
        </a>
    </div>
    <div class="content">
        <h2>비밀번호찾기</h2>
        <div class="title"></div>
        <div class="element">
        </div>

        <div class="element">
            <div class="label">이메일</div>
            <div class="input-div">
                <input type="text" class="input001" name="email" placeholder="email">
                <div class="email-msg input-msg"><i class="fas fa-exclamation-circle"></i> 잘못된 이메일 형식입니다.</div>
                <div class="email-exist-msg input-msg"><i class="fas fa-exclamation-circle"></i> 이미 가입된 이메일입니다.</div>
            </div>
            <div class="btn-area">
                <button name="email-auth-btn" class="btn-disabled btn002">이메일인증</button>
            </div>
        </div>
        <!-- 이메일 인증코드 입력 -->
        <div class="element">
            <div class="label">&nbsp;</div>
            <div class="input-div">
                <input type="text" class="input001" name="emlAuthTkn" placeholder="email 인증코드">
                <div class="auth-msg input-msg"><i class="fas fa-exclamation-circle"></i> 잘못된 인증코드입니다.</div>
            </div>
            <div class="btn-area">
                &nbsp;
            </div>
        </div>

        <div class="element">
            <div id="validateMsg"></div>
        </div>

        <div class="title"></div>

        <div class="element" id="btn">
            <button type="submit" class="btn001" name="findPwd">비밀번호찾기</button>
        </div>
    </div>
</div>
</body>
</html>

<script>
    $(document).ready(function (e) {
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let emlInput = $("input[name='email']");
        let emlValidMsg = $(".email-msg");
        let emlAuthBtn = $("button[name='email-auth-btn']");

        let emlAuthCode = '';           // 이메일 인증코드

        let isRightEmail = false;       // 이메일 형식 일치 여부
        let isCertifiedEmail = false;   // 이메일 인증 진행 여부

        // 이메일 입력 값 변경될 때마다
        emlInput.on('propertychange change keyup paste input', function (e) {
            isCertifiedEmail = false;                       // 인증여부 초기화
            $(".email-exist-msg").css("display", "none");

            if (checkEmail($(this).val())) {                // 값이 형식에 부합하는지 확인
                emlValidMsg.css("display", "none");         // 안내 메세지 hide
                emlAuthBtn.attr("class", "btn002");         // 이메일 인증버튼 활성화
                isRightEmail = true;
                return;
            }

            // 값이 형식에 부합하지않으면
            emlValidMsg.css("display", "block");               // 안내 메세지 show
            emlAuthBtn.attr("class", "btn-disabled btn002");    // 인증버튼 비활성화
            isRightEmail = false;
        });

        emlAuthBtn.on('click', function (e) {
            e.preventDefault();
            let eml = emlInput.val();

            if (!checkEmailAlreadyExists(eml)) {
                $(".email-exist-msg").css("display", "block");
                return;
            }
            $(".email-exist-msg").css("display", "none");
            emlCodeInput.val("");

            emlAuthBtn.attr("class", "btn-disabled btn002");
            alert("인증코드가 메일로 전송되었습니다. \n5분 이내에 도착하지 않는다면 다시 한 번 시도해주세요.");

            $.ajax({
                type: 'get',
                url: '/account/emailConfirm?email=' + eml,
                success: function (result) {
                    emlAuthCode = result.code;   // 인증코드 메일 전송을 성공하면 해당 코드값을 받아옴
                }, error: function (result) {
                    emailAuthBtn.attr("class", "btn002");
                    alert("인증코드 전송에 실패했습니다. \n이메일 확인 후 다시 시도해주세요.");
                }
            });
        });

        let emlCodeInput = $("input[name='emlAuthTkn']");
        emlCodeInput.on("propertychange change keyup paste input", function (e) {
            if (emlAuthCode === $(this).val()) {        // 입력 값과 인증코드가 같으면
                $(".auth-msg").css("display", "none");  // 안내 메세지 hide
                isCertifiedEmail = true;                // 이메일 인증여부 true
                return;
            }
            $(".auth-msg").css("display", "block");     // 안내 메세지 show
            isCertifiedEmail = false;                   // 이메일 인증여부 false
        });

        $('button[name="submit"]').on('click', function (e) {
            e.preventDefault();

            let email = $('input[name="email"]').val();

            if (printValidateMsg(!isCertifiedEmail, "이메일 인증을 진행해주세요.")) return;
            if (printValidateMsg(!isRightEmail, "이메일 형식을 확인해주세요.")) return;

            // 모두 만족시 임시 비밀번호 발급
            $.ajax({
                type: 'patch',
                url: '/account/sendTemporaryPwd',
                data: JSON.stringify(email),
                contentType: 'application/json; charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function (result) {
                    alert("가입하신 이메일로 임시 비밀번호를 전송했습니다.\n임시 비밀번호로 로그인 후 마이페이지에서 비밀번호를 변경해주세요.");
                    window.location.replace("/account/signIn");
                }, error: function (result) {
                    alert(data.responseText);
                }
            });
        });

        // 유효성 검사 실패시 안내 문자 출력
        function printValidateMsg(check, msg) {
            if (check) {
                $('#validateMsg').css("display", "block");
                $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> " + msg);
                return true;
            }
            $('#validateMsg').css("display", "none");
            $('#validateMsg').empty();
            return false;
        }
    });

    // 이메일 정규식 체크
    function checkEmail(email) {
        let regExp = /^[-_\.0-9a-zA-Z]*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
        return regExp.test(email);
    }

    // 사용자가 입력한 이메일이 이미 사용중인지 확인
    function checkEmailAlreadyExists(email) {
        let isExists = true;
        $.ajax({
            type: 'get',
            url: '/account/checkExists?email=' + email,
            async: false,
            success: function (result) {
                // 이미 존재하는 이메일이면 true, 사용중인 이메일이 아니면 false
                isExists = result;
            },
            error: function (result) {
                alert("이메일 확인중 문제가 발생했습니다. 다시 시도해주세요.");
            }
        });

        return isExists;
    }
</script>