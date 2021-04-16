// 관심상품
let wishListService = (function () {

    // 관심상품 추가
    function add(wish, callback, error) {
        console.log("insert wish....")

        let csrfHeaderName ="${_csrf.headerName}";
        let csrfTokenValue="${_csrf.token}";

        $.ajax({
            type: "POST",
            url: "/wishList/register",
            beforeSend: function (xhr){
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data: JSON.stringify(wish),
            contentType: "application/json; charset=utf-8",
            success: function (result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            }, error: function (xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        })
    }

    // 관심상품 삭제
    function remove(wish, callback, error) {
        console.log("delete wish....")

        let csrfHeaderName ="${_csrf.headerName}";
        let csrfTokenValue="${_csrf.token}";

        $.ajax({
            type: "POST",
            url: "/wishList/remove",
            beforeSend: function (xhr){
                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            },
            data: JSON.stringify(wish),
            contentType: "application/json; charset=utf-8",
            success: function (result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            }, error: function (xhr, status, er) {
                if (error) {
                    error(er);
                }
            }
        })
    }

    return {
        add: add,
        remove: remove
    };
})();