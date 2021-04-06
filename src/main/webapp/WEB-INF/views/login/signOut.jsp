<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/login/signUp.css"/><!--sign_up.css로 pwd/email css 사용-->
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

    <form action="/login/signOut" method="post">
    <div class="element" id="btn">

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="error" value="로그아웃되었습니다.">
            <button type="submit" class="btn003">로그아웃</button>

    </div>
    </form>

</div>
</body>
</html>