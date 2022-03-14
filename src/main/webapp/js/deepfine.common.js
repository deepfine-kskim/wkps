$(document).ready(function () {
    /* enter 검색 설정 */
    $('.flow-enter-search').each(function (i, item) {
        const searchButton = $(item).data('search-button');

        $(item).off('keydown').on('keydown', function (e) {
            if (e.keyCode === 13) {
                if (!!searchButton) {
                    $('#' + searchButton).click();
                }
                e.preventDefault();
            }
        });
    });
});