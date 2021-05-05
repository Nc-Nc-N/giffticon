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

                alert("다시 시도해주세요.");

            }
        })
    }

    // 관심상품 삭제
    function remove(wish) {
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

                $("#like-button").removeClass('selected');
                alert("관심상품에서 삭제되었습니다.");

            }, error: function () {

                alert("다시 시도해주세요.");

            }
        })
    }

    return {
        add: add,
        remove: remove
    };
})();