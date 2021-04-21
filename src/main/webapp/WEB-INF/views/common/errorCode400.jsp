<%--
  Created by IntelliJ IDEA.
  User: lwiii
  Date: 2021-04-20
  Time: 오후 7:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Title</title>

    <!-- FONTAWESOME -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300&display=swap');

        * {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
        }

        div {
            width: 100%;
            height: 100%;
            text-align: center;
        }

        img {
            width: 700px;
            height: 500px;
        }

        a {
            font-size: 24px;
            font-weight: 600;
            color: #514859;
            text-decoration: none;
        }

        a:hover {
            color: rgb(255, 88, 93);
        }
    </style>

</head>
<body>
<div>
    <img src="/resources/img/400error.png"/>
    <br/>
    <a href="/user/home">기쁘티콘 <i class="fas fa-home"></i></a>
</div>
</body>
</html>
