<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../header.css" type="text/css">
    <link rel="stylesheet" href="templete.css" type="text/css">
    <link rel="stylesheet" href="mypage_point_billing_page.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link rel="stylesheet" href="../../common-css/button.css" type="text/css">
    <link rel="stylesheet" href="../../common-css/pagination.css" type="text/css">
    <link rel="stylesheet" href="../../common-css/search-box.css" type="text/css">
    
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
                        <span>포인트 충전</span>
                    </div>
                    <div class="select_section">
                        <div class="select_pnt">
                            
                            <button class="pnt btn-light" value="5000">
                                <div>5000p</div>
                                <div></div>
                            </button>
                            <button class="pnt btn-light" value="11000">
                                <div>10000p</div>
                                <div>+1000p 추가지급!</div>
                            </button>
                            <button class="pnt btn-light" value="22500">
                                <div>20000p</div>
                                <div>+2500p 추가지급!</div>
                            </button>
                            <button class="pnt btn-light" value="56000">
                                <div>50000p</div>
                                <div>+6000p 추가지급!</div>
                            </button>

                        </div>
                        <div class="pnt_prc_section">
                            <div>5000원</div>
                            <div>5000원</div>
                            <div>5000원</div>
                            <div>5000원</div>
                        </div>
                    </div>
                    <div class="pnt_info_section">
                        <div class="pnt_info_column">
                            <div>현재 포인트</div>
                            <div>충전 포인트</div>
                            <div>충전 후 포인트</div>
                            <div>총 결제 금액</div>
                        </div>
                        <div class="pnt_info_row">
                            <div>현재 포인트 불러오기</div>
                            <div>선택된 충전포인트</div>
                            <div>충전 후 포인트 계산</div>
                            <div>총 결제금액</div>
                        </div>
                        <div class="pnt_bought_btn_section">
                            <button class="btn btn-active">결제하기</button>
                        </div>
                    </div>
                    

                </div>
            </div>
        </div>
    </div>

</body>
</html>