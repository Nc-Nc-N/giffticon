
<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"></jsp:include>


    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/resources/css/admin/adminLayout.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/cs/admin_faq.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/admin/cs/admin_one-on-one.css" type="text/css">



            <h2>고객센터</h2>
            <div id="menu">
                <div>
                    <a href="#">공지사항</a>
                </div>
                <div>
                    <a href="#">자주묻는질문</a>
                </div>
                <div>
                    <a href="#" style="color: rgb(255, 88, 93);">1:1문의</a>
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
                        <input type="text" class="search-input"/>

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
                <input type="checkbox" name="trg1" id="acc1">
                <label for="acc1"><span class="qna-q">Q. </span>기쁘티콘 판매자가 직접 거래를 요청하는 경우 어떻게 하나요?
                    <span class="one-user-email">abcdefg@gmail.com</span>
                    <span class="one-date">2021.03.24</span>
                    <button class="btn-no btn-erase"><i class="fas fa-minus"></i></button>
                    <button class="btn-no dark">완료</button>
                </label>
                <div class="content">
                    <div class="inner">
                        <p class="qna-qq"><span class="qna-q">Q. </span>
                            다른계좌로 반품받고 싶은데 어떻게 해야할까요~?</p>
                        <p class="qna-qa"><span class="qna-a">A. </span>
                            님 안녕하세요. 기쁘티콘입니다. <br>
                            홈페이지를 통하지 않은 거래는 기쁘티콘에서 책임지지 않습니다. <br>
                            따라서, 판매자가 홈페이지를 통하지 않은 직접 거래를 요청하는 경우 거래에 응하지 않는 것을 권합니다.
                            <button class="btn-qna-qa-modify">수정</button>
                        </p>

                    </div>
                </div>
            </div>
            <!-- end accordionMenu-->


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
        <!--end main-->

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"></jsp:include>