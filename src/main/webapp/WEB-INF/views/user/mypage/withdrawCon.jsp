<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="templete.jsp"/>

<link rel="stylesheet" href="/resources/css/user/mypage/withdrawCon.css" type="text/css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<div class="contents">
    <div class="contentheader">
        <span> 콘 인출</span>
    </div>
    <div class="tbl-group">
        <table class="type02">
            <tr>
                <th scope="row">이름</th>
                <td><c:out value="${user.name}"/></td>
            </tr>
            <tr>
                <th scope="row">계좌</th>
                <td class="myAcc"><c:out value="${user.bnkName}"/>&nbsp;<c:out value="${user.acc}"/></td>
            </tr>
        </table>
    </div>
    <div class="pnt_info_column">
        <div class="con_info" > 인출 가능 콘 <span class="userPnt"><c:out value="${user.pnt}"/> 콘</span> </div>
        <div class="con_info">  인출할 충전 콘 <input type="number" id="wdCon"/></div>
        <div class="con_info"> 인출 후 콘 <span class="afterAdd"></span></div>
        <span class="money"></span>
        <div class="pnt_bought_btn_section">
            <button id= "withdraw-btn" class="btn btn-active">인출하기</button>
        </div>
    </div>
</div>

</div>
</div>
</div>
</div>

<div class="modal">
    <div class="screen">
        <button type="button" value="close" class="btn modal--close">X</button>
        <div class="layerpop">
            <div  class="pwd_group">
                <div class="input_text">
                    비밀번호 확인 &ensp;<input type="password" class="originPwd" placeholder="기존 비밀번호를 입력해주세요">
                </div>
                <button class="btn btn-submit" id="btn-confirmOriginPwd">인증</button>
            </div>
            <div class="message" id="msg-originPwd"></div>
        </div>
    </div>
</div>

</body>
</html>
<script>
    $(document).ready(function (){

        // 문자열에서 앞 0 제거하는 함수
        let trimFrontZero = function (String) {
            return String.replace(/(^0+)/, "");
        }

        // 문자열에서 숫자만 남기는 함수
        let trimString = function (string) {
            return string.trim().replace(/[^0-9]/g, "");
        }

        // 인출할 콘 input box를 벗어날 때
        function isNotInMyArea( $targetObj )
        {
            let isIn = true;
            let $objArr = Array();
            let opts = {
                left: 99999, right: 0, top: 99999, bottom: 0
            }

            if( $targetObj )
            {
                if( $targetObj.length == 1 ) {
                    $objArr.push( $targetObj );
                } else {
                    $objArr = $targetObj;
                }

                $.each($objArr, function(i, $obj){
                    let obj_position = $obj.offset();
                    obj_position.right = parseInt( obj_position.left ) + ( $obj.width() );
                    obj_position.bottom = parseInt( obj_position.top ) + parseInt( $obj.height() );

                    if( obj_position.left < opts.left ) opts.left = obj_position.left;
                    if( obj_position.right > opts.right ) opts.right = obj_position.right;
                    if( obj_position.top < opts.top ) opts.top = obj_position.top;
                    if( obj_position.bottom > opts.bottom ) opts.bottom = obj_position.bottom;
                });

                if( ( opts.left <= event.pageX && event.pageX <= opts.right )
                    && ( opts.top <= event.pageY && event.pageY <= opts.bottom ) )
                {
                    isIn = false;
                }
            }

            return isIn;
        }


        let userCon = ${user.pnt};
        let oldVal = 0;
        let inputBox = $("#wdCon");

        // 인출할 충전 콘이 변할 때마다 인출 후 콘 변경
        inputBox.on("propertychange change keyup paste input", function (){
            let currentVal = $(this).val();
            $(this).val(trimFrontZero(trimString(currentVal)));

            if(currentVal === oldVal){
                return;
            }

            oldVal = currentVal;

            if(oldVal !== ""){

                $('.afterAdd').html(userCon-parseInt(oldVal)).append(" 콘");
            }else{
                $('.afterAdd').html("");
            }

            // 인출할 충전 콘이 보유 콘보다 클 때
            if(oldVal > userCon){
                $(this).val(userCon);
                oldVal = userCon;
                $('.afterAdd').html(userCon-parseInt(oldVal)).append(" 콘");
            }
        })

        // 인출할 충전 콘이 1000원 미만일 때 1000원으로 처리
        $(function(){
            $(document).mousedown(function(){
                if( isNotInMyArea ( [ $("button"), $("#wdCon") ] ) ) {
                    if(parseInt(inputBox.val())<1000){
                        alert("충전 콘은 1,000원 이상부터 1원 단위로 인출하실 수 있습니다.");
                        inputBox.val(1000);
                        $('.afterAdd').html(userCon-1000).append(" 콘");
                    }
                }
            })
        });

        $modal = $(".modal");

        // '인출하기' 버튼 클릭시
        $("#withdraw-btn").on("click", function (){
            if(!inputBox.val()){
                alert("인출할 충전 콘을 입력해주세요.");
                return false;
            }
            $modal.show();

        })

        $(".modal--close").click(function(){
            $modal.hide();
        });

    })
</script>
<%-- modal 비밀번호 확인--%>
<script>
    $(document).ready(function () {

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        const oriEmail = "<c:out value="${user.email}"/>";

        //비밀번호 확인 버튼
        let btnOriginPwd = $("#btn-confirmOriginPwd");

        //input 칸
        let insertOriginPwd = $(".originPwd");

        //msg 출력칸
        let originPwdMsg = $("#msg-originPwd");

        //기존 비밀번호 인증
        btnOriginPwd.on("click", function (e) {

            var msg = "";
            let oriPwdVal = insertOriginPwd.val();

            let checkUser = {
                email: oriEmail,
                pwd: oriPwdVal
            }

            originPwdMsg.html("");

            $.ajax({
                url: '/user/mypage/checkPassword',
                contentType: "application/json",
                data: JSON.stringify(checkUser),
                type: 'post',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                success: function () {
                    // 비밀번호 확인 성공


                },
                error: function () {

                    msg += "<i class='fas fa-exclamation-circle'></i>";
                    msg += "<p>&nbsp;비밀번호가 다릅니다.</p>";
                    originPwdMsg.html(msg);

                }

            })

        })
    });

</script>
