<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../../common/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/user/gifticon/map.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ac51465d91bcae237e6703842ae5d0c5&libraries=services"></script>
    <title>Document</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>
</head>
<body>

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
                <div class="container"><!--메인컨텐츠 (이하 각자 내용 작성)-->
                <div class="selectedbrd"></div>
                <div id="map"></div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>

<script>
    $(document).ready(function(){

        let cateBtn = $(".cateList");

        cateBtn.on("click", function(){

            $(".cateList").css("color", "black");
            $(this).css( "color", "rgb(255,88,93)" );

            let cateCode = $(this).val();
            let cateName = $(this).text();
            cateCode = "0" + cateCode;

            $.ajax({
                url:'/user/map/getBrdList/' + cateCode,
                type: 'get',
                dataType: 'json',
                success: function(result){

                    let str = "";

                    str += "<li class='brdList'><input type='checkbox' class='all' name='전체' id='" + cateName + " 전체" + "' value='" + cateCode+ "'>전체</li>";

                    for(var key in result){
                     str += "<li class='brdList'><input type='checkbox' class='brand' name='" + result[key] + "' value='" + key + "'>" + result[key] + "</li>";
                    }

                    $(".brandbar").html(str);
                    $(".brandbar").css("visibility","visible");

                },
                error: function(){
                    alert("error received");
                }

            })
        })
    })
</script>
<script> //브랜드 checkbox

    //매장 검색용 선택 List
    var brand = [];

    $(".brandbar").on("click",function(){

        brand = [];

        //화면 출력용 선택 List
        var name = [];

        $("input[class='brand']:checked").each(function(){

            name.push($(this).attr('name'));
            brand = name;
        });

        if($("input[name='전체']").is(":checked") == true){

            $("input:checkbox[class='brand']").prop("checked",false);
            $("input:checkbox[class='brand']").prop("disabled", true);

            brand = [];
            name = [];
            name = $("input[name='전체']").attr('id');

            $(".brand").each(function(){
                brand.push($(this).attr('name'));
            })

        }else{
            $("input:checkbox[class='brand']").prop("disabled", false);
        }
        $('.selectedbrd').text(name);
    });

</script>
<script>
    var lat = 0;
    var lon = 0;

    if (navigator.geolocation) {
        // 현재 접속 위치 얻기
        navigator.geolocation.getCurrentPosition(function(position) {
            lat = position.coords.latitude; // 위도
            lon = position.coords.longitude; // 경도

            lat = lat.toFixed(6);
            lon = lon.toFixed(6);
        });
    } else {
       lat = 33.450701;
       lon = 126.570667;
    }

</script>
<script> //카카오맵 로딩


    $(document).ready(function(){

        var container = document.getElementById('map');

        //최초 지도 로딩 설정
        var options = {center: new kakao.maps.LatLng(lat, lon),
                        level: 3};

        //카카오맵 생성
        var map = new kakao.maps.Map(container, options);

        // 검색객체 생성
        var places = new kakao.maps.services.Places(map);

        //최초 마커 생성
        var marker = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(0,0)
        });

        //검색 결과 출력용 마커 배열
        var markers= [];

        //마커 표시 함수
        function displayMarker(result){

            for(let j=0; j<result.length; j++){

                marker = new kakao.maps.Marker({
                    map: map,
                    position: new kakao.maps.LatLng(result[j].y,result[j].x),
                    title: result[j].place_name
                });
                markers.push(marker);
            }
        }

        //마커 삭제 함수
        function removeMarker(){

            for(let j=0; j<markers.length; j++){
                markers[j].setMap(null);
            }
            markers = [];
        }

        //검색 결과 callback 함수
        function callback (result, status){

            //검색 결과 있을 시
            if(status === kakao.maps.services.Status.OK){
                searchGifticon(result[0].category_name);
                displayMarker(result);
            }else{
                //다중 브랜드 검색 시, total 검색 결과에 따라 not Found 추가 또는 삭제
                if($(".searchedGft").length == 0){
                    let notFound = "";
                    notFound += '<div class="mapUsingGuide notFound"><span>검색된 매장이 없습니다.</span></div>';
                    $(".listSpace").html(notFound);
                }
            }

        };

        //카카오 키워드 검색
        function searchGifticon(cateString){

            //검색 결과의 카테고리에서 문자열 splicing
            let categories = cateString.split(' > ');

            //검색 결과 중 브랜드 이름만 출력
            let brdName = categories.reverse()[0];

            $.ajax({
                url:'/user/map/getMainGfts/' + brdName,
                type: 'get',
                dataType: 'json',
                success: function(result){

                    let str = "";

                    for (let i = 0; i < result.length; i++) {
                        str += '<a class="searchedGft" href="/user/gifti_detail?code=' + result[i].prodCode + '">';
                        str += '<div class="bar ' + result[i].prodCode + '">';
                        str += '<div class="prdImg"><img src="' + result[i].pimgPath + '"></div>';
                        str += '<div class="prdInfo">';
                        str += '<div class="brdName">' + result[i].bname + '</div>';

                        if(result[i].pname.length >= 14){
                            str += '<div class="prdName small">' + result[i].pname + '</div>';
                        }else{
                            str += '<div class="prdName medium">' + result[i].pname + '</div>';
                        }

                        str += '<div class="prcInfo">';
                        str += '<span class="dcRate">' + Math.round(result[i].dcRate * 100) + '%' + '</span>';
                        str += '<span class="dcPrc">' + result[i].dcPrc + '원' + '</span>';
                        str += '<span class="oriPrc">' + result[i].prc + '원' + '</span>';
                        str += '    </div>';
                        str += '   </div>';
                        str += '   </div>';
                        str += '  </a>';
                    }

                    $(".listSpace").append(str);

                    //다중 브랜드 검색 시, total 검색 결과에 따라 not Found 추가 또는 삭제
                    if($(".searchedGft").length == 0){
                        let notFound = "";
                        notFound += '<div class="mapUsingGuide notFound"><span>판매중인 기프티콘이 없습니다.</span></div>';
                        $(".listSpace").html(notFound);
                    }else{
                        $(".notFound").remove();
                    }
                },
                error: function(error){
                    alert("error received");

                }
            })
        }

        //맵 drag 할 때 검색 실행
        kakao.maps.event.addListener(map, 'dragend', function(){

            //지도 위치 기준으로 검색 설정
            var position = map.getCenter();
            var bound = map.getBounds();

            //이전 출력 마커 삭제 후 진행
            removeMarker();

            //이전 기프티콘 리스트 삭제 후 진행
            $(".listSpace").html("");

            //검색 브랜드 리스트에서 검색 실행
            for(let i in brand){
                console.log("검색: " + brand[i]);

                var searchOptions = {
                    location: position,
                    bounds: bound,
                    size: 15
                };
                places.keywordSearch(brand[i], callback, searchOptions);
            }
        })
    })

</script>
