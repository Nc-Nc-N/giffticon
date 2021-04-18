<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="/resources/css/user/mypage/mypage_info_edit_user.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_info_edit_account.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>
</head>
<body>
    <div id="acc_register-content">
        <h2>계좌정보 수정</h2>
        
        <div id="acc_content">
            
            <div class="acc_info_section">
                <div>
                    <h3>은행명</h3>
                        <select class="acc_bank_select">
                            <option value="신한">신한은행</option>
                            <option value="우리">우리은행</option>
                            <option value="국민">국민은행</option>
                            <option value="카카오">카카오뱅크</option>
                            <option value="BC">BC</option>
                            <option value="농협">농협은행</option>  
                        </select>
                </div>
                
            </div>
            <div class="acc_info_section">
                <div>
                    <h3>예금주</h3>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="기존 예금주 출력">
                    </div>
                </div>
                
            </div>
            <div class="acc_info_section">
                <div>
                    <h3>계좌번호</h3>
                    <div class="input_text">
                        <input type="text" id="email" placeholder="기존 계좌번호 출력">
                    </div>
                    <button class="btn btn-submit">인증</button>
                </div>
                <div class="message"><h5>게좌 확인 완료</h5></div>
            </div>
            <div class="acc_info_section">
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
            <button class="btn btn-active">등록</button>
            <button class="btn btn-disabled cancel">취소</button>
        </div>
    </div>
</body>
</html>