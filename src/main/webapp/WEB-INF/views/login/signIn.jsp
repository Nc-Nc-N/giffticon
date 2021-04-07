<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/login/signIn.css"/>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
    </style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
</head>
<body>
    <div class="container">
        <div class="element">
            <a href="/user/home"><img src="/resources/img/logo.png"></a>
        </div>

        <form action="/login" method="POST">
        <div class="element">
            <input type="text" class="input001" name="username" placeholder="Email" value="${email}">
        </div>
        <div class="element">
            <input type="password" class="input001" name="password" placeholder="Password">
        </div>
        <div class="element">
            <span id="validateMsg"><i class="fas fa-exclamation-circle"></i>${msg}</span>
        </div>
        <div class="element01">
            <div id="checkbox-container">
                <input type="checkbox" class="checkbox001" name="isRemember" ${isRemember}>
                <span>Remember ID</span>
            </div>
            <span><a href="/login/signUp">회원가입</a></span>
            <span><a href="/finduser">Email/비밀번호 찾기</a></span>
        </div>
        <div class="element" id="btn">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="btn001">로그인</button>
        </div>
        </form>

    </div>
</body>
</html>