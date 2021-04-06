<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/common/button.css"/>
    <link rel="stylesheet" href="/resources/css/login/signUp.css"/>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
    <div class="container">
        
        <div class="imgcontainer">
           <img src="/resources/img/logo.png">
        </div>
        <form action="#" method="POST">
        <div class="element_email">
            <div class="email_input">
             <input type="text" class="input001" name="email" placeholder="Email">
            </div>
            <button class="btn btn-active">인증</button>
        </div>
        <div class="element">
            <input type="password" class="input001" name="password" placeholder="비밀번호">
        </div>
        <div class="element">
            <input type="password" class="input001" name="confirmPassword" placeholder="비밀번호 재입력">
        </div>
        <div class="element">
            <input type="text" class="input001" name="name" placeholder="이름">
        </div>
        <div class="element">
            <input type="text" class="input001" name="email" placeholder="전화번호">
        </div>

        <div class="element">
            <span id="validateMsg">
                <i class="fas fa-exclamation-circle"></i>
                이미 존재하는 Email 입니다.
            </span>
        </div>

        <div class="element" id="btn">
            <button type="submit" class="btn001">가입하기</button>
        </div>
        </form>
        
    </div>
</body>
</html>