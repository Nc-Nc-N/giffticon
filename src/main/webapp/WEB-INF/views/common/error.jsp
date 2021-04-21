<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp"/>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/error.css" type="text/css">
</head>
<body>
<div class="error_center">
    <div>
        <h2>존재하지 않는 페이지 입니다.</h2>
        <div class="btn-section">
        <button class="btn btn-active" id="error_home">홈으로 가기</button>
        </div>
    </div>

</div>
</body>
</html>
<script type="text/javascript">

    $(".document").ready(function(){

        $("#error_home").on("click",function(e){

            location.href="/user/home"
        })
    })
</script>
