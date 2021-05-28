<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="csTemplete.jsp"/>
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/css/admin/cs/admin_notice.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/notice_board.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/cs/register_psnl_qust.css" type="text/css">

<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>


<h3>1:1문의</h3>

<div class="line-117"></div>

<div class="psnlQustContainer">

    <div class="psnlQ">
        <div class="q-input header">문의 유형</div>
        <div class="q-input cate">
            <div class="catecheck">
                <input class="cate-check" name="qcate" type="radio" value="001"> 구매
                <input class="cate-check" name="qcate" type="radio" value="002"> 판매
            </div>
        </div>
    </div>

    <div class="psnlQ">
        <div class="q-input header">문의 제목</div>
        <div class="q-input title">
            <input type="text" class="input-title">
        </div>
    </div>

    <div class="psnlQ">
        <div class="q-input header">파일 첨부</div>
        <div class="q-input file">
            <input type="file" class="file-input" name="uploadFile" accept="image/jpeg, image/jpg, image/png">
        </div>
    </div>
    <div class="psnlQ">
    <div class="q-input header cntTitle">문의 내용</div>
    <div class="cntInput">
        <textarea class="cnt"></textarea>
    </div>
    </div>
</div>
<div id="qna-write">
    <button type="submit" class="btn btn-active">저장</button>
</div>
<%--<table id="t1" width=100%>--%>
<%--    <thead>--%>
<%--    <tr>--%>
<%--        <th class="t11">문의유형</th>--%>
<%--        <th class="t12">제목</th>--%>
<%--        <th class="t15">내용</th>--%>
<%--        <th class="t16">파일</th>--%>
<%--    </tr>--%>
<%--    </thead>--%>
<%--    <tbody>--%>
<%--    <tr>--%>
<%--        <input type="hidden" class="register-user-id" name="userId" value="">--%>
<%--        <input type="hidden" class="register-stus" name="stusCode" value="000">--%>
<%--        <td class="t21">--%>
<%--            <select class="td-select" name="csCateCode">--%>
<%--                <option value="001">구매</option>--%>
<%--                <option value="002">판매</option>--%>
<%--            </select>--%>
<%--        </td>--%>
<%--        <td class="t22">--%>
<%--            <input type="text" class="td-title" name="title">--%>
<%--        </td>--%>
<%--        <td class="t25">--%>
<%--            <div class="td-div-intro">--%>
<%--                <p>1:1문의 작성 전 확인해주세요!<br>--%>
<%--                    기쁘티콘에서 구매하신 쿠폰은 프로모션 상품, 또는 리셀링된 쿠폰입니다.<br>--%>
<%--                    추후 문제가 발생할 우려가 있어 바코드 이미지 노출 이후 단순 변심, 주문 실수 등의 사유로 환불 및 교환이 불가합니다.<br>--%>
<%--                    해당 내용은 구매 페이지에 안내되어 있으니 참고 부탁드립니다.--%>
<%--                </p>--%>
<%--            </div>--%>
<%--            <div class="td-div-content">--%>
<%--                <textarea type="text" class="td-content" name="cntnt"></textarea>--%>
<%--            </div>--%>
<%--        </td>--%>
<%--        <td class="t26">--%>

<%--            <input type="file" class="file-input" name="uploadFile"--%>
<%--                   accept="image/jpeg, image/jpg, image/png">--%>
<%--        </td>--%>

<%--    </tr>--%>

<%--    </tbody>--%>
<%--</table>--%>
<%--                    </form>--%>
</div>
</div>
</div>
</div>


<script>

    $(document).ready(function(){
        $("#psnlQ-link").attr("class", "menu active");
    })

    let userId = "<c:out value="${userId}"/>";

    let psnlqustpath = "<spring:eval expression="@psnlqustpath['path']"/>";
    let originPath = ""; //table의 atch_file_path에 들어갈 변수

    //파일 확장자 및 크기 사전 처리
    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    var maxSize = 5242880; //5MB

    function checkExtension(fileName, fileSize) {

        if (fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }

        if (regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }
        return true;
    }

    //파일 업로드
    $(document).on("change", ".file-input", function () {

        var formData = new FormData();
        var inputFile = $("input[name='uploadFile']");
        var files = inputFile[0].files;

        for (var i = 0; i < files.length; i++) {
            //파일 용량, 확장자 체크
            if (!checkExtension(files[i].name, files[i].size)) {
                return false;
            }
            formData.append("uploadFile", files[i]);
        }

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";


        $.ajax({
            url: '/psnl/uploadAjaxAction',
            processData: false,
            contentType: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data: formData,
            type: 'POST',
            dataType: 'json',
            success: function (result) {
                saveFile(result);
            },
            error: function (request, status, error) {
                alert("code:" + request.status + "\n" + "massage:" + request.responseText + "\n" + "error:" + error);
            }
        }); //$.ajax


        //이미지 파일 save하는 함수
        function saveFile(uploadResultArr) {

            console.log("uploadResultArr: " + uploadResultArr);
            $(uploadResultArr).each(function (i, obj) {

                originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;

                console.log(originPath);
                originPath = originPath.replace(new RegExp(/\\/g), "/");
            });
        }

    });

    //유효성 검사 후 db 저장
    $(".btn-active").on("click", function () {

        if($('input[name="qcate"]:checked').val() == null){
            alert("문의 유형을 선택해주세요");
            return false;
        }

        if ($(".input-title").val() == '') {
            alert("제목을 입력해주세요.");
            return false;
        }
        if ($(".cnt").val() == '') {
            alert("내용을 입력해주세요.");
            return false;
        }

        insertPsnlQust();
    });

    //유효성 통과 시 Ajax로 db에 insert
    let insertPsnlQust = function () {
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        let filePath = originPath.length != 0 ? "/user/display?fileName=" + "/pnslQust/" + originPath : '';

        var form = {
            id: null,
            userId: userId,
            title: $(".input-title").val(),
            cntnt: $(".cnt").val(),
            atchFilePath: filePath,
            adminId: null,
            ansCntnt: null,
            ansInDt: null,
            cmpltDt: null,
            csCateCode: $('input[name="qcate"]:checked').val(),
            stusCode: '000',
            inDate: null,
            upDate: null
        }

        $.ajax({
            url: '/user/mypage/psnlQustBoard/register',
            processData: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data: JSON.stringify(form),
            contentType: "application/json; charset=utf-8",
            type: 'POST',
            success: function (result) {
                alert("1:1 문의 성공. 빠른 시일 내에 답변드리겠습니다.");
                self.location = "/user/mypage/psnlQustBoard";
            },
            error: function (error) {
                console.log(error);
                alert("등록과정에서 오류가 발생했습니다. 관리자에게 문의해주세요.");
            }
        })

    }


</script>

</body>
</html>

<%@include file="/WEB-INF/views/common/footer.jsp"%>