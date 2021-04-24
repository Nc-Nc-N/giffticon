<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../common/header.jsp"%>

<!DOCTYPE html>
    <script src="https://kit.fontawesome.com/61917e421e.js" crossorigin="anonymous"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/user/prod_list.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/prod.css" type="text/css">
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
                <div class="search-result" style="display: none">총 <c:out value="${headerPageMaker.total}"/> 개의 상품이 검색되었습니다. </div>
                <div class="noresult" style="display: none; font-size: large">'${headerPageMaker.cri.keyword}’ 상품을 찾지 못했습니다.</div>
                <ul>
                    <a class="cateAll" href="prod_list?code=${category.code}&orderby=best&pageNum=1&amount=${headerPageMaker.cri.amount}">전체보기</a>
                    <c:forEach items="${brandList}" var="brandList">
                    <a class="brandList ${headerPageMaker.cri.code == brandList.code ? "active":""}" href="prod_list?code=${brandList.code}&orderby=best&pageNum=1&amount=${headerPageMaker.cri.amount}"><c:out value="${brandList.name}"/></a>
                    </c:forEach>
                </ul>
            </nav>

            <%-- 정렬 방식 --%>
            <select class="search-select">
                <option id="best" value="best"
                        <c:out value="${headerPageMaker.cri.orderby eq 'best' ? 'selected':''}"/>>인기순</option>
                <option id="low" value="low"
                        <c:out value="${headerPageMaker.cri.orderby eq 'low' ? 'selected':''}"/>>낮은 가격순</option>
                <option id="high" value="high"
                        <c:out value="${headerPageMaker.cri.orderby eq 'high' ? 'selected':''}"/>>높은 가격순</option>
                <option id="deadline" value="deadline"
                        <c:out value="${headerPageMaker.cri.orderby eq 'deadline' ? 'selected':''}"/>>마감 임박순</option>
            </select>

            <%-- 재검색 안내  --%>
            <div class="noresult-tip" style="display: none">
                <div class="tip_txt">
                    <span>다시 검색해보세요.</span>
                </div>
                <div class="tip_lst">
                    <p>단어의 철자가 정확한지 확인해 보세요.</p>
                    <p>띄어쓰기 또는 넓은 의미의 단어를 사용해 보세요.</p>
                </div>
            </div>

            <%-- 상품 목록 리스트 --%>
            <c:set var="i" value="0"/>
            <c:set var="j" value="4"/>
            <c:set var="k" value="1"/>
            <table>
            <c:forEach items="${gifti}" var="gifti">
                <c:if test="${i%j==0}">
                    <tr>
                </c:if>
                <td>
                    <a href="prod_detail?code=${gifti.prodCode}">
                    <div class="items">
                        <div class="pic">
                            <div class="img">
                                <c:if test="${k<9}">
                                    <p class="best" style="display:none;">NO. <c:out value="${k}"/></p>
                                </c:if>
                                <c:set var="k" value="${k+1}"/>
                                <img src="${gifti.pimgPath}">
                            </div>
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
        <div class="pagination-container">
            <div class="pagination">
                <c:if test="${headerPageMaker.prev}">
                    <li>
                        <a  class="paginate_button previous" href="${headerPageMaker.startPage -1}">&lt;</a>
                    </li>
                </c:if>

                <c:forEach var="num" begin="${headerPageMaker.startPage}" end="${headerPageMaker.endPage}">
                    <li>
                        <a class="paginate_button ${headerPageMaker.cri.pageNum == num ? "active":""}" href="${num}">${num}</a>
                    </li>
                </c:forEach>

                <c:if test="${headerPageMaker.next}">
                    <li>
                        <a class="paginate_button next" href="${headerPageMaker.endPage +1 }">&gt;</a>
                    </li>
                </c:if>
            </div>
            <!-- end pagination -->
        </div>
    </div>

    <%-- 페이지 번호 -> url 이동 --%>
    <form id="actionForm" action='/user/prod_list' method="get">
        <input type="hidden" name="keyword" value='<c:out value="${headerPageMaker.cri.keyword}"/>'>
        <input type="hidden" name="code" value='<c:out value="${headerPageMaker.cri.code}"/>'>
        <input type="hidden" name="orderby" value='<c:out value="${headerPageMaker.cri.orderby}"/>'>
        <input type="hidden" name="pageNum" value='<c:out value="${headerPageMaker.cri.pageNum}"/>'>
        <input type="hidden" name="amount" value='<c:out value="${headerPageMaker.cri.amount}"/>'>
    </form>

</body>
<script type="text/javascript">
    $(document).ready(function (e){

        let curr_url = document.URL;
        let new_curr_url = new URL(curr_url);

        // 현재 url의 code parameter value
        let code = new_curr_url.searchParams.get("code");

        // 현재 url의 orderby parameter value
        let selectedOrder = new_curr_url.searchParams.get("orderby");

        // 인기순 8위까지 보여주기
        if(selectedOrder==='best'){
            $('.best').show();
        }
        if(${headerPageMaker.cri.pageNum} >1){
            $('.best').hide();
        }

        // 검색 후 카테고리 숨기기, 검색 결과 상품수 출력
        if(code==='' || code===null || code==='0'){
            code = '0';
            $('.cateAll').hide();
            $('.search-result').show();
        }

        // 검색 결과가 0일 때
        if(${headerPageMaker.total}===0 && code==='0'){
            $('.search-result').hide();
            $('.search-select').hide();
            $('.noresult').show();
            $('.noresult-tip').show();
        }

        // 상품 정렬 방식 이벤트 처리
        $(".search-select").on("change", function (){

            let orderby = $(".search-select option:selected").val();

            location.href="prod_list?keyword=${headerPageMaker.cri.keyword}&code="+code+"&orderby="+orderby+"&pageNum=1&amount=${headerPageMaker.cri.amount}";
        });

        // 페이지 번호 이벤트 처리
        let actionForm = $("#actionForm");

        $(".paginate_button").on("click", function (e){

            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        // 에러 메시지 처리
        let error = "${error}";

        if(error.length > 0){
            alert("error: " + error);
        }
    });

</script>
