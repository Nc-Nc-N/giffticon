<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="../../사용자/header.css" type="text/css">
    <link rel="stylesheet" href="../admin_layout.css" type="text/css">
    <link rel="stylesheet" href="admin_notice.css" type="text/css">
    <link rel="stylesheet" href="../../common-css/search-box.css" type="text/css">
    <link rel="stylesheet" href="../../common-css/button.css" type="text/css">
    <link rel="stylesheet" href="../../common-css/pagination.css" type="text/css">
    <link rel="stylesheet" href="admin_faq.css" type="text/css">
</head>
<body>

<div id="container">
    <!-- header-->
    <div class="header">
        <div class= "top_menu">
            <span><a href="#" class="login-panel">로그인</a></span>
            <span class="header_divider">|</span>
            <span><a href="#" class="login-panel">회원가입</a></span>
            <span class="header_divider">|</span>
            <span><a href="#" class="login-panel">고객센터</a></span>
        </div>
        <div class="main-logo">
            <div class="home-logo"><img src="../../사용자/img/기쁘티콘.png" width="230px" height="100px"></a></div>
        </div>
    </div>
    <!-- end header-->


    <div id="content">

        <!-- sidebar -->
        <div id="sidebar">
            <div id="admin-menu">
                <h2>회원관리</h2>
                <h2>상품관리</h2>
                <h2>배너관리</h2>
                <h2>판매요청관리</h2>
                <h2>거래내역관리</h2>
                <h2>포인트관리</h2>
                <h2>통계분석</h2>
            </div>
            <div id="admin-memo">
                <span class="span">Memo</span>
                <textarea id="memo">2021-03-25 관리자 메모내용</textarea>
            </div>
        </div>

        <!-- list-->
        <div id="main">
            <h2>고객센터</h2>
            <div id="menu">
                <div>
                    <a href="#" >공지사항</span></a>
                </div>
                <div>
                    <a href="#" style="color: rgb(255, 88, 93);">자주묻는질문</span></a>
                </div>
                <div>
                    <a href="#">1:1문의</span></a>
                </div>
            </div>

            <!-- search area -->
            <div class="search-area">
                <select class="search-select">
                    <option>전체</option>
                    <option>구매</option>
                    <option>판매</option>
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
            <!-- search area end -->

            <!--accordionMenu-->
            <div class="accordionMenu">
                <!-- 1st menu-->
                <input type="checkbox" name="trg1" id="acc1" >
                <label for="acc1"><span class="qna-q">Q. </span>기쁘티콘 판매자가 직접 거래를 요청하는 경우 어떻게 하나요?
                    <span class="faq-date">2021.03.24</span>
                    <button class= "btn-no btn-erase"><i class="fas fa-minus"></i></button>
                    <button class= "btn-no btn-modify">수정</button>
                </label>
                <div class="content">
                    <div class="inner">

                        <p><span class="qna-a">A. </span>
                            안녕하세요. 기쁘티콘입니다. 홈페이지를 통하지 않은 거래는 기쁘티콘에서 책임지지 않습니다. <br>
                            따라서, 판매자가 홈페이지를 통하지 않은 직접 거래를 요청하는 경우 거래에 응하지 않는 것을 권합니다.
                        </p>
                    </div>
                </div>
                <!-- 2nd menu-->
                <input type="checkbox" name="trg1" id="acc2" >

                <label for="acc2"><span class="qna-q">Q. </span>분쟁처리절차는 어떻게 되나요?
                    <span class="faq-date">2021.03.24</span>
                    <button class= "btn-no btn-erase"><i class="fas fa-minus"></i></button>
                    <button class= "btn-no btn-modify">수정</button>
                </label>
                <div class="content">
                    <div class="inner">

                        <p><span class="qna-a">A. </span>
                            안녕하세요. 기쁘티콘입니다. 홈페이지를 통하지 않은 거래는 기쁘티콘에서 책임지지 않습니다. <br>
                            따라서, 판매자가 홈페이지를 통하지 않은 직접 거래를 요청하는 경우 거래에 응하지 않는 것을 권합니다.
                        </p>
                    </div>
                </div>
                <!-- 3th menu-->
                <input type="checkbox" name="trg1" id="acc3" >
                <label for="acc3"><span class="qna-q">Q. </span>긴급재난지원금을 기쁘티콘에서 사용 가능한가요?
                    <span class="faq-date">2021.03.24</span>
                    <button class= "btn-no btn-erase"><i class="fas fa-minus"></i></button>
                    <button class= "btn-no btn-modify">수정</button>
                </label>
                <div class="content">
                    <div class="inner">
                        <p><span class="qna-a">A. </span>
                            안녕하세요. 기쁘티콘입니다. 홈페이지를 통하지 않은 거래는 기쁘티콘에서 책임지지 않습니다. <br>
                            따라서, 판매자가 홈페이지를 통하지 않은 직접 거래를 요청하는 경우 거래에 응하지 않는 것을 권합니다.
                        </p>
                    </div>
                </div>
                <!-- 4th menu-->
                <input type="checkbox" name="trg1" id="acc4" >
                <label for="acc4"><span class="qna-q">Q. </span>환불계좌를 등록 / 변경하고 싶어요.
                    <span class="faq-date">2021.03.24</span>
                    <button class= "btn-no btn-erase"><i class="fas fa-minus"></i></button>
                    <button class= "btn-no btn-modify">수정</button>
                </label>
                <div class="content">
                    <div class="inner">
                        <p><span class="qna-a">A. </span>
                            안녕하세요. 기쁘티콘입니다. 홈페이지를 통하지 않은 거래는 기쁘티콘에서 책임지지 않습니다. <br>
                            따라서, 판매자가 홈페이지를 통하지 않은 직접 거래를 요청하는 경우 거래에 응하지 않는 것을 권합니다.
                        </p>
                    </div>
                </div>
                <!-- 5th -->
                <input type="checkbox" name="trg1" id="acc5" >
                <label for="acc5"><span class="qna-q">Q. </span>환불계좌를 등록 / 변경하고 싶어요.
                    <span class="faq-date">2021.03.24</span>
                    <button class= "btn-no btn-erase"><i class="fas fa-minus"></i></button>
                    <button class= "btn-no btn-modify">수정</button>
                </label>
                <div class="content">
                    <div class="inner">
                        <p><span class="qna-a">A. </span>
                            안녕하세요. 기쁘티콘입니다. 홈페이지를 통하지 않은 거래는 기쁘티콘에서 책임지지 않습니다. <br>
                            따라서, 판매자가 홈페이지를 통하지 않은 직접 거래를 요청하는 경우 거래에 응하지 않는 것을 권합니다.
                        </p>
                    </div>
                </div>
                <!-- 6th menu-->
                <input type="checkbox" name="trg1" id="acc6" >
                <label for="acc6"><span class="qna-q">Q. </span>환불계좌를 등록 / 변경하고 싶어요.
                    <span class="faq-date">2021.03.24</span>
                    <button class= "btn-no btn-erase"><i class="fas fa-minus"></i></button>
                    <button class= "btn-no btn-modify">수정</button>
                </label>
                <div class="content">
                    <div class="inner">
                        <p><span class="qna-a">A. </span>
                            안녕하세요. 기쁘티콘입니다. 홈페이지를 통하지 않은 거래는 기쁘티콘에서 책임지지 않습니다. <br>
                            따라서, 판매자가 홈페이지를 통하지 않은 직접 거래를 요청하는 경우 거래에 응하지 않는 것을 권합니다.
                        </p>
                    </div>
                </div>
                <!-- 7th menu-->
                <input type="checkbox" name="trg1" id="acc7" >
                <label for="acc7"><span class="qna-q">Q. </span>환불계좌를 등록 / 변경하고 싶어요.
                    <span class="faq-date">2021.03.24</span>
                    <button class= "btn-no btn-erase"><i class="fas fa-minus"></i></button>
                    <button class= "btn-no btn-modify">수정</button>
                </label>
                <div class="content">
                    <div class="inner">
                        <p><span class="qna-a">A. </span>
                            안녕하세요. 기쁘티콘입니다. 홈페이지를 통하지 않은 거래는 기쁘티콘에서 책임지지 않습니다. <br>
                            따라서, 판매자가 홈페이지를 통하지 않은 직접 거래를 요청하는 경우 거래에 응하지 않는 것을 권합니다.
                        </p>
                    </div>
                </div>
            </div>
            <!-- end accordionMenu-->

            <div id="notion-write">

                <button class="btn btn-active">글쓰기</button>

                <!-- pagenation-->
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
                <!-- end pagenation-->

            </div>

        </div>
        <!--end jb-content-->



    </div>
    <!-- end mycon-->

</div>
<!-- end jb-container-->

</body>
</html>
