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
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ac51465d91bcae237e6703842ae5d0c5"></script>
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
                        <li class="catelist">카페</li>
                        <li class="catelist">빵, 아이스크림</li>
                        <li class="catelist">편의점, 마트</li>
                        <li class="catelist">피자, 햄버거, 치킨</li>
                        <li class="catelist">문화, 게임, 영화</li>
                        <li class="catelist">외식, 분식</li>
                        <li class="catelist">백화점, 주유, 뷰티</li>
                    </div>
                    <div class="brandbar">
                        <li class="brdlist"><input type="checkbox" value="스타벅스">전체</li>
                        <li class="brdlist"><input type="checkbox" value="스타벅스">스타벅스</li>
                        <li class="brdlist"><input type="checkbox" value="스타벅스">탐앤탐스</li>
                        <li class="brdlist"><input type="checkbox" value="스타벅스">투썸플레이스</li>
                        <li class="brdlist"><input type="checkbox" value="스타벅스">빽다방</li>
                        <li class="brdlist"><input type="checkbox" value="스타벅스">ㅅㅁㅇ</li>
                        <li class="brdlist"><input type="checkbox" value="스타벅스">커피빈</li>
                    </div>
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
                <div class="selectedbrd">스타벅스</div>
                <div id="map"></div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
<script>
    var container = document.getElementById('map');

    var options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
    };

    var map = new kakao.maps.Map(container, options);
</script>