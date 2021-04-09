<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/common/header.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/mypage/mypage_deals.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">

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
                        <span>구매 내역</span>
                    </div>
                    <div class="contentinfo">
                        구매확정대기  >  구매확정완료
                    </div>
                    <div class="contentsearch">
                        <div class="date-search">
                            <input type="date" id="start-date">
                            <span>~</span>
                            <input type="date" id="end-date">
                        </div>
                        <div class="search-area">
                            <select class="search-select">
                                <option>전체</option>
                                <option>상품코드</option>
                                <option>상품명</option>
                            </select>
                        
                            <form class="search-form">
                                <div>
                                    <input type="text" class="search-input" />
                    
                                    <button type="submit" class="search-button">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="space30"></div>
                    <div class="item">
                        <c:forEach items="${dealList}" var="list">
                        <div class='item_purdate'><fmt:formatDate pattern="yyyy-MM-dd" value="${list.dealDt}"/></div>
                        <div class='item_info'>
                            <span class="item_img"><img src="<c:out value='${list.imgPath}'/>"></span>
                            <span class="item_brdNname">
                                <div class="item_brd"><c:out value="${list.brdName}"/></div>
                                <div class="item_name"><c:out value="${list.prdName}"/></div>
                            </span>
                            <span class="item_prc"><c:out value="${list.pymtPrc}"/>원</span>
                            <span class="item_status"><c:out value="${list.stusCode}"/></span>
                            <div class="item_buttons">
                                <button class="btn btn-active">구매 확정</button>
                                <button class="btn btn-disabled">구매 상세</button>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                    <div class="contentfooter">
                        <div class="pagination">
                            <a href="#">&lt;</a>
                            <a href="#">1</a>
                            <a href="#" class="active">2</a>
                            <a href="#">3</a>
                            <a href="#">4</a>
                            <a href="#">5</a>
                            <a href="#">6</a>
                            <a href="#">&gt;</a>
                        </div>  
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>