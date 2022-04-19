$(document).ready(function() {
    var cardSlider = $('.card_item_list.owl-carousel');
    cardSlider.find('.card_item .caption_box').matchHeight();
    cardSlider.each(function() {
        if ($(this).find('.card_item').length > 0) {
            $(this).after('<div class="counter"></div>');
            var count = $(this).next('.counter');
            $(this).on("initialized.owl.carousel changed.owl.carousel", function(e) {
                if (!e.namespace) {
                    return;
                }
                var cNum = e.relatedTarget.relative(e.item.index) + 1;
                var tNum = e.item.count;
                var page = Math.round(e.item.count/2);
                if (page > 1 && tNum > 3) {
                    page = e.item.count - 2;
                    count.html('<span class="num">' + cNum + '</span> / ' + page);
                }
            }).owlCarousel({
                dots: false,
                touchDrag: true,
                // autoplay: true,
                // autoplayTimeout:2000,
                // smartSpeed:500,
                // autoplayHoverPause:true,
                navText: ['<i class="ti-angle-left"></i><span class="sr-only">이전</span>', '<i class="ti-angle-right"></i><span class="sr-only">다음</span>'],
                margin:10,
                nav:true,
                responsive:{
                    0: {
                        items:1,
                        margin:0
                    },
                    500: {
                        items:2,
                        margin:0
                    },
                    768: {
                        items:3,
                        margin:0
                    },
                    992: {
                        items:4,
                        margin:0
                    },
                    1181:{
                        items:3
                    }
                }

            });
        } else {
            return false;
        }
    });
    
    $('.main_tabs_area a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        $('.card_item_list').trigger('refresh.owl.carousel');
        cardSlider.find('.card_item .caption_box').matchHeight();
    });
    
	$('.preview').click(function(){
	    var convertType = "0";	// HTML로 변환
	    var fileType = "URL";	// URL로 문서 다운로드 후 변환
	    var fid = $(this).data('fid');
	    var filePath = $(this).data('url'); // 첨부파일 URL

	    var encodedUrl = encodeURIComponent(filePath);
	    var requestUrl = "http://105.0.111.171:8080/SynapDocViewServer/job?fid=" + fid + "&filePath=" + encodedUrl + "&convertType=" + convertType + "&fileType=" + fileType;
	     
	    window.open(requestUrl, "preview");
	 });
});