function pwdChecker(newPwd){

    var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/;
    var pattern_num = /[0-9]/;
    var pattern_eng = /[a-zA-Z]/;

    let checkAllconditions = true;

    if(newPwd.length < 8 || newPwd.length > 20){
        checkAllconditions = false;
    }

    if(!pattern_spc.test(newPwd)){
        checkAllconditions = false;
    }

    if(!pattern_num.test(newPwd)){
        checkAllconditions = false;
    }

    if(!pattern_eng.test(newPwd)){
        checkAllconditions = false;
    }

    return checkAllconditions;
}

function nameChecker(newName){

    var pattern_spc = /[~!@#$%^&*()_+|<>?:{}]/;
    var pattern_num = /[0-9]/;
    var pattern_eng = /[a-zA-Z]/;

    let checkAllconditions = true;

    if(newName.length < 2 || newName.length > 20){
        checkAllconditions = false;
    }

    if(pattern_spc.test(newName)){
        checkAllconditions = false;
    }

    if(pattern_eng.test(newName)){
        checkAllconditions = false;
    }

    if(pattern_num.test(newName)){
        checkAllconditions = false;
    }

    return checkAllconditions;
}