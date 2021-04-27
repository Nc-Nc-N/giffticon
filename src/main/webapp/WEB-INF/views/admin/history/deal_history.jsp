<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--isELIgnored="false"--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/history/deal_history.css" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<h1>거래내역관리</h1>

        <!-- search area -->
        <div class="search-area">
          <span id="period">거래 기간</span>
          <div class="date-search">
            <input type="date" id="start-date">
            <span style="font-size:20px">~</span>
            <input type="date" id="end-date">
          </div>
          <select class="search-select">
            <option>전체</option>
            <option>구매자 Email</option>
            <option>판매자 Email</option>
            <option>상품일련번호</option>
            <option>브랜드명, 상품명</option>
            <option>브랜드명</option>
            <option>상품명</option>
            <option>상태</option>
          </select>
          <form class="search-form">
            <div>
              <input type="text" class="search-input" />

              <button type="submit" class="search-button">
                <i class="fas fa-search"></i>
              </button>
            </div>
          </form>
        </div>
        <!-- search area end -->
        <div>
          <table id="t1" width="100%">
            <tr>
              <th style="width:10%">주문번호</th>
              <th style="width:25%">
                <p>구매자 Email</p>
                <p>판매자 Email</p>
              </th>
              <th style="width:15%">상품일련번호</th>
              <th style="width:20%">
                <p>브랜드명</p>
                <p>상품명</p>
              </th>
              <th style="width:20%">
                <p>구매일시</p>
                <p>구매확정일시</p>
              </th>
              <th>상태</th>
            </tr>
              <c:forEach items="${list}" var="dealL">
            <tr>
              <td>${dealL.id}</td>
              <td>
                <p>${dealL.buyerEmail}</p>
                <p>${dealL.sellerEmail}</p>
              </td>
              <td>${dealL.gifticonId}</td>
              <td>
                <p>${dealL.brdName}</p>
                <p>${dealL.prodName}</p>
              </td>
              <td>
                <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                   value="${dealL.dealDt}"/></p>
                <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                   value="${dealL.cmplDt}"/></p>
              <td>${dealL.codeName}</td>
            </tr>
              </c:forEach>
          </table>


        </div>

<!-- pagination container -->
<div class="pagination-container">
  <div class="pagination">

    <c:if test="${pageMaker.prev}">
      <li>
        <a class="paginate_button previous" href="${pageMaker.startPage -1}">&lt;</a></li>
    </c:if>

    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
      <li>
        <a class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}" href="${num}">${num}</a>
      </li>
    </c:forEach>

    <c:if test="${pageMaker.next}">
      <li>
        <a class="paginate_button next" href="${pageMaker.endPage +1 }">&gt;</a></li>
    </c:if>
  </div>
</div>
<!-- pagination container end -->

<form id='actionForm' action="/admin/deal-history" method='get'>
  <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
  <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
  <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type}"/>'>
  <input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword}"/>'>
</form>

      </div>
    </div>
  </div>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>


<script type="text/javascript">
  $(document).ready(function () {

    document.getElementById("dealHistAdministration").className = 'active';

    let actionForm = $("#actionForm");

    $(".paginate_button").on("click", function (e) {

      e.preventDefault();

      console.log("click");

      actionForm.find("input[name='pageNum']").val($(this).attr("href"));
      actionForm.submit();

    });

    let searchForm = $("#searchForm");

    $("#searchForm button").on("click", function (e) {

      searchForm.find("input[name='pageNum']").val("1");
      e.preventDefault();

      searchForm.submit();

    });

  }); //end of $(document).ready

</script>