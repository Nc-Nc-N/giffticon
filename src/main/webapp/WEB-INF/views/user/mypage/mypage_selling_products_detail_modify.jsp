<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../../common-css/button.css" type="text/css">
    <link rel="stylesheet" href="../../common-css/search-box.css" type="text/css">
    <link rel="stylesheet" href="mypage_info_edit_user.css" type="text/css">
    <link rel="stylesheet" href="mypage_selling_products_detail_modify.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>
</head>
<body>
    <div id="register-content">
        <h2>상품 정보 수정</h2>
        
        <div id="content">
            <div class="email_section">
                <h3>카테고리 분류</h3>
                <h4>대분류 출력</h4>&nbsp;>&nbsp;
                <h4>중분류 출력</h4>&nbsp;>&nbsp;
                <h4>상품 출력</h4>
            </div>
            <div class="email_section">
                <h3>상품 코드 번호</h3>
                <h4>기프티콘 등록 번호 출력 (변경불가)</h4>
               
            </div>
            <div class="img_section">
                <h3>상품 정보</h3>
                <div>
                    <div class="img_container">
                        <img src="../img/star_americano.png">
                    </div> 
                    <div class="img_container">
                        <img src="../img/barcode">
                    </div> 
                </div>
            </div>

            <div class="info_section">
                <div>
                    <h3>바코드 입력</h3>
                    <h4>바코드 번호 출력 (변경불가)</h4>
                </div>
            </div>

            <div class="date_section">
                <h3>유효기간</h3>
                <div class="date-search">
                    <input type="date" id="end-date">
                </div>
               
            </div>
            
            <div class="price_section">
                <h3>가격 수정</h3>
                <div class="price_modify">
                    <form class="select">
                       <label><input type="radio" name="price_select" class="price_select" value="자동">자동</label><br>
                        <label><input type="radio" name="price_select"class="price_select" value="수동">수동</label>
                    </form>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="가격표시">
                    </div>
                </div>
               
            </div>
            <div class="info_section">
                <div>
                    <h3>비밀번호 입력</h3>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="">
                    </div>
                </div>
                <div class="message"><h5>비밀번호가 일치하지 않습니다!</h5></div>
            </div>
            
        </div>

        <div id="reg-btn-area">
            <button class="btn btn-active">수정</button>
            <button class="btn btn-disabled">취소</button>
        </div>
    </div>
</body>
</html>