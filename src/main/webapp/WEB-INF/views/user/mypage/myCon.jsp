<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="templete.jsp"/>

<link rel="stylesheet" href="/resources/css/user/mypage/myCon.css" type="text/css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<div class="contentheader">
    <span> 마이 콘</span>
</div>
<div class="viewConList">
    <div class="con-info">
        <div class="con-tit">
            <div class="con-tit_txt">
                <div class="giffticon-txt">기쁘티콘</div>
                <div class="con-txt">콘 잔액</div>
            </div>
        </div>
        <div class="info-right">
            <div class="con-amount-info">
                <span class="con-amount">0</span>
                <span class="con-amount-won">원</span>
            </div>
            <ul class="con-btns">
                <li class="btn-li">
                    <a href="/user/mypage/addCon" class="home-summary-buttons__alink--topUp">
                        <span class="btns-txt"><i class="fas fa-plus"></i> 충전하기</span>
                    </a>
                </li>
                <li class="btn-li">
                    <a href="/user/mypage/withdrawCon" class="home-summary-buttons__alink--topUp">
                        <span class="btns-txt"><i class="fas fa-minus"></i> 인출하기</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <table class="tbl tbl_type1">
        <colgroup>
            <col style="width: 120px;">
            <col style="width: auto;">
            <col style="width: 122px;">
            <col style="width: 140px;">
        </colgroup>
        <thead>
        <tr>
            <th>날짜</th>
            <th class="info">내용</th>
            <th>유효기간</th>
            <th>금액</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="4" class="no_data">
            적립금 내역이 존재하지 않습니다.
            </td>
        </tr>
        </tbody>
    </table>
</div>

</div>
</div>
</div>
</div>
</div>

</body>
</html>
