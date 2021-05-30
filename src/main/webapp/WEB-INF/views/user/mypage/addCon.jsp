<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <p style="color: grey; margin: 5% 5%; font-size: small">최소 충전금액은 5,000원이며 최대 충전금액은 50,000원 입니다.</p>
    </div>

    <div class="pnt_info_column">
        <div class="con_info"> 현재 콘 <span class="userPnt"><fmt:formatNumber value="${userCon}" type="number"
                                                                            maxFractionDigits="3"/> 콘</span></div>
        <div class="con_info"> 충전 콘 <span class="addCon"></span> <span class="benefits"></span></div>
        <div class="con_info"> 충전 후 콘 <span class="afterAdd"></span></div>
        <div class="con_info"> 총 결제 금액
            <span class="money">
            </span>
        </div>
        <div class="space50"></div>
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
<div class="space100"></div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
<script>
    $(document).ready(function () {
        $("#con-link").attr("class", "menu active");

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        const email = '${email}';
        const name = '${name}';
        const tel = '${tel}';

        let userCon =${userCon};                    // 사용자 보유 콘
        let money = 0;

        // 라디오 버튼 클릭시 충전 콘 정보 변경
        $('input[name="cp_item"]').click(function () {
            money = $('input[name="cp_item"]:checked').val();
            let benefits = 0;

            $('.addCon').html(numberWithCommas(money)).append(" 콘");                                   // 충전 콘
            $('.money').html(numberWithCommas(money)).append(" 원");                                   // 결제 금액

            // 콘 충전 혜택
            if (money === 10000) {
                benefits = 1000;
            } else if (money === 20000) {
                benefits = 2500;
            } else if (money === 50000) {
                benefits = 6000;
            }

            if (benefits > 0) {
                $('.benefits').html(" +" + benefits + "콘 추가 지급!")
            }

            $('.afterAdd').html(numberWithCommas(userCon + parseInt(money) + benefits)).append(" 콘");    // 충전 후 콘
        });

        $('#charge_kakao').click(function () {
            // getter
            let IMP = window.IMP;
            IMP.init('imp60743034');

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
                if (rsp.success) {
                    var msg = "결제가 완료되었습니다.";
                    msg += '결제 금액 : ' + rsp.paid_amount;

                    $.ajax({
                        type: "POST",
                        url: "/user/conUpdate", //충전 금액값을 보낼 url 설정
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                        },
                        data: JSON.stringify({
                            "chgQuty": money,
                            "pntHistCode": "001"        // 충전
                        }),
                        contentType: 'application/json; charset=UTF-8',
                        async: false,
                        success: function () {
                        },
                        error: function () {
                            alert('충전 업데이트에 실패하였습니다. 관리자에게 문의해주시기 바랍니다.')
                        }
                    });
                } else {
                    var msg = '충전에 실패하였습니다. 다시 시도해 주세요.';
                    msg += '에러내용 : ' + rsp.error_msg;
                }
                alert(msg);
                document.location.href = "/user/mypage/addCon"; //alert창 확인 후 이동할 url 설정
            });
        });
    });

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
</script>
