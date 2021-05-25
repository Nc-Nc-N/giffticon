<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@include file="/WEB-INF/views/common/header.jsp" %>

<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/css/user/mypage/templete.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/notice_board.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/register_psnl_qust.css" type="text/css">

<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>

<body>

<div id="container">
    <div class="space"></div>
    <div class="main">

        <div class="menuhead">
        </div>

        <div class="menubody">
            <div class="sidebarspace">
                <div class="menuname">고객센터</div>
                <div class="sidebar">

                    <a href="/user/cs/noticeBoard">
                        <div class="bar">
                            <div>공지사항</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="/user/cs/faqBoard">
                        <div class="bar">
                            <div>자주묻는질문</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>
                    <a href="/user/mypage/psnlQustBoard">
                        <div class="bar" style="background-color:rgb(240, 240, 240);">
                            <div style="color: rgb(255, 88, 93); background-color:rgb(240, 240, 240);">1:1문의</div>
                            <i class="fas fa-chevron-right"></i></div>
                    </a>

                </div>
            </div>
            <div class="emptyspace">

            </div>
            <div class="content">

                <h3>1:1문의</h3>
                    <form role="form" action="/user/mypage/psnlQustBoard/register" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <table id="t1" width=100%>
                        <thead>
                        <tr>
                            <th class="t11">문의유형</th>
                            <th class="t12">제목</th>
                            <th class="t15">내용</th>
                            <th class="t16">파일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <input type="hidden" class="register-user-id" name="userId" value="">
                            <input type="hidden" name="stusCode" value="000">
                            <td class="t21">
                                <select class="td-select" name="csCateCode">
                                    <option value="001">구매</option>
                                    <option value="002">판매</option>
                                </select>
                            </td>
                            <td class="t22">
                                <input type="text" class="td-title" name="title">
                            </td>
                            <td class="t25">
                                <div class="td-div-intro">
                                    <p>1:1문의 작성 전 확인해주세요!<br>
                                        기쁘티콘에서 구매하신 쿠폰은 프로모션 상품, 또는 리셀링된 쿠폰입니다.<br>
                                        추후 문제가 발생할 우려가 있어 바코드 이미지 노출 이후 단순 변심, 주문 실수 등의 사유로 환불 및 교환이 불가합니다.<br>
                                        해당 내용은 구매 페이지에 안내되어 있으니 참고 부탁드립니다.
                                    </p>
                                </div>
                                <div class="td-div-content">
                                    <textarea type="text" class="td-content" name="cntnt"></textarea>
                                </div>
                            </td>
                            <td class="t26">
                                <input type="file" class="td-file" name="atchFilePath" multiple>
                            </td>

                        </tr>

                        </tbody>
                    </table>
                    <div id="qna-write">
                        <button type="submit" class="btn btn-active">저장</button>
                    </div>
                    </form>
            </div>
        </div>
    </div>
</div>


<script>

    let userId = "<c:out value="${userId}"/>";

    $(".register-user-id").val(userId);


    //파일 확장자 및 크기 사전 처리
    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    var maxSize = 5242880; //5MB

    function checkExtension(fileName, fileSize){

        if(fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }

        if(regex.test(fileName)){
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }
        return true;
    }




</script>

</body>
</html>

<%@include file="/WEB-INF/views/common/footer.jsp"%>