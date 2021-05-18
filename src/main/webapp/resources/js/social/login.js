function socialLogin(email, soclUserInfo) {

    $.ajax({
        url: '/account/socialAccountCheck',
        method: 'get',
        data: {email: email, soclType: soclUserInfo.soclTypeCode},
        contentType: 'application/json',
        dataType: 'json',
        success: function (result) {
            console.log("result : " + result);
            soclLoginPathDivider(soclUserInfo, result);
        },
        error: function () {
            alert("소셜로그인 실패");
        }

    })

}

function soclLoginPathDivider(soclUserInfo, result) {
    console.log("result : " + result);
    let socialLoginForm = $(".form-socialLogin");

    if (result == 0) {
        socialLoginForm.append("<input type='hidden' name='email' value='" + soclUserInfo.email + "'>");
        socialLoginForm.append("<input type='hidden' name='name' value='" + soclUserInfo.name + "'>");
        socialLoginForm.append("<input type='hidden' name='soclTypeCode' value='" + soclUserInfo.soclTypeCode + "'>");
        socialLoginForm.attr("action", "/account/socialSignUp").attr("method","get");
        socialLoginForm.submit();
    } else if (result == 1) {
        $("#validateMsg").html("<i class='fas fa-exclamation-circle'></i>" + "관리자계정으로 등록된 이메일입니다. 일반 로그인을 이용해주세요");
        return;
    } else if (result == 2) {
        if(confirm("해당 이메일로 가입된 일반계정이 존재합니다. 소셜계정으로 변경하시겠습니까?")) {
            socialLoginForm.append("<input type='hidden' name='email' value='" + soclUserInfo.email + "'>");
            socialLoginForm.append("<input type='hidden' name='name' value='" + soclUserInfo.name + "'>");
            socialLoginForm.append("<input type='hidden' name='soclTypeCode' value='" + soclUserInfo.soclTypeCode + "'>");
            socialLoginForm.attr("action", "/account/socialAccLink").attr("method", "get");
            socialLoginForm.submit();
        }else{
            return;
        }
    } else if (result == 3) {
        // 소셜로그인 계정 있음. 로그인 실행
        socialLoginForm.find("input[name='username']").val(soclUserInfo.email);
        socialLoginForm.find("input[name='password']").val("");
        socialLoginForm.submit();
    } else if (result == 4) {
        //다른 sns의 소셜계정인 계정인경우
        $("#validateMsg").html("<i class='fas fa-exclamation-circle'></i>" + "다른 SNS로 가입된 계정입니다. 해당 로그인을 이용해주세요");
        return;
    }
}

