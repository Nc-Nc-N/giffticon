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
                <ul>
                    <a href="prod_list?code=${category.code}&orderby=best"><li>전체보기</li></a>
                    <c:forEach items="${brandList}" var="brandList">
                    <a href="prod_list?code=${brandList.code}&orderby=best"><li><c:out value="${brandList.name}"/></li></a>
                    </c:forEach>


                </ul>

                <%-- 정렬 방식 --%>
                <select class="search-select">
                    <option id="best" value="best">인기순</option>
                    <option id="low" value="low">낮은 가격순</option>
                    <option id="high" value="high">높은 가격순</option>
                </select>
            </nav>

            <%-- 상품 목록 리스트 --%>
            <c:set var="i" value="0"/>
            <c:set var="j" value="4"/>
            <table>
            <c:forEach items="${gifti}" var="gifti">
                <c:if test="${i%j==0}">
                    <tr>
                </c:if>
                <td>
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
                                <span><del><c:out value="${gifti.prc}"/></del> 원</span>
                            </div>
                        </div>
                    </div>
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
            <a href="#">&lt;</a>
            <a href="#">1</a>
            <a href="#" class="active">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">6</a>
            <a href="#">&gt;</a>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function (){


            let curr_url = document.URL;
            let new_curr_url = new URL(curr_url);

            // 현재 url의 code parameter value
            let code = new_curr_url.searchParams.get("code");

            // 현재 url의 orderby parameter value
            let selectedOrder = new_curr_url.searchParams.get("orderby");

           // 상품 정렬 방식
           $(".search-select").on("change", function (){
               let orderby = $(".search-select option:selected").val();

               location.href="prod_list?code="+code+"&orderby="+orderby;
           });

           // select box 선택값 유지
            if(selectedOrder=='best'){
                $('#best').attr('selected','selected');
            }else if(selectedOrder=='low'){
                $('#low').attr('selected','selected');
            }else{
                $('#high').attr('selected','selected');
            }

        });

    </script>

</body>
</html>