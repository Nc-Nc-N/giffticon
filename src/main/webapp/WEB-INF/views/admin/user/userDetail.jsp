<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/user/userDetail.css" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>

<h1>회원관리</h1>
<div id="menu">
    <div>
        <h3>회원상세조회</h3>
    </div>
</div>
<br>

<table id="t1" width=100%>
    <thead>
    <tr>
        <th><span>회원번호</span></th>
        <th><span>이메일</span></th>
        <th><span>이름</span></th>
        <th><span>휴대폰</span></th>
        <th><span>가입일시</span></th>
        <th><span>계좌정보 - 은행</span></th>
        <th><span>계좌정보 - 계좌번호</span></th>
        <th><span>현재포인트</span></th>
        <th><span>주문횟수</span></th>
        <th><span>총 주문금액</span></th>
        <th><span>1:1문의횟수</span></th>
        <th><span>회원상태</span></th>
        <th><span>탈퇴처리일시</span></th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="c2"><span><c:out value="${user.id}"/></span></td>
        <td class="c2"><span><c:out value="${user.email}"/></span></td>
        <td class="c2"><span><c:out value="${user.name}"/></span></td>
        <td class="c2"><span><c:out value="${user.telNo}"/></span></td>
        <td class="c2"><span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                       value="${user.inDate}"/></span></td>
        <td class="c2"><span><c:out value="${user.bankName}"/></span></td>
        <td class="c2"><span><c:out value="${user.bankAccount}"/></span></td>
        <td class="c2"><span><c:out value="${user.balance}"/> P</span></td>
        <td class="c2"><span><c:out value="${user.dealCount}"/></span></td>
        <td class="c2"><span><c:out value="${user.paysum}"/> 원</span></td>
        <td class="c2"><span><c:out value="${user.pqustCount}"/></span></td>
        <td class="c2" id="ustatus">
            <span>
            <c:if test="${user.enabled == 1}">
                <c:out value="정상"/>
            </c:if>
            <c:if test="${user.enabled == 0}">
                <c:out value="탈퇴"/>
            </c:if>
            </span>
        </td>

        <td class="c2">
            <span>
            <c:if test="${user.enabled == 0}">
               <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                               value="${user.quitHist}"/>
            </c:if>
            </span>
        </td>

    </tr>
    <tr>
        <td class="c3">ㅤ</td>
        <td class="c3">ㅤ</td>
        <td class="c3">ㅤ</td>
        <td class="c3">ㅤ</td>
        <td class="c3">ㅤ</td>
        <td class="c3">ㅤ</td>
        <td class="c3">ㅤ</td>
        <td class="c3"><input type="button" class="btnclass" id="btn1" value="콘 충전/사용내역 조회"></td>
        <td class="c3"><input type="button" class="btnclass" id="btn2" value="거래내역 조회"></td>
        <td class="c3">ㅤ</td>
        <td class="c3"><input type="button" class="btnclass" id="btn3" value="1:1문의 조회"></td>
        <td class="c3">
            <form action="/admin/user/update-status" id="statusUpdateForm" method="post" onchange="submitStatus()">
                <sec:csrfInput/>
                <select name="statusTxt" class="btnclass" id="statusbtn">
                    <option value="정상" selected="selected">정상</option>
                    <option value="탈퇴">탈퇴</option>
                </select>
                <input id="userId2" type="hidden" name="id" value="${user.id}"/>
            </form>
        </td>
        <td class="c3">ㅤ</td>
    </tr>

    </tbody>
</table>
<br>
<div id="memo-container">
    <p id="memo-title"><span>관리자 메모</span></p>

    <form action="/admin/user/update-memo" method="post" id="submitform">
        <sec:csrfInput/>
        <input id="memo-input" type="text" name="memo"
               value='<c:out value="${user.memo}"/>' style="border:solid black 1px">
        <input id="userId" type="hidden" name="id" value="${user.id}"/>
        <input type="submit" id="memochange" value="수정">
    </form>
</div>


</div>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

        // 페이지 로딩시 회원 상세정보 불러오기 실패하면 에러메세지 출력
        if ("${initError}" != "") {
            alert("${initError}");
        }

        document.getElementById("userAdministration").className = 'active';

        let ustat = document.getElementById('ustatus').innerText;

        if (ustat == "정상") {
            document.getElementById('statusbtn').value = "정상";
        } else if (ustat == "탈퇴") {
            document.getElementById('statusbtn').value = "탈퇴";
        }

    });

    let submitStatus = function () {
        document.getElementById('statusUpdateForm').submit();
    }

    $("#statusbtn").change(function () {
        alert("회원상태를 변경합니다.");
    });

    $("#btn1").click(function() {
        location.href="/admin/con-history?type=EN&keyword=" + encodeURIComponent("${user.email}");
    });

    $("#btn2").click(function() {
        location.href="/admin/deal-history?type=BSCNEPL&keyword=" + encodeURIComponent("${user.email}");
    });

    $("#btn3").click(function() {
        location.href="/admin/adminPsnlQust?type=NE&keyword=" + "${user.id}";
    });


</script>