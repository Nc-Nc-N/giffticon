function calAutoPrc(prc, startDcRate, expirDt) {
    console.log("listPrc: " + prc);
    let today = new Date().getTime();
    expirDt = new Date(expirDt).getTime();

    let finalPnR = [0,0]; //최종 prc 와 rate
    let interval = 0; //구간별 할인레벨 (15일 간격 최대 60일)

    //남은 일자
    let remainedDt = Math.ceil((expirDt - today) / (1000 * 3600 * 24));

    console.log("remained Dt: " + remainedDt);

    //남은일자를 구간별로 나누어 할인율 상승 시킴
    if (remainedDt <= 60) {

        let intervalCheck = Math.ceil(remainedDt / 15);
        console.log("intervalCheck : " + intervalCheck);

        switch (intervalCheck) {

            case 4 :
                interval = 1;
                break;
            case 3 :
                interval = 2;
                break;
            case 2 :
                interval = 3;
                break;
            case 1 :
                interval = 4;
                break;
        }
    }

    console.log("interval: " + interval);

    finalPnR = dcCalculator(prc, startDcRate, 0.05, interval);

    return finalPnR;
}

//남은 날짜와 정가, 할인율 계산하여 현재가 할인율 return
function dcCalculator(prc, startDcRate, slope, interval) {

    let finalDcRate = (parseFloat(startDcRate) + parseFloat(slope * interval)).toFixed(2);

    let finalPrc = prc * (1 - finalDcRate);

    finalPrc = Math.round(finalPrc/10)*10;

    return [finalPrc, finalDcRate]
}
