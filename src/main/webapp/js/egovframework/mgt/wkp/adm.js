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
var admUi = {
    inpDateTime: function() {
        var inps = $('.datetime');
        var inpDate = inps.filter('.inp_date');
        var inpTime = inps.filter('.inp_time');
        if (inpDate.length > 0) {
            inpDate.datetimepicker({
                format: 'YYYY-MM-DD',
                locale:'ko',
                widgetPositioning:{
                    vertical: 'bottom'
                }
            });
        }
        if (inpTime.length > 0) {
            inpTime.datetimepicker({
                format: 'LT',
                showClose: true
            });
            inpTime.datetimepicker().on('dp.change', function(e){
                $('.btn-primary[data-action="togglePeriod"]').click(function() {
                    console.log('test');
                });

            });
        }

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
    inpAct: function() {
        $('#contents').on('click','.tag_btn .remove',function(){
            $(this).closest('.tag_btn').remove();
        });
        $('.inp_set_area').each(function() {
            var radios = $(this).find('input[type="radio"]');
            var btnTog = $(this).find('.inp_tog_cont');
            radios.on('change', function() {
                if($(this).hasClass('inp_tog')){
                    btnTog.show();
                } else {
                    btnTog.hide();
                }
            });
        });
        $('.all_chks_frm').each(function() {
            var allChkInp = $(this).find('.all_chk');
            var myFrmBox = $(this);
            allChkInp.checkAll({
                scope: myFrmBox
            });
        });
    }
};
(function($) {
    admUi.inpDateTime();
    admUi.treeView();
    admUi.inpAct();
})(jQuery);