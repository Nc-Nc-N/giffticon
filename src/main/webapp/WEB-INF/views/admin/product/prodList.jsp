<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/admin/adminLayout.jsp"/>

<link rel="stylesheet" href="/resources/css/common/search-box.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/button.css" type="text/css">
<link rel="stylesheet" href="/resources/css/common/pagination.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/request/requestList.css" type="text/css">
<link rel="stylesheet" href="/resources/css/admin/product/productDetail.css" type="text/css">

<h1>상품관리</h1>

<!-- menu -->
<div id="submenu"></div>
<!-- menu end -->

<!-- search area -->
<div class="search-area">
    <form id="search-form">
        <select name="type" class="search-select">
            <option value="CBPD" <c:out value="${pageMaker.cri.type eq 'CBPD' ? 'selected' : ''}"/>>전체</option>
            <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}"/>>카테고리명</option>
            <option value="B" <c:out value="${pageMaker.cri.type eq 'B' ? 'selected' : ''}"/>>브랜드명</option>
            <option value="P" <c:out value="${pageMaker.cri.type eq 'P' ? 'selected' : ''}"/>>상품명</option>
            <option value="D" <c:out value="${pageMaker.cri.type eq 'D' ? 'selected' : ''}"/>>상품코드</option>
        </select>
        <div class="search-form">
            <div>
                <input type="text" name="keyword" class="search-input"
                       value="<c:out value='${pageMaker.cri.keyword}'/>"/>
                <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
                <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>

                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>
</div>
<!-- search area end -->

<!-- request list -->
<div id="rqust-div">
    <table id="rqust-tb">
        <thead>
        <tr>
            <td class="w100">상품 이미지</td>
            <td class="w45">상품코드</td>
            <td class="w100">카테고리</td>
            <td class="w100">브랜드</td>
            <td class="w125">상품명</td>
            <td class="w45">사용여부</td>
            <td class="w45">&nbsp;</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="prod" items="${prodList}" varStatus="status">
            <tr class="rqust-tr">
                <td>
                    <div class="rqust-img"><img src="<c:out value='${prod.imgPath}'/>"></div>
                </td>
                <td>
                    <div><c:out value="${prod.prodCode}"/></div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${prod.cateName}"/></div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${prod.brdName}"/></div>
                </td>
                <td>
                    <div class="ellipsis"><c:out value="${prod.prodName}"/></div>
                </td>
                <td>
                    <div><c:out value="${prod.enabled.toString() eq '1' ? '사용' : '미사용'}"/></div>
                </td>
                <td>
                    <div><a href="${prod.prodCode}" class="detail-link">상세</a></div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>
<!-- request list end -->

<c:if test="${empty prodList}">
    <div class="nothing">판매요청이 없습니다.</div>
</c:if>

<div class="main-footer">
    <button class="btn btn-active reg-btn">등록</button>
    <div class="pagination">
        <c:if test="${pageMaker.prev}">
            <a class="paginate_button prev" href="${pageMaker.startPage - 1}">&lt;</a>
        </c:if>
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <a class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}" href="${num}">${num}</a>
        </c:forEach>
        <c:if test="${pageMaker.next}">
            <a class="paginate_button next" href="${pageMaker.endPage + 1}">&gt;</a>
        </c:if>
    </div>
</div>

<form id="actionForm" action='/admin/product/prodList' method="get">
    <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
    <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
    <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
    <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
</form>

</div>
<!-- main content end -->

<!-- register modal -->
<div class="modal reg-modal">
    <div id="detail-modal">
        <div class="modal-title">상품등록</div>
        <form id="reg-form" action="/admin/product/register" method="post" enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <table id="gft-td">
                <tr class="under-line">
                    <td class="td-title">
                        <div>분류</div>
                    </td>
                    <td colspan="5">
                        <div class="select-div">
                            <div class="cate-select">
                                <select class="cate" name="cateCode">
                                    <option value="00">카테고리</option>
                                </select>
                            </div>
                            <div class="brd-select">
                                <select class="brd" name="brdCode"></select>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr class="under-line">
                    <td class="td-title">상품명</td>
                    <td colspan="5">
                        <div class="td-cntnt text-input"><input type="text" name="name" placeholder="상품명을 입력해주세요."/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td-title">
                        <div>정가</div>
                    </td>
                    <td colspan="2">
                        <div class="td-cntnt text-input"><input type="text" name="prc" placeholder="숫자만 입력가능합니다."/>
                        </div>
                    </td>
                    <td class="td-title">
                        <div>기본 할인율</div>
                    </td>
                    <td colspan="2">
                        <div class="td-cntnt text-input"><input type="text" name="inDcRate" placeholder="숫자만 입력가능합니다."/>
                        </div>
                    </td>
                </tr>
                <tr class="under-line">
                    <td></td>
                    <td colspan="5">
                        <div class="td-cntnt warn-msg">
                            <i class="fas fa-exclamation-circle"></i>정가는 최대 99,999,999원 까지, 할인율은 최대 30% 까지 입력가능합니다.
                        </div>
                    </td>
                </tr>
                <tr class="under-line">
                    <td class="td-title">상품설명</td>
                    <td colspan="5">
                        <div class="td-cntnt text-input descn">
                            <textarea name="descn" placeholder="상품 설명을 입력해주세요."></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="td-title">상품이미지</td>
                    <td colspan="5">
                        <div class="td-cntnt"><input type="file" name="prodImg"/></div>
                    </td>
                </tr>
            </table>
        </form>
        <div id="detail-btn-area">
            <button class="btn btn-active prod-reg">등록</button>
            <button class="btn btn-disabled cancel">취소</button>
        </div>
    </div>
</div>
<!-- end register modal -->

<script src="/resources/js/admin/product/prodList.js"></script>
<script>
    let csrfHeaderName = "${_csrf.headerName}";
    let csrfTokenValue = "${_csrf.token}";
    $(document).ready(function (e) {

        // 사이드바 판매요청관리 active
        $("a[id='prodAdministration']").attr('class', 'active');

        // 페이지 이동
        let actionForm = $("#actionForm");
        $(".paginate_button").on("click", function (e) {
            e.preventDefault();
            let pageNum = $(this).attr("href");
            submitAction(actionForm, pageNum);
        });

        // 검색
        let searchForm = $("#search-form");
        $("#search-form button").on("click", function (e) {
            e.preventDefault();
            submitAction(searchForm, 1);
        });

        fillCateSelect();

        $(".reg-btn").on("click", function (e) {
            e.preventDefault();
            showRegModal();
        });

    });

    function submitAction(form, pageNum) {
        form.find("input[name='pageNum']").val(pageNum);
        form.submit();
    }

    function fillBrdSelect(cateCode) {
        let brdList = getBrdList(cateCode);

        // 브랜드 select를 채운다.
        brdList.forEach(brd => {
            $(".brd-select select").append("<option value='" + brd.code + "'>" + brd.name + "</option>");
        });
    }

    function fillCateSelect() {
        let cateList = getCateList();       // 카테고리 목록

        // 카테고리 select를 채운다.
        cateList.forEach(cate => {
            if (cate.code === '99') return;
            $(".cate-select select").append("<option value='" + cate.code + "'>" + cate.name + "</option>");
        });

        // 카테고리가 선택되면 해당 카테고리에 포함된 브랜드 목록을 불러온다.
        $(".cate-select select").on("change", function (e) {
            let cateCode = $(".cate-select option:selected").val();
            fillBrdSelect(cateCode);
        });
    }

    function showRegModal() {
        // 입력창 유효성 검사
        $("input[name='prc']").on("propertychange change keyup paste input", function (e) {
            let prc = $(this).val().replace(/[^0-9]/g, '').substring(0, 8);
            $(this).val(prc);
        });
        $("input[name='inDcRate']").on("propertychange change keyup paste input", function (e) {
            $(this).val($(this).val().replace(/[^0-9]/g, '').substring(0, 2));
        });

        // 등록버튼 이벤트 등록
        $(".prod-reg").on("click", function (e) {
            // 입력한 상품정보가 유효하면 상품을 등록한다.
            if (!checkInputVale()) return;

            let formData = new FormData($("#reg-form")[0]);

            $.ajax({
                type: 'post',
                url: '/admin/product/register',
                contentType: false,
                processData: false,
                enctype: 'multipart/form-data',
                data: formData,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function (result) {
                    hideRegModal();
                    let pageNum = parseInt("${pageMaker.cri.pageNum}");
                    let realEnd = getRealEnd("${pageMaker.total}", "${pageMaker.cri.amount}");
                    submitAction(searchForm, pageNum > realEnd ? realEnd : pageNum);
                },
                error: function (result) {
                    alert("다시 한 번 시도해주세요.");
                }
            });

        });

        // 취소버튼 이벤트 등록
        $(".cancel").on("click", function (e) {
            hideRegModal();
        });

        // 모달 visibility visible
        $(".reg-modal").css("visibility", "visible");
    }

    function hideRegModal() {
        // 버튼 이벤트 off
        $(".prod-reg").off();
        // select, input remove
        $(".cate-select select option:selected").prop("selected", false);
        $(".brd-select select option").remove();
        $(".reg-modal input[type='text']").val("");
        $(".reg-modal textarea").val("");
        // 모달 hidden
        $(".reg-modal").css("visibility", "hidden");
    }

    function getRealEnd(t, a) {
        let total = parseInt(t) - 1;
        let amount = parseInt(a);
        return parseInt(Math.ceil((total * 1.0) / amount));
    }

    let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    let maxSize = 5242880; //5MB

    function checkExtension(fileName, fileSize){
        if(fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }

        if(regex.test(fileName)){
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }
        return true;
    }

    function checkCategory() {
        let cateCode = $(".cate-select option:selected").val();
        return cateCode !== '00';
    }

    function checkPrc() {
        let prc = $("input[name='prc']").val();
        return /^[0-9]+/g.test(prc);
    }

    function checkInDcRate() {
        let inDcRate = $("input[name='inDcRate']").val();
        return /^[0-9]{1,2}$/g.test(inDcRate) && (parseInt(inDcRate) > 0 && parseInt(inDcRate) <= 30);
    }

    function checkImg() {
        let img = $("input[name='prodImg']");
        return img.val() !== 0 && checkExtension(img.val(), img.size);
    }

    function checkInputVale() {
        if (!checkCategory()) {
            alert("카테고리를 선택해주세요.");
            return false;
        }
        if ($("input[name='name']").val().length === 0) {
            alert("상품명을 입력하세요.");
            return false;
        }
        if (!checkPrc()) {
            alert("정가를 입력해주세요.");
            return false;
        }
        if (!checkInDcRate()) {
            alert("기본 할인율을 입력해주세요.\n할인율은 1이상 30이하 숫자여야합니다.");
            return false;
        }
        if (!checkImg()) {
            alert("상품 이미지를 등록해주세요.");
            return false;
        }
        return true;
    }
</script>

<jsp:include page="/WEB-INF/views/admin/adminMemo.jsp"/>

