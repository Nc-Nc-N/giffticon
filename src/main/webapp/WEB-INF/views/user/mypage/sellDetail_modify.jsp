<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <div id="register-content" tabindex="-1" role="dialog" aria-hidden="true">
        <h2>상품 정보 수정</h2>

        <div id="content">
            <div class="email_section">
                <h3>브랜드 / 상품명</h3>
                <h4><c:out value="${gftInfo.brdName}"/></h4>&nbsp;>&nbsp;
                <h4><c:out value="${gftInfo.prdName}"/></h4>
            </div>
            <div class="img_section">
                <h3>상품 정보</h3>
                <div>
                    <div class="img_container">
                        <img class="modal-img" src="<c:out value="${gftInfo.prdImgPath}"/>">
                    </div>
                    <div class="img_container">
                        <img class="modal-img" src="<c:out value="${gftInfo.brcdImgPath}"/>">
                    </div>
                </div>
            </div>

            <div class="info_section">
                <div>
                    <h3>바코드 번호</h3>
                    <h4><c:out value="${gftInfo.brcd}"/></h4>
                </div>
            </div>

            <div class="date_section">
                <h3>유효기간</h3>
                <div class="date-search">
                    <input type="date" id="end-date"
                           value="<fmt:formatDate pattern="yyyy-MM-dd" value="${gftInfo.expirDt}"/>"
                           readonly="readonly">
                </div>

            </div>

            <div class="price_section">
                <h3>가격 수정</h3>
                <div class="price_modify">
                    <form class="select">

                        <label>
                            <input type="radio" name="price_select" class="price_select" id="prc_auto" value="1"
                            <c:if test="${gftInfo.isAutoPrc eq '1'.charAt(0)}"> checked </c:if>
                            >자동</label><br>
                        <label>
                            <input type="radio" name="price_select" class="price_select" id="prc_manual" value="0"
                            <c:if test="${gftInfo.isAutoPrc eq '0'.charAt(0)}"> checked </c:if>
                            >수동</label>
                    </form>
                    <div class="input_text">
                        <input type="number" placeholder="가격표시" id="prcinput" value="<c:out value="${gftInfo.dcPrc}"/>">
                    </div>
                </div>

            </div>
            <div class="info_section">
                <div>
                    <h3>비밀번호 입력</h3>
                    <div class="input_text">
                        <input type="password" id="userPwd" placeholder="">
                    </div>
                </div>
                <div class="message"><h5></h5></div>
            </div>

        </div>

        <div id="reg-btn-area">
            <button class="btn btn-submit" id="modal-register">수정</button>
            <button class="btn btn-dark" id="modal-close">취소</button>
        </div>
        <form id="modalAction">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="gftId" value="<c:out value="${gftInfo.id}"/>">
        </form>
    </div>
