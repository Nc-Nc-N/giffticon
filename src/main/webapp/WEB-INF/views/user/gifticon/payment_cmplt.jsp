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
					2021031801
				</td>
			</tr>
			<tr>
				<td class="infotitle">
					주문 접수일
				</td>
				<td>
					2021-03-18
				</td>
			</tr>
			<tr>
				<td class="infotitle">
					결제 금액
				</td>
				<td>
					3,000 원
				</td>
			</tr>
			<tr>
				<td class="infotitle">
					남은 포인트
				</td>
				<td>
					5,000 원
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
