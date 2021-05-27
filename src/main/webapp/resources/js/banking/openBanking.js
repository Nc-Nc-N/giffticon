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

// 콘 인출
function deposit(accTkn, userInfo){

    return new Promise(function (resolve, reject) {

        const dateNow = new Date();
        const tranDTime = moment(dateNow).format('YYYYMMDDHHmmss');
        const bnkTranId = "M202112121U" + (String)(dateNow.getTime()).slice(-9, (String)(dateNow.getTime()).length);

        $.ajax({
            url: 'https://testapi.openbanking.or.kr/v2.0/transfer/deposit/acnt_num',
            type: 'post',
            contentType: 'application/json; charset=UTF-8',
            data:
                JSON.stringify({
                    "cntr_account_type": "N",
                    "cntr_account_num": "123123123123",     // 약정계좌
                    "wd_pass_phrase": "NONE",
                    "wd_print_content": "콘인출",
                    "name_check_option": "off",
                    "tran_dtime": tranDTime,
                    "req_cnt": "1",
                    "req_list": [{
                        "tran_no": "1",
                        "bank_tran_id": bnkTranId,
                        "bank_code_std": userInfo.bnkCode,
                        "account_num": userInfo.acc,
                        "account_holder_name": userInfo.holder,
                        "print_content": "콘인출",
                        "tran_amt": userInfo.conAmt,
                        "req_client_name": userInfo.name,
                        "req_client_bank_code": userInfo.bnkCode,
                        "req_client_account_num": userInfo.acc,
                        "req_client_num": userInfo.id,
                        "transfer_purpose": "TR",
                        "recv_bank_tran_id":bnkTranId
                        }]
                }),
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", accTkn);
            },
            success: function (result) {

                console.log(result);

                if (result.rsp_code == "A0000") {
                    console.log("A0000");
                    resolve(userInfo.conAmt);
                }
                else{
                    reject('인출에 실패하였습니다. 다시 시도해 주세요. 에러내용:'+result.rsp_message);
                }

            }
        })
    })
}

let header = $("meta[name='_csrf_header']").attr("content");
let token = $("meta[name='_csrf']").attr("content");

// 콘 업데이트
function conUpdate(con){
    return new Promise(function (resolve, reject){

        $.ajax({
            type:"POST",
            url: "/user/conUpdate",
            beforeSend: function (xhr){
                xhr.setRequestHeader( header, token );
            },
            data:
                JSON.stringify({
                "chgQuty": -con,
                "pntHistCode":"002"     // 인출
                }),
            contentType: 'application/json; charset=UTF-8',
            success:function (){
                resolve("인출이 완료되었습니다.");
                document.location.href = "/user/mypage/withdrawCon";
            }, error: function (){
                reject("일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.");
            }
        })
    })
}