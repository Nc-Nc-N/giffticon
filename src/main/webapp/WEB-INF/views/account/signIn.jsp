<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/login/signIn.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">
    <script src="https://apis.google.com/js/api:client.js"></script>
    <script>Kakao.init('ac51465d91bcae237e6703842ae5d0c5');</script>
</head>
<body>
<div class="container">
    <div class="element">
        <a href="/user/home"><img src="/resources/img/logo.png"></a>
    </div>

    <form class="form-basicLogin" action="/login" method="POST">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="element">
            <input type="text" class="input001" name="username" placeholder="Email" value="${email}">
        </div>
        <div class="element">
            <input type="password" class="input001" name="password" placeholder="Password">
        </div>
        <div class="element">
            <span id="validateMsg">
                <c:if test="${msg != null}">
                    <i class="fas fa-exclamation-circle"></i>${msg}
                </c:if>
            </span>
        </div>
        <div class="element01">
            <div id="checkbox-container">
                <input type="checkbox" class="checkbox001" name="isRemember" ${isRemember}>
                <span>Remember ID</span>
            </div>
            <span><a class="link" href="/account/signUp">회원가입</a></span>
            <span><a class="link" href="/finduser">Email/비밀번호 찾기</a></span>
        </div>
    </form>

    <div class="element" id="btn">
        <button type="button" id="btn-login" class="btn001">로그인</button>
    </div>

    <div id="socialLoginHeader">
        <p>SNS계정으로 간편 로그인/회원가입</p>
    </div>
    <div class="element" id="socialLogin">
        <!-- Kakao Btn -->
        <img class="social kakao" src="/resources/img/socialLogin/kakao_login_square.png">
        <!-- Naver Btn -->
        <img class="social naver" src="/resources/img/socialLogin/naver_login_square.PNG">
        <!-- Google Btn -->
        <div id="gSignInWrapper">
            <div id="googleBtn" class="customGPlusSignIn">
                <img class="social google" src="/resources/img/socialLogin/google_login_square.png">
            </div>
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

<script type="text/javascript" src="/resources/js/social/login.js"></script>
<script type="text/javascript" src="/resources/js/social/logout.js"></script>

<script> //일반 로그인 유저 체크

let csrfHeaderName = "${_csrf.headerName}";
let csrfTokenValue = "${_csrf.token}";

let soclTypes = "<c:out value='${soclTypes}'/>";

$(document).ready(function () {

    $("#btn-login").on("click", function () {

        let email = $("input[name='username").val();
        let password = $("input[name='password").val();

        if (email == "" || password == "") {
            $("#validateMsg").html("<i class='fas fa-exclamation-circle'></i>" + "이메일/비밀번호를 입력해주세요.");
            return;
        }

        $.ajax({
            url: '/account/basicAccountCheck',
            method: 'get',
            data: {email: email},
            dataType: 'text',
            success: function (result) {
                if (result == "social") {
                    $("#validateMsg").html("<i class='fas fa-exclamation-circle'></i>" + "소셜 계정입니다. 해당 로그인을 이욯해주세요");
                } else if (result == "none") {
                    $("#validateMsg").html("<i class='fas fa-exclamation-circle'></i>" + "존재하지 않는 계정입니다.");
                } else if (result == "basic") {
                    $(".form-basicLogin").submit();
                }
            }

        })

    })
})

</script>

<script> //소셜로그인 btn handler

$(".kakao").on("click", function () {

    loginWithKakao();
})

$(".google").on("click", function () {

    loginWithGoogle();
})

$(".naver").on("click", function () {

    let soclType = "<c:out value="${soclTypes['네이버']}"/>";

    alert("soclType :" + soclType);
})


</script>

<script type="text/javascript"> //kakao login function

function loginWithKakao() {

    let soclType = "<c:out value="${soclTypes['카카오']}"/>";

    Kakao.Auth.login({
        success: function (authObj) {

            alert(authObj.access_token)

            // Kakao.Auth.setAccessToken(authObj.access_token);
            alert("accessTOKEN: " + Kakao.Auth.getAccessToken());
            Kakao.API.request({
                url: '/v2/user/me',
                success: function (response) {

                    let email = response.kakao_account.email;

                    alert("email : " + email);

                    let soclUserInfo = {
                        email: email,
                        soclTypeCode: '001',
                        tknType: authObj.token_type,
                        accesTkn: authObj.access_token,
                        accesTknExpirIn: authObj.expires_in,
                        rfrshTkn: authObj.refresh_token,
                        rfrshTknExpirIn: authObj.refresh_token_expires_in
                    }

                    socialLogin(email, soclType, soclUserInfo);
                },
                fail: function (error) {
                    console.log("error: " + error);
                }
            })
        },
        fail: function (error) {
            console.log("error: " + error);
        },
    })
}

</script>

<script>   //google login function
//얘는 왜 header에 넣어야 하나......
var googleUser = {};

function loginWithGoogle() {

    gapi.load('auth2', function () {

        auth2 = gapi.auth2.init({
            client_id: '782565824847-67jmbjhonm2e91r0d8am02um8rncgme4.apps.googleusercontent.com',
            cookiepolicy: 'single_host_origin',
        });
        attachSignin(document.getElementById('googleBtn'));
    });
};

function attachSignin(element) {

    let soclType = "<c:out value="${soclTypes['구글']}"/>";

    // console.log(element.id);
    auth2.attachClickHandler(element, {},
        function (googleUser) {
            let email = googleUser.getBasicProfile().getEmail();
            var id_token = googleUser.getAuthResponse().id_token;
            var ac_token = googleUser.getAuthResponse().acc;
            console.log("id token: " + id_token);
            console.log("ac token: " + ac_token);

            //카카오 / 네이버에서 token 사용자 식별번호 설정 되면 id_tkn 비교로 바꾸기
            let soclUserInfo = {
                email: email,
                soclTypeCode: '001'
            }

            socialLogin(email, soclType, soclUserInfo);

        }, function (error) {
            alert(JSON.stringify(error, undefined, 2));
        });
}

</script>
