function calculateContentLength(){

    let totalLengthMenuBody = 850;
    let totalLengthContainer = 970;

    $("div[class='content']").each(function () {

        if($(this).css("display") == 'block'){

            let divLengthStr = $(this).css("height");
            let divLength = divLengthStr.substr(0,divLengthStr.length -2);
            totalLengthMenuBody += parseInt(divLength) + 40;
            totalLengthContainer += parseInt(divLength) + 40;
        }

    });

    $("div[class='cs-menubody']").css("height",totalLengthMenuBody+"px");
    $("div[class='cs-main']").css("height",totalLengthContainer+"px");
    $("div[id='cs-container']").css("height",totalLengthContainer+"px");
}