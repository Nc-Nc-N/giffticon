<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../common/header.jsp"%>
<head>
    <link rel="stylesheet" href="/resources/css/user/sale.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/gifticon/gifti_order.css" type="text/css">
</head>

<body>
    <!-- 컨테이너 전체 -->
    <div id="container">
        <div id="space"></div> 
        <!-- '구매하기'부터 전체 -->
        <div id="main">

            <div class="menuname"><h2>구매하기</h2></div>

            <!-- '구매상품'부터 전체 -->
            <div id="content">

                <form id="order-form" action="/payment_cmplt" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <!-- 구매상품 -->
                    <h3 class="tit_section fst">구매상품</h3>
                    <div id="itemList" class="page_aticle order_goodslist">
                        <div class="info_product">
                            <div class="imgsec">
                                <img src="<c:out value='${gifticon.imgPath}'/>" alt="gifticon">
                            </div>
                            <div class="short_info">[<c:out value="${gifticon.bname}"/>] <c:out value="${gifticon.pname}"/> 상품을 주문합니다.</div>
                        </div>
                    </div>

                    <!-- 구매자 정보 -->
                    <h3 class="tit_section">구매자 정보</h3>
                    <div class="order_section data_orderer">
                        <table class="goodsinfo_table ">
                            <tbody><tr class="fst">
                                <th>이름</th>
                                <td>
                                    <c:out value="${user.name}"/>
                                    <input type="hidden" name="orderer_name" value="<c:out value="${user.name}"/>">
                                </td>
                            </tr>
                            <tr>
                                <th>휴대폰</th>
                                <td>
                                    <c:out value="${user.telNo}"/>
                                    <input type="hidden" name="orderer_phone" value="<c:out value="${user.telNo}"/>">
                                </td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td>
                                    <input type="hidden" id="email" name="orderer_email" value="<c:out value="${user.email}"/>" option="regEmail">
                                    <c:out value="${user.email}"/>
                                    <p class="txt_guide">
                                        <span class="txt txt_case1">이메일을 통해 주문처리과정을 보내드립니다.</span>
                                        <span class="txt txt_case2">정보 변경은 <span class="txt_desc">마이페이지 &gt; 개인정보 수정</span> 메뉴에서 가능합니다.</span>
                                    </p>
                                </td>
                            </tr>
                            </tbody></table>
                    </div>

                    <!-- 결제수단 -->
                    <h3 class="tit_section">결제수단</h3>
                    <table class="goodsinfo_table">
                        <tbody>
                        <tr>
                            <th>전액 콘 결제</th>
                            <td class="noline" style="position:relative">
                                <label class="label_radio checked" id="payCon" style="padding-bottom:4px;">
                                    <input type="radio" id="con" name="settlekind" value="p">
                                    현재 보유 콘 <span class="p_pink"> <c:out value="${user.pnt}"/> 콘</span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>일반결제</th>
                            <td class="noline" style="position:relative">
                                <label class="label_radio" id="settlekindCard" style="padding-bottom:4px;">
                                    <input type="radio" name="settlekind" value="c" >
                                    신용카드
                                </label>
                            </td>
                        </tr>

                        <tr class="card_detail">
                            <th></th>
                            <td>
                                <div id="cardSelect"><div>
                                    <div class="card_select">
                                        <div class="select_box">
                                            <strong class="tit">카드를 선택해주세요</strong>
                                            <!----> <select name="lguplus_card_code" class="list"><option disabled="disabled" value="">카드를 선택해주세요</option> <option value="61">현대</option><option value="41">신한</option><option value="31">비씨</option><option value="11">KB국민</option><option value="51">삼성</option><option value="36">씨티</option><option value="71">롯데</option><option value="21">하나(외환)</option><option value="91">NH채움</option><option value="33">우리</option><option value="34">수협</option><option value="46">광주</option><option value="35">전북</option><option value="42">제주</option><option value="62">신협체크</option><option value="38">MG새마을체크</option><option value="39">저축은행체크</option><option value="37">우체국카드</option><option value="30">KDB산업은행</option><option value="15">카카오뱅크</option></select></div>
                                    </div> <!---->
                                    <div class="card_event">
                                        <div></div>
                                        <div class="inner_card">
                                            <div><strong class="emph">· 무이자할부 유의사항</strong> 은행계열/체크/기프트/선불/법인/개인사업자 기업카드는 제외</div>
                                        </div>
                                    </div>
                                </div
                                ></div>
                            </td>
                        </tr>

                        <tr>
                            <th> CHAI 결제</th>
                            <td>
                                <label class="label_radio" id="cardBenefitChai">
                                    <input type="radio" name="settlekind" value="chai">
                                    <img src="https://res.kurly.com/pc/service/order/2001/logo_chi_x2.png" height="18" alt="Chai 결제">
                                    <img class="img_benefit" src="https://res.kurly.com/pc/service/order/2101/bubble_chai_0301.png" height="20">
                                    <div class="info_benefit"></div>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th> 토스 결제</th>
                            <td>
                                <label class="label_radio" id="cardBenefitToss">
                                    <input type="radio" name="settlekind" value="toss">
                                    <img src="https://res.kurly.com/pc/service/order/1912/toss-logo-signature.svg" height="18" alt="토스 결제">
                                    <img class="img_benefit" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP4zwAAAgEBAKEeXHUAAAAASUVORK5CYII=" height="20">
                                    <div class="info_benefit"></div>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>네이버페이 결제</th>
                            <td class="noline">
                                <label class="label_radio" id="cardBenefitNaverpay">
                                    <input type="radio" name="settlekind" value="n">
                                    <img src="//res.kurly.com/pc/service/order/1710/ico_naverpay_v3.png" height="20" alt="네이버 페이 로고">                                <img class="img_benefit" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP4zwAAAgEBAKEeXHUAAAAASUVORK5CYII=" height="20">
                                    <div class="info_benefit"></div>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>PAYCO 결제</th>
                            <td>
                                <label class="label_radio" id="cardBenefitPayco">
                                    <input type="radio" name="settlekind" value="t">



                                    <img src="https://static-bill.nhnent.com/payco/checkout/img/v2/btn_checkout2.png" alt="PAYCO 간편결제" height="18">
                                    <img class="img_benefit" src="https://res.kurly.com/pc/service/order/2101/bubble_payco_0303.png" height="20">
                                    <div class="info_benefit"></div>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>휴대폰 결제</th>
                            <td>
                                <label class="label_radio">
                                    <input type="radio" name="settlekind" value="h">
                                    휴대폰
                                </label>
                            </td>
                        </tr>

                        <tr>
                            <td class="txt_notice" colspan="2">
                                <ul>
                                    <li>※ 페이코, 네이버페이, 토스, 차이 결제는 결제 시 결제하신 수단으로만 환불되는 점 양해부탁드립니다.</li>
                                    <li>※ 고객님은 안전거래를 위해 현금 등으로 결제시 저희 쇼핑몰에서 가입한 토스 페이먼츠의 구매안전(에스크로) 서비스를 이용하실 수 있습니다.</li>
                                    <li>※ 보안강화로 Internet Explorer 8 미만 사용 시 결제창이 뜨지 않을 수 있습니다. </li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <!-- 결제금액 -->
                    <h3 class="tit_section">결제금액</h3>
                    <div class="orderitem_money_info">
                        <table class="money_info_table ">
                            <tbody>
                            <tr class="fst">
                                <th>주문금액</th>
                                <td>
                                    <c:out value="${gifticon.dcPrc}"/> <span>원</span>
                                </td>
                            </tr>
                            <tr>
                                <th>콘 사용</th>
                                <td>
                                    <span class="useCon"> 0 </span>
                                </td>
                            </tr>
                            <tr>
                                <th>최종결제금액</th>
                                <td>
                                    <span class="final"><c:out value="${gifticon.dcPrc}"/></span> 원
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- 개인정보 수집/제공 -->
                    <h3 class="tit_section">개인정보 수집/제공</h3>
                    <table class="goodsinfo_table">
                        <tbody>
                        <tr>
                            <td class="reg_agree">
                                <div class="bg_dim"></div>
                                <div class="check type_form">
                                    <label class="agree_check">
                                        <input type="checkbox" name="ordAgree" value="y" required="" fld_esssential="" label="결제 진행 필수 동의" msgr="결제 진행 필수 동의 내용에 동의하셔야 결제가 가능합니다.">
                                        <span class="ico"></span>
                                        결제 진행 필수 동의
                                    </label>
                                    <ul class="list_agree">
                                        <li>
                                            <span class="subject">개인정보 수집 · 이용 및 위탁 동의 <span class="emph">(필수)</span></span>
                                            <a href="#terms" class="link_terms">약관보기</a>
                                        </li>
                                        <li id="pgTerms" style="display: list-item;">
                                            <span class="subject">결제대행 서비스 약관 동의 <span class="emph">(필수)</span></span>
                                            <a href="#pgTerms" class="link_terms">약관보기</a>
                                        </li>
                                    </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <button class="btn_payment">
                        결제하기
                    </button>
                </form>
            </div>
        </div>
    </div>

</body>
<script>
$(document).ready(function(){
    let payBtn = $(".btn_payment");
    let money = ${gifticon.dcPrc};
    let con = ${user.pnt};

    // 결제방식- 콘 사용
    $('input[name="settlekind"]').click(function (){
        payBtn.attr("disabled", false);

        if($('input:radio[id="con"]').is(':checked')){      // 콘 사용 체크시

            // 보유 콘으로 기프티콘을 구입할 수 있을 때
            if(con>= money){
                con = "- "+money+" 콘";
                money = 0;
            }else{
                con = '보유 콘이 부족합니다.'
                $('.useCon').css("color", "#FF585D");
                payBtn.attr("disabled", true);

            }
        }else{                                              // 다른 결제방식 선택
            $('.useCon').css("color", '');
            con = "- "+0+" 콘";

        }
        $('.useCon').html(con);
        $('.final').html(money);
    })


    // '결제하기' 버튼 클릭시 이벤트 발생
    payBtn.on("click", function (e){

        let payCon = ${gifticon.dcPrc};

        e.preventDefault();
        let orderForm = $("#order-form");
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        if($('input:radio[id="con"]').is(':checked') === false){
            alert("결제 진행을 위해 결제 방식을 선택해주세요.")
            return false;
        }

        if( $('input[name=ordAgree]').is(':checked') === false ) {
            alert('결제 진행을 위해 결제 진행 필수 동의에 체크해주세요.');
            return false;
        }

        $.ajax({
            type:"POST",
            url:"/user/mypage/payCon",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data:{
                "amount": payCon
            },
            success: function (){
                orderForm.submit();

            }, error: function (){
                alert('일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.');
            }

        })

    });
});
</script>