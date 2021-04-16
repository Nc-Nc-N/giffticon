<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../common/header.jsp"%>

<!DOCTYPE html>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/user/prod_list.css" type="text/css">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
</style>
</head>
<body>

    
    <!-- 컨테이너 전체 -->
    <div id="container">
        <div class="space"></div>
        <div class="main">
            
            <!-- 카테고리바 -->
            <nav>
                <div class="catename"><i class="<c:out value="${category.iconPath}"/>"></i> &nbsp;<c:out value="${category.name}"/></div>
                <div class="search-result" style="display: none">총 <c:out value="${pageMaker.total}"/> 개의 상품이 검색되었습니다. </div>
                <ul>
                    <a href="prod_list?code=${category.code}&orderby=best&pageNum=1&amount=${pageMaker.cri.amount}"><li class="cateAll">전체보기</li></a>
                    <c:forEach items="${brandList}" var="brandList">
                    <a href="prod_list?code=${brandList.code}&orderby=best&pageNum=1&amount=${pageMaker.cri.amount}"><li><c:out value="${brandList.name}"/></li></a>
                    </c:forEach>
                </ul>
            </nav>

            <%-- 정렬 방식 --%>
            <select class="search-select">
                <option id="best" value="best"
                        <c:out value="${pageMaker.cri.orderby eq 'best' ? 'selected':''}"/>>인기순</option>
                <option id="low" value="low"
                        <c:out value="${pageMaker.cri.orderby eq 'low' ? 'selected':''}"/>>낮은 가격순</option>
                <option id="high" value="high"
                        <c:out value="${pageMaker.cri.orderby eq 'high' ? 'selected':''}"/>>높은 가격순</option>
                <option id="deadline" value="deadline"
                        <c:out value="${pageMaker.cri.orderby eq 'deadline' ? 'selected':''}"/>>마감 임박순</option>
            </select>

            <%-- 상품 목록 리스트 --%>
            <c:set var="i" value="0"/>
            <c:set var="j" value="4"/>
            <table>
            <c:forEach items="${gifti}" var="gifti">
                <c:if test="${i%j==0}">
                    <tr>
                </c:if>
                <td>
                    <a href="prod_detail?code=${gifti.prodCode}">
                    <div class="items">
                        <div class="itemimg">
                            <img src="${gifti.pimgPath}">
                        </div>
                        <div class="itemnameNprice">
                            <div class="itembrand">
                                <c:out value="${gifti.bname}"/>
                            </div>
                            <div class="itemname">
                                <c:out value="${gifti.pname}"/>
                            </div>
                            <div class="itemprice">
                                <span><fmt:formatNumber value="${gifti.dcRate}" type="percent" /></span>&nbsp;&nbsp;
                                <span><fmt:formatNumber type="number" maxFractionDigits="3" value="${gifti.dcPrc}" /> 원 ~</span>
                            </div>
                            <div class="itemoriginprice">
                                <span><del><fmt:formatNumber type="number" maxFractionDigits="3" value="${gifti.prc}"/> 원</del></span>
                            </div>
                        </div>
                    </div>
                    </a>
                </td>
                <c:if test="${i%j == j-1}">
                    </tr>
                </c:if>
                <c:set var="i" value="${i+1}"/>
            </c:forEach>
            </table>
        </div>


        <div class="space"></div>
        <!-- 페이지네이션 -->
        <div class="pagination">
            <c:if test="${pageMaker.prev}">
                <li class="paginate_button previous">
                    <a href="${pageMaker.startPage-1}">&lt;</a>
                </li>
            </c:if>
            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}">
                    <a href="${num}">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next}">
                <li class="paginate_button next">
                    <a href="{pageMaker.endPage+1}">&gt;</a>
                </li>
            </c:if>
        </div>
    </div>

    <%-- 페이지 번호 -> url 이동 --%>
    <form id="actionForm" action='/user/prod_list' method="get">
        <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
        <input type="hidden" name="code" value='<c:out value="${pageMaker.cri.code}"/>'>
        <input type="hidden" name="orderby" value='<c:out value="${pageMaker.cri.orderby}"/>'>
        <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
        <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
    </form>

    <script type="text/javascript">
        $(document).ready(function (){

            let curr_url = document.URL;
            let new_curr_url = new URL(curr_url);

            // 현재 url의 code parameter value
            let code = new_curr_url.searchParams.get("code");

            // 현재 url의 orderby parameter value
            let selectedOrder = new_curr_url.searchParams.get("orderby");

            // 검색 후 '전체보기' 숨기기, 검색 결과
            if(code==='' || code===null || code==='0'){
                code = '0';
                $('.cateAll').hide();
                $('.search-result').show();
            }

           // 상품 정렬 방식 이벤트 처리
           $(".search-select").on("change", function (){

               let orderby = $(".search-select option:selected").val();

               location.href="prod_list?keyword=${pageMaker.cri.keyword}&code="+code+"&orderby="+orderby+"&pageNum=1&amount=${pageMaker.cri.amount}";
           });

            // 페이지 번호 이벤트 처리
            let actionForm = $("#actionForm");

            $(".paginate_button a").on("click", function (e){

                e.preventDefault();

                actionForm.find("input[name='pageNum']").val($(this).attr("href"));
                actionForm.submit();
            });

        });

        // 검색 버튼 이벤트 처리
        let searchForm = $('#searchForm');

        $("#searchForm button").on("click", function (e){

            if(!searchForm.find("input[name='keyword']").val()){
                alert("검색어를 입력해주세요");
                return false;
            }
            searchForm.submit();
        });

    </script>

</body>
</html>