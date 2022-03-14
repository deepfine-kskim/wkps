$.fn.checkAll = function (options) {
    var options = $.extend({
        scope: 'form',
        onMasterClick: null,
        onScopeChange: null
    }, options);
    return this.each(function () {
        var $master_checkbox = $(this), $scope = options.scope instanceof jQuery ? options.scope : $master_checkbox.closest(options.scope);
        $master_checkbox.on('click', function (e) {
            if ($master_checkbox.is(':checked'))
                $scope.find('input[type="checkbox"]').not($master_checkbox).prop('checked', true).trigger('change');
            else
                $scope.find('input[type="checkbox"]').not($master_checkbox).prop('checked', false).trigger('change');
            if (typeof options.onMasterClick === 'function')
                options.onMasterClick($master_checkbox, $scope);
        });
        $scope.on('change', 'input[type="checkbox"]', function (e) {
            var $changed_checkbox = $(this);
            if ($changed_checkbox.is($master_checkbox))
                return;
            if (typeof options.onScopeChange === 'function')
                options.onScopeChange($master_checkbox, $changed_checkbox, $scope);
            if (!$changed_checkbox.is(':checked')) {
                $master_checkbox.prop('checked', false);
                return;
            }
            if ($scope.find('input[type="checkbox"]').not($master_checkbox).not(':checked').length === 0)
                $master_checkbox.prop('checked', true);

        });
    });
};
var customUi = {
    gnb: function() {
        var gnbLi = $('#header .navbar-nav > li');
        var onTxt = 'active';
        gnbLi.on('mouseenter focusin', function() {
            $(this).find('.dropdown-menu').stop(true,false).slideDown(600, 'easeOutExpo');
            $(this).addClass(onTxt);
        });
        gnbLi.on('mouseleave focusout', function() {
            $(this).find('.dropdown-menu').stop(true,false).slideUp('fast');
            $(this).removeClass(onTxt);
            gnbLi.removeClass(onTxt);
        });
    },
    topBtn: function() {
        var topBtn = $('#scrollTopBtn');
        $(window).scroll(function() {
            if($(this).scrollTop() != 0) {
                topBtn.fadeIn(100);
            } else {
                topBtn.fadeOut(100);
            }
        });
        topBtn.click(function() {
            $('body,html').animate({
                scrollTop:0
            },400);
            return false;
        });
    },
    treeList: function () {
        $('.tree_list').each(function() {
            var tree = $(this);
            /*$('li', tree).each(function() {
                var subList = $(this).children('.sub_list').length;
                if (subList) {
                    $(this).prepend('<a href="#" class="ico"><span class="sr-only">버튼</span></a>');
                }
            });*/
            tree.metisMenu({
                triggerElement: 'a',
                toggle: false
            });
            tree.find('.sub_list').css('display', '');
        });

    },
    mGnb: function () {
        $('#wrap').append('<div id="pageBg" class="hidden-lg hidden-md"></div>');
        var bodyObj = $('body');
        var mBtn = $('#mMenuBtn');
        var mSide = $('#mSidebar');
        var bg = $('#pageBg');
        var xBtn = mSide.find('.btn_close');
        mSide.removeClass('open');
        function sideOpen() {
            mSide.animate({left: '0'}, 50).addClass('open');
            bg.show();
            bodyObj.addClass('fix');
        }
        function sideClose() {
            mSide.animate({left: '-230'}, 50).removeClass('open');
            bg.hide();
            bodyObj.removeClass('fix');
        }
        mBtn.on('click', function () {
            if (!mSide.hasClass('open')) {
                sideOpen();
            } else {
                sideClose();
            }
        });
        xBtn.on('click', function () {
            sideClose();
        });
        bg.on('click', function () {
            sideClose();
        });
        $('.m_side_menu > a').each(function() {
            var myLi = $(this).parent('li');
            var mySub = $(this).next('.sub_menu_list');
            if (myLi.hasClass('on')) {
                mySub.show();
            }
            $(this).on('click', function() {
                if (mySub.length > 0) {
                    if (!myLi.hasClass('on')) {
                        myLi.siblings('.m_side_menu').removeClass('on');
                        myLi.siblings('.m_side_menu').find('.sub_menu_list').slideUp(100);
                        myLi.addClass('on');
                        mySub.slideDown(100);
                    } else {
                        myLi.removeClass('on');
                        mySub.slideUp(100);
                    }
                    return false;
                } else {
                    return true;
                }
            });
        });
    },
    treeView: function() {
        $.fn.hummingbird.defaults.hoverColorText2 = false;
        $.fn.hummingbird.defaults.hoverColorBg2 = false;
        $.fn.hummingbird.defaults.collapsedSymbol = "ti-plus";
        $.fn.hummingbird.defaults.expandedSymbol = "ti-minus";
        var chkTreeArea = $('.chk_tree_area');
        chkTreeArea.mCustomScrollbar({
            theme: "dark"
        });
        if (chkTreeArea.length > 0) {
            chkTreeArea.each(function () {
                var myTree = $(this).find('.treeview');
                var allChk = $(this).find('.all_chk');
                myTree.hummingbird();
                allChk.on('change', function () {
                    if ($(this).is(':checked')) {
                        myTree.hummingbird('checkAll');
                    } else {
                        myTree.hummingbird('uncheckAll');
                    }
                });
            });
        } else {
            return false;
        }
    },
    grpEditView: function() {
        var grpEditRow = $('.grp_edit_row');
        if (grpEditRow.length > 0) {

            grpEditRow.find('.edit_area').mCustomScrollbar({
                theme: "dark"
            });
            var myTree = grpEditRow.find('.treeview');
            myTree.each(function() {
                myTree.hummingbird();
            });
        } else {
            return false;
        }

    },

    lightBox: function() {
        var zoomimg = $('.zoom_pop');
        if (zoomimg.length > 0) {
            $('.zoom_pop').magnificPopup({
                  type: 'image',
                  closeOnContentClick: true,
                  image: {
                      verticalFit: true
                  }
            });
        } else {
            return false;
        }
    },
    inpDateTime: function() {

        var inps = $('.datetime');
        var inpDate = inps.filter('.inp_date');
        var inpTime = inps.filter('.inp_time');
        if (inpDate.length > 0) {
            /*
            $.datetimepicker.setLocale('ko');
            $('.inp_date').datetimepicker({
	            format:'Y-m-d H:m',
            });
            */
            inpDate.datetimepicker({
                format: 'YYYY-MM-DD',
                locale:'ko',

                widgetPositioning:{
                    vertical: 'bottom'
                }
            });

            /*
            inpDate.datetimepicker().on('dp.change', function(e){
                if( !e.oldDate || !e.date.isSame(e.oldDate, 'day')){
                    $(this).data('DateTimePicker').hide();
                }
            }); */

        }
        if (inpTime.length > 0) {
            inpTime.datetimepicker({
                format: 'HH:mm',
                showClose: true
            });
            inpTime.datetimepicker().on('dp.change', function(e){
                $('.btn-primary[data-action="togglePeriod"]').click(function() {
                    console.log('test');
                });

            });
        }

    },
    showPopup: function() {
        var alertPopup = $('#popupShow');
        var closeBtn = alertPopup.find('.close_btn');
        var todayChk = alertPopup.find('.today_chk input[type="checkbox"]');
        if (alertPopup.length > 0) {
            $.support.transition = false;
            todayChk.removeAttr('checked');
            var midnight = new Date();
            midnight.setHours(23,59,59,0);
            closeBtn.click(function() {

                if (todayChk.is(':checked')) {
                    $.cookie('show-popup', 'close', {
                        expires:  midnight
                    });
                }
            });
            if (!$.cookie('show-popup')) {

                alertPopup.modal('show').css('padding-right', '0');
                $('.modal-backdrop').removeClass('in').hide();
                $('body').removeClass('modal-open').addClass('modal-show').css('padding-right', '0');
            }
        } else {
            return false;
        }


    },
    layerPopup: function() {
        var popup = $('.layer_popup');
        if (popup.length > 0) {
            popup.each(function() {
                var myPop = $(this);
                var closeBtn = myPop.find('.close_btn');
                var todayChk = myPop.find('.today_chk input[type="checkbox"]');
                var myNum = todayChk.attr('id').split('popupToday')[1];
                todayChk.removeAttr('checked');
                var midnight = new Date();
                midnight.setHours(23,59,59,0);
                closeBtn.click(function() {
                    if (todayChk.is(':checked')) {
                        $.cookie('main-popup' + myNum, 'close', {
                            expires: midnight
                        });
                    }
                });
                if (!$.cookie('main-popup' + myNum)) {
                    $('#popupMain' + myNum).modal('show').css('padding-right', '0');
                    $('.modal-backdrop').removeClass('in').hide();
                    $('body').removeClass('modal-open').addClass('popup_wrap_body').css('padding-right', '0'); // 수정
                }
            });
        } else {
            return false;
        }
    },
    modalEvt: function() {
        /*
        $('.date_modal').on('hidden.bs.modal', function () {
            $('.xdsoft_datetimepicker').hide();
        }); */
    },
    inpAct: function() {

        $('.inp_set_area').each(function() {
            var radios = $(this).find('input[type="radio"]');
            var btnTog = $(this).find('.inp_tog_cont');

            if ($(this).find('input[type="radio"]:checked').hasClass('inp_tog')) {
                btnTog.show();
            }

            radios.on('change', function() {
                if($(this).hasClass('inp_tog')){
                    btnTog.show();
                } else {
                    btnTog.hide();
                }
            });
        });
        $('.inp_keyword').tagsinput({
            maxTags: 10
        });
        $('.all_chks_frm').each(function() {
            var allChkInp = $(this).find('.all_chk');
            var myFrmBox = $(this);
            allChkInp.checkAll({
                scope: myFrmBox
            });
        });

        $('.form-group').on('click','.tag_btn .remove',function(){
            $(this).closest('.tag_btn').remove();
        });



        $('.pop_grp_inp').change(function() {
            if($(this).is(':checked')) {
                // $('#selectGrpPopup').modal('show');
            } else {}
        });

        $('.tooltip_btn[data-toggle="tooltip"]').tooltip({
            animated: 'fade',
            placement: 'bottom',
            trigger: 'click'
        });

        // $('.tog_on_btn').on('click', function() {
        //     $(this).toggleClass('on');
        // });
    },
    mSideTog: function() {
        var mSideTog = $('.mside_tog');
        if (mSideTog.length > 0) {
            mSideTog.each(function() {
                var togBtn = $(this).find('.side_top .m_btn');
                var togCont = $(this).find('.mside_tog_cont');
                togBtn.on('click', function() {
                    if (togCont.css('display') == 'none') {
                        togCont.slideDown();
                        $(this).addClass('open');
                        $(this).find("i").removeClass("fa-chevron-down").addClass("fa-chevron-up");
                    } else {
                        togCont.slideUp();
                        $(this).removeClass('open');
                        $(this).find("i").removeClass("fa-chevron-up").addClass("fa-chevron-down");
                    }

                });
            });
        }
    },
    fileFrmBtn: function() {
        if ($('.btn-file').length) {
            $(document).on('change', '.btn-file :file', function() {
                var input = $(this);
                var numFiles = input.get(0).files ? input.get(0).files.length : 1;
                var label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [numFiles, label]);
            });
            $(document).ready( function() {
                $('.btn-file').each(function() {
                    $(this).after('<div class="tag_grp_area"></div>');
                });
                $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
                    var input_label = $(this).closest('.form-group').find('.tag_grp_area');
                    var log = numFiles > 1 ? numFiles + ' files selected' : label;
                    if( input_label.length ) {
                        input_label.append('<span class="tag_btn label label-default">' + log + '<i class="remove">x</i><span class="sr-only">삭제</span></span>');
                    } else {
                        return false;
                    }
                });
            });
        } else {
            return false;
        }
    }
};

(function($) {
    customUi.gnb();
    customUi.mGnb();
    customUi.topBtn();
    customUi.treeList();
    customUi.treeView();
    customUi.grpEditView();
    customUi.lightBox();
    customUi.modalEvt();
    customUi.inpDateTime();
    customUi.layerPopup();
    customUi.showPopup();
    customUi.inpAct();
    customUi.mSideTog();
    customUi.fileFrmBtn();





    $('.widget_set').each(function() {
        var widgetBody = $(this).find('.panel-body');
        widgetBody.matchHeight();
    });


    $('.bootstrap-tagsinput input[type=text]').on('keydown', function (e) {
   if ( event.which == 13 ) {
           $(this).blur();
           $(this).focus();
           return false;
    }
});

})(jQuery);
