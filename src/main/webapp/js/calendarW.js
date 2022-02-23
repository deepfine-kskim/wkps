(function($) {


    $('.inp_set_area input[type="radio"]').on('change', function(){
        if($(this).hasClass('tog_radio')){
            $('#collapseOne').collapse('show');
        } else {
            $('#collapseOne').collapse('hide');
            $("#treeview").hummingbird("uncheckAll");
        }
    });
})(jQuery);
