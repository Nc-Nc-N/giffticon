<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="templete.jsp"/>

<link rel="stylesheet" href="/resources/css/user/mypage/addCon.css" type="text/css">
<link rel="stylesheet" href="/resources/css/user/mypage/withdrawCon.css" type="text/css">
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<div class="contentheader">
    <span> 콘 인출</span>
</div>
<div class="tbl-group">
    <table class="type02">
        <tr>
            <th scope="row">이름</th>
            <td>내용이 들어갑니다.</td>
        </tr>
        <tr>
            <th scope="row">은행</th>
            <td>내용이 들어갑니다.</td>
        </tr>
        <tr>
            <th scope="row">계좌번호</th>
            <td>내용이 들어갑니다.</td>
        </tr>
    </table>
</div>
<div class="pnt_info_column">
    <div class="con_info" style="border-top: 1px solid gainsboro;"> 인출 가능 콘 <span class="userPnt"><c:out value="${user.pnt}"/> 콘</span> </div>
    <div class="con_info">  인출할 충전 콘 <input type="number" id="wdCon"/></div>
    <div class="con_info"> 인출 후 콘 <span class="afterAdd"></span></div>
    <span class="money"></span>
</div>
<div class="pnt_bought_btn_section">
    <button id= "withdraw-btn" class="btn btn-active">인출하기</button>
</div>


</div>
</div>
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

            if(oldVal > userCon){
                $(this).val(userCon);
                oldVal = userCon;
                $('.afterAdd').html(userCon-parseInt(oldVal)).append(" 콘");
            }
        })

        $(function(){
            $(document).mousedown(function( e ){
                if( isNotInMyArea ( [ $("button"), $("#wdCon") ] ) ) {
                    if(parseInt(inputBox.val())<1000){
                        alert("충전 콘은 1,000원 이상부터 1원 단위로 인출하실 수 있습니다.");
                    }
                }
            })
        });

        // '인출하기' 버튼 클릭시
        $("#withdraw-btn").on("click", function (e){
            if(!inputBox.val()){
                alert("인출할 충전 콘을 입력해주세요.");
                return false;
            }

        })


    })
</script>
