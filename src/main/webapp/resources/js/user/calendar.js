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