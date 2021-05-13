function getCateList() {
    let cateList = [];

    $.ajax({
        type: 'get',
        url: '/admin/product/cateList',
        async: false,
        success: function (result) {
            result.forEach(cate => cateList.push({code: cate.code, name: cate.name}));
        },
        error: function () {
            alert("카테고리 목록을 불러올 수 없습니다.\n 문제가 계속될 경우 담당자에게 문의해주세요.");
        }
    });

    return  cateList;
}

function getBrdList(cateCode) {
    let brdList = [];

    $.ajax({
        type: 'get',
        url: '/admin/product/category/' + cateCode + '/brdList',
        async: false,
        success: function (result) {
            brdList = result;
        },
        error: function () {
            alert("카테고리 목록을 불러올 수 없습니다.\n 문제가 계속될 경우 담당자에게 문의해주세요.");
        }
    });

    return  brdList;
}