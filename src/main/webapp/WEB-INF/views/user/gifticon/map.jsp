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
                        
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                    <a href="(메뉴이동">
                        <div class="bar">
                            <div class="prdImg"><img src="img/star_americano.png"></div>
                            <div class="prdInfo">
                                <div class="brdName">스타벅스</div>
                                <div class="prdName">부드러운 디저트 세트</div>
                                <div class="prcInfo">
                                    <span class="dcRate">70%</span>
                                    <span class="dcPrc"> 5200원</span>
                                    <span class="oriPrc"> 7000원</span>
                                </div>
                            </div>
                        </div>
                    </a>
                   
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

        //
        var value = [];

        //화면 출력용 선택 List
        var name = [];

        $("input[class='brand']:checked").each(function(){
            value.push($(this).val());
            name.push($(this).attr('name'));

            brand = name;
        });

        if($("input[name='전체']").is(":checked") == true){
            $("input:checkbox[class='brand']").prop("checked",false);
            $("input:checkbox[class='brand']").prop("disabled", true);

            brand = [];

            value = "";
            name = "";

            value = $("input[name='전체']").val();
            name = $("input[name='전체']").attr('id');

            $(".brand").each(function(){
                brand.push($(this).attr('name'));
            })

        }else{
            $("input:checkbox[class='brand']").prop("disabled", false);
        }

        $('.selectedbrd').text(name);

        console.log("brand : " + brand);
        console.log("brand size : " + brand.length);
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

        var infowindow = new kakao.maps.InfoWindow({zIndex:1});

        var container = document.getElementById('map');

        var options = {
            center: new kakao.maps.LatLng(lat, lon),
            level: 3
        };

        //카카오맵 생성
        var map = new kakao.maps.Map(container, options);

        // 검색객체 생성
        var places = new kakao.maps.services.Places(map);

        var marker = new kakao.maps.Marker({
            position: new kakao.maps.LatLng(0,0)
        });

        var markers= [];

        var callback = function(result, status){

            if(status === kakao.maps.services.Status.OK){
                    displayMarker(result);
            }
        };

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

        function removeMarker(){

            for(let j=0; j<markers.length; j++){
                markers[j].setMap(null);
            }
            markers = [];
        }


        kakao.maps.event.addListener(map, 'dragend', function(){

            var position = map.getCenter();
            var bound = map.getBounds();

            removeMarker();

            for(let i in brand){
                console.log("검색: " + brand[i]);

                var searchOptions = {
                    location: position,
                    bounds: bound,
                    size: 15
                };

                places.keywordSearch(brand[i],callback,searchOptions);
            }

            console.log("position: " + position);
            console.log("bound : " + bound);

        })

    })

</script>