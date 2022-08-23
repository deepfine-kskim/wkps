function panelPlus() {
    $('#itemSetPlus').on('click', function () {
    	var panelTag = '';
        var num = $('.item_panel').length + 1;
        //console.log('num - ' + num);
        panelTag += '<div id="item' + num + '-panel" class="panel panel-default item_panel">';
        panelTag += '<div class="panel-heading">';
        panelTag += '<strong class="panel-title"><span class="order-id" style="float: left;">' + num + '</span>. 설문항목</strong><button type="button" class="btn btn-danger btn-sm del_panel_btn" style="float: right; margin-left:5px;">항목삭제</button><button type="button" class="btn btn-primary btn-sm add_panel_btn" style="float: right; padding: -10px;">설문항목 중간 추가</button>';
        //panelTag += '<strong class="panel-title"><span class="order-id">' + num + '</span>. 설문항목</strong><button type="button" class="btn btn-danger btn-sm del_panel_btn">항목삭제</button>';
        panelTag += '</div>';
        panelTag += '<div class="panel-body">';
        panelTag += '<div class="form-horizontal">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-type" class="col-sm-2 control-label sel_type_lable">항목형식</label>';
        panelTag += '<div class="col-sm-4">';
        panelTag += '<select id="item' + num + '-type" name="item' + num + '-type" class="form-control sel_tab">';
        panelTag += '<option value="0">선택해주세요.</option>';
        panelTag += '<option value="1">서술형</option>';
        panelTag += '<option value="2">단일선택형</option>';
        panelTag += '<option value="3">복수선택형</option>';
        panelTag += '<option value="4">건너뛰기 형</option>';
        panelTag += '</select>';
        panelTag += '</div>';
        panelTag += '<div class="col-sm-6">';
        panelTag += '<label for="item' + num + '-req" class="checkbox-inline">';
        panelTag += '<input type="checkbox" id="item' + num + '-req" name="item' + num + '-req" class="dev-must-check"/> 필수';
        panelTag += '</label>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="tab-content item_tab1">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-tit1" class="col-sm-2 control-label">질문</label>';
        panelTag += '<div class="col-sm-10">';
        panelTag += '<input type="text" id="item' + num + '-tit1" name="item' + num + '-tit1" class="form-control dev-example-input" placeholder="질문을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="tab-content item_tab2">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-tit2" class="col-sm-2 control-label">질문</label>';
        panelTag += '<div class="col-sm-10">';
        panelTag += '<input type="text" id="item' + num + '-tit2" name="item' + num + '-tit2" class="form-control" placeholder="단일선택 질문을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="inp_list ra_grp">';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-ra1" class="col-sm-2 control-label"><span class="num">1</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-ra1" name="item' + num + '-ra1" class="form-control dev-example-input" placeholder="단일선택 내용을 입력하세요" />';
        panelTag += '</div>';
        panelTag += ' <div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-ra2" class="col-sm-2 col-lg-2 control-label"><span class="num">2</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-ra2" name="item' + num + '-ra2" class="form-control dev-example-input" placeholder="단일선택 내용을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button> ';
        panelTag += '<button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">항목삭제</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="etc_area">'
        panelTag += '<div class="form-group dev-group">'
        panelTag += '<label for="item' + num + '-ra-etc" class="col-sm-2 control-label"><span class="num">기타</span>)</label>'
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">'
        panelTag += '<input type="text" id="item' + num + '-ra-etc" name="item' + num + '-ra-etc" class="form-control dev-example-input" placeholder="단일선택 기타항목 사용" readonly="readonly" />'
        panelTag += '</div>'
        panelTag += '</div>'
        panelTag += '</div>'
        panelTag += '<div class="text-right">';
        panelTag += '<button type="button" class="btn btn-black add_etc_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 기타 항목 추가</button> ';
        panelTag += '<button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 단일선택 항목 추가</button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="tab-content item_tab3">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-tit3" class="col-sm-2 control-label">질문</label>';
        panelTag += '<div class="col-sm-10">';
        panelTag += '<input type="text" id="item' + num + '-tit3" name="item' + num + '-tit3" class="form-control" placeholder="복수선택 질문을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="inp_list chk_grp">';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-chk1" class="col-sm-2 control-label"><span class="num">1</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-chk1" name="item' + num + '-chk1" class="form-control dev-example-input" placeholder="복수선택 내용을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">첨부</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-chk2" class="col-sm-2 col-lg-2 control-label"><span class="num">2</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-chk2" name="item' + num + '-chk2" class="form-control dev-example-input" placeholder="복수선택 내용을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">첨부</span></button> ';
        panelTag += '<button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">삭제</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '</div>';

        // panelTag +=                '<div class="etc_area">'
        // panelTag +=                    '<div class="form-group">'
        // panelTag +=                         '<label for="item'+ num +'-chk-etc" class="col-sm-2 control-label">기타)</label>'
        // panelTag +=                         '<div class="col-sm-8 col-md-7 col-lg-8">'
        // panelTag +=                            '<input type="text" id="item'+ num +'-chk-etc" name="item'+ num +'-chk-etc" class="form-control" placeholder="복수선택 기타항목 사용" readonly="readonly" />'
        // panelTag +=                        '</div>'
        // panelTag +=                    '</div>'
        // panelTag +=                '</div>'

        panelTag += '<div class="text-right">';
        // panelTag +=                    '<button type="button" class="btn btn-black add_etc_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 기타 항목 추가</button> ';
        panelTag += '<button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 복수선택 항목 추가</button>';
        panelTag += '</div>';
        panelTag += '</div>';


        panelTag += '<div class="tab-content item_tab4 skip_type_box">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-tit4" class="col-sm-2 control-label">질문</label>';
        panelTag += '<div class="col-sm-10">';
        panelTag += '<input type="text" id="item' + num + '-tit4" name="item' + num + '-tit4" class="form-control" placeholder="건너뛰기 형 질문을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="inp_list skip_grp">';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-skip1" class="col-sm-2 control-label"><span class="num">1</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-skip1" name="item' + num + '-skip1" class="form-control dev-example-input" placeholder="건너뛰기 형 단일선택 내용을 입력하세요" />';
        panelTag += '<div class="form-inline skip_num_inp">';
        // panelTag += '<label for="item' + num + '-skip1-num1" class="text-primary control-label"> 선택시 <input type="text" id="item' + num + '-skip1-num1" name="item' + num + '-skip1-num1" class="form-control dev-example-skip" readonly="readonly" maxlength="2" />';
        panelTag += '<label for="item' + num + '-skip1-num1" class="text-primary control-label"> 선택시';
        panelTag += '   <select id="item' + num + '-skip1-num1" name="item' + num + '-skip1-num1" class="_flow-select-skip dev-example-skip">';
        panelTag += '   <option value="0" selected>건너뛸 항목을 선택해주세요</option>';
        $('.item_panel').each(function (i, item) {
            // 첫 번째 항목으로 건너뛰기는 방지, 나 자신에게 건너뛰기 못하게
            if(i > 0 && (i+1) != num){
                panelTag += '<option value="'+ (i + 1) +'">'+(i + 1)+' 번 항목으로 건너뛰기</option>';
            }
        });
        panelTag += '</label>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += ' <div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '</div>';

        // panelTag +=                '<div class="etc_area">'
        // panelTag +=                    '<div class="form-group">'
        // panelTag +=                         '<label for="item'+ num +'-chk-etc" class="col-sm-2 control-label">기타)</label>'
        // panelTag +=                         '<div class="col-sm-8 col-md-7 col-lg-8">'
        // panelTag +=                            '<input type="text" id="item'+ num +'-chk-etc" name="item'+ num +'-chk-etc" class="form-control" placeholder="복수선택 기타항목 사용" readonly="readonly" />'
        // panelTag +=                        '</div>'
        // panelTag +=                    '</div>'
        // panelTag +=                '</div>'

        panelTag += '<div class="text-right">';
        // panelTag +=                    '<button type="button" class="btn btn-black add_etc_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 기타 항목 추가</button> ';
        panelTag += '<button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 복수선택 항목 추가</button>';
        panelTag += '</div>';
        panelTag += '</div>';


        panelTag += '</div>';
        panelTag += '</div>';
        $('.item_panel_area').append(panelTag);
        allNumReset();
    });
}

function panelPlusBefore() {
	$('.item_panel_area').on('click', '.add_panel_btn', function () {
		var panelTag = '';
		var numB = $(this).closest('.item_panel').attr('id').substring(4,5);
        var num = $('.item_panel').length + 1;

        //console.log('numB - ' + numB);
        panelTag += '<div id="item' + num + '-panel" class="panel panel-default item_panel">';
        panelTag += '<div class="panel-heading">';
        panelTag += '<strong class="panel-title"><span class="order-id" style="float: left;">' + num + '</span>. 설문항목</strong><button type="button" class="btn btn-danger btn-sm del_panel_btn" style="float: right; margin-left:5px;">항목삭제</button><button type="button" class="btn btn-primary btn-sm add_panel_btn" style="float: right; padding: -10px;">설문항목 중간 추가</button>';
        //panelTag += '<strong class="panel-title"><span class="order-id">' + num + '</span>. 설문항목</strong><button type="button" class="btn btn-danger btn-sm del_panel_btn">항목삭제</button>';
        panelTag += '</div>';
        panelTag += '<div class="panel-body">';
        panelTag += '<div class="form-horizontal">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-type" class="col-sm-2 control-label sel_type_lable">항목형식</label>';
        panelTag += '<div class="col-sm-4">';
        //console.log('numnum - ' + numB);
        panelTag += '<select id="item' + num + '-type" name="item' + num + '-type" class="form-control sel_tab">';
        //console.log('numnumnumnumnum - ' + numB);
        panelTag += '<option value="0">선택해주세요.</option>';
        panelTag += '<option value="1">서술형</option>';
        panelTag += '<option value="2">단일선택형</option>';
        panelTag += '<option value="3">복수선택형</option>';
        panelTag += '<option value="4">건너뛰기 형</option>';
        panelTag += '</select>';
        panelTag += '</div>';
        panelTag += '<div class="col-sm-6">';
        panelTag += '<label for="item' + num + '-req" class="checkbox-inline">';
        panelTag += '<input type="checkbox" id="item' + num + '-req" name="item' + num + '-req" class="dev-must-check"/> 필수';
        panelTag += '</label>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="tab-content item_tab1">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-tit1" class="col-sm-2 control-label">질문</label>';
        panelTag += '<div class="col-sm-10">';
        panelTag += '<input type="text" id="item' + num + '-tit1" name="item' + num + '-tit1" class="form-control dev-example-input" placeholder="질문을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="tab-content item_tab2">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-tit2" class="col-sm-2 control-label">질문</label>';
        panelTag += '<div class="col-sm-10">';
        panelTag += '<input type="text" id="item' + num + '-tit2" name="item' + num + '-tit2" class="form-control" placeholder="단일선택 질문을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="inp_list ra_grp">';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-ra1" class="col-sm-2 control-label"><span class="num">1</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-ra1" name="item' + num + '-ra1" class="form-control dev-example-input" placeholder="단일선택 내용을 입력하세요" />';
        panelTag += '</div>';
        panelTag += ' <div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-ra2" class="col-sm-2 col-lg-2 control-label"><span class="num">2</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-ra2" name="item' + num + '-ra2" class="form-control dev-example-input" placeholder="단일선택 내용을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button> ';
        panelTag += '<button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">항목삭제</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="etc_area">'
        panelTag += '<div class="form-group dev-group">'
        panelTag += '<label for="item' + num + '-ra-etc" class="col-sm-2 control-label"><span class="num">기타</span>)</label>'
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">'
        panelTag += '<input type="text" id="item' + num + '-ra-etc" name="item' + num + '-ra-etc" class="form-control dev-example-input" placeholder="단일선택 기타항목 사용" readonly="readonly" />'
        panelTag += '</div>'
        panelTag += '</div>'
        panelTag += '</div>'
        panelTag += '<div class="text-right">';
        panelTag += '<button type="button" class="btn btn-black add_etc_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 기타 항목 추가</button> ';
        panelTag += '<button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 단일선택 항목 추가</button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="tab-content item_tab3">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-tit3" class="col-sm-2 control-label">질문</label>';
        panelTag += '<div class="col-sm-10">';
        panelTag += '<input type="text" id="item' + num + '-tit3" name="item' + num + '-tit3" class="form-control" placeholder="복수선택 질문을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="inp_list chk_grp">';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-chk1" class="col-sm-2 control-label"><span class="num">1</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-chk1" name="item' + num + '-chk1" class="form-control dev-example-input" placeholder="복수선택 내용을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">첨부</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-chk2" class="col-sm-2 col-lg-2 control-label"><span class="num">2</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-chk2" name="item' + num + '-chk2" class="form-control dev-example-input" placeholder="복수선택 내용을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">첨부</span></button> ';
        panelTag += '<button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">삭제</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '</div>';

        // panelTag +=                '<div class="etc_area">'
        // panelTag +=                    '<div class="form-group">'
        // panelTag +=                         '<label for="item'+ num +'-chk-etc" class="col-sm-2 control-label">기타)</label>'
        // panelTag +=                         '<div class="col-sm-8 col-md-7 col-lg-8">'
        // panelTag +=                            '<input type="text" id="item'+ num +'-chk-etc" name="item'+ num +'-chk-etc" class="form-control" placeholder="복수선택 기타항목 사용" readonly="readonly" />'
        // panelTag +=                        '</div>'
        // panelTag +=                    '</div>'
        // panelTag +=                '</div>'

        panelTag += '<div class="text-right">';
        // panelTag +=                    '<button type="button" class="btn btn-black add_etc_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 기타 항목 추가</button> ';
        panelTag += '<button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 복수선택 항목 추가</button>';
        panelTag += '</div>';
        panelTag += '</div>';


        panelTag += '<div class="tab-content item_tab4 skip_type_box">';
        panelTag += '<div class="form-group">';
        panelTag += '<label for="item' + num + '-tit4" class="col-sm-2 control-label">질문</label>';
        panelTag += '<div class="col-sm-10">';
        panelTag += '<input type="text" id="item' + num + '-tit4" name="item' + num + '-tit4" class="form-control" placeholder="건너뛰기 형 질문을 입력하세요" />';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '<div class="inp_list skip_grp">';
        panelTag += '<div class="form-group dev-group">';
        panelTag += '<label for="item' + num + '-skip1" class="col-sm-2 control-label"><span class="num">1</span>)</label>';
        panelTag += '<div class="col-sm-8 col-md-7 col-lg-8">';
        panelTag += '<input type="text" id="item' + num + '-skip1" name="item' + num + '-skip1" class="form-control dev-example-input" placeholder="건너뛰기 형 단일선택 내용을 입력하세요" />';
        panelTag += '<div class="form-inline skip_num_inp">';
        // panelTag += '<label for="item' + num + '-skip1-num1" class="text-primary control-label"> 선택시 <input type="text" id="item' + num + '-skip1-num1" name="item' + num + '-skip1-num1" class="form-control dev-example-skip" readonly="readonly" maxlength="2" />';
        panelTag += '<label for="item' + num + '-skip1-num1" class="text-primary control-label"> 선택시';
        panelTag += '   <select id="item' + num + '-skip1-num1" name="item' + num + '-skip1-num1" class="_flow-select-skip dev-example-skip">';
        panelTag += '   <option value="0" selected>건너뛸 항목을 선택해주세요</option>';
        $('.item_panel').each(function (i, item) {
            // 첫 번째 항목으로 건너뛰기는 방지, 나 자신에게 건너뛰기 못하게
            if(i > 0 && (i+1) != num){
                panelTag += '<option value="'+ (i + 1) +'">'+(i + 1)+' 번 항목으로 건너뛰기</option>';
            }
        });
        panelTag += '</label>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += ' <div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
        panelTag += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button>';
        panelTag += '</div>';
        panelTag += '</div>';
        panelTag += '</div>';

        // panelTag +=                '<div class="etc_area">'
        // panelTag +=                    '<div class="form-group">'
        // panelTag +=                         '<label for="item'+ num +'-chk-etc" class="col-sm-2 control-label">기타)</label>'
        // panelTag +=                         '<div class="col-sm-8 col-md-7 col-lg-8">'
        // panelTag +=                            '<input type="text" id="item'+ num +'-chk-etc" name="item'+ num +'-chk-etc" class="form-control" placeholder="복수선택 기타항목 사용" readonly="readonly" />'
        // panelTag +=                        '</div>'
        // panelTag +=                    '</div>'
        // panelTag +=                '</div>'

        panelTag += '<div class="text-right">';
        // panelTag +=                    '<button type="button" class="btn btn-black add_etc_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 기타 항목 추가</button> ';
        panelTag += '<button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 복수선택 항목 추가</button>';
        panelTag += '</div>';
        panelTag += '</div>';


        panelTag += '</div>';
        panelTag += '</div>';
        $('#item' + numB + '-panel').before(panelTag);

        $('.item_panel_area .panel').each(function (i) {
            var newNum = i + 1;
            $(this).find(".dev-example-skip").each(function () {
                let beforeVal = $(this).val();
                $(this).html('');
                let selectOption = '';
                if(beforeVal == 0 || beforeVal == '' || beforeVal == null){
                    selectOption += '<option value="0" selected>건너뛸 항목을 선택해주세요</option>';
                } else{
                    selectOption += '<option value="0">건너뛸 항목을 선택해주세요</option>';
                }
                $('.item_panel').each(function (i, item) {
                    // 첫 번째 항목으로 건너뛰기는 방지, 나 자신에게 건너뛰기 못하게
                    if(i > 0 && (i+1) != newNum){
                        // 삭제된 이후의 리셋인지
                        if(numB <= beforeVal){
                            if(beforeVal == i){
                                selectOption += '<option value="'+ (i + 1) +'" selected>'+(i + 1)+' 번 항목으로 건너뛰기</option>';
                            }else{
                                selectOption += '<option value="'+ (i + 1) +'">'+(i + 1)+' 번 항목으로 건너뛰기</option>';
                            }
                        } else{
                            selectOption += '<option value="'+ (i + 1) +'" '+(beforeVal == i+1 ? "selected" : "")+'>'+(i + 1)+' 번 항목으로 건너뛰기</option>';
                        }
                    }
                });
                $(this).html(selectOption);
            });
        });

        allNumReset();
    });
}

function panelDel() {
    $('.item_panel_area').on('click', '.del_panel_btn', function () {
        var myPanel = $(this).closest('.panel');
        var myOrderId = myPanel.find('.order-id').text();

        //console.log(myPanel);
        $(".dev-example-skip").each(function () {

            if ($(this).val() == myOrderId) {
                $(this).val(0);
            }
        });

        $('.' + myPanel.attr('id') + '-connect').remove();
        myPanel.remove();
        allNumReset(myOrderId);
    });
}

function allNumReset(delId) {
    $('.item_panel_area .panel').each(function (i) {
        var newNum = i + 1;
        var myNum = $(this).attr('id').replace(/[^0-9]/g, '');
        var beStr = 'item' + myNum;
        var afStr = 'item' + newNum;
        $(this).attr('id', $(this).attr('id').replace(beStr, afStr));
        $(this).find('.panel-title > span').text(newNum);
        $(this).find(".dev-example-skip").each(function () {
            let beforeVal = $(this).val();
            $(this).html('');
            let selectOption = '';
            if(beforeVal == 0 || beforeVal == '' || beforeVal == null){
                selectOption += '<option value="0" selected>건너뛸 항목을 선택해주세요</option>';
            } else{
                selectOption += '<option value="0">건너뛸 항목을 선택해주세요</option>';
            }
            $('.item_panel').each(function (i, item) {
                // 첫 번째 항목으로 건너뛰기는 방지, 나 자신에게 건너뛰기 못하게
                if(i > 0 && (i+1) != newNum){
                    // 삭제된 이후의 리셋인지
                    if(delId && delId < beforeVal){
                        selectOption += '<option value="'+ (i + 1) +'" '+(beforeVal-1 == i+1 ? "selected" : "")+'>'+(i + 1)+' 번 항목으로 건너뛰기</option>';
                    } else{
                        selectOption += '<option value="'+ (i + 1) +'" '+(beforeVal == i+1 ? "selected" : "")+'>'+(i + 1)+' 번 항목으로 건너뛰기</option>';
                    }
                }
            });
            $(this).html(selectOption);

            // if ($(this).val() == myNum) {
            //     $(this).val(newNum);
            //     return false;
            // }
        });

        var inps = $(this).find('input[id^="item' + myNum + '"]');
        var labels = $(this).find('label[for^="item' + myNum + '"]');
        var txts = $(this).find('textarea[id^="item' + myNum + '"]');
        var selects = $(this).find('select[id^="item' + myNum + '"]');
        inps.each(function () {
            $(this).attr({
                'id': $(this).attr('id').replace(beStr, afStr),
                'name': $(this).attr('name').replace(beStr, afStr)
            });
        });
        labels.each(function () {
            $(this).attr({
                'for': $(this).attr('for').replace(beStr, afStr)
            });
        });
        txts.each(function () {
            $(this).attr({
                'id': $(this).attr('id').replace(beStr, afStr)
            });
        });
        selects.each(function () {
            $(this).attr({
                'id': $(this).attr('id').replace(beStr, afStr)
            });
        });
    });
}

function optPlus() {
    $('.item_panel_area').on('click', '.add_inp_btn', function () {
        var myTab = $(this).closest('.tab-content');
        var inpList = myTab.find('.inp_list');
        var lastNum = inpList.find('> .form-group:last-child .num').text();
        var num = inpList.find('> .form-group:last-child .form-control').attr('id').substring(4, 5);
        lastNum++;
        var inpTags = '';
        if (inpList.hasClass('ra_grp')) {
            inpTags += '<div class="form-group dev-group">';
            inpTags += '<label for="item' + num + '-ra' + lastNum + '" class="col-sm-2 col-lg-2 control-label"><span class="num">' + lastNum + '</span>)</label>';
            inpTags += '<div class="col-sm-8 col-md-7 col-lg-8">';
            inpTags += '<input type="text" id="item' + num + '-ra' + lastNum + '" name="item' + num + '-ra' + lastNum + '" class="form-control dev-example-input" placeholder="단일선택 내용을 입력하세요" />';
            inpTags += '</div>';
            inpTags += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
            inpTags += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button> ';
            inpTags += '<button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">항목삭제</span></button>';
            inpTags += '</div>';
            inpTags += '</div>';
        } else if (inpList.hasClass('skip_grp')) {
            var panels = $(".panel-default:visible");
            var myNum = Number($(this).closest(".panel-default").find(".order-id").text());
            var skipNumList = inpList.find(".dev-example-skip");

            var checked = false;

            panels.each(function () {
                var _this = $(this);
                var thisNum = Number(_this.find(".order-id").html());
                if (myNum < thisNum) {
                    if (skipNumList.length > 0) {
                        if (_this.find(".dev-must-check").is(":checked")) {
                            var count = 0;
                            skipNumList.each(function () {
                                if (thisNum == Number($(this).val())) {
                                    count++;
                                }
                            });

                            if (count < 1) {
                                checked = true;
                            }
                        }
                    }
                }
            });

            /*if (checked) {
                alert("해당 질문보다 높은 순서의 설문항목의 필수값이 있어서 추가할 수 없습니다.");
            } else {*/
                var afterNum = $(".panel-default:visible").length + 1;

                inpTags += '<div class="form-group dev-group">';
                inpTags += '<label for="item' + num + '-skip' + lastNum + '" class="col-sm-2 col-lg-2 control-label"><span class="num">' + lastNum + '</span>)</label>';
                inpTags += '<div class="col-sm-8 col-md-7 col-lg-8">';
                inpTags += '<input type="text" id="item' + num + '-skip' + lastNum + '" name="item' + num + '-skip' + lastNum + '" class="form-control dev-example-input" placeholder="건너뛰기 형 단일선택 내용을 입력하세요" />';
                inpTags += '<div class="form-inline skip_num_inp">';
                inpTags += '<label for="item' + num + '-skip' + lastNum + '-num' + lastNum + '" class="text-primary control-label">선택시 ';
                // inpTags += '<input type="text" id="item' + num + '-skip1-num1" name="item' + num + '-skip1-num1" class="form-control dev-example-skip" readonly="readonly" maxlength="2" value="' + afterNum + '" />'
                inpTags += '<select id="item' + num + '-skip1-num1" name="item' + num + '-skip1-num1" class="_flow-select-skip dev-example-skip">';
                inpTags += '<option value="0" selected>건너뛸 항목을 선택해주세요</option>';
            $('.item_panel').each(function (i, item) {
                // 첫 번째 항목으로 건너뛰기는 방지, 나 자신에게 건너뛰기 못하게
                if(i > 0 && (i+1) != num){
                    inpTags += '<option value="'+ (i + 1) +'">'+(i + 1)+' 번 항목으로 건너뛰기</option>';
                }
            });
                inpTags += '</select>';
                inpTags += '</label>';
                inpTags += '</div>';
                inpTags += '</div>';
                inpTags += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
                inpTags += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button> ';
                inpTags += '<button type="button" class="btn btn-black ico_btn inp_del dev-skip-del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">항목삭제</span></button>';
                inpTags += '</div>';
                inpTags += '</div>';

                // $('#itemSetPlus').trigger('click');
                // var myPanel = $(this).closest('.panel');
                // var connectPanel = $(document).find(".panel:visible").last();
                // var connectClass = myPanel.attr('id') + '-connect';
                // connectPanel.addClass(connectClass);
                // connectPanel.find('.del_panel_btn').remove();
            //}
        } else {
            inpTags += '<div class="form-group dev-group">';
            inpTags += '<label for="item' + num + '-chk' + lastNum + '" class="col-sm-2 col-lg-2 control-label"><span class="num">' + lastNum + '</span>)</label>';
            inpTags += '<div class="col-sm-8 col-md-7 col-lg-8">';
            inpTags += '<input type="text" id="item' + num + '-chk' + lastNum + '" name="item' + num + '-chk' + lastNum + '" class="form-control dev-example-input" placeholder="복수선택 내용을 입력하세요" />';
            inpTags += '</div>';
            inpTags += '<div class="col-sm-2 col-md-3 col-lg-2 btn_area">';
            inpTags += '<button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button> ';
            inpTags += '<button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">항목삭제</span></button>';
            inpTags += '</div>';
            inpTags += '</div>';
        }
        inpList.append(inpTags);
    });
}

function optEtcPlus() {
    $('.item_panel_area').on('click', '.add_etc_btn', function () {
        var myTab = $(this).closest('.tab-content');
        var myEtc = myTab.find('.etc_area');
        if (myEtc.css('display') == 'none') {
            $(this).html('<i class="fa fa-close" aria-hidden="true"></i> 기타 항목 삭제');
            myEtc.show();
        } else {
            myEtc.hide();
            $(this).html('<i class="fa fa-plus-square" aria-hidden="true"></i> 기타 항목 추가');
        }
    });
}

function optDel() {
    $(document).on('click', '.inp_del', function () {
        var _this = $(this);
        var myTab = _this.closest('.tab-content');
        var inpList = myTab.find('.inp_list');
        var num = inpList.find('> .form-group:last-child .form-control').attr('id').substring(4, 5);
        var mySet = _this.closest('.form-group');
        mySet.remove();

        if (_this.hasClass("dev-skip-del")) {
            var num = _this.closest(".dev-group").find(".dev-example-skip").val();
            $("#item" + num + "-panel").remove();
            allNumReset();
        }

        inpList.find('> .form-group').each(function (i) {
            var newNum = i + 1;
            var labels = $(this).find('.control-label');
            var inps = $(this).find('.col-lg-8 .form-control');
            var fileSet = $(this).find('.file_set');
            $(this).find('.num').text(newNum);
            if (inpList.hasClass('ra_grp')) {
                labels.attr({
                    'for': 'item' + num + '-ra' + newNum
                });
                inps.attr({
                    'id': 'item' + num + '-ra' + newNum,
                    'name': 'item' + num + '-ra' + newNum
                });
            } else if (inpList.hasClass('skip_grp')) {
                labels.attr({
                    'for': 'item' + num + '-skip' + newNum,
                    'for': 'item' + num + '-skip' + newNum + '-num' + newNum,

                });
                inps.attr({
                    'id': 'item' + num + '-skip' + newNum,
                    'name': 'item' + num + '-skip' + newNum,
                    'id': 'item' + num + '-skip' + newNum + '-num' + newNum,
                    'name': 'item' + num + '-skip' + newNum + '-num' + newNum
                });
            } else {
                labels.attr({
                    'for': 'item' + num + '-chk' + newNum
                });
                inps.attr({
                    'id': 'item' + num + '-chk' + newNum,
                    'name': 'item' + num + '-chk' + newNum
                });
            }
            fileSet.each(function () {
                var myLabel = labels.attr('for');
                var fileLabels = $(this).find('label');
                var fileInps = $(this).find('input[type="file"]');
                var fileLabelsFor = fileLabels.attr('for').split('-file');
                fileLabels.attr('for', function () {
                    return $(this).attr('for').replace(fileLabelsFor[0], myLabel);
                });
                fileInps.attr('id', function () {
                    return $(this).attr('id').replace(fileLabelsFor[0], myLabel);
                });
                fileInps.attr('name', function () {
                    return $(this).attr('name').replace(fileLabelsFor[0], myLabel);
                });

            });
        });
    });

}

function filePlus() {
    $('.item_panel_area').on('click', '.file_add.btn', function () {
        var myGrp = $(this).closest('.form-group');
        var myRow = myGrp.find('> .col-lg-8');
        var myLabel = myGrp.find('.control-label').attr('for');
        var myNum = myGrp.find('.num').text();
        var fileNum = myRow.find('.file_set').length;

        if (fileNum < 1) {
            var fileTags = '';
            fileNum++;
            fileTags += '<div class="form-group inner_frm_grp file_set">';
            fileTags += '<div class="col-xs-9 col-sm-10 dev-file-wrap">'
            fileTags += '<label for="' + myLabel + '-file' + fileNum + '" class="sr-only file_num">파일</label><input type="file" id="' + myLabel + '-file' + fileNum + '" name="' + myLabel + '-file' + fileNum + '" class="form-control dev-input-file" />'
            fileTags += '</div>'
            fileTags += '<div class="col-xs-3 col-sm-2">'
            fileTags += '<button type="button" class="btn btn-xs btn-danger file_del ico_btn outline">삭제</button>'
            fileTags += '</div>'
            fileTags += '</div>'
            myRow.append(fileTags);
        }
    });
}

function fileDel() {
    $('.item_panel_area').on('click', '.file_del', function () {
        var mySet = $(this).closest('.file_set');
        var myGrp = mySet.closest('.col-lg-8');
        mySet.remove();
        myGrp.find('.file_set').each(function (i) {
            var newNum = i + 1;
            var labelsFor = $(this).find('label').attr('for').split('-file');
            var listLabel = labelsFor[0] + '-file' + newNum;
            $(this).find('label').attr('for', listLabel);
            $(this).find('input[type="file"]').attr('id', listLabel);
            $(this).find('input[type="file"]').attr('name', listLabel);
        });
    });
}

/*
function fileDel() {
    $(document).on('click','.del_file_btn',function(){
        var mySet = $(this).parents('.form-group');
        mySet.remove();
        $('#fileList .form-group').each(function(count) {
            var num  =  count + 1;
            $(this).find('.control-label').attr('for', 'input_file' + num).text('泥⑤��뚯씪 ' + num);
            $(this).find('.col-xs-5 .form-control').attr('id', 'input_file' + num);
        });
    });
} */
$(document).ready(function () {
    panelPlus();
    panelPlusBefore();
    panelDel();
    optPlus();
    optDel();
    optEtcPlus();
    filePlus();
    fileDel();

    $('.item_panel_area').on('change', '.sel_tab', function () {

        var myPanel = $(this).closest('.panel');
        var myNum = myPanel.find(".order-id").html();
        var selVal = myPanel.find('.sel_tab').val();

        if (selVal == '4') {
            var checked = false;
            $(".panel-default:visible").each(function () {
                var _this = $(this);
                var thisNum = Number(_this.find(".order-id").html());
                if (myNum < thisNum) {
                    if (_this.find(".dev-must-check").is(":checked")) {
                        checked = true;
                        return false;
                    }
                }
            });

            if (checked) {
                alert("선택항목보다 먼저 필수값이 설정되어있습니다. 필수값을 확인해주세요.");
                $(this).val(0).trigger("change");
                return false;
            }
        }

        myPanel.find('.tab-content').hide();
        myPanel.find('.item_tab' + selVal).show();

        if (selVal == '4') {
            var next = myPanel.find(".dev-example-skip");
            next.each(function (index, item) {
                var _this = $(this);
                // _this.val($(".panel-default:visible").length + 1);
                // $('#itemSetPlus').trigger('click');
                // var connectPanel = $(document).find(".panel:visible").last();
                // var connectClass = myPanel.attr('id') + '-connect';
                // connectPanel.addClass(connectClass);
                // connectPanel.find('.del_panel_btn').remove();
            });
        } else {
            // $('.' + myPanel.attr('id') + '-connect').remove();
            allNumReset();
        }
    });

    $(document).on("change", ".dev-must-check", function (e) {
        var isSkip = false;
        var _this = $(this);
        if (_this.is(":checked")) {
            var panels = $(".panel-default:visible");
            var myNum = Number(_this.closest(".panel-default").find(".order-id").text());
            panels.each(function () {
                var thisNum = Number($(this).find(".order-id").html());
                if (myNum > thisNum) {
                    var inpList = $(this).find('.inp_list:visible');
                    if (inpList.hasClass("skip_grp")) {
                        var skipNumList = inpList.find(".dev-example-skip");
                        if (myNum < Number(skipNumList[skipNumList.length - 1].value)) {
                            var count = 0;
                            skipNumList.each(function () {
                                if (myNum == Number($(this).val())) {
                                    count++;
                                }
                            });

                            if (count < 1) {
                                isSkip = true;
                            }
                        }
                    }
                }
            });
        }

        if (isSkip) {
            alert("건너뛰기형보다 순서가 낮은 항목의 질문을 필수값으로 만들 수 없습니다.");
            _this.prop("checked", false);
        }

    });

});