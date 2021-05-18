<%--
  Created by IntelliJ IDEA.
  User: lee hyeji
  Date: 2021-04-08
  Time: 오후 12:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="adminLayout.jsp"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<link rel="stylesheet" href="/resources/css/admin/adminMain.css" type="text/css">

<!-- billboard.js -->
<script src="https://d3js.org/d3.v6.min.js"></script>
<script src="/resources/js/admin/billboard.js"></script>
<link rel="stylesheet" href="/resources/css/admin/stat/billboard.css">

<h1>Status Board</h1>

<!-- submenu -->
<div id="submenu">
</div>
<!-- submenu end -->

<div>
    <table id="status-board">
        <tr>
            <th>오늘 매출</th>
            <th>신규회원</th>
            <th>판매요청</th>
            <th>1:1문의</th>
            <th>방문자</th>
        </tr>
        <tr>
            <td><c:out value="${main.statisticsVO.salesRec} 원" default="-"/></td>
            <td><c:out value="${main.countRecentlyRegister} 명" default="-"/></td>
            <td><a href="/admin/request/list"><c:out value="${main.countNotYetApproved} 개" default="-"/></a></td>
            <td><a href="/admin/adminPsnlQust"><c:out value="${main.countHaveNoAns} 개" default="-"/></a></td>
            <td><c:out value="${main.statisticsVO.visitrRec} 명" default="-"/></td>
        </tr>
    </table>
</div>

<div id="svchart">
    <div>
        <div class="chart-title">월별 매출</div>
        <div class="areaChart1 chart"></div>
    </div>
    <div>
        <div class="chart-title">월별 평균 방문자 수</div>
        <div class="areaChart2 chart"></div>
    </div>
</div>

<div id="pieChart-wrapper">
    <div>
        <div class="chart-title">카테고리별 판매율</div>
        <div id="pieChart"></div>
    </div>
</div>

</div>
<!-- main end -->

<jsp:include page="adminMemo.jsp"/>

<script>

    //월별 매출 통계 데이터 받기
    //1. ajax로 AdminSalesHistVO 객체 list 받기
    //2. 받은 list를 배열에 넣기
    //3. 월 위치에 맞게 배열의 매출 값 chart1에 넣기


    //ajax를 받을 배열 - 길이 12, 매출액 0으로 초기화
    var salesList = new Array(12);

    for (let i=0; i<salesList.length; i++){
        salesList[i] = 0;
    }


    //ajax로 AdminSalesHistVO 객체 list 받기
    $.ajax({
        type:'get',
        url: '/admin/sales',
        async: false,
        success: function (result){
            console.log(result);

            //해당 월에 매출액 넣기
            for(let i =0; i<result.length; i++){
                console.log(parseInt(result[i].smonth));

                salesList[parseInt(result[i].smonth)] = result[i].sumPrc;
            }
        },
        error: function (e){
            console.log("ajax list를 받아오는 것을 실패했습니다.");
            console.log(e);
        }

    });



    //월별 방문자 통계 데이터 받기.

    //ajax를 받을 배열 - 길이 12, 방문자 수 0으로 초기화
    var visitrList = new Array(12);

    for (let i=0; i<visitrList.length; i++){
        visitrList[i] = 0;
    }


    //ajax로 AdminVisitrHistVO 객체 list 받기
    $.ajax({
        type:'get',
        url: '/admin/visitr',
        async: false,
        success: function (result){
            console.log(result);

            //해당 월에 매출액 넣기
            for(let i =0; i<result.length; i++){
                console.log(parseInt(result[i].vmonth));

                visitrList[parseInt(result[i].vmonth)] = result[i].sumVisitr;
            }
        },
        error: function (e){
            console.log("ajax list를 받아오는 것을 실패했습니다.");
            console.log(e);
        }

    });


    //월별 매출액 그래프
    let chart1 = bb.generate({
        data: {
            columns: [
                ["매출 (원)", salesList[0],salesList[1],salesList[2],salesList[3],salesList[4],salesList[5],salesList[6],salesList[7],salesList[8],salesList[9],salesList[10],salesList[11]],
            ],
            types: {}
        },
        bindto: ".areaChart1"
    });

    //월별 방문자 수 그래프
    let chart2 = bb.generate({
        data: {
            columns: [
                ["방문자 수", visitrList[0],visitrList[1],visitrList[2],visitrList[3],visitrList[4],visitrList[5],visitrList[6],visitrList[7],visitrList[8],visitrList[9],visitrList[10],visitrList[11]],
            ],
            types: {}
        },
        bindto: ".areaChart2"
    });

    // for ESM environment, need to import modules as:
    // import bb, {pie} from "billboard.js"

    let chart = bb.generate({
        data: {
            columns: [
                ["카페", 120],
                ["피자, 햄버거, 치킨", 50],
                ["빵, 아이스크림", 70],
                ["편의점, 마트", 20],
                ["문화, 게임, 영화", 20],
                ["외식, 분식", 30],
                ["백화점, 주유, 뷰티", 10],
                ["휴대폰 데이터", 0]
            ],
            type: "pie", // for ESM specify as: pie()
            onclick: function (d, i) {
                console.log("onclick", d, i);
            }
        },
        bindto: "#pieChart"
    });

    $(document).ready(function (e) {
        // 값을 조회하는 과정에서 exception이 발생한 경우 error 값이 전달됨
        let error = "${error}";

        // error 메세지가 존재하면 해당 메세지를 alert
        if (error.length > 0) {
            alert("데이터를 가져오는데 문제가 발생했습니다. 담당자에게 문의해주세요. error: " + error);
        }

        console.log(error);


    });





</script>