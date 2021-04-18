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
                            <div>E-mail</div>
                            <div>이름</div>
                            <div>전화번호</div>
                            <div>보유 포인트</div>
                        </div>

                        <div class="user_info_row">
                            <div><c:out value="${user.email}"/></div>
                            <div><c:out value="${user.name}"/></div>
                            <div><c:out value="${user.telNo}"/></div>
                            <div><c:out value="${user.pnt}"/></div>
                        </div>
                        <div class="user_info_btn">
                            <button class="btn btn-active">정보 수정</button>
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
                            <button class="btn btn-active">정보 수정</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>