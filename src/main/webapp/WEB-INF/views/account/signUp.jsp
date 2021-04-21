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

    <div class="content">
        <h2>회원가입</h2>
        <div class="title"><span class="red">*</span> 필수입력사항</div>
        <div class="element">
            <div class="label">이메일<span class="red">*</span></div>
            <div class="input-div">
                <input type="text" class="input001" name="email" placeholder="email">
                <div class="email-msg input-msg"><i class="fas fa-exclamation-circle"></i> 잘못된 이메일 형식입니다.</div>
                <div class="email-exist-msg input-msg"><i class="fas fa-exclamation-circle"></i> 이미 가입된 이메일입니다.</div>
            </div>
            <div class="btn-area">
                <button name="email-auth-btn" class="btn002">이메일인증</button>
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
            <div class="label">비밀번호<span class="red">*</span></div>
            <div class="input-div">
                <input type="password" class="input001" name="pwd" placeholder="비밀번호를 입력해주세요.">
                <div class="pwd-info">
                    <ul>
                        <li>8자 이상 16자 이하 입력</li>
                        <li>영문/숫자/특수문자(!@#$%^&*) 모두 조합</li>
                    </ul>
                </div>
                <div class="pwd-msg input-msg"><i class="fas fa-exclamation-circle"></i> 비밀번호 조건을 확인해주세요.</div>
            </div>
            <div class="btn-area">
                &nbsp;
            </div>
        </div>
        <div class="element">
            <div class="label">비밀번호확인<span class="red">*</span></div>
            <div class="input-div">
                <input type="password" class="input001" name="confirmPassword" placeholder="비밀번호를 한번 더 입력해주세요.">
                <div class="pwd-confirm-msg input-msg"><i class="fas fa-exclamation-circle"></i> 비밀번호가 다릅니다.</div>
            </div>
            <div class="btn-area">
                &nbsp;
            </div>
        </div>
        <div class="element">
            <div class="label">이름<span class="red">*</span></div>
            <div class="input-div">
                <input type="text" class="input001" name="name" placeholder="이름을 입력해주세요.">
                <div class="name-msg input-msg"><i class="fas fa-exclamation-circle"></i> 이름은 2자 이상 입력해야 합니다.</div>
            </div>
            <div class="btn-area">
                &nbsp;
            </div>
        </div>
        <div class="element">
            <div class="label">휴대폰<span class="red">*</span></div>
            <div class="input-div">
                <input type="text" class="input001" name="telNo" placeholder="숫자만 입력해주세요.">
                <div class="tel-msg input-msg"><i class="fas fa-exclamation-circle"></i> 휴대폰 번호를 알맞게 입력해주세요.</div>
            </div>
            <div class="btn-area">
                <button name="tel-auth-btn" class="btn002">휴대폰인증</button>
            </div>
        </div>

        <div class="element">
            <div id="validateMsg"></div>
        </div>

        <div class="title"></div>

        <div class="element">
            <div class="label">이용약관동의</div>
            <div class="input-div">
                <div class="checks">
                    <input type="checkbox" id="f-all" value="1"/>
                    <label class="f-all" for="f-all">전체약관 동의</label>
                </div>
                <div class="checks">
                    <input type="checkbox" id="f1" name="term" value="1"/>
                    <label for="f1">이용약관 동의<span class="red">*</span></label><a href="f1" class="term">약관보기 &gt;</a>
                </div>
                <div class="checks">
                    <input type="checkbox" id="f2" name="term" value="1"/>
                    <label for="f2">개인정보 수집·이용 동의<span class="red">*</span></label><a href="f2" class="term">약관보기 &gt;</a>
                </div>
            </div>
        </div>

        <div class="title"></div>

        <div class="element" id="btn">
            <button type="submit" class="btn001">가입하기</button>
        </div>
    </div>

    <div class="modal f1">
        <div class="term-content">
            <h2>이용약관<span class="red">*</span></h2>
            <div class="textarea-div">
                <textarea readonly>
제 1장 총칙

제 1 조(목적)

본 약관은 국가공간정보포털 웹사이트(이하 "국가공간정보포털")가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 회원과 국가공간정보포털의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.

제 2 조(약관의 효력과 변경)

1. 국가공간정보포털은 이용자가 본 약관 내용에 동의하는 경우, 국가공간정보포털의 서비스 제공 행위 및 회원의 서비스 사용 행위에 본 약관이 우선적으로 적용됩니다.

2. 국가공간정보포털은 약관을 개정할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 국가공간정보포털의 초기화면에 그 적용일 7일 이전부터 적용 전일까지 공지합니다. 단, 회원에 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 국가공간정보포털은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 회원이 알기 쉽도록 표시합니다.

3. 변경된 약관은 국가공간정보포털 홈페이지에 공지하거나 e-mail을 통해 회원에게 공지하며, 약관의 부칙에 명시된 날부터 그 효력이 발생됩니다. 회원이 변경된 약관에 동의하지 않는 경우, 회원은 본인의 회원등록을 취소(회원탈퇴)할 수 있으며, 변경된 약관의 효력 발생일로부터 7일 이내에 거부의사를 표시하지 아니하고 서비스를 계속 사용할 경우는 약관 변경에 대한 동의로 간주됩니다.

제 3 조(약관 외 준칙)

본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다.
                </textarea>
            </div>
            <div class="confirm">
                <button name="cancel">확인</button>
            </div>
        </div>
    </div>

    <div class="modal f2">
        <div class="term-content">
            <h2>개인정보수집·이용 동의<span class="red">*</span></h2>
            <div class="textarea-div">
                <textarea readonly>
가. 개인정보의 수집 및 이용 목적
① 국가공간정보포털은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
1. 국가공간정보포털 서비스 제공을 위한 회원관리
1) 공간정보 다운로드, 오픈API 신청 및 활용 등 포털 서비스 제공과 서비스 부정이용 방지를 목적으로 개인정보를
   처리합니다.

나. 수집하는 개인정보의 항목
① 국가공간정보포털 회원정보(필수): 이름, 이메일(아이디), 비밀번호

다. 개인정보의 보유 및 이용기간
① 국가공간정보포털은 법령에 따른 개인정보 보유ㆍ이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유ㆍ이용기간 내에서 개인정보를 처리ㆍ보유합니다.
1. 국가공간정보포털 회원정보
- 수집근거: 정보주체의 동의
- 보존기간: 회원 탈퇴 요청 전까지(1년 경과 시 재동의)
- 보존근거: 정보주체의 동의

라. 동의 거부 권리 및 동의 거부에 따른 불이익
위 개인정보의 수집 및 이용에 대한 동의를 거부할 수 있으나, 동의를 거부할 경우 회원 가입이 제한됩니다.
                </textarea>
            </div>
            <div class="confirm">
                <button name="cancel">확인</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script>
    $(document).ready(function (e) {
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // 휴대폰 입력창 마우스 오른쪽 버튼 차단
        $("input[name='telNo']").bind("contextmenu", function (){
            return false;
        });

        // 인증 코드를 저장
        let emlAuthTkn = '';
        // 인증 여부를 저장
        let isEmailConfirm = false;
        let isEqualCode = false;

        let emailAuthBtn = $('button[name="email-auth-btn"]');

        emailAuthBtn.on('click', function (e) {
            e.preventDefault();

            let email = $('input[name="email"]').val();

            // 이메일 형식 확인
            if (showValidateMsg(!checkEmail(email), $(".email-msg"))) return;

            if (showValidateMsg(checkEmailAlreadyExists(email), $(".email-exist-msg"))) return;

            alert("인증코드가 메일로 전송되었습니다. \n5분 이내에 도착하지 않으면 다시 한 번 시도해주세요.");

            // 이메일 인증을 하면 인증 버튼을 비활성화 시킴
            emailAuthBtn.attr("class", "btn-diabled btn002");

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
            isEqualCode = false;

            // 인증 버튼을 다시 활성화 시킴
            emailAuthBtn.attr("class", "btn002");
        });

        // 휴대폰 입력창에 숫자만 입력가능
        $("input[name='telNo']").on('keyup', function (e) {
            let tel = $(this).val().replace(/[^0-9]/g, '').substring(0, 11);
            $(this).val(tel);
        });

        $("input[name='emlAuthTkn']").on('keyup', function () {
            // 메일로 전송된 인증코드와 사용자가 입력한 인증코드가 다르면
            if (showValidateMsg((emlAuthTkn !== $(this).val()), $(".auth-msg"))) {
                isEqualCode = false;
                return;
            }

            isEqualCode = true;
        });

        $('button[type="submit"]').on('click', function (e) {
            e.preventDefault();

            let email = $('input[name="email"]').val();
            let confirmPwd = $('input[name="confirmPassword"]').val();
            let telNo = $('input[name="telNo"]').val();
            let name = $('input[name="name"]').val();
            let pwd = $('input[name="pwd"]').val();

            if (printValidateMsg(!isEmailConfirm, "이메일 인증을 진행해주세요.")) return;

            if (printValidateMsg(!isEqualCode, "입력하신 이메일에 전송된 인증코드를 입력해주세요.")) return;

            if (showValidateMsg(!checkPassword(pwd), $(".pwd-msg"))) return;

            if (showValidateMsg((confirmPwd !== pwd), $(".pwd-confirm-msg"))) return;

            if (showValidateMsg(!(name.length >= 2), $(".name-msg"))) return;

            if (showValidateMsg((telNo.length === 0 || telNo.length < 10), $(".tel-msg"))) return;

            $.ajax({
                type: 'post',
                url: '/account/register',
                data: JSON.stringify({
                    email: email,
                    pwd: pwd,
                    name: name,
                    telNo: telNo,
                    emlAuthTkn: emlAuthTkn
                }),
                contentType: 'application/json; charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {
                    alert("회원가입 성공");
                    // 사용자 등록에 성공하면 로그인 페이지로 이동
                    window.location.replace("/account/signIn");
                },
                error: function () {
                    alert("다시 시도해주세요.");
                }
            });
        });

        // 전체약관 동의 체크박스를 클릭하면 전체 체크박스 checked
        $("#f-all").click(function() {
            if ($(this).prop("checked")) {
                $("input[type='checkbox']").prop("checked", true);
            } else {
                $("input[type='checkbox']").prop("checked", false);
            }
        });

        // 모든 체크박스가 checked면 전체약관 동의 체크박스도 checked
        $("input[type='checkbox']").click(function () {
            if ($("input[name='term']:checked").length === 2) {
                $("#f-all").prop("checked", true);
            } else {
                $("#f-all").prop("checked", false);
            }
        });

        $(".term").on('click', function(e) {
            e.preventDefault();
            let c = $(this).attr("href");

            $("." + c).css("visibility", "visible");
        });

        $("button[name='cancel']").on("click", function (e) {
            e.preventDefault();

            $(".modal").css("visibility", "hidden");
        });
    });

    function printValidateMsg(check, msg) {
        if (check) {
            $('#validateMsg').css("display", "block");
            $('#validateMsg').html("<i class=\"fas fa-exclamation-circle\"></i> " + msg);
            return true;
        }
        $('#validateMsg').css("display", "none");
        $('#validateMsg').html("");
        return false;
    }

    function showValidateMsg(check, item) {
        if (check) {
            item.css("display", "block");
            return true;
        }
        item.css("display", "none");
        return false;
    }

    function checkEmail(email) {
        let regExp = /^[-_\.0-9a-zA-Z]*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

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
                // 사용중인 이메일이 아니면 0
                count = result;
            }
        });

        return parseInt(count) === 1;
    }

    // 영어와 숫자, 특수문자를 포함한 최소 8자리 ~ 최대 16자리 비밀번호
    function checkPassword(pwd) {
        let regExp = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,16}$/;

        return regExp.test(pwd);
    }

</script>