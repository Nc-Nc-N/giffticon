function socialLogin(email, soclType, soclUserInfo) {

    alert("type in js : " + soclType);
    alert("type in js : " + typeof (soclType));
    $.ajax({
        url: '/account/socialAccountCheck',
        method: 'get',
        data: {email: email, soclType: soclType},
        contentType: 'application/json',
        dataType: 'json',
        success: function (result) {
            soclLoginPathDivider(soclUserInfo, result);
        },
        error: function () {
            alert("실패");
        }

    })

}

function soclLoginPathDivider(soclUserInfo, result) {

    let socialLoginForm = $(".form-socialLogin");

    if (result == 0) {
        // 소셜로그인 연동 회원가입창으로 보내기
    } else if (result == 1) {
        // 관리자 이므로 로그인 불가
    } else if (result == 2) {
        // 일반 회원 계정 있음.. 기존계정 연동창으로 보내기
    } else if (result == 3) {
        // 소셜로그인 계정 있음. 로그인 실행
        socialLoginForm.find("input[name='username']").val(soclUserInfo.email);
        socialLoginForm.find("input[name='password']").val("");

        alert("소셜로그인 진행");

        socialLoginForm.submit();
    } else if (result == 4) {
        $("#validateMsg").html("<i class='fas fa-exclamation-circle'></i>" + "다른 SNS로 가입된 계정입니다. 해당 로그인을 이용해주세요");
        return;
    }
}

