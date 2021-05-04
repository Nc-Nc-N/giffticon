function logoutWithKakao() {

    if (!Kakao.Auth.getAccessToken()) {
        console.log("카카오 - 이미 로그아웃 되어있습니다.")
        return;
    } else {

        Kakao.Auth.logout(function () {
            console.log("카카오 - 로그아웃 실행합니다.");
            console.log("Logout Auth TKN : " + Kakao.Auth.getAccessToken());
            logoutForm.submit();
        })
    }


}
