<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <head>
        <meta charset="utf-8" />
        <title>userList</title>
        <link rel="stylesheet" href="/resources/css/common-css/header.css" type="text/css">
        <link rel="stylesheet" href="/resources/css/admin/user/userList.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    </head>
    <body>
        <div id="container">
            <div class="header">
                <div class= "top_menu">
                    <span><a href="#" class="login-panel">로그인</a></span>
                    <span class="header_divider">|</span>
                    <span><a href="#" class="login-panel">회원가입</a></span>
                    <span class="header_divider">|</span>
                    <span><a href="#" class="login-panel">고객센터</a></span>
                </div>
                <div class="main-logo">
                    <div class="home-logo"><a href="#"><img src="/resources/img/기쁘티콘.png" width="230px" height="100px"></a></div>
                </div>
            </div>
            <div id="content">
                <!-- sidebar -->
                <div id="sidebar">
                  <div id="admin-menu">
                      <h2>회원관리</h2>
                      <h2>상품관리</h2>
                      <h2>배너관리</h2>
                      <h2>판매요청관리</h2>
                      <h2>거래내역관리</h2>
                      <h2>포인트관리</h2>
                      <h2>통계분석</h2>
                  </div>
                  <div id="admin-memo">
                      <span class="span">Memo</span>
                      <textarea id="memo">2021-03-25 관리자 메모내용</textarea>
                  </div>
              </div>
                <div id="main">
                    <h2>회원목록</h2>
                    <div id="menu">
                        <div>
                            <a href="#" style="color: rgb(255, 88, 93);"><span>회원목록</span></a>
                        </div>
                        <div>
                            <a href="#"><span>탈퇴회원목록</span></a>
                        </div>
                    </div>
                    <br>

                    <!-- search area -->
                    <div class="search-area">
                      <form id='searchForm' action="/admin/user/userlist"  method='get'>
                      <select name='type' class="search-select">
                          <option value="NET"
                              <c:out value="${pageMaker.cri.type eq 'NET'?'selected':''}"/>>전체</option>
                          <option value="N"
                              <c:out value="${pageMaker.cri.type eq 'N'?'selected':''}"/>>이름</option>
                          <option value="E"
                              <c:out value="${pageMaker.cri.type eq 'E'?'selected':''}"/>>이메일</option>
                          <option value="T"
                              <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>전화번호</option>
                      </select>
                        <div id='search-bar-container'>
                            <input type="text" name='keyword' class="search-input" value='<c:out value="${pageMaker.cri.keyword}"/>' />
                            <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' />
                            <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />

                            <button type="submit" class="search-button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                      </form>
                  </div>
                  <!-- search area end -->
                    <br><br>
                    <div id="tablewrapper">
                      <table id="t1" width="100%">
                        <tr>
                          <th>회원번호</th>
                          <th>이메일</th>
                          <th>이름</th>
                          <th>가입일시</th>
                          <th>전화번호</th>
                          <th>회원상태</th>
                        </tr>
                        <c:forEach items="${list}" var="userL">
                        <tr class="test11">
                          <td>${userL.id}</td>
                          <td>${userL.email}</td>
                          <td>${userL.name}</td>
                          <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                              value="${userL.inDate}" /></td>
                          <td>${userL.telNo}</td>
                          <td>${userL.enabled}</td>
                        </tr>
                        </c:forEach>


                      </table>


                    </div>
                    <br><br>
                    <div class="pagination-container">
                    <div class="pagination">

                       <c:if test="${pageMaker.prev}">
                           <li>
                               <a  class="paginate_button previous" href="${pageMaker.startPage -1}">&lt;</a></li>
                       </c:if>

                        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            <li>
                                <a class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}" href="${num}">${num}</a></li>
                        </c:forEach>

                        <c:if test="${pageMaker.next}">
                            <li>
                            <a class="paginate_button next" href="${pageMaker.endPage +1 }">&gt;</a></li>
                        </c:if>
                    </div>
                    <!-- end pagination -->
                    </div>
                </div>

                    <form id='actionForm' action="/admin/user/userlist" method='get'>
                        <input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum}'>
                        <input type='hidden' name='amount' value = '${pageMaker.cri.amount}'>
                        <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type}"/>'>
                        <input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword}"/>'>
                    </form>

                </div>
            </div>

    </body>
</html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){

        var actionForm = $("#actionForm");

        $(".paginate_button").on("click", function(e){

            e.preventDefault();

            console.log("click");

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();

        });


        var searchForm = $("#searchForm");

        $("#searchForm button").on("click", function(e){

            searchForm.find("input[name='pageNum']").val("1");
            e.preventDefault();

            searchForm.submit();

        });

    }); //end of $(document).ready

</script>