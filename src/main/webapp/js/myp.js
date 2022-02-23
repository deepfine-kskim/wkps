

$(document).ready(function() {
    var mypSlider = $('.myp_slider_box').find('.list_slider');
    mypSlider.each(function () {
        if ($(this).find('.item').length > 0) {
            $(this).after('<div class="counter"></div>');
            var count = $(this).next('.counter');

            $(this).on("initialized.owl.carousel changed.owl.carousel", function (e) {
                if (!e.namespace) {
                    return;
                }
                var cNum = e.relatedTarget.relative(e.item.index) + 1;
                var tNum = e.item.count;
                if (tNum > 1) {
                    count.html('<span class="num">' + cNum + '</span> / ' + tNum);
                }
            }).owlCarousel({
                dots: false,
                touchDrag: true,
                autoHeight: true,
                items: 1,
                // autoplay: true,
                // autoplayTimeout:2000,
                // smartSpeed:500,
                // autoplayHoverPause:true,
                navText: ['<i class="ti-angle-left"></i><span class="sr-only">이전</span>', '<i class="ti-angle-right"></i><span class="sr-only">다음</span>'],
                margin: 0,
                nav: true

            });
        } else {
            return false;
        }
    });
    $('.mypage_grid .frame_line').matchHeight();
    $('.myskin_list .thumbnail input[type="radio"]').on('change', function() {
        if ($(this).is(':checked')) {
            $('.myskin_list .thumbnail').removeClass('active');
            $(this).parents('.thumbnail').addClass('active');
        }
    });

});