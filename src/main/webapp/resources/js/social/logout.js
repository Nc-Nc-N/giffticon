function logoutWithKakao() {

    alert("카카오로그아웃 실행....");

    if (!Kakao.Auth.getAccessToken()) {
        alert("Not logged in.");
        return;
    } else {

        Kakao.Auth.logout(function () {
            alert("카카오 로그아웃합니다.");
            console.log("Logout Auth TKN : " + Kakao.Auth.getAccessToken());
            logoutForm.submit();
        })
    }


}
