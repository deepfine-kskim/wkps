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

    $('.no-enter-submit').each(function (i, item) {
        $(item).off('keydown').on('keydown', function (e) {
            if (e.keyCode === 13) {
                e.preventDefault();
            }
        });
    });

    $('.flow-remove-attachment').off('click').on('click', function (e) {
        const atchFileNo = $(this).data('atch-file-no');
        const fileSn = $(this).data('file-sn');
        const removeNum = $(this).data('remove-num');

        if (confirm('해당 파일을 삭제하시겠습니까? 삭제 시 복구가 불가능합니다.')) {
            const data = {
                atchFileNo: atchFileNo,
                fileSn: fileSn
            };

            $.ajax({
                url: '/cmm/fms/deleteFileInfs.do',
                type: 'post',
                data: JSON.stringify(data),
                contentType: 'application/json',
                dataType: 'json',
                success: function (data) {
                    $('.flow-remove-group' + removeNum).remove();
                    alert('파일이 삭제되었습니다.');
                },
                error: function () {
                    alert('처리 중 오류가 발생했습니다.');
                }
            });
        }
    });
});