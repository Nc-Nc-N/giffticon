<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../../common-css/button.css" type="text/css">
    <link rel="stylesheet" href="../../common-css/search-box.css" type="text/css">
    <link rel="stylesheet" href="mypage_info_edit_user.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>
</head>
<body>
    <div id="register-content">
        <h2>회원정보 수정</h2>
        
        <div id="content">
            <div class="email_section">
                <h3>Email</h3>
                <h4>이메일 출력 (변경불가)</h4>
               
            </div>
            <div class="info_section">
                <div>
                    <h3>현재 비밀번호</h3>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="">
                    </div>
                </div>
                <div class="message"><h5>비밀번호가 일치하지 않습니다!</h5></div>
            </div>
            <div class="info_section">
                <div>
                    <h3>새 비밀번호</h3>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="">
                    </div>
                </div>
                
            </div>
            <div class="info_section">
                <div>
                    <h3>새 비밀번호 재입력</h3>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="">
                    </div>
                </div>
                <div class="message"><h5>비밀번호가 일치하지 않습니다!</h5></div>
            </div>
            <div class="info_section">
                <div>
                    <h3>이름</h3>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="기존이름출력">
                    </div>
                </div>
                
            </div>
            <div class="info_section">
                <div>
                    <h3>전화번호</h3>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="기존전화번호출력">
                    </div>
                    <button class="btn btn-submit">인증</button>
                </div>
                <div class="message"><h5>인증 완료</h5></div>
            </div>
            
        </div>

        <div id="reg-btn-area">
            <button class="btn btn-active">등록</button>
            <button class="btn btn-disabled">취소</button>
        </div>
    </div>
</body>
</html>