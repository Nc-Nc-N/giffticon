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
    <link rel="stylesheet" href="/resources/css/login/signUp.css"/>
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
                <div class="name-msg input-msg"><i class="fas fa-exclamation-circle"></i> 이름은 2자 이상 20자
                    이하<small>(공백포함)</small>로 입력해주세요.
                </div>
            </div>
            <div class="btn-area">
                &nbsp;
            </div>
        </div>
        <div class="element">
            <div class="label">생년월일</div>
            <div class="input-div">
                <input type="text" class="input001" name="birth" placeholder="생년(2자리)월일 (예: 210513)">
                <div class="birth-msg input-msg"><i class="fas fa-exclamation-circle"></i>생년(2자리)월일 형식에 맞춰 입력해주세요.
                </div>
            </div>
            <div class="btn-area">
                &nbsp;
            </div>
        </div>
        <div class="element">
            <div class="label">휴대폰<span class="red">*</span></div>
            <div class="input-div">
                <input type="text" class="input001" name="telNo" placeholder="숫자만 입력해주세요.">
                <div class="tel-msg input-msg"><i class="fas fa-exclamation-circle"></i> 휴대폰 번호<small>(11자리)</small> 전체를
                    입력해주세요.
                </div>
            </div>
            <div class="btn-area">
                <button name="tel-auth-btn" class="btn-disabled btn002">휴대폰인증</button>
            </div>
        </div>
        <!-- 휴대폰 인증코드 입력 -->
        <div class="element">
            <div class="label">&nbsp;</div>
            <div class="input-div">
                <input type="text" class="input001" name="telAuthTkn" placeholder="휴대폰 인증코드">
                <div class="tel-auth-msg input-msg"><i class="fas fa-exclamation-circle"></i> 잘못된 인증코드입니다.</div>
            </div>
            <div class="btn-area">
                &nbsp;
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
                    <input type="checkbox" id="f1" class="essn" name="term" value="1"/>
                    <label for="f1">이용약관 동의<span class="red">*</span></label><a href="f1" class="term">약관보기 &gt;</a>
                </div>
                <div class="checks">
                    <input type="checkbox" id="f2" class="essn" name="term" value="1"/>
                    <label for="f2">개인정보 수집·이용 동의<span class="red">*</span></label><a href="f2" class="term">약관보기
                    &gt;</a>
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

        let emlInput = $("input[name='email']");
        let emlValidMsg = $(".email-msg");
        let emlAuthBtn = $("button[name='email-auth-btn']");
        let telAuthBtn = $("button[name='tel-auth-btn']");

        let emlAuthCode = '';           // 이메일 인증코드
        let telAuthCode = '';

        let isRightEmail = false;       // 이메일 형식 일치 여부
        let isCertifiedEmail = false;   // 이메일 인증 진행 여부
        let isCertifiedTel = false;     // 전화번호 인증 진행 여부
        let isRightPwd = false;         // 비밀번호 형식 일치 여부
        let isEqualPwd = false;         // 비밀번호와 비밀번호 확인 값 일치 여부
        let isRightName = false;        // 이름 형식 일치 여부
        let isRightBirth = false;       // 생년월일 형식 일치 여부
        let isRightTelNo = false;       // 휴대전화 형식 일치 여부
        let isAllEssnChecked = false;   // 필수 약관동의 여부

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

            if (checkEmailAlreadyExists(eml)) {
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

        telAuthBtn.on('click', function (e) {
            e.preventDefault();

            let telNo = telInput.val();

            telAuthBtn.attr("class", "btn-disabled btn002");
            telCodeInput.val("");
            alert("인증코드가 문자로 전송되었습니다. \n5분 이내에 도착하지 않는다면 다시 한 번 시도해주세요.");

            $.ajax({
                type: 'get',
                url: '/account/telNoConfirm?telNo=' + telNo,
                success: function (result) {
                    telAuthCode = result.code;   // 인증코드 메일 전송을 성공하면 해당 코드값을 받아옴
                }, error: function (result) {
                    $(this).attr("class", "btn002");
                    alert("인증코드 전송에 실패했습니다. \n휴대폰번호 확인 후 다시 시도해주세요.");
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

        let telCodeInput = $("input[name='telAuthTkn']");
        telCodeInput.on("propertychange change keyup paste input", function (e) {
            if (telAuthCode === $(this).val()) {            // 입력 값과 인증코드가 같으면
                $(".tel-auth-msg").css("display", "none");  // 안내 메세지 hide
                isCertifiedTel = true;                      // 휴대폰 인증여부 true
                return;
            }
            $(".tel-auth-msg").css("display", "block");     // 안내 메세지 show
            isCertifiedTel = false;                         // 휴대폰 인증여부 false
        });

        let pwdInput = $("input[name='pwd']");
        pwdInput.on("propertychange change keyup paste input", function (e) {
            if (checkPwd($(this).val())) {
                $(".pwd-msg").css("display", "none");
                isRightPwd = true;
                return;
            }
            $(".pwd-msg").css("display", "block");
            isRightPwd = false;
        });

        let confirmPwdInput = $("input[name='confirmPassword']");
        confirmPwdInput.on("propertychange change keyup paste input", function (e) {
            if (pwdInput.val() === $(this).val()) {
                $(".pwd-confirm-msg").css("display", "none");
                isEqualPwd = true;
                return;
            }
            $(".pwd-confirm-msg").css("display", "block");
            isEqualPwd = false;
        });

        // 이름 길이(2~20), 정규식 체크 -> 특수문자, 숫자 불가능 + 앞뒤 공백 제거
        let nameInput = $("input[name='name']");
        nameInput.on("focusout", function (e) {
            let name = $(this).val().trim();
            $(this).val(name);

            if (checkName($(this).val())) {
                $(".name-msg").css("display", "none");
                isRightName = true;
                return;
            }
            $(".name-msg").css("display", "block");
            isRightName = false;
        });

        let birthInput = $("input[name='birth']");
        birthInput.on("focusout", function (e) {
            let birth = $(this).val().replace(/[^0-9]/g, '').substring(0, 6);
            $(this).val(birth);

            if (checkBirth($(this).val())) {
                $(".birth-msg").css("display", "none");
                isRightBirth = true;
                return;
            }
            $(".birth-msg").css("display", "block");
            isRightBirth = false;
        });

        // 전화번호 유효성 검사과정
        let telInput = $("input[name='telNo']");
        telInput.on("propertychange change keyup paste input", function (e) {
            isCertifiedTel = false;
            let tel = $(this).val().replace(/[^0-9]/g, '').substring(0, 11);
            $(this).val(tel);

            if (checkTelNo(tel)) {
                $(".tel-msg").css("display", "none");
                telAuthBtn.attr("class", "btn002");             // 휴대폰 인증버튼 활성화
                isRightTelNo = true;
                return;
            }
            $(".tel-msg").css("display", "block");
            telAuthBtn.attr("class", "btn-disabled btn002");    // 인증버튼 비활성화
            isRightTelNo = false;
        });

        // 약관내용 모달 visible
        $(".term").on('click', function (e) {
            e.preventDefault();
            $("." + $(this).attr("href")).css("visibility", "visible");
        });

        // 약관내용 모달 hidden
        $("button[name='cancel']").on("click", function (e) {
            e.preventDefault();
            $(".modal").css("visibility", "hidden");
        });

        let allCheck = $("#f-all");                     // 약관 전체동의 체크박스
        let checkboxes = $("input[type='checkbox']");

        // 전체약관 동의 체크박스를 클릭하면 전체 체크박스 checked
        allCheck.click(function () {
            if ($(this).prop("checked")) {
                checkboxes.prop("checked", true);
            } else {
                checkboxes.prop("checked", false);
            }
        });

        checkboxes.click(function () {
            // 모든 약관에 동의한 경우 전체동의 체크박스도 선택됨
            if ($("input[name='term']:checked").length === (checkboxes.length - 1)) {
                allCheck.prop("checked", true);
            } else {
                allCheck.prop("checked", false);
            }
            // 필수약관을 모두 체크했는지 확인
            isAllEssnChecked = $(".essn").length === $("input[class='essn']:checked").length;
        });

        // 가입하기
        $('button[type="submit"]').on('click', function (e) {
            e.preventDefault();


            let email = $('input[name="email"]').val();
            let pwd = $('input[name="pwd"]').val();
            let name = $('input[name="name"]').val();
            let birth = $('input[name="birth"]').val();
            let telNo = $('input[name="telNo"]').val();

            console.log("birth: " + birth);

            if (printValidateMsg(!isCertifiedEmail, "이메일 인증을 진행해주세요.")) return;
            if (printValidateMsg(!isRightEmail, "이메일 형식을 확인해주세요.")) return;
            if (printValidateMsg(!isRightPwd, "비밀번호를 조건에 맞게 입력해주세요.")) return;
            if (printValidateMsg(!isEqualPwd, "비밀번호가 일치하지 않습니다.")) return;
            if (printValidateMsg(!isRightName, "이름을 다시 입력해주세요.")) return;
            if (printValidateMsg(!isRightBirth, "생년월일을 형식에 맞게 입력하거나,<br>등록을 원하지 않으면 입력 값을 비워주세요.")) return;
            if (printValidateMsg(!isRightTelNo, "휴대폰 번호를 알맞게 입력해주세요.")) return;
            if (printValidateMsg(!isAllEssnChecked, "필수 약관 동의가 필요합니다.")) return;


            // 모두 만족시 가입진행
            $.ajax({
                type: 'post',
                url: '/account/register',
                data: JSON.stringify({
                    email: email,
                    pwd: pwd,
                    name: name,
                    birthDt: birth,
                    telNo: telNo,
                    emlAuthTkn: emlAuthCode
                }),
                contentType: 'application/json; charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {
                    alert("기쁘티콘에 가입해주셔서 감사합니다!");
                    // 사용자 등록에 성공하면 로그인 페이지로 이동
                    window.location.replace("/account/signIn");
                },
                error: function (data) {
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

    // 영어 대,소문자와 특수문자를 포함한 최소 8자리 ~ 최대 16자리 비밀번호
    function checkPwd(pwd) {
        let regExp = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,16}$/;
        return regExp.test(pwd);
    }

    // 영문 또는 한글로 이루어진 2이상 20이하 문자열인지 확인
    function checkName(name) {
        let regExp = /^[ㄱ-ㅎ가-힣a-zA-Z ]{2,20}$/g;
        return regExp.test(name);
    }

    // 잔화번호 유효성 검사 -> 11자리의 숫자로만 이루어진 문자인지 확인
    function checkTelNo(telNo) {
        return telNo.match(/^[0-9]{11}$/);
    }

    function checkBirth(birth) {
        return birth.match(/^[0-9]{6}$/) || birth === '';
    }

</script>