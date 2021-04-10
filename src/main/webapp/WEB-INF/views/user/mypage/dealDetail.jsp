<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/mypage/mypage_deals_detail.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
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
                <div class="menuname">MY PAGE</div><!--메뉴 이름 (사이드바 위)-->
            </div>
            <div class="menubody">
                <div class="sidebarspace">
                    <div class="sidebar"> <!--사이드 바 영역 (필요한만큼 영역 늘리기)-->
                        <!--필요한만큼 아래 추가해서 사용 (개당 간격70px)-->
                        <a href="(메뉴이동"><div class="bar"><div>구매 내역</div><i class="fas fa-chevron-right"></i></div></a>
                        <a href="(메뉴이동"><div class="bar"><div>판매 내역</div><i class="fas fa-chevron-right"></i></div></a>
                        <a href="(메뉴이동"><div class="bar"><div>회원 정보</div><i class="fas fa-chevron-right"></i></div></a>
                        <a href="(메뉴이동"><div class="bar"><div>1:1 문의</div><i class="fas fa-chevron-right"></i></div></a>
                        <a href="(메뉴이동"><div class="bar"><div>포인트 충전</div><i class="fas fa-chevron-right"></i></div></a>
                    </div>
                </div>
                <div class="content"><!--메인컨텐츠 (이하 각자 내용 작성)-->
                    <div class='abstracts'>
                        <div class='abs'>
                            <div class="abs_name">사용 대기</div>
                            <div class="abs_num">3</div>
                        </div>
                        <div class='abs'>
                            <div class="abs_name">판매 대기</div>
                            <div class="abs_num">3</div>
                        </div>
                        <div class='abs'>
                            <div class="abs_name">판매 중</div>
                            <div class="abs_num">3</div>
                        </div>
                        <div class='abs'>
                            <div class="abs_name">현재 포인트</div>
                            <div class="abs_pnt">10200p</div>
                        </div>
                    </div>
                    <div class="space30"></div>
                    <div class="contentheader">
                        <span>구매 내역 > 상품 상세</span>
                    </div>
                    <div class="item_info">
                        <div class="item_img">
                            <img src="<c:out value="${gftInfo.prdImgPath}"/>">
                        </div>
                        <div class="item_nameNcode">
                            <div class="item_name">
                                <div>상품명</div>
                                <c:out value="${gftInfo.prdName}"/>
                            </div>
                            <div class="item_code">
                                <div>등록번호</div>
                                <c:out value="${gftInfo.gftId}"/>
                            </div>
                        </div>
                        <div class="item_btn">
                            <button class="btn btn-active">구매확정</button>

                        </div>
                    </div>
                    <div class="item_info">
                        <div class="item_img">
                            <img src="<c:out value='${gftInfo.gftImgPath}'/>">
                        </div>
                        <div class="item_nameNcode">
                            <div class="item_name">
                                <div>구매일자</div>
                            <fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.dealDt}"/>
                            </div>
                            <div class="item_name">
                                <div>유효기간</div>
                            <fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.exprDt}"/>
                            </div>
                            <div class="item_name">
                                <div>바코드</div>
                            <c:out value=" ${gftInfo.brcd}"/>
                            </div>
                            <div class="item_name">
                                <div>상태</div>
                            <c:out value="${gftInfo.stusCode}"/>
                            </div>
                            
                            
                        </div>
                        <div class="item_btn">
                        </div>
                    </div>
                   
                </div>
            </div>
        </div>
    </div>

</body>
</html>