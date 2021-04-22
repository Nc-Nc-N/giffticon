<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/common/error.css" type="text/css">

</head>
<body>
<div class="error-center">
    <div class="error-section">
        <c:set var="errorCode" value="${requestScope['javax.servlet.error.status_code']}"/>
        <c:choose>
            <c:when test="${errorCode == 404}">
                <div class="error-code">
                    <div class="img_404">
                        <img src="/resources/img/error/404NotFound.PNG"/>
                    </div>
                </div>
                <div class="error-msg">
                    <div class="msg_line1"><span>죄송합니다.</span>&nbsp;&nbsp;<span>요청하신 페이지를 찾을 수 없습니다.</span></div>
                    <h4>찾으시려는 페이지는 주소를 잘못 입력하셨거나</h4>
                    <h4>페이지 주소 변경등의 이유로 페이지를 찾을 수 없습니다.</h4>
                    <h4>입력하신 페이지의 주소가 정확한지 확인 후 이용해주시기 바랍니다.</h4>
                </div>
            </c:when>
            <c:when test="${errorCode == 400}">
                <div class="error-code">
                    <div class="img_400">
                        <img src="/resources/img/error/400BadRequest.PNG"/>
                    </div>
                </div>
                <div class="error-msg">
                    <div class="msg_line1"><span>잘못된 요청입니다.</span>&nbsp;&nbsp;<span>해당 요청은 유효하지 않습니다.</span></div>
                    <h4>주소 또는 요청에 올바르지 않은 값이 있습니다.</h4>
                    <h4>보내시는 요청의 값을 확인 하신 후 다시 보내주시기 바랍니다.</h4>
                </div>
            </c:when>

            <c:when test="${errorCode == 500}">
            <div class="error-code">
                <div class="img_500">
                    <img src="/resources/img/error/500ServerError.PNG"/>
                </div>
            </div>
            <div class="error-msg">
                <div class="msg_line1"><span>죄송합니다.</span>&nbsp;&nbsp;<span>시스템 에러가 발생했습니다.</span></div>
                <h4>서비스 이용에 불편을 드려 죄송합니다.</h4>
                <h4>시스템 에러가 발생하여 페이지를 표시할 수 없습니다.</h4>
                <h4>관리자에게 문의하거나 잠시후 다시 시도해주세요.</h4>
            </div>
            </c:when>

        </c:choose>

        <div class="btn-section">
            <button class="btn btn-active" id="error_home">Home</button>
            <button class="btn btn-active" id="error_faq">고객센터</button>
        </div>
    </div>

</div>

</body>
</html>
<script type="text/javascript">

    $(".document").ready(function(){

        $("#error_home").on("click",function(e){
            console.log("btn cllicked");
            location.href="/user/home"
        })

        $("#error_faq").on("click",function(e){
            console.log("btn cllicked");
            location.href="/user/cs/faqBoard"
        })
    })
</script>
