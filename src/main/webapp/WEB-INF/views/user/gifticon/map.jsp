<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="../../common/header.jsp" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ac51465d91bcae237e6703842ae5d0c5&libraries=services"></script>
    <title>Document</title>

    <link rel="stylesheet" href="/resources/css/user/gifticon/map.css" type="text/css">
</head>

<div id="container">
    <div class="space"></div>
    <div class="main">
        <div class="menuhead">
            <div class="menuname"><span>지도 검색</span></div>
            <div class="searchbar">
                <div class="categorybar">
                    <c:forEach items="${cateList}" var="cate">
                        <li class="cateList" value="<c:out value="${cate.code}"/>"><c:out value="${cate.name}"/></li>
                    </c:forEach>
                </div>
                <ul class="brandbar">
                </ul>
            </div>
        </div>
        <div class="menubody">
            <div class="listSpace type1">
                <div class="mapUsingGuide"><span>브랜드 선택 후 매장을 찾아주세요.</span></div>
            </div>
            <div class="map-container"><!--메인컨텐츠 (이하 각자 내용 작성)-->
                <div class="selectedbrd"></div>
                <div id="map"></div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>

<script>
    $(document).ready(function () {
        let cateBtn = $(".cateList");

        cateBtn.on("click", function () {

            $(".cateList").css("color", "black");
            $(this).css("color", "rgb(255,88,93)");

            let cateCode = $(this).val();
            let cateName = $(this).text();
            cateCode = "0" + cateCode;

            $.ajax({
                url: '/user/map/getBrdList/' + cateCode,
                type: 'get',
                dataType: 'json',
                success: function (result) {

                    let str = "";

                    str += "<li class='brdList'><input type='checkbox' class='all' name='전체' id='" + cateName + " 전체" + "' value='" + cateCode + "'>전체</li>";

                    for (var key in result) {
                        str += "<li class='brdList each'><input type='checkbox' class='brand' name='" + result[key] + "' value='" + key + "'>" + " " + result[key] + "</li>";
                    }

                    $(".brandbar").html(str);
                    $(".brandbar").css("visibility", "visible");

                },
                error: function () {
                    alert("error received");
                }
            });
        });
    });
</script>
<script> //브랜드 checkbox

//매장 검색용 선택 List
var brand = [];

$(".brandbar").on("click", function () {

    brand = [];

    //화면 출력용 선택 List
    var name = [];

    $("input[class='brand']:checked").each(function () {

        name.push($(this).attr('name'));
        brand = name;
    });

    if ($("input[name='전체']").is(":checked") == true) {

        $("input:checkbox[class='brand']").prop("checked", false).prop("disabled", true);
        $(".each").css("color", "grey");


        brand = [];
        name = [];
        name = $("input[name='전체']").attr('id');

        $(".brand").each(function () {
            brand.push($(this).attr('name'));
        })

    } else {
        $("input:checkbox[class='brand']").prop("disabled", false);
        $(".each").css("color", "black");
    }
    $('.selectedbrd').text(name);
});
</script>

<script>
    var lat = 37.715133;
    var lon = 126.734086;

    // if (navigator.geolocation) {
    //     // 현재 접속 위치 얻기
    //     navigator.geolocation.getCurrentPosition(function (position) {
    //         lat = position.coords.latitude; // 위도
    //         lon = position.coords.longitude; // 경도
    //
    //         lat = lat.toFixed(6);
    //         lon = lon.toFixed(6);
    //     });
    // } else {
    //     lat = 33.450701;
    //     lon = 126.570667;
    // }

</script>

<script> //카카오맵 로딩
$(document).ready(function () {

    const container = document.getElementById('map');

    //최초 지도 로딩 설정
    const options = {center: new kakao.maps.LatLng(lat, lon), level: 3};

    //카카오맵 생성
    const map = new kakao.maps.Map(container, options);

    // 검색객체 생성
    const places = new kakao.maps.services.Places(map);

    //최초 마커 생성
    let marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(0, 0)
    });

    //검색 결과 출력용 마커 배열
    let markers = [];

    //장소 검색 결과 리스트
    let placeResults = [];

    //기프티콘 검색 결과 리스트
    let gftResult = [];

    //마커 표시 함수
    function displayMarker(result) {
        for (let i = 0; i < result.length; i++) {
            for (let j = 0; j < result[i].documents.length; j++) {

                marker = new kakao.maps.Marker({
                    map: map,
                    position: new kakao.maps.LatLng(result[i].documents[j].y, result[i].documents[j].x),
                    title: result[i].documents[j].place_name
                });
                markers.push(marker);
            }
        }
    }

    //마커 삭제 함수
    function removeMarker() {

        for (let j = 0; j < markers.length; j++) {
            markers[j].setMap(null);
        }
        markers = [];
    }

    //카카오맵 장소 검색 메서드
    function searchPlaces(query, API_KEY) {

        const response = fetch("https://dapi.kakao.com/v2/local/search/keyword.json?" + query,
            {headers: {Authorization: 'KakaoAK ' + API_KEY}});

        return response.then(res => res.json());

    }

    //장소검색 핸들러
    async function placeSearchHandler(brand) {
        let bound = map.getBounds();
        let params = {"rect": bound.ha + "," + bound.qa + "," + bound.oa + "," + bound.pa};
        const API_KEY = "9f25bd36ab923b67977eb8ffa2d6c29a";

        let keywordPromise = [];

        brand.forEach(brand => {
            params.query = brand;
            let query = Object.keys(params).map(k => encodeURIComponent(k) + '=' + encodeURIComponent(params[k])).join('&');
            const response = searchPlaces(query, API_KEY);

            keywordPromise.push(response);
        });

        await Promise.all(keywordPromise)
            .then((result) => insertPlcInResultList(placeResults, result))
            .then(() => gifticonSearchHandler(placeResults));
    }

    //기프티콘검색핸들러
    async function gifticonSearchHandler(placeResults) {
        if (placeResults.length != 0) {

            let promiseList = [];

            placeResults.forEach(brand => {
                const response = searchGifticon(brand.meta.same_name.keyword)
                promiseList.push(response)
            })

            await Promise.allSettled(promiseList)
                .then((results) => {
                    results.forEach(result => {
                        if (result.status == 'fulfilled') {
                            insertGftInResultList(result)
                        }
                    });
                })
                .then(() => displayGifticon(gftResult));

            displayMarker(placeResults);
        } else {
            let notFound = "";
            notFound += '<div class="mapUsingGuide notFound"><span>검색된 매장이 없습니다.</span></div>';
            $(".listSpace").html(notFound);
        }
    }

    //판매중인 기프티콘 검색
    function searchGifticon(brdName) {
        return new Promise(function (resolve, reject) {
            $.ajax({
                url: '/user/map/getMainGfts/' + brdName,
                type: 'get',
                dataType: 'json',
                statusCode: {
                    200: function (result) {
                        resolve(result);
                    },
                    204: function () {
                        reject();
                    },
                    500: function () {
                        alert("검색 오류가 발생했습니다. 관리자에게 문의하세요.");
                        reject();
                    }
                }
            });
        });
    }

    //기프티콘 목록 출력
    function displayGifticon(gftResult) {

        if (gftResult.length == 0) {
            let notFound = "";
            notFound += '<div class="mapUsingGuide notFound"><span>판매중인 기프티콘이 없습니다.</span></div>';
            $(".listSpace").html(notFound);
        } else {
            let str = "";
            for (let i = 0; i < gftResult.length; i++) {

                str += '<a class="searchedGft" href="/user/gifti_detail?code=' + gftResult[i].prodCode + '">';
                str += '<div class="bar ' + gftResult[i].prodCode + '">';
                str += '<div class="prdImg"><img src="' + gftResult[i].pimgPath + '"></div>';
                str += '<div class="prdInfo">';
                str += '<div class="brdName">' + gftResult[i].bname + '</div>';

                let pnameSize = gftResult[i].pname.length;

                if (pnameSize >= 16) {
                    str += '<div class="prdName small">' + gftResult[i].pname.substr(0, 15) + '...' + '</div>';
                } else if (16 < pnameSize && pnameSize >= 12) {
                    str += '<div class="prdName small">' + gftResult[i].pname + '</div>';
                } else {
                    str += '<div class="prdName medium">' + gftResult[i].pname + '</div>';
                }

                str += '<div class="prcInfo">';
                str += '<span class="dcRate">' + Math.round(gftResult[i].dcRate * 100) + '%' + '</span>';
                str += '<span class="dcPrc">' + gftResult[i].dcPrc + '원' + '</span>';
                str += '<span class="oriPrc">' + gftResult[i].prc + '원' + '</span>';
                str += '    </div>';
                str += '   </div>';
                str += '   </div>';
                str += '  </a>';
            }

            $(".listSpace").html(str);
        }
    }

    //기프티콘 검색결과 리스트에 넣기
    async function insertGftInResultList(result) {
        result.value.forEach(gifticon => {
                gftResult.push(gifticon)
            }
        )
    }

    //장소 검색결과 리스트에 넣기
    async function insertPlcInResultList(placeResults, response) {
        for (let i = 0; i < response.length; i++) {
            if (response[i].documents.length != 0) {
                placeResults.push(response[i]);
            }
        }
    }

    //맵 움직일 때 검색 실행
    kakao.maps.event.addListener(map, 'dragend', function () {

        //이전 출력 마커 삭제 후 진행
        removeMarker();

        //이전 기프티콘 리스트 삭제 후 진행
        $(".listSpace").html("");

        //검색, 출력 배열 초기화
        placeResults = [];
        gftResult = [];

        placeSearchHandler(brand);
    });
});
</script>