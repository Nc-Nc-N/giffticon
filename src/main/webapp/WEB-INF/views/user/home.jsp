<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common/header.jsp"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/resources/css/user/home.css" type="text/css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>
</head>

<!--여기서부터 home body-->
<body>
    <div class="space"></div> <!--광고 위 여백-->
    <div id="advertiser"> <!--광고판테두리-->
        <div class="advertise"> <!--광고 삽입-->

        </div>
        <span> 
            <i class="fas fa-chevron-left"></i>
            &nbsp;&nbsp;&nbsp;
            <i class="fas fa-chevron-right"></i>
        </span>
    
    </div>
    <div id="container"> <!-- 광고 아래 메인 컨텐츠-->
        <div class="space"></div>
            
        <div class="prdlist"><!-- 첫째줄 (지도 + 관심상품)-->
            <div class="listname_first"><!--카테고리 이름 삽입-->
                <div class='listnamefirst'>
                    <h3><i class="fas fa-map-marked-alt"></i>&nbsp;지도로 찾는 기쁘티콘</h3>
                </div>
                <div class='listnamelast'>
                    <h3><i class="far fa-heart"></i>&nbsp;나만의 관심상품</h3>
            
                </div>
                <div class="categorycontroller">
                    <div class="categorypaging">
                        <!--페이징 이동 바 삽입해주세요!!!-->
                        페이지 이동 바 삽입!!
                    </div>
                    <div class="watchAll"><a href="(카테고리전체보기이동)">전체보기</a></div>
                </div>
                
            </div>
            <div class="listcontent"><!--카테고리 컨텐츠 삽입-->
                <div class="maps"><!--지도 삽입-->
                    <div class="mapicon">
                        <a href="(위치찾기)"><p><img src="img/map.png"></p></a> <!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="mapinfo">
                        <span>현재 위치에서 기쁘티콘 찾기</span>
                    </div>
                </div>

                <!-- 관심상품 db값을 html태그와 함께for문으로 출력(중복제거)-->
                <div class="items"><!--상품1-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <div class="items"><!--상품2-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <div class="items"><!--상품3-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <!-- 관심상품 for문 종료 -->

            </div>
        </div>
        <div class="prdlist"><!-- 둘째줄 (인기상품)-->
            <div class="listname">
                <div class='listnametotal'>
                    <h3><i class="far fa-thumbs-up"></i>&nbsp;모두들 찾는 인기상품</h3>
                </div>
                <div class="categorycontroller">
                    <div class="categorypaging">
                        <!--페이징 이동 바 삽입해주세요!!!-->
                        페이지 이동 바 삽입!!
                    </div>
                    <div class="watchAll"><a href="(카테고리전체보기이동)">전체보기</a></div>
                </div>
            </div>
            <div class="listcontent">
                <!-- 관심상품 db값을 html태그와 함께for문으로 출력 -->
                <div class="items"><!--상품1-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <div class="items"><!--상품2-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <div class="items"><!--상품3-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <div class="items"><!--상품4-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <!-- 관심상품 for문 종료 -->

            </div>
        </div>
        <div class="prdlist"><!--셋째줄 (임박상품)-->
            <div class="listname">
                <div class='listnametotal'>
                    <h3><i class="far fa-clock"></i>&nbsp;초특가! 만료 임박 상품</h3>
                </div>
                <div class="categorycontroller">
                    <div class="categorypaging">
                        <!--페이징 이동 바 삽입해주세요!!!-->
                        페이지 이동 바 삽입!!
                    </div>
                    <div class="watchAll"><a href="(카테고리전체보기이동)">전체보기</a></div>
                </div>
            </div>
            <div class="listcontent">
                <!-- 관심상품 db값을 html태그와 함께for문으로 출력 -->
                <div class="items"><!--상품1-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <div class="items"><!--상품2-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <div class="items"><!--상품3-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <div class="items"><!--상품4-->
                    <div class="itemimg">
                        <img src="img/starbuckAme.png"><!--db에서 상품 이미지불러오기-->
                    </div>
                    <div class="itemnameNprice">
                        <div class="itembrand">
                            스타벅스
                        </div>
                        <div class="itemname">
                            아메리카노 Tall
                        </div>
                        <div class="itemprice">
                            <span>15%</span>&nbsp;&nbsp;
                            <span>3,800원</span>
                        </div>
                        <div class="itemoriginprice">
                            <span><del>5,000원</del></span>
                        </div>
                    </div>
                </div>
                <!-- 관심상품 for문 종료 -->

            </div>
        </div>
        
    </div>
</body>
</html>