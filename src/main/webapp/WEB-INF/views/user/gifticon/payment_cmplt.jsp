<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../../common/header.jsp"%>
<head>
<link rel="stylesheet" href="/resources/css/user/sale.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/gifticon/payment_cmplt.css" type="text/css">
</head>

<!-- 컨테이너 전체 -->
<div id="container">
	<div id="space">
	</div>
	<div id="main">
		<c:set var="today" value="<%=new java.util.Date()%>" />

		<div class="msg">
			<span>결제가 완료되었습니다.</span>
			<br>
			<span>이용해주셔서 감사합니다.</span>
		</div>
		<div class="tablewrapper">
			<table class="infotable">
			<tbody>
			<tr>
				<td class="infotitle">
					주문번호
				</td>
				<td>
					<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyyMMdd" /></c:set>
					<c:out value="${date}"/><c:out value="${gftId}"/>
				</td>
			</tr>
			<tr>
				<td class="infotitle">
					주문 접수일
				</td>
				<td>
					<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
					<c:out value="${date}"/>
				</td>
			</tr>
			<tr>
				<td class="infotitle">
					주문 금액
				</td>
				<td>
					<fmt:formatNumber type="number" maxFractionDigits="3" value="${dcPrc}" /><span> 원</span>
				</td>
			</tr>
			<tr>
				<td class="infotitle">
					남은 콘
				</td>
				<td>
					<fmt:formatNumber type="number" maxFractionDigits="3" value="${user.pnt}" /><span> 콘</span>
				</td>
			</tr>
			</tbody>
			</table>
		</div>
        <div>
            <button class="btn btn-deals">구매내역 확인</button>
            <button class="btn btn-home">홈으로 가기</button>
        </div>
	</div>
</div>
</body>
<script>
	// 에러 메시지 처리
	let error = "${error}";

	if(error.length > 0){
		alert("error: " + error);
	}
</script>
