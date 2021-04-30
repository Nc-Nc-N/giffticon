<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="templete.jsp"/>

<link rel="stylesheet" href="/resources/css/user/mypage/addCon.css" type="text/css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<div class="contentheader">
    <span> 콘 충전</span>
</div>

<div class="pnt_info_section">
    <div class="select_section">
        <table class="select_pnt">
            <thead>
            <tr>
                <th scope="cols">구매금액</th>
                <th scope="cols">충전 콘</th>
                <th scope="cols">혜택</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><input type="radio" name="cp_item" value="5000"> 5,000 원</td>
                <td>5,000 콘</td>
                <td></td>
            </tr>
            <tr>
                <td><input type="radio" name="cp_item" value="10000"> 10,000 원</td>
                <td>10,000 콘</td>
                <td>+1,000 콘 추가지급!</td>
            </tr>
            <tr>
                <td><input type="radio" name="cp_item" value="20000"> 20,000 원</td>
                <td>20,000 콘</td>
                <td>+2,500 콘 추가지급!</td>
            </tr>
            <tr>
                <td><input type="radio" name="cp_item" value="50000"> 50,000 원</td>
                <td>50,000 콘</td>
                <td>+6,000 콘 추가지급!</td>
            </tr>
            </tbody>
        </table>
        <p  style="color: grey; margin: 5% 5%;">최소 충전금액은 5,000원이며 최대 충전금액은 50,000원 입니다.</p>
    </div>

    <div class="pnt_info_column">
        <div>현재 콘</div>
        <div>충전 콘</div>
        <div>충전 후 콘</div>
        <div>총 결제 금액</div>

        <div class="pnt_bought_btn_section">
            <button id="charge_kakao" class="btn btn-active">결제하기</button>
        </div>
    </div>
</div>
</div>
</div>
</div>
</div>
</div>

</body>
</html>
<script>
    $(document).ready(function(){

        let csrfHeaderName="${_csrf.headerName}";
        let csrfTokenValue="${_csrf.token}";

        const email = '${email}';
        const name = '${name}';
        const tel = '${tel}';

        $('#charge_kakao').click(function () {

            // getter
            let IMP = window.IMP;
            IMP.init('imp60743034');
            let money = $('input[name="cp_item"]:checked').val();
            console.log(money);

            IMP.request_pay({
                pg: 'kakao',
                merchant_uid: 'merchant_' + new Date().getTime(),

                name: '콘 충전',
                amount: money,
                buyer_email: email,
                buyer_name: name,
                buyer_tel: tel,
                buyer_addr: '인천광역시 부평구',
                buyer_postcode: '123-456'
            }, function (rsp) {
                console.log(rsp);
                if (rsp.success) {
                    let msg = '결제가 완료되었습니다.';
                    msg += '고유ID : ' + rsp.imp_uid;
                    msg += '상점 거래ID : ' + rsp.merchant_uid;
                    msg += '결제 금액 : ' + rsp.paid_amount;
                    msg += '카드 승인번호 : ' + rsp.apply_num;
                    $.ajax({
                        type: "GET",
                        url: "/user/mypage/addCon/con", //충전 금액값을 보낼 url 설정
                        data: {
                            "amount": money
                        },
                    });
                } else {
                    let msg = '결제에 실패하였습니다.';
                    msg += '에러내용 : ' + rsp.error_msg;
                }
                alert(msg);
                document.location.href = "/user/mypage/addCon"; //alert창 확인 후 이동할 url 설정
            });
        });
    })


</script>