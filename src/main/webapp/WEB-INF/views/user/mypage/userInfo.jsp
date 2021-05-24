<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/user/mypage/mypage_info.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>


<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
<title>Document</title>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
</style>

<jsp:include page="templete.jsp"/>

                    <div class="contentheader">
                        <span>회원 정보</span>
                    </div>
                    <div class="user_section">

                        <div class="user_info_column">
                            <div>Email</div>
                            <div>이름</div>
                            <div>생년월일</div>
                            <div>전화번호</div>
                            <div>보유 포인트</div>
                        </div>

                        <div class="user_info_row">
                            <div><c:out value="${user.email}"/></div>
                            <div><c:out value="${user.name}"/></div>
                            <div>
                                <c:if test="${user.birthDt == null}">
                                    생년월일을 등록해주세요
                                </c:if>
                                <c:if test="${user.birthDt != null}">
                                    <c:out value="${user.birthDt}"/>
                                </c:if>
                            </div>
                            <div><c:out value="${user.telNo}"/></div>
                            <div><c:out value="${user.pnt}"/>p</div>
                        </div>
                        <div class="user_info_btn">
                            <button class="btn btn-active" id="modTelNo">휴대전화 인증</button>
                            <c:if test="${pwdExist == false}">
                                <button class="btn btn-active" id="modPwd">비밀번호 설정</button>
                                <button class="btn btn-disabled needPwd">회원정보 수정</button>
                            </c:if>
                            <c:if test="${pwdExist == true}">
                                <button class="btn btn-active" id="modPwd">비밀번호 변경</button>
                                <button class="btn btn-active" id="modInfo">회원정보 수정</button>
                            </c:if>
                        </div>
                    </div>
                    <div class="contentheader">
                        <span>계좌 정보</span>
                    </div>
                    <div class="account_section">
                        <div class="user_info_column">
                            <div>은행명</div>
                            <div>예금주</div>
                            <div>계좌번호</div>
                        </div>

                        <div class="user_info_row">
                            <div><c:out value="${user.bnkName}"/></div>
                            <div><c:out value="${user.holder}"/></div>
                            <div><c:out value="${user.acc}"/></div>
                        </div>
                        <div class="user_info_btn">
                            <c:choose>
                                <c:when test="${pwdExist == false}">
                                    <button class="btn btn-disabled needPwd">계좌정보 수정</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-active" id="modAccInfo">계좌정보 수정</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<div class="modalOn modal_editPwd">
    <jsp:include page="userInfo_editPwd.jsp"/>
</div>
<div class="modalOn modal_editInfo">
    <jsp:include page="userInfo_editInfo.jsp"/>
</div>
<div class="modalOn modal_telNo">
    <jsp:include page="userInfo_editTelNo.jsp"/>
</div>
<div class="modalOn modal_accInfo">
    <jsp:include page="userInfo_editAcc.jsp"/>
</div>
<div class="modalOn modal_alert">
    <div class="alertMsg">비밀번호 설정 후 이용가능합니다.</div>
</div>
</body>


</html>

<script>

    let modalSection = $(".modalOn");
    let modPwd = $("#modPwd");
    let modTelNo = $("#modTelNo");
    let modAccInfo = $("#modAccInfo");
    let modInfo = $("#modInfo");

    $(".document").ready(function(){

        //계좌정보 수정 비활성화, 휴대전화인증 비활성화, 비밀번호 변경 텍스트 바꾸기
    })

    modPwd.on("click",function (){

        $(".modal_editPwd").css("visibility","visible");
    })

    modTelNo.on("click", function(){

        $(".modal_telNo").css("visibility","visible");
    })

    modAccInfo.on("click",function(){

        $(".modal_accInfo").css("visibility", "visible");
    })

    modInfo.on("click",function(){

        $(".modal_editInfo").css("visibility", "visible");
    })

    $(".needPwd").on("click",function(){
        $(".modal_alert").css("visibility","visible");
    })

    $(".modal_alert").on("click",function(){
        $(this).css("visibility", "hidden");
    })

    $(".cancel").on("click",function(e){

        $(".modalOn").css("visibility", "hidden");
    })

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>