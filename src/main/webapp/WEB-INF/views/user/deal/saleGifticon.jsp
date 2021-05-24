<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@include file="../../common/header.jsp" %>


<!DOCTYPE html>
<html>
<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/css/user/deal/sale.css" type="text/css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>

<body>
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
                            <ul class="categorybox"> <!-- 대분류 카테고리 -->
                                <c:forEach items="${categoryList}" var="catL">
                                    <li class="categorySelect">
                                        <button type="button" class="select"><c:out value="${catL.name}"/></button>
                                    </li>
                                </c:forEach>

                            </ul>
                        </div>
                        <div class="innerbox">
                            <!-- <span>중분류 선택</span> -->
                            <ul class="brandbox"> <!-- 중분류 카테고리 -->

                            </ul>
                        </div>

                        <div class="innerbox">
                            <!-- <span>소분류 선택<span> -->
                            <ul class="productbox"> <!-- 소분류 카테고리 -->

                            </ul>


                        </div>
                    </div>
                    <h3 class="showCategory" style="text-align:left">선택한 카테고리 : <b></b></h3>
                    <div class="prodInfo">
                        <div class="imgspace"> <!-- 이미지 테두리-->
                            <img id="prodImg" src="/resources/img/product/99/9999/999999.jpeg">
                        </div>
                        <textarea id="prodDescn" readonly>
                                </textarea>
                    </div>
                </div>
            </div>
            <!-- 가격 정보 자리 시작 -->

            <!-- 바코드 + 유효기간 시작 -->
            <div class="couponblock">
                <div class="catename">
                    바코드
                    <span>*</span>
                </div>
                <div class="innerblock">
                    <input type="text" id="barcode" placeholder=" 바코드 번호를 입력해주세요.">
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
                    <%--                    <input type="date" id="end-date"> <!-- datepicker로 나중에 바꿔보기-->--%>
                    <input type="text" id="end-date" readonly>
                    <label>
                        기프티콘에 명시된 유효기간을 입력해주세요.
                    </label>
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
                        <div class="thumbnailspace">
                            <label>
                                <input type="image" src="/resources/img/thumbnailDefault2.png" id="thumbnail">
                                <input type="file" style="display:none" id="gifticon-img-upload" name="uploadFile"
                                       class="file-input" accept="image/jpeg, image/jpg, image/png">
                            </label>

                        </div>
                        <textarea readonly="readonly">[ 쿠폰 등록시 유의사항 ]

1. 반드시 쿠폰 이미지만 잘라서 올려주세요. 캡쳐 이미지에 배터리 잔여량, 통신사, 시간, 화살표 등이 표기된 경우, 저희 시스템상 바코드와 유효기간을 잘못 인식하는 경우가 많아 반려하고 있습니다.

2. 카테고리가 지정된 쿠폰이 우선적으로 검수됩니다. 해당 쿠폰의 정확한 카테고리를 지정해주세요.

3. 기프티콘의 유효기간을 반드시 입력해주세요

4. 기쁘티콘 혹은 기쁘티콘 제휴사에서 구매한 쿠폰은 다시 매입하지 않습니다.
                                </textarea>
                        <!-- 쿠폰 파일 업로드 -->
                        <div class="box-file-input">

                        </div>
                    </div>
                </div>
            </div>

            <div class="block">
                <div class="catename">
                    가격정보
                    <span>*</span>
                </div>
                <div class="innerblock">
                    <div class="pricebox">
                        <div class="pricename">정가</div>
                        <input type="text" id="fixedprice" readonly> 원
                        <div class="pricename"><span>판매가</span>
                            <span id="dcrateindicator">(할인율 : %)</span>

                        </div>
                        <div class="explain">
                            <input type="text" id="dcprice" placeholder=" 숫자만 입력해주세요." readonly> 원
                            <label>
                                자동입력을 체크하시면 유효기간에 따라 금액이 자동으로 측정되어 판매됩니다.<br>
                                60일을 기준으로 15일 간격으로 할인율이 5% 증가됩니다.
                            </label>
                        </div>
                        <div class="pricetype">
                            <label for="autoprice" class="auto">
                                <input id="autoprice" name="group1" type="radio" value="1"> 자동입력
                            </label>
                            <label for="manualprice" class="manual">
                                <input id="manualprice" name="group1" type="radio" value="0"> 가격제시
                            </label>
                        </div>
                    </div>

                </div>

            </div>    <!-- end 가격 정보 -->

            <!-- 기쁘티콘에게 전달할 메시지부터 -->
            <div class="message">
                <div class="message-title">
                    기쁘티콘에게 전달할 메시지
                </div>
                <textarea id="descn" placeholder="이미지에 유효기간/바코드가 없거나 스크래치 번호 등 사용방법에 참고해야할 이야기가 있으시면 적어주세요."></textarea>
            </div>

            <!-- 판매 등록하기 버튼 -->
            <div class="register">
                <button class="btn btn-active" id="saleReg">판매 등록하기</button>
            </div>

        </div>
    </div>

    <!-- Modal -->
    <div class="modal1">
        <div class="black_bg"></div>
        <div class="modal_wrap">
            <div class="modal-content">
                <h1>판매 등록 요청이 완료되었습니다.</h1><br>
                <h3>( 판매 수락은 기쁘티콘 업무시간에 순차적으로 진행됩니다. )</h3>
                <div class="inputcontainer">
                    <div class="inputtitle"></div>
                    <br>
                </div>
                <div class="modalbtn">
                    <button type="button" id="btn-to-main" class="btn btn-active" style="color:white">메인으로 이동</button>
                    <button type="button" id="btn-to-hist" class="btn btn-disabled" style="margin-left:30px">판매 내역으로
                        이동
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
</div>    <!-- end of container -->

<script type="text/javascript">

    $(document).ready(function () {
        // 페이지 로딩시 카테고리 불러오기 실패하면 에러메세지 출력
        if ("${initError}" != "") {
            alert("${initError}");
        }

        // 가격종류 변경시 동작
        $("input:radio[name=group1]").click(function () {
            let radioValue = $(this).val();
            // alert(radioValue);    // 자동입력시 1, 가격제시시 0
            if (radioValue == 1) {
                inputPriceAuto();
                indicateCheckedDcRate();
            } else if (radioValue == 0) {
                dcPriceClean();
                dcRateIndicatorClean();
                $("#dcprice").attr("readonly", false);
            }
        });

        // ------------------------ 파일 업로드
        // 이미지 등록시 자동 업로드
        $(document).on("change", ".file-input", function () {
            var formData = new FormData();
            var inputFile = $("input[name='uploadFile']");
            var files = inputFile[0].files;

            for (var i = 0; i < files.length; i++) {
                // 파일 용량, 확장자 체크
                if (!checkExtension(files[i].name, files[i].size)) {
                    return false;
                }
                formData.append("uploadFile", files[i]);
            }

            let csrfHeaderName = "${_csrf.headerName}";
            let csrfTokenValue = "${_csrf.token}";

            $.ajax({
                url: '/user/uploadAjaxAction',
                processData: false,
                contentType: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                data: formData,
                type: 'POST',
                dataType: 'json',
                success: function (result) {
                    // 이미지 등록 성공시 썸네일 이미지 불러오기
                    showUploadedFile(result);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });  //$.ajax
        });
    });  //end of $(document).ready()

    // 업로드 파일 확장자, 용량 제한
    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    var maxSize = 5242880; //5MB

    function checkExtension(fileName, fileSize) {
        if (fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }

        if (regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }
        return true;
    }

    // 자동입력 선택시 작동하는 함수 - 정가에 값이 있을 때만 판매가 입력 가능, 유효기간 선택 안했으면 오류메시지 출력
    let inputPriceAuto = function () {
        $('#dcprice').attr('readonly', true);
        let fixedprice = document.getElementById('fixedprice').value;

        if (document.getElementById('end-date').value == "") {
            alert("유효기간을 먼저 입력해주세요.");
            dcPriceClean();
            priceChoiceButtonClean();
            return;
        }

        if (fixedprice != "") {
            // 자동입력가는 할인율(기본할인율 + 날짜별 추가할인율) 적용 후 일의자리에서 반올림
            document.getElementById('dcprice').value = Math.round(fixedprice * (1 - (inDcRate + getAddDcRate())) / 10.0) * 10;
        } else {
            dcPriceClean();
        }
    }

    // 정가 입력값 비우는 함수
    let fixedPriceClean = function () {
        document.getElementById('fixedprice').value = "";
    }

    // 판매가 입력값 비우는 함수
    let dcPriceClean = function () {
        document.getElementById('dcprice').value = "";
    }

    // 가격종류 선택버튼 입력값 비우는 함수
    let priceChoiceButtonClean = function () {
        document.getElementById('autoprice').checked = false;
        document.getElementById('manualprice').checked = false;
    }

    // 가격정보 모두 지우는 함수
    let priceAllClean = function () {
        fixedPriceClean();
        dcPriceClean();
        priceChoiceButtonClean();
    }

    // 할인율 계산해주는 함수
    let calculateDcRate = function () {
        let fixedprice = parseInt(document.getElementById('fixedprice').value);
        let dcprice = 0;
        if (document.getElementById('dcprice').value != "") {
            dcprice = parseInt(document.getElementById('dcprice').value);
        }

        return Math.round((fixedprice - dcprice) / fixedprice * 100);
    }

    // 할인율 표시해주는 함수
    let indicateDcRate = function (dcrate) {
        document.getElementById('dcrateindicator').innerText = "(할인율 : " + dcrate + "%)"
    }

    // 할인율 체크(NaN 혹은 100이면 표시하지 않음)하고 최종적으로 화면에 표시해주는 함수
    let indicateCheckedDcRate = function () {
        let dcrate = "";
        if (!(isNaN(calculateDcRate()) || calculateDcRate() == 100)) {
            dcrate = calculateDcRate();
        }
        indicateDcRate(dcrate);
    }

    // 판매가가 정가보다 높으면 에러메세지 출력하고 판매가 초기화하는 함수
    let checkDcPrice = function () {
        let fixedprice = parseInt(document.getElementById('fixedprice').value);
        let dcprice = parseInt(document.getElementById('dcprice').value);

        if (dcprice > fixedprice) {
            alert("정가보다 높은 가격으로 판매할 수 없습니다.");
            dcPriceClean();
        }
    }

    // 문자열에서 앞 0 제거하는 함수
    let trimFrontZero = function (String) {
        return String.replace(/(^0+)/, "");
    }

    // 문자열에서 숫자만 남기는 함수
    let trimString = function (string) {
        return string.trim().replace(/[^0-9]/g, "");
    }

    // 할인율 표시 초기화 함수
    let dcRateIndicatorClean = function () {
        document.getElementById('dcrateindicator').innerText = '(할인율 : %)';
    }

    // product img 삭제하는 함수
    let deleteProdImg = function () {
        document.getElementById('prodImg').src = "/resources/img/product/99/9999/999999.jpeg";
    }

    // product 설명 삭제하는 함수
    let deleteProdDescn = function () {
        document.getElementById('prodDescn').textContent = "";
    }

    // product 이미지, 설명 삭제하는 함수
    let deleteProdInfo = function () {
        deleteProdImg();
        deleteProdDescn();
    }

    // 선택한 카테고리 출력용 변수
    let selectedCatName = "";
    let selectedBrdName = "";
    let selectedProdName = "";

    let catSelectResultText = function () {
        return "선택한 카테고리 : " + selectedCatName;
    }

    let brdSelectResultText = function () {
        return "선택한 카테고리 : " + selectedCatName + " > " + selectedBrdName;
    }

    let prodSelectResultText = function () {
        return "선택한 카테고리 : " + selectedCatName + " > " + selectedBrdName + " > " + selectedProdName;
    }

    // 선택한 카테고리 문자열 변경해주는 함수
    let changeSelectedResultText = function (text) {
        document.getElementsByClassName('showCategory')[0].innerText = text;
    }

    // 소분류 삭제하는 함수
    let deleteProductList = function () {
        let prodbox = document.getElementsByClassName('productbox')[0];
        let prodboxlength = prodbox.children.length;

        for (let i = 0; i < prodboxlength; i++) {
            prodbox.removeChild(prodbox.children[0]);
        }
    }

    // 대분류 클릭시 동작
    $('.categorySelect').on("click", function () {
        // 대분류 클릭시 대분류이름을 보내고 중분류 객체리스트를 받아온다.
        // 선택퇸 카테고리 텍스트 변경, 상품 정보 삭제, 가격정보 초기화
        let catName = this.innerText;

        // 선택된 카테고리 텍스트 변경
        selectedCatName = this.innerText;
        changeSelectedResultText(catSelectResultText());
        // 가격정보 초기화
        priceAllClean();
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // 대분류 클릭시 소분류 목록 삭제
        deleteProductList();

        // 대분류 클릭시 product 정보 삭제
        deleteProdInfo();

        // 대분류 클릭시 할인율 표시 초기화
        dcRateIndicatorClean();

        // 해당 대분류 하위 중분류 목록 가져옴
        $.ajax({
            url: '/user/getBrandAction?name=' + encodeURI(encodeURIComponent(catName)),
            processData: false,
            contentType: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data: catName,
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                let brbox = document.getElementsByClassName('brandbox')[0];
                let brboxlength = brbox.children.length;

                // 현재 중분류 목록 삭제하고
                for (let i = 0; i < brboxlength; i++) {
                    brbox.removeChild(brbox.children[0]);
                }

                // 새로 받아온 중분류 button 생성해서 연결
                for (let i = 0; i < result.length; i++) {
                    let li = document.createElement('li');
                    li.setAttribute('class', 'brandSelect');
                    let btn = document.createElement('button');
                    btn.setAttribute('type', 'button');
                    btn.setAttribute('class', 'select');
                    btn.innerText = result[i].name;

                    brbox.appendChild(li).appendChild(btn);
                }
            },
            error: function () {
                alert("카테고리 불러오기에 실패했습니다. 다시 시도해주세요.")
            }
        }); //$.ajax
    }); // 대분류 클릭 시 동작

    let brdName = "";

    // 중분류 클릭시 동작
    $('.brandbox').on("click", $('.brandSelect .select'), function (e) {
        // 중분류 클릭시 중분류이름을 보내고 소분류 객체리스트를 받아온다.
        // 선택퇸 카테고리 텍스트 변경, 상품 정보 삭제, 가격정보 초기화
        // alert(e.target.innerText);
        // alert(e.target.type == "button");
        if (e.target.type == "button") {
            brdName = e.target.innerText;
            selectedBrdName = e.target.innerText;
            // 선택된 카테고리 텍스트 변경
            changeSelectedResultText(brdSelectResultText());
            // 가격정보 초기화
            priceAllClean();
            // 중분류 클릭시 product 정보 삭제
            deleteProdInfo();
            // 중분류 클릭시 할인율 초기화
            dcRateIndicatorClean();
        } else {
            return;
        }
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // 해당 중분류 하위 소분류 목록 가져옴
        $.ajax({
            url: '/user/getProductAction?name=' + encodeURI(encodeURIComponent(brdName)),
            processData: false,
            contentType: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data: brdName,
            type: 'GET',
            dataType: 'json',
            success: function (result) {

                // console.log(result);
                // console.log(result.length);
                let prodbox = document.getElementsByClassName('productbox')[0];
                let prodboxlength = prodbox.children.length;

                // 현재 소분류 목록 삭제하고
                for (let i = 0; i < prodboxlength; i++) {
                    prodbox.removeChild(prodbox.children[0]);
                }

                // 새로 받아온 소분류 button 생성해서 연결
                for (let i = 0; i < result.length; i++) {
                    let li = document.createElement('li');
                    li.setAttribute('class', 'productSelect');
                    let btn = document.createElement('button');
                    btn.setAttribute('type', 'button');
                    btn.setAttribute('class', 'select');
                    btn.innerText = result[i].name;

                    prodbox.appendChild(li).appendChild(btn);
                }
            },
            error: function () {
                alert("브랜드 불러오기에 실패했습니다. 다시 시도해주세요.")
            }
        }); //$.ajax
    }); // 중분류 클릭 시 동작

    let cateCode = "";
    let brdCode = "";
    let prodCode = "";
    let prodDescn = "";
    let prc = 0;
    let inDcRate = 0.0;
    let userId = ${userId};
    let originPath = "";
    let barcodepath = "<spring:eval expression="@barcodepath['path']"/>";

    // 소분류 클릭시 동작
    $('.productbox').on("click", $('.productSelect .select'), function (e) {
        // 소분류 클릭시 중분류, 소분류 이름을 보내고 소분류 객체를 받아온다.
        // 선택퇸 카테고리 텍스트 변경, 상품 정보 변경, 가격정보 초기화
        // 등록요청시 전송할 GifticonVO 객체에 받아온 소분류 객체의 변수값 입력
        // alert(e.target.innerText);
        let prodName = "";
        if (e.target.type == "button") {
            prodName = e.target.innerText;
            selectedProdName = e.target.innerText;
            // 선택된 카테고리 텍스트 변경
            changeSelectedResultText(prodSelectResultText());
            // 소분류 클릭시 가격정보 초기화
            dcPriceClean();
            priceChoiceButtonClean();
            // 할인율 표시 초기화
            dcRateIndicatorClean();
        } else {
            return;
        }
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // 소분류 클릭시 중분류, 소분류 이름을 보내고 소분류 객체를 받아온다.
        $.ajax({
            url: '/user/getProductObjectAction?brdName=' + encodeURI(encodeURIComponent(brdName)) +
                '&prodName=' + encodeURI(encodeURIComponent(prodName)),
            processData: false,
            contentType: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data: {brdName: brdName, prodName: prodName},
            type: 'GET',
            dataType: 'json',
            success: function (result) {
                // 등록요청시 전송할 GifticonVO 객체에 받아온 소분류 객체의 변수값 입력
                // alert(result.code.substring(0,2));  //대분류 코드
                cateCode = result.code.substring(0, 2);
                // alert(result.brdCode);  // 중분류 코드
                brdCode = result.brdCode;
                // alert(result.code);   // 소분류 코드
                prodCode = result.code;
                // alert(result.descn); // product 설명
                prodDescn = result.descn;
                // alert(result.prc);  // 정가
                prc = result.prc;
                // alert(result.inDcRate);  // 기본할인율
                inDcRate = result.inDcRate;

                // 상품 이미지, 설명 변경
                // document.getElementById('prodImg').src = "/resources/img/product/01/0101/010101.jpeg";
                // let imgSrc = "/resources/img/product/" + cateCode + "/" + brdCode + "/" + prodCode + ".jpeg";
                document.getElementById('prodImg').src = result.imgPath;
                document.getElementById('prodDescn').textContent = prodDescn;
                document.getElementById('fixedprice').value = prc;
            },
            error: function () {
                alert("상품 불러오기에 실패했습니다. 다시 시도해주세요.")
            }
        }); // $.ajax
    }); // 소분류 클릭 시 동작

    originPath = "";

    // 이미지 업로드시 썸네일 보여주는 함수
    function showUploadedFile(uploadResultArr) {

        $(uploadResultArr).each(function (i, obj) {
            // fileCallPath : 썸네일 이미지 경로
            var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" +
                obj.uuid + "_" + obj.fileName);

            // controller 호출. 썸네일 이미지 받아옴
            document.getElementById('thumbnail').src =
                "/user/display?fileName=/" + fileCallPath;

            // DB gifticon 테이블 img_path에 입력할때 사용할 변수 originPath
            originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;

            originPath = originPath.replace(new RegExp(/\\/g), "/");
        });
    }

    // 바코드 번호 입력시 동작
    $('#barcode').on("propertychange change keyup paste input", function () {
        let rawBarcode = document.getElementById('barcode').value;
        document.getElementById('barcode').value = trimString(rawBarcode);
    });

    // 판매가 변경시 동작
    $('#dcprice').on("propertychange change keyup paste input", function () {
        checkDcPrice();
        indicateCheckedDcRate();
        let rawDcPrice = document.getElementById('dcprice').value;
        // 문자 제거하고 앞자리 0 제거
        document.getElementById('dcprice').value = trimFrontZero(trimString(rawDcPrice));
    });

    // 썸네일이미지 클릭시 동작
    $("#thumbnail").on("click", function () {
        document.getElementById('gifticon-img-upload').click();
    });

    // 모달 버튼 클릭시 동작
    $('#btn-to-main').on("click", function () {
        location.href = "/user/home";
    });

    $('#btn-to-hist').on("click", function () {
        location.href = "/user/mypage/sells";
    });

    // 판매 등록하기 버튼 클릭시 동작
    $("#saleReg").on("click", function () {

        // 유효성검사
        if (userIdCheck()) {
            alert("회원정보를 확인할 수 없습니다. 다시 로그인해주세요.")
            return;
        }

        if (prodCodeCheck()) {
            alert("상품을 선택해주세요.")
            return;
        }

        if (barcodeCheck()) {
            alert("기프티콘 바코드 번호를 입력해주세요.")
            return;
        }

        if (endDateCheck()) {
            alert("기프티콘 유효기간을 입력해주세요.")
            return;
        }

        if (originPathCheck()) {
            alert("쿠폰 이미지를 등록해주세요.")
            return;
        }

        if (priceTypeCheck()) {
            alert("판매가격 종류를 선택해주세요. (자동입력 혹은 가격제시)")
            return;
        }

        if (dcPriceCheck()) {
            alert("판매가격을 입력해주세요.")
            return;
        }

        if (dcPriceCheckOver100()) {
            alert("100원 미만의 가격으로 판매할 수 없습니다.")
            return;
        }

        if (inDcRateCheck()) {
            alert("상품 할인율 정보를 불러오는데 실패했습니다. 관리자에게 문의해주세요.")
            return;
        }

        // 유효성검사 모두 통과하면 판매등록 진행
        insertGifticonValues();
    });

    // 유효성검사 통과 시 Ajax로 DB에 Insert하는 함수
    let insertGifticonValues = function () {
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        var form =
            {
                id: null,
                userId: userId,
                prodCode: prodCode,
                dcPrc: $("#dcprice")[0].value * 1,
                dcRate: inDcRate + getAddDcRate(),
                expirDt: $("#end-date")[0].value,
                brcd: $("#barcode")[0].value,
                descn: $("#descn")[0].value,
                imgPath: barcodepath + "/" + originPath,
                isAutoPrc: $("input[name=group1]:checked")[0].value,
                gftStusCode: '001',
                aprvDt: null,
                inDate: null,
                upDate: null
            }

        $.ajax({
            url: '/user/registerGifticonAction',
            processData: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data: JSON.stringify(form),
            contentType: "application/json; charset=utf-8",
            type: 'POST',
            success: function (result) {

                console.log(result);
                // 등록 성공시 모달창 보여주기
                showFinalModal();

            },
            error: function (error) {
                console.log(error);
                alert("등록과정에서 오류가 발생했습니다. \n" +
                    "(이미 등록된 바코드번호일 수 있습니다.)");
            }
        });
    }


    // ------------------유효성검사 개별 함수------------------
    // 회원정보 확인
    let userIdCheck = function () {
        return userId === 0
    }

    // 상품코드 확인
    let prodCodeCheck = function () {
        return prodCode === "";
    }

    // 판매가격 입력 확인
    let dcPriceCheck = function () {
        return $("#dcprice")[0].value === "";
    }

    // 판매가격 100원 이상인지 확인
    let dcPriceCheckOver100 = function () {
        return parseInt($("#dcprice")[0].value) < 100;
    }

    // 상품 기본 할인율 적용여부 확인
    let inDcRateCheck = function () {
        return inDcRate === 0.0
    }

    // 유효기간 입력 확인
    let endDateCheck = function () {
        return $("#end-date")[0].value === "";
    }

    // 바코드번호 입력 확인
    let barcodeCheck = function () {
        return $("#barcode")[0].value === "";
    }

    // 바코드이미지 등록 확인
    let originPathCheck = function () {
        return originPath === "";
    }

    // 가격종류 선택 확인
    let priceTypeCheck = function () {
        return $("input[name=group1]:checked")[0] === undefined;
    }
    // ------------------유효성검사 개별 함수------------------


    // 모달 배경처리
    function wrapWindowByMask() {
        var maskHeight = $(document).height();

        $('.black_bg').css('height', maskHeight);
        $('.black_bg').css('display', 'block');
    }

    // 모달창 띄워주기
    let showFinalModal = function () {
        wrapWindowByMask();
        $('.modal_wrap').css('left', ($(window).width() - 850) * 0.5);
        $('.modal_wrap').css('display', 'block');

        // 스크롤 고정
        $('html, body').css({'overflow': 'hidden', 'height': '100%'});
        $('#element').on('scroll touchmove mousewheel', function (event) {
            event.preventDefault();
            event.stopPropagation();
            return false;
        });
    };

    // 날짜에 따른 추가 할인율 계산
    let getAddDcRate = function () {
        let addDcRate = 0.0;
        let expirDt = new Date($("#end-date")[0].value);
        let today = new Date();
        // 만료일까지 남은 일 수 계산
        let diffInMillies = expirDt.getTime() - today.getTime();
        let dateDiff = Math.ceil(diffInMillies / (1000 * 3600 * 24));

        if (dateDiff <= 60 && dateDiff >= 0) {
            // 남은기간 60일부터 15일간격으로 할인율 변경구간 분리
            let interval = Math.ceil((60 - dateDiff) / 15);
            // 구간별 할인율 계산 (5%, 10%, 15%, 20%)
            let dcRateByInterval = interval * 0.05;
            // 소수점 2째자리 밑으로 버림(부동소수점 제거)
            addDcRate = Math.floor(dcRateByInterval * 100) / 100;
        }
        return addDcRate;
    }

    // 대분류 클릭시 동작
    // 선택된 대분류에만 클래스이름 추가, 나머지는 삭제
    $(".categorySelect").children(".select").on("click", function () {
        $(".categorySelect").children(".select").removeClass('on');
        $(this).addClass('on');
    });

    // 중분류 클릭시 동작
    // 선택된 중분류에만 클래스이름 추가, 나머지는 삭제
    $(".brandbox").on("click", $('.brandSelect'.select), function (e) {
        $(".brandSelect").children(".select").removeClass('on');
        $(e.target).addClass('on');
    });

    // 소분류 클릭시 동작
    // 선택된 소분류에만 클래스이름 추가, 나머지는 삭제
    $(".productbox").on("click", $('.productSelect'.select), function (e) {
        $(".productSelect").children(".select").removeClass('on');
        $(e.target).addClass('on');
    });

    // 유효기간 변경 시 가격 종류, 입력값 초기화, 할인율 표시 초기화
    $("#end-date").change(function () {
        dcPriceClean();
        priceChoiceButtonClean();
        dcRateIndicatorClean();
    });

    // datepicker
    $("#end-date").datepicker({
        dateFormat: 'yy-mm-dd',
        minDate: 0
    });

</script>
</body>
</html>