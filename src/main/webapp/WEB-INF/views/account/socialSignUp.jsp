<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/login/socialSignUp.css"/>
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
        <h2>소셜 회원가입</h2>
        <div class="title"></div>
        <div class="element">
            <div class="label">이메일</div>
            <div class="input-div">
                    <div><c:out value="${email}"/></div>
            </div>
        </div>
        <div class="element">
            <div class="label">이름</div>
            <div class="input-div">
                <div class="name_received">
                    <div><c:out value="${name}"/></div>
                </div>
            </div>
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
            <div class="msg_output">
                <div id="validateMsg"></div>
            </div>
            <div class="btn_section"><button type="submit" class="btn001">가입하기</button></div>
        </div>
    </div>

    <!-- social login-form -->
    <form class="form-socialLogin" action="/login" method="post">
        <input type="hidden" name="username" value=""/>
        <input type="hidden" name="password" value=""/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>

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

        let socialLoginForm = $(".form-socialLogin");

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let email = "<c:out value='${email}'/>";
        let name = "<c:out value='${name}'/>";
        let soclTypeCode = "<c:out value="${soclTypeCode}"/>";

        let isAllEssnChecked = false;   // 필수 약관동의 여부

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

            if (printValidateMsg(!isAllEssnChecked, "필수 약관 동의가 필요합니다.")) return;

            // 모두 만족시 가입진행
            $.ajax({
                type: 'post',
                url: '/account/soclRegister',
                data: JSON.stringify({
                    email: email,
                    pwd: "",
                    name: name,
                    telNo: "",
                    roleCode: soclTypeCode,
                    emlAuthTkn: "",
                }),
                contentType: 'application/json; charset=utf-8',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {
                    alert("회원가입에 성공했습니다.");

                    socialLoginForm.find("input[name='username']").val(email);
                    socialLoginForm.find("input[name='password']").val("");
                    socialLoginForm.submit();

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

</script>