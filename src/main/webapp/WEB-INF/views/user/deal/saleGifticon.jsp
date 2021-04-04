<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/common-css/header.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/deal/sale.css" type="text/css">
    <style>
        /*@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');*/
    </style>
</head>

<body>
<!-- 헤더 -->
<div id="header">
    <div class= "top_menu">
        <span><a href="#" class="login-panel">로그인</a></span>
        <span class="header_divider">|</span>
        <span><a href="#" class="login-panel">회원가입</a></span>
        <span class="header_divider">|</span>
        <span><a href="#" class="login-panel">고객센터</a></span>
    </div>
    <div class="main-logo">
        <div class="home-logo"><img src="/resources/img/기쁘티콘.png" width="80%" ></div>
    </div>
    <div class="main-bar">

        <div class="bar-left">
            <div class="category-drop">
                <div class="category-btn"><i class="fas fa-bars"></i>&nbsp;전체 카테고리</div>
            </div>
            <div class="leftmenus">
                <div class="leftmenu">충전하기</div>
                <div class="leftmenu"><i class="fas fa-map-marker-alt"></i></div>
            </div>
        </div>

        <div class="search">
            <form action="(login)" >
                <input type="text" class="searchbar" placeholder="기쁘티콘">
                <button class="searchbutton"><i class="fas fa-search"></i> </button>
            </form>
        </div>

        <div class="bar-right">

            <span class="rightmenu"><i class="fas fa-ticket-alt"></i></span>

            <span class="rightmenu">판매하기</span>
            <span class="rightmenu">마이페이지</span>
        </div>
    </div>
</div>
<!-- 컨테이너 전체 -->
<div id="container">
    <div id="space"></div>
    <!-- '판매하기'부터 전체 -->
    <div id="main">

        <div class="menuname"><h2>판매하기</h2></div>

        <!-- '카테고리'부터 전체 -->
        <div id="content">
            <!-- 카테고리 -->
            <div class="block">
                <div class="catename">
                    카테고리
                    <span>*</span>
                </div>
                <div class="innerblock"> <!-- 카테고리 내용 전체-->
                    <div class="category"> <!-- select box 3개 묶음 -->
                        <div class="innerbox"> <!-- select box 1개-->
                            <ul class="lclsbox"> <!-- 대분류 카테고리 -->
                                <c:forEach items="${categoryList}"  var="catL">
                                <li class="lclsSelect">
                                    <button type="button" class="select"><c:out value="${catL.name}"/></button>
                                </li>
                                </c:forEach>

                            </ul>
                        </div>
                        <div class="innerbox">
                            <!-- <span>중분류 선택</span> -->
                            <ul class="brandbox"> <!-- 중분류 카테고리 -->
                                <c:forEach items="${brandList}" var="brandL">
                                    <li class="lclsSelect">
                                        <button type="button" class="select"><c:out value="${brandL.name}"/></button>
                                    </li>
                                </c:forEach>

                            </ul>
                        </div>

                        <div class="innerbox">
                            <!-- <span>소분류 선택<span> -->
                            <ul class="productbox" type="hidden"> <!-- 소분류 카테고리 -->
                                <c:forEach items="${productList}" var="prodL">
                                    <li class="lclsSelect">
                                        <button type="button" class="select"><c:out value="${prodL.name}"/></button>
                                    </li>
                                </c:forEach>

                            </ul>


                        </div>
                    </div>
                    <h3 class="showCategory">선택한 카테고리 : <b></b></h3>
                    <div class="prodInfo">
                        <div class="imgspace"> <!-- 이미지 테두리-->
                            <img src="/resources/img/star_americano.png" alt="">
                        </div>
                        <textarea>▶상품설명 스타벅스의 깔끔한 맛을 자랑하는 커피로, 스타벅스 파트너들이 가장 좋아하는 커피입니다. ▶유의사항 - 상기 이미지는 연출된 것으로 실제와 다를 수 있습니다.- 본 상품은 매장 재고 상황에 따라 동일 상품으로 교환이 불가능할 수 있습니다.- 동일 상품 교환이 불가능한 경우 동일 가격 이상의 다른 상품으로 교환이 가능하며 차액은 추가 지불하여야 합니다.- 정식 판매처 외의 장소나 경로를 통하여 구매하거나 기타의 방법으로 보유하신 쿠폰은 사용이 금지/제한될 수 있으니 주의하시기 바랍니다.- 해당 쿠폰과 스타벅스 카드의 복합결제 거래는 스타벅스 카드의 고유혜택인 Free Extra 적용대상이 아닌 점 이용에 참고하시기 바랍니다.- 해당 쿠폰 거래시 스타벅스 카드의 고유혜택인 별적립 적용대상이 아닌 점 이용에 참고하시기 바랍니다.
                                </textarea>
                    </div>
                </div>
            </div>

            <!-- 가격정보 -->
            <div class="block">
                <div class="catename">
                    가격정보
                    <span>*</span>
                </div>
                <div class="innerblock">
                    <div class="pricebox">
                        <div class="pricename">정가</div>
                        <input type="text"> 원
                        <div class="pricename">판매가</div>
                        <div class="explain">
                            <input type="text" placeholder=" 숫자만 입력해주세요."> 원
                            <label>
                                자동입력을 체크하시면 유효기간에 따라 금액이 자동으로 측정되어 판매됩니다.<br>
                                60일을 기준으로 15일 간격으로 할인율이 5% 증가됩니다.
                            </label>
                        </div>
                        <div class="pricetype">
                            <label for="자동입력" class="auto">
                                <input id="자동입력" name="group1" type="radio" value="0"> 자동입력
                            </label>
                            <label for="가격제시" class="manual">
                                <input id="가격제시" name="group1" type="radio" value="1"> 가격제시
                            </label>
                        </div>
                    </div>

                </div>

            </div>

            <!-- 쿠폰 등록 -->
            <div class="couponblock">
                <div class="catename">
                    쿠폰등록
                    <span>*</span>
                </div>
                <div class="innerblock">
                    <div class="coupon">
                                <textarea>쿠폰 등록시 유의사항 1. 반드시 쿠폰 이미지만 잘라서 올려주세요. 캡쳐 이미지에 배터리 잔여량, 통신사, 시간, 화살표 등이 표기된 경우, 저희 시스템상 바코드와 유효기간을 잘못 인식하는 경우가 많아 반려하고 있습니다.2. 카테고리가 지정된 쿠폰이 우선적으로 검수됩니다. 해당 쿠폰의 정확한 카테고리를 지정해주세요.3. 이미지에 유효기간이 없는 경우에는 직접 입력해주세요. (단, 이미지에 유효기간이 있는 경우에는 입력하실 필요가 없습니다!)4.'추가 이미지' 버튼은 해당 쿠폰에 부가적인 이미지가 있을 경우에만 사용해주세요. 새 쿠폰을 추가하려면 상단에 있는 '+쿠폰 추가' 버튼을 눌러주세요.5. 기쁘티콘 혹은 기쁘티콘 제휴사에서 구매한 쿠폰은 다시 매입하지 않습니다.
                                </textarea>
                        <!-- 쿠폰 파일 업로드 -->
                        <div class="box-file-input">
                            <label><input type="file" name="ev_display" class="file-input" accept="image/*"></label>
                            <span class="filename">바코드를 포함한 쿠폰을 등록해주세요.</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="couponblock">
                <div class="catename">
                    바코드
                    <span>*</span>
                </div>
                <div class="innerblock">
                    <input type="text" placeholder=" 바코드 번호를 입력해주세요.">
                    <label>
                        -를 제외하고 전체 바코드 숫자를 입력해주세요.
                    </label>
                </div>
            </div>
            <div class="block">
                <div class="catename">
                    유효기간
                    <span>*</span>
                </div>
                <div class="innerblock">
                    <input type="date" id="end-date"> <!-- datepicker로 나중에 바꿔보기-->
                    <label>
                        기쁘티콘에 명시된 유효기간을 입력해주세요.
                    </label>
                </div>
            </div>

            <!-- 기쁘티콘에게 전달할 메시지부터 -->
            <div class="message">
                <div class="message-title">
                    기쁘티콘에게 전달할 메시지
                </div>
                <textarea></textarea>
            </div>

            <!-- 판매 등록하기 버튼 -->
            <div class="register">
                <button class="btn btn-active">판매 등록하기</button>
            </div>

        </div>
    </div>
</div>
</div>

<script>
    $(document).ready(function(){

    });

    // 쿠폰 업로드시 파일명 보여줌
    $(document).on("change", ".file-input", function(){

        $filename = $(this).val();

        if($filename == "")
            $filename = "바코드를 포함한 쿠폰을 등록해주세요.";

        $(".filename").text($filename);
    })
</script>
</body>
</html>