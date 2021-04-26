//날짜 선택 시 from이 to보다 늦은 날짜인지 체크
function calendarCheck(dateFrom, dateTo){

    let listFrom = $("#dateFrom").val().split('-');
    let listTo = $("#dateTo").val().split('-');

    let finDateFrom = parseInt(listFrom[0]+listFrom[1]+listFrom[2]);
    let finDateTo = parseInt(listTo[0]+listTo[1]+listTo[2]);

    if(finDateFrom > finDateTo){
        return false;
    }else{
        return true;
    }
}