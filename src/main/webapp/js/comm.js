$(document).ready(function() {

    $.fn.randomize = function (selector) {
        var $elems = selector ? $(this).find(selector) : $(this).children(),
            $parents = $elems.parent();
        $parents.each(function () {
            $(this).children(selector).sort(function () {
                return Math.round(Math.random()) - 0.5;
            }).detach().appendTo(this);
        });
        return this;
    };
    /*
    $('.comm_bnr_list').owlCarousel({
        loop:true,
        items: 1,
        dots: true,
        nav: false,
        onInitialize: function () {
            $('.comm_bnr_list').randomize();
        }
    }); */

    $('.comm_my_list').owlCarousel({
        margin:0,
        loop:true,
        items: 1,
        dots: false,
        nav: true,
        navText: ['<i class="ti-angle-left"></i><span class="sr-only">이전</span>', '<i class="ti-angle-right"></i><span class="sr-only">다음</span>']
    });



    var commSlider = $('.comm_bnr_list');
        commSlider.each(function() {
            if ($(this).find('.item').length > 0) {
                $(this).after('<div class="counter"></div>');
                var count = $(this).next('.counter');

                $(this).on("initialized.owl.carousel changed.owl.carousel", function(e) {
                    if (!e.namespace) {
                        return;
                    }
                    var cNum = e.relatedTarget.relative(e.item.index) + 1;
                    var tNum = e.item.count;
                    if (tNum > 1) {
                        count.html('<span class="num">' + cNum + '</span> / ' + tNum);
                    }
                }).owlCarousel({
                    loop: true,
                    dots: false,
                    touchDrag: true,
                    autoHeight:true,
                    items:1,
                    autoplay: true,
                    autoplayTimeout:3000,
                    smartSpeed:500,
                    autoplayHoverPause:true,
                    navText: ['<i class="ti-angle-left"></i><span class="sr-only">이전</span>', '<i class="ti-angle-right"></i><span class="sr-only">다음</span>'],
                    margin:0,
                    items:1,
                    nav:true,
                    onInitialize: function () {
                        $('.comm_bnr_list').randomize();
                    }

                });
            } else {
                return false;
            }
        });

    /*
    $('.comm_bnr_list').owlCarousel({
            loop:true,
            items: 1,
            dots: true,
            nav: false,
            onInitialize: function () {
                $('.comm_bnr_list').randomize();
            }
        });
        $('.comm_card_list .frame, .comm_my_list .panel').matchHeight();


        */

});