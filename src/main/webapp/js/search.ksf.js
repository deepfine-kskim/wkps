/*******************************************************
* 프로그램명 	 : search.ksf.js 
* 설명        : 통합검색 환경에서 KSF 통해 조회하는 공통 함수 - ajax 함수 사용
* 작성일      : 2017.12.
* 작성자      : 김승희
* 수정내역    : -
*******************************************************/


/**
 * 화면 구동시 호출하는 함수정보  
 * 사용되는 함수목록은 자동완성(), 오타교정(), 인기검색어() 기본 사용합니다.
 * - 해당 정보 호출하기전에 KSF 모듈에서 기능 사용을 적용하였는지 확인되어야 합니다.
 */
$(function(){
	//자동완성
	autocomplete();
	
	//인기검색어
//	popularkey();
	
	//최근검색어(위젯)
//	$( "#recent" ).recent();
	
	
	//오타교정 건수체크하기
	var rsCount = '<c:out value="${total}" />';
	var kwd = '<c:out value="${params.kwd}" />';
	
	if(kwd.length > 0 && rsCount == 0){
		//getSpellchek();
	}
	
	//오류메시지출력
	/*
	var message = '<c:out value="${message}" />';
	if(message.length > 0){
		alert(message);
		return false;
	}
	*/	
	
});

/**
* 통합검색어 인기검색어
* ksf 표준소스 기준으로 ajax 호출하여 데이터를 보여준다.
* @ return str 			
**/
/*function popularkey(){
	var ajax = {
			type: "GET",
			url: "",
			data: {},
			success: {},
			error: {}
	};
	ajax.url = 'ksf/ppk.do';
	ajax.success = function(data) {
		
		if(data.length > 0){				
			//console.log("[initPPK] success");
			var ppkHTML = "";
			var metaClass="";
			ppkHTML = "<ol class='num_list'>";
			var ppkValue;
			
			$.each(data, function( i, item) {
				
				ppkValue = (item.ppk).replace(/</gi,"&lt;").replace(/>/gi,"&gt;");
				if(item.meta == "new") metaClass = "new"
				else if( Number(item.meta) == 0) metaClass = "equal"	
				else if( Number(item.meta) > 0) metaClass = "arrow-up"
				else	 metaClass = "arrow-down"
				
				ppkHTML +=	"<li><a name='ppk' href='#' onclick='javascript:ppkSrch('<c:out value=";
				ppkHTML += 	ppkValue+"/>')'><span class='num'>";
				ppkHTML += 	i+"</span>";
				ppkHTML +=	ppkValue + "</a>";
				ppkHTML +=	"</li>";
				
			})
		}
			ppkHTML += "</ol>";
			$("#rankings").html(ppkHTML);
	};	
	ajax.error = function(xhr, ajaxOptions) {
		console.log(ajaxOptions);
	};
	
	$.ajax(ajax);
}*/



/**
* 통합검색어 자동완성 
* ksf 표준소스 기준으로 ajax 호출하여 데이터를 보여준다.
* @ return str 			
**/
function autocomplete(){
	//$("input[name=kwd]").autocomplete( { source: "ksf/akc.do" } );
	$("input[name=kwd]").autocomplete({
		
	    source : function( request, response ) {
	         $.ajax({
	                type: 'get',
	                url: "ksf/akc.do",
	                dataType: "json",
	                data: {"term":$("#topKwd").val()},
	                success: function(data) {
	                    //서버에서 json 데이터 response 후 목록에 추가
	                    response(
	                        $.map(data, function(item) {    //json[i] 번째 에 있는게 item 임.
	                            return {
	                                label: item,    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
	                                value: item,    //그냥 사용자 설정값?
	                            }
	                        })
	                    );
	                }
	           });
	        },    // source 는 자동 완성 대상
/*	    select : function(event, ui) {    //아이템 선택시
	        console.log(ui);//사용자가 오토컴플릿이 만들어준 목록에서 선택을 하면 반환되는 객체
	        console.log(ui.item.label);    //김치 볶음밥label
	        console.log(ui.item.value);    //김치 볶음밥
	        console.log(ui.item.test);    //김치 볶음밥test
	        
	    },*/
	    focus : function(event, ui) {    //포커스 가면
	        return false;//한글 에러 잡기용도로 사용됨
	    },
	    minLength: 1,// 최소 글자수
	    autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
	    classes: {    //잘 모르겠음
	        "ui-autocomplete": "highlight"
	    },
	    delay: 150,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
//	            disabled: true, //자동완성 기능 끄기
	    position: { my : "right top", at: "right bottom" },    //잘 모르겠음
	    close : function(event){    //자동완성창 닫아질때 호출
	        console.log(event);
	    }
	});
}


/**
* 카테고리 매칭 함수(카운트). 
* 카테고리 코드값을 넘겨주면, total 값을 리턴한다.
* 
* @ return str 			
**/
function getSpellchek() {
	var kwd = $.trim($("input[name=kwd]").val());

	var ajax = {
			type: "GET",
			url: "",
			data: {},
			success: {},
			error: {}
	};
	ajax.url = 'ksf/spell.do';
	ajax.data = { term :kwd};
	ajax.success = function(data) {
		//console.log("[getSpellchek] success");
		if(data.length > 0){				
			var rsData;
			
			rsData = '<strong>검색어 교정</strong>';
			data.forEach(function(item) {
				rsData += '<em><a href=\"javascript:getSpellKwd(\''+item+'\')\">'+item+'</a></em> ';			
			});

			rsData += ' 으로 검색할까요?';
			$(".proofs_wrap").html(rsData);
			$(".proofs_wrap").css("display","block");
			}
	};	
	ajax.error = function(xhr, ajaxOptions) {
		console.log(ajaxOptions);
	};
	
	$.ajax(ajax);
};

//검색어 교정을 통해 바로 검색활성화
function getSpellKwd(value){
	//dftSchKwd( value );
};

