<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/user/userList.css" type="text/css">
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
                            <th>회원번호</th>
                            <th>이메일</th>
                            <th>이름</th>
                            <th>휴대폰</th>
                            <th>가입일시</th>
                            <th>계좌정보 - 은행</th>
                            <th>계좌정보 - 계좌번호</th>
                            <th>현재포인트</th>
                            <th>주문횟수</th>
                            <th>총 주문금액</th>
                            <th>1:1문의횟수</th>
                            <th>회원상태</th>
                            <th>탈퇴처리일시</th>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td class="c2"><c:out value="${user.id}" /></td>
                            <td class="c2"><c:out value="${user.email}" /></td>
                            <td class="c2"><c:out value="${user.name}" /></td>
                            <td class="c2"><c:out value="${user.telNo}" /></td>
                            <td class="c2"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                                           value="${user.inDate}" /></td>
                            <td class="c2"><c:out value="${user.bankName}" /></td>
                            <td class="c2"><c:out value="${user.bankAccount}" /></td>
                            <td class="c2"><c:out value="${user.balance}" /> P</td>
                            <td class="c2"><c:out value="${user.dealCount}" /></td>
                            <td class="c2"><c:out value="${user.paysum}" /> 원</td>
                            <td class="c2"><c:out value="${user.pqustCount}" /></td>
                            <td class="c2" id="ustatus">
<%--                                <c:out value="${user.enabled}" />--%>
                                <c:if test="${user.enabled == 1}">
                                    <c:out value="정상"/>
                                </c:if>
                                <c:if test="${user.enabled == 0}">
                                    <c:out value="탈퇴"/>
                                </c:if>
                            </td>

                            <td class="c2">ㅤ</td>
                          </tr>
                          <tr>
                            <td class="c3">ㅤ</td>
                            <td class="c3">ㅤ</td>
                            <td class="c3">ㅤ</td>
                            <td class="c3">ㅤ</td>
                            <td class="c3">ㅤ</td>
                            <td class="c3">ㅤ</td>
                            <td class="c3">ㅤ</td>
                            <td class="c3"><input type="button" class="btnclass" value="포인트 충전/사용내역 조회"></td>
                            <td class="c3"><input type="button" class="btnclass" value="거래내역 조회"></td>
                            <td class="c3">ㅤ</td>
                            <td class="c3"><input type="button" class="btnclass" value="1:1문의 조회"></td>
                            <!-- <td class="c3"><button class="btnclass">선택</button></td> -->
                            <td class="c3">
                                <form action="/admin/user/update-status" id="statusUpdateForm" method="post" onchange="submitStatus()">
                                    <sec:csrfInput />
                                <select name="statusTxt" class="btnclass" id="statusbtn" style="background-color:rgb(245, 243, 243)">
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
                      <!-- <span style="display: inline-block; width:175px;" id="memo-title">관리자 메모</span> <br> -->
                      <p id="memo-title">관리자 메모</p>

                          <form action="/admin/user/update-memo" method="post" id="submitform">
                              <sec:csrfInput />
                              <input id="memo-input" type="text" name="memo"
                                     value='<c:out value="${user.memo}"/>' style="border:solid black 1px">
<%--                                     value='testmemo' style="border:solid black 1px">--%>
                              <input id="userId" type="hidden" name="id" value="${user.id}"/>
                              <input type="submit" id="memochange" value="수정">
                          </form>
                      </div>
                      

        </div>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        let ustat = document.getElementById('ustatus').innerText;

        if(ustat == "정상") {
            document.getElementById('statusbtn').value = "정상";
        } else if(ustat == "탈퇴") {
            document.getElementById('statusbtn').value = "탈퇴";
        }

    });

    let submitStatus = function() {
        document.getElementById('statusUpdateForm').submit();
    }

    $("#statusbtn").change(function() {
       alert("회원상태를 변경합니다.");
    });


</script>