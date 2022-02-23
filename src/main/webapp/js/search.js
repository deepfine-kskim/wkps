// 페이지 선택
function srchKwd(){
	var kwd =  $('#topKwd').val();
	var resrchFlag = $('#resrchFlag').prop("checked");

	var preKwds = "";
	preKwds = kwd+"|";
	var arrPreKwds  = new Array();
	arrPreKwds =$('#preKwds').val().split("|");
	if(!resrchFlag){
		$('#historyForm input').val('');
	}
	if(resrchFlag){
		if(arrPreKwds.length >1){
			var preKwdCnt =arrPreKwds.length;
			for (var i = 0; i < arrPreKwds.length; i++) {
				if(arrPreKwds[i] != kwd && arrPreKwds[i] != ""){
					preKwds += arrPreKwds[i]+"|";
				}
			}
		}
		$("#historyForm #reSearch").val(resrchFlag);
		$("#historyForm #pageNum").val('');
	}
	$("#historyForm #preKwds").val(preKwds);
	if(!resrchFlag){
		$("#historyForm #schAreaAll").val("true");
		$("#historyForm #category").val("TOTAL");
	}
	$('#historyForm #userid').val($('.navbar #userid').val() );
	$('#historyForm  #kwd').val(kwd);
	if(resrchFlag){
		$('#contents').load($('#historyForm').attr('action'), $('#historyForm').serializeArray());
	}
	if(kwd == ""){
		alert("검색어를 입력해주세요.");
		return false;
	}else{
		$('#historyForm').submit();
	}				
}

//상세검색
function detailSrchKwd(){
	var kwd =  $('#topKwd').val();
	var resrchFlag = $('#resrchFlag').prop("checked");
	var cate=null;
	var preKwds = "";
	preKwds = kwd+"|";
	var arrPreKwds  = new Array();
	arrPreKwds =$('#preKwds').val().split("|");

	$('#historyForm input').val('');
	if(resrchFlag){
		if(arrPreKwds.length >1){
			var preKwdCnt =arrPreKwds.length;
			for (var i = 0; i < arrPreKwds.length; i++) {
				if(arrPreKwds[i] != kwd && arrPreKwds[i] != ""){
					preKwds += arrPreKwds[i]+"|";
				}
			}
		}
		$("#historyForm #reSearch").val(resrchFlag);
		$("#historyForm #pageNum").val('');
	}
	if($('#schCate').prop("checked")){
		$("#historyForm #category").val("TOTAL");
	}
	else{
		if($('#schCate0').prop("checked")){
			cate="kno";
		}
		if($('#schCate1').prop("checked")){
			if(cate == null)
				cate="qna";
			else
				cate+=",qna";
		}
		if($('#schCate2').prop("checked")){
			if(cate == null)
				cate="srv";			
			else
				cate+=",srv";
		}
		if($('#schCate3').prop("checked")){
			if(cate == null)
				cate="comm";
			else
				cate+=",comm";
		}
		if($('#schCate4').prop("checked")){
			if(cate == null)
				cate="notice";
			else
				cate+=",notice";
		}
		if($('#schCate5').prop("checked")){
			if(cate == null)
				cate="faq";
			else
				cate+=",faq";
		}
		if($('#schCate6').prop("checked")){
			if(cate == null)
				cate="edmsRecv";
			else
				cate+=",edmsRecv";
		}
		if($('#schCate7').prop("checked")){
			if(cate == null)
				cate="edmsPost";
			else
				cate+=",edmsPost";
		}
		$("#historyForm #category").val(cate);
	}

	$("#historyForm #schAreaAll").val($('#schArea').prop("checked"));
	$("#historyForm #schAreaTit").val($('#schArea1').prop("checked"));
	$("#historyForm #schAreaCont").val($('#schArea2').prop("checked"));
	$("#historyForm #schAreaFile").val($('#schArea3').prop("checked"));
	$("#historyForm #preKwds").val(preKwds);
	getStEddate();
	$('#historyForm #userid').val($('.navbar #userid').val() );
	$('#historyForm  #kwd').val(kwd);
	if(kwd == ""){
		alert("검색어를 입력해주세요.");
		return false;
	}else{
		$('#historyForm').submit();
	}				
}

function ppkSrch(kw){
	$('#historyForm input').val('');
	$('#historyForm  #kwd').val(kw);
	$("#historyForm #preKwds").val(kw+"|");
	$('#historyForm').submit();

}

function sortSrch(sort){
	$('#historyForm  #sort').val(sort);
	$('#historyForm').submit();
}

// 페이지 선택
function gotopage(p) {
//	$('#categorize').val(false); // 페이지 이동의 경우 새로 카테고리 그루핑할 필요 없음
	$('#page').val(p);
	$('#pageNum').val(p);
//	$('#contents').load($('#historyForm').attr('action'), $('#historyForm').serializeArray());
	$('#historyForm').submit();
}
//20160706, 현재날짜 조회
function getTodate(){
	var rightNow = new Date();
	var res = rightNow.toISOString().slice(0,10).replace(/-/g,"");
	
	return ($('#nowDate').val()).length > 7 ? ('#nowDate').val(): rightNow.toISOString().slice(0,10).replace(/-/g,""); 	
}
//시작-종료날짜선택
function getStEddate(){
	var startdate ;
	var enddate;
	if($('#schDate1').prop("checked")){
		startdate=getAddDate("w");
		enddate=getToday();
	}else if($('#schDate2').prop("checked")){
		startdate=getAddDate("m");
		enddate=getToday();
	}else if($('#schDate3').prop("checked")){
		startdate=getAddDate("y");
		enddate=getToday();
	}else if($('#schDate4').prop("checked")){
		startdate=$('#inpStartDate').val();
		enddate=$('#inpEndDate').val();
	}
	$("#historyForm #startDate").val(startdate);
	$("#historyForm #endDate").val(enddate);
	return null;	
}
/* 날짜 객체 받아서 문자열로 리턴하는 함수 */
function getDateStr(myDate){
	return (myDate.getFullYear() + '-' + ("00"+(myDate.getMonth() + 1)).slice(-2) + '-' + ("00"+myDate.getDate()).slice(-2))
}

/* 오늘 날짜를 문자열로 반환 */
function getToday() {
  var d = new Date()
  return getDateStr(d)
}
//현재 날짜계산기준으로 날짜 계산
function getAddDate(dtFg) {
	if(dtFg==null || dtFg =="") {
		return "";
	}
	
	  var d = new Date()
	  if("d" == dtFg){
	    	d.setDate(d.getDate() - 1);
	  }else  if("w" == dtFg){
	    	d.setDate(d.getDate() - 7);
	  }else  if("m" == dtFg){
	    	d.setMonth( d.getMonth() - 1);
	  }else  if("y" == dtFg){
	    	d.setFullYear( d.getFullYear() - 1);
	  }

	  return getDateStr(d);
}

function getDetail(paramCategory, paramId){
	send_KLA_click_log(paramCategory, paramId);
	
	var popUrl = "detail.do?category="+paramCategory+"&docid="+paramId;	//팝업창에 출력될 페이지 URL

	var popOption = "width=450, height=450, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
	window.open(popUrl,"konandetail",popOption);
}

// 카테고리 선택
function goCategory( val ) {
	$('#historyForm #category').val(val);
	$('#historyForm #pageNum').val("");
	$('#historyForm').submit();
}


// 첨부파일 미리보기
$('.preview label label-default').on('click', function() {
	alert('preview');
	/*// 미리보기
	var $base = $(this).parents(".media:first"),
		$that = $base.find(".preview-dialog");
	if ($that.length == 0) {
		$.ajax({
			type: 'GET',
			url: 'dispatch.jsp',
			data: { view: 'preview', query: $('#query').val(), rowid: $base.find('input[name=rowid]').val() },
			dataType: 'html',
			success: function(data) {
				$('#preview-dialog').clone()
					.attr('id', '')
					.find('.modal-body p').html(data).end()
					.appendTo($base).collapse('show');
			}
		});
	} else {
		$that.collapse('toggle');
	}*/
});

$(function() {
	//사용자설정
	$('.navbar #userid').val($('#historyForm #userid').val()==""?"admin":$('#historyForm #userid').val());
	
	
	// 검색 타깃 초기화 및 사이드바 위젯 초기화
	$('#sidebar')
		.find('[data-target=' + $('#category').val() + ']').addClass('active').end()
		.find('form').deserialize($('#historyForm').serializeArray());

	// 사이드바 위젯 - 첨부 초기화
	if ($('#fileext').val()) { // 전체 선택이 아닐 경우
		var initValues = $('#fileext').val().split(',');
		$('#sidebar').find('input[name=fileext]').each(function() {
			$(this).prop('checked', ($.inArray($(this).val(), initValues) != -1));
		});
	}

	// 결과 내 재검색 플래그 설정
	if ($('#resrch').val() == 'true') {
		$('form').find('input[name=reSearch]').prop('checked', true);
	}
	
	// 상세검색 영역결과 플래그 설정
	if ($('#schArea').val() == 'true') {
		$('form').find('input[name=schArea]').prop('checked', true);
	}
	
	// 상세검색 검색영역  설정
	if ($('#schArea').val() == 'true') {
		$('header form').find('input[name=schArea]').prop('checked', true);
	}
	

	// 기간 직접 입력 폼 보이기/숨기기
	if ($('#date').val() == 'r') {
		$('#date-radio').hide(), $('#date-input').show();
	}

	/* Event Handlers */

	/* 검색 폼 제출 시 */
	$('#historyForm').submit(function(e) {

		$('#categorize').val($('#category').val() != 'TOTAL');
		$('#page').val(0);
		//$('#category').val('');
		$('#resrch').val($('form input[name=reSearch]').is(':checked'));
//		$('#recent').recent('add', $('#kwd').val()); // 최근 검색어 추가
	});

	/* 상/하단 키워드 입력 폼을 통한 검색 시 */
	$('header form, footer form').submit(function(e) {
		e.preventDefault();
		//e.stopPropagation();

		if ($.trim($(this).find('input[name=kwd]').val())) {
			srchKwd();
		} else {
			alert('검색어를 입력해주세요.');
		}
	});

	/* 검색어 추천, 인기검색어, 최근검색어 클릭 시 */
/*	$('.suggestions, #rankings, #recent').on('click', 'a', function() {
		alert($(this).text());
		$('#historyForm input').val("");
		$('#kwd').val($(this).text());
		$('#historyForm').submit();
	});*/
	
	
	
	/* 사이드바 영역 이벤트 */
	$('#sidebar').on('click', '.nav > li > a', function() {
		// 검색 타깃 선택 시
		$('#fileext').val('');
		$('#target').val( $(this).parent().attr('data-target') );
		$('#historyForm').submit();
	}).on('change', 'input:radio[name=sort]', function(e) {
		// 사이드바 위젯 - 정렬
		$('#sort').val($(this).val());
		$('#categorize').val(false);
		$('#contents').load($('#historyForm').attr('action'), $('#historyForm').serializeArray());
		$('#historyForm').submit();
	}).on('change', 'input:radio[name=fields]', function(e) {
		// 사이드바 위젯 - 영역 : 20160706 수정
		$('#historyForm').deserialize(
				$(e.delegateTarget).find('form').serializeArray()
			).submit();		
	}).on('change', 'input:radio[name=date]', function(e) {
		//날짜 설정 20160706 추가
		$('#startDate').val(getAddDate($(this).val()) );
		$('#endDate').val(getTodate());
		// 사이드바 위젯 -  기간
		$('#historyForm').deserialize(
				$(e.delegateTarget).find('form').serializeArray()
			).submit();
	}).on('click', '#open-date-input', function(e) {
		// 사이드바 위젯 - 기간 > 직접입력
		$('#date-radio').hide();
		$('#date-input').show();
		return false;
	}).on('click', '#close-date-input', function(e) {
		// 사이드바 위젯 - 기간 > 직접입력 > 닫기
		$('#date').val($('#date-radio').find("input:radio:checked").val());
		$('#date-input').hide();
		$('#date-radio').show();
		return false;
	}).on('click', '#apply-date-input', function(e) {
		// 사이드바 위젯 - 기간 > 직접입력 > 적용
		$('#date').val('r');
		//날짜 설정 20160706 추가
		$('#startDate').val( $('#date-input').find("input:text[name=date-from]").val() );
		$('#endDate').val( $('#date-input').find("input:text[name=date-to]").val() );		
		$('#historyForm').deserialize(
				$('#date-input').find('input').serializeArray()
			).submit();
	}).on('change', 'input[name=fileext]', function() {
		// 사이드바 위젯 - 확장자 선택
		var $sw = $(this).parents(".sidebar-widget");
		// 개별 확장자 선택 시 전체 선택 해제.
		if ($(this).val()) $sw.find(':checkbox[value=""]').prop('checked', false);
		// 전체 선택 시 개별 확장자 선택 해제
		else if ($(this).is(':checked')) $sw.find(':checkbox').not(this).prop('checked', false);
	}).on('click', '#apply-fileext', function() {
		// 사이드바 위젯 - 확장자 검색
		var $sw = $(this).parents(".sidebar-widget");
		$('#fileext').val(
			$sw.find('input[name=fileext]:checked').map(function() { return $(this).val(); }).get().join()
		);
		$('#historyForm').submit();
	}).on('click', '#toggle-widget', function() {
		// 반응형 - 사이드바 위젯 모두 펼침/닫기
		var $sw = $(this).parents(".sidebar-widget");
		$('#sidebar').find('.sidebar-widget').not($sw).toggle();
		$(this).toggleClass('fa-chevron-up fa-chevron-down');
	});

	/* 검색 결과 영역 이벤트 */
	$('#contents').on('click', '.more > a', function() {
		// 결과 더보기 - 통합검색
		$('#category').val($(this).attr('data-target'));
		$('#historyForm').submit();
	});

	/* 상세 검색 */
	$('#detailed-search').click(function() {

		if( $("#detailed-search-dialog").css("display") != undefined && $("#detailed-search-dialog").css("display") != "none" ){
			return false;
		}

		$('<div>').attr('id', 'detailed-search-dialog').dialog({
			title: '상세검색',
			// 검색 결과 영역의 상단에 맞춰 대화상자 위치
    		position: { my: 'left top', at: 'left+10 top+2', of: '.main-contents' },
    		width: $('.main-contents').width(),   		
			open: function() { $(this).load('dispatch.jsp?view=detailed-search'); },
			close: function() { $(this).remove(); }
		});
	});

	/* 카테고리 필터링 - 트리 */
/*	$('.category-tree').fancytree({ 
		icons: false, 
		activate: function(event, data) {
			$('#categorize').val(false); // 카테고리 필터링의 경우 새로 카테고리 그루핑할 필요 없음
			$('#page').val(0);
			$('#category').val(data.node.key);
			$('#contents').load($('#historyForm').attr('action'), $('#historyForm').serializeArray());
		}
	});*/

	/* 카테고리 필터링 - 리스트 */
	$('.category-list').on('click', 'li', function() {
		$('#categorize').val(false); // 카테고리 필터링의 경우 새로 카테고리 그루핑할 필요 없음
		$('#page').val(0);
		$('#category').val($(this).attr('data-group'));
		$('#contents').load($('#historyForm').attr('action'), $('#historyForm').serializeArray());
	});
});


function send_KLA_click_log(paramCategory, paramId){
	var o = {
		user : $('#historyForm #userid').val(),
		keyword : $("#historyForm #kwd").val(),
		section : paramCategory,
		docid : paramId
	}
	var kwl = new KWL("10.10.20.238:9000", paramCategory);
	kwl.writeLog(o);
}