// 관심상품
let wishListService = (function () {

    let header = $("meta[name='_csrf_header']").attr("content");
    let token = $("meta[name='_csrf']").attr("content");

    // 관심상품 추가
    function add(wish) {
        console.log("insert wish....")

        $.ajax({

            type: "POST",
            url: "/wishList/register",
            beforeSend: function (xhr){
                xhr.setRequestHeader( header, token );
            },
            data: JSON.stringify(wish),
            contentType: "application/json; charset=utf-8",
            success: function () {

                $("#like-button").addClass('selected');

                alert("관심상품으로 등록되었습니다.");

            }, error: function () {

                alert('일시적인 오류가 생겨 잠시 후 다시 시도해주시기 바랍니다.');

            }
        })
    }

    // 관심상품 삭제
    function remove(wish) {

        return new Promise(function (resolve,reject){

        console.log("delete wish....")

        $.ajax({
            type: "POST",
            url: "/wishList/remove",
            beforeSend: function (xhr){
                xhr.setRequestHeader( header, token );
            },
            data: JSON.stringify(wish),
            contentType: "application/json; charset=utf-8",
            success: function () {

                alert("관심상품에서 삭제되었습니다.");
                resolve();

            }, error: function () {

                reject("다시 시도해주세요.");

            }
        })
        })
    }

    return {
        add: add,
        remove: remove
    };
})();