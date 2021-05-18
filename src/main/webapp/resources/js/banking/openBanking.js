function getBankingAccTkn() {

    return new Promise(function (resolve, reject) {

        $.ajax({
            url: 'https://testapi.openbanking.or.kr/oauth/2.0/token',
            type: 'post',
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            data:
                {
                    client_id: '7a41174f-2d92-442b-b5fe-df7a488ea118',
                    client_secret: '6c14acbb-02b7-4e18-b632-acb691e15cc3',
                    scope: 'oob',
                    grant_type: 'client_credentials'
                },
            success: function (result) {
                if (result.access_token != null) {
                    resolve(result.token_type + " " + result.access_token);
                } else {
                    reject("토큰획득 실패");
                }
            }
        })

    })
}

function inqRealNameBnkAcc(accTkn, accInfo) {

    return new Promise(function (resolve, reject) {

        const dateNow = new Date();
        const bnkTranId = "M202112121U" + (String)(dateNow.getTime()).slice(-9, (String)(dateNow.getTime()).length);
        const tranDTime = moment(dateNow).format('YYYYMMDDHHmmss');

        $.ajax({
            url: 'https://testapi.openbanking.or.kr/v2.0/inquiry/real_name',
            type: 'post',
            contentType: 'application/json; charset=UTF-8',
            data:
                JSON.stringify({
                    "bank_tran_id": bnkTranId,
                    "bank_code_std": accInfo.bnkCode,
                    "account_num": accInfo.acc,
                    "account_holder_info_type": "",
                    "account_holder_info": accInfo.birth,
                    "tran_dtime": tranDTime
                }),
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", accTkn);
            },
            success: function (result) {

                if (result.rsp_code == "A0000") {
                    if (result.account_holder_name == accInfo.holder) {
                        resolve("계좌 조회 완료");
                    }
                }
                reject("조회된 계좌가 없습니다.")
            }
        })

    })
}