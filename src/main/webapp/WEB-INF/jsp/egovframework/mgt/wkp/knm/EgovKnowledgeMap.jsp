<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">지식 맵 관리</h2>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="msg"><strong class="text-primary">${loginVO.displayName }</strong>님! 반갑습니다.</p>
                        <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
                    </div>
                </div>
            </div>
            <!-- //cont_header -->
            <div class="cont_body">
            	<ol class="breadcrumb">
                    <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
                    <li>지식 관리</li>
                    <li class="active">지식 맵 관리</li>
				</ol>
				<div id="contents">
                    <div class="map_set_area wid-lg">
                        <div class="well well-primary">
                            <i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 분류 정렬 변경시 드래그해서 순서를 변경하실수 있습니다.
                        </div>
	                    <ul class="nav nav-tabs" role="tablist">
	                        <li role="presentation"<c:if test="${knowlgMapType eq 'REPORT'}"> class="active"</c:if>><a href="#bbsTab1" class="dev-tab" aria-controls="bbsTab1" role="tab" data-toggle="tab" data-type="REPORT">행정자료</a></li>
	                        <li role="presentation"<c:if test="${knowlgMapType eq 'REFERENCE'}"> class="active"</c:if>><a href="#bbsTab2" class="dev-tab" aria-controls="bbsTab2" role="tab" data-toggle="tab" data-type="REFERENCE">업무참고자료</a></li>
	                        <li role="presentation"<c:if test="${knowlgMapType eq 'PERSONAL'}"> class="active"</c:if>><a href="#bbsTab3" class="dev-tab" aria-controls="bbsTab3" role="tab" data-toggle="tab" data-type="PERSONAL">개인별지식</a></li>
	                    </ul>
	                    <form:form name="updFrm" action="/adm/updateKnowledgeMap.do" modelAttribute="knowledgeMapVO">
                        <div class="row type20">
                            <div class="col-xs-6 cate_box1">
                                <div class="map_cate_box">
                                    <div id="main" class="inp_set_list sort_list">
                                    	<c:forEach var="knowlgMap" items="${knowledgeMapList }">
                                    	<c:if test="${knowlgMap.upNo eq 0 }">
                                    	<input type="hidden" name="knowledgeMapList[${knowlgMap.knowlgMapNo }].knowlgMapType" value="${knowlgMapType }">
                                    	<input type="hidden" name="knowledgeMapList[${knowlgMap.knowlgMapNo }].knowlgMapNo" value="${knowlgMap.knowlgMapNo }">
										<input type="hidden" name="knowledgeMapList[${knowlgMap.knowlgMapNo }].sortOrdr" value="${knowlgMap.sortOrdr }">
										<input type="hidden" name="knowledgeMapList[${knowlgMap.knowlgMapNo }].upNo" value="${knowlgMap.upNo }">
                                        <div class="inp_set" data-no="${knowlgMap.knowlgMapNo }">
                                            <div class="row type0">
                                                <div class="col-xs-10">
                                                	<input type="text" class="form-control" name="knowledgeMapList[${knowlgMap.knowlgMapNo }].knowlgMapNm" value="${knowlgMap.knowlgMapNm }" placeholder="분류명을 입력해주세요." readonly="readonly" data-no="${knowlgMap.knowlgMapNo }" required />
                                                </div>
                                                <div class="col-xs-2 text-center btns">
                                                    <button type="button" class="btn btn-xs btn-danger del_btn" data-no="${knowlgMap.knowlgMapNo }" data-target="${knowlgMapType}">삭제</button>
                                                </div>
                                            </div>
                                        </div>
                                        </c:if>
                                        </c:forEach>
                                    </div>
                                    <div class="text-center btn_area">
                                    	<div class="col-xs-9"><input type="text" id="parentNm" class="form-control" placeholder="대분류명을 입력해주세요."></div>
                                        <button type="button" id="parentAdd" class="btn btn-default add_inp_btn" onclick="return confirm('추가하시겠습니까?');"><span class="txt">대분류</span> 추가</button>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xs-6 cate_box2">
                                <div class="map_cate_box">
                                    <div id="sub" class="inp_set_list sort_list">
                                    </div>
                                    <div class="text-center btn_area">
                                    	<div class="col-xs-9"><input type="text" id="childNm" class="form-control" placeholder="소분류명을 입력해주세요."></div>
                                        <button type="button" id="childAdd" class="btn btn-default add_inp_btn" onclick="return confirm('추가하시겠습니까?');"><span class="txt">소분류</span> 추가</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <div class="text-right mb_15">
                            <button type="submit" class="btn btn-blue min-lg btn-lg">적용</button>
                            <button type="button" class="btn btn-black min-lg btn-lg">취소</button>
                        </div>
                        </form:form>
                        <div class="panel panel-primary panel-sm">
                            <div class="panel-heading">
                                <strong class="panel-title">변경이력</strong>
                            </div>
                            <div class="panel-body">
                                <ul class="dot_list">
                                	<c:forEach var="log" items="${logList }">
                                    <li><fmt:formatDate value="${log.registDtm}" pattern="yyyy-MM-dd HH:mm:ss"/> : [${log.logType }] ${fn:replace(log.cont,"knowlgMapNm","지식맵") } ${log.registerName }(${log.ou })</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- //map_set_area -->
                </div>
                <!-- //CONTENTS -->
                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->
<form:form name="insertFrm" action="/adm/insertKnowledgeMap.do" modelAttribute="knowledgeMapVO">
<input type="hidden" name="knowlgMapType" value="${knowlgMapType }">
<input type="hidden" name="knowlgMapNo" value=0>
<input type="hidden" name="knowlgMapNm" value="">
<input type="hidden" name="upNo" value=0>
<input type="hidden" name="sortOrdr" value=0>
</form:form>
<script>
	$(function() {
		$('#parentAdd').click(function(e) {
           	e.preventDefault();
           	
			var myBox = $(this).closest('.map_cate_box');
			var inpList = myBox.find('.inp_set_list');
			var num = inpList.find('.inp_set').length + 1;

           	var knowlgMapNm = $('#parentNm').val();
			if(knowlgMapNm == ''){
				alert("대분류명을 입력해주세요.");
				return false;
			}
			
           	var form = $("form[name=insertFrm]");
           	var upNo = form.find("input[name=upNo]").val();
			if(upNo != 0){
				alert("대분류 선택을 해제해주세요.");
				return false;
			}
			
			if(upNo == ''){
				alert("대분류,소분류 선택을 해제해주세요.");
				return false;
			}
			
           	form.find("input[name=knowlgMapNm]").val(knowlgMapNm);
           	form.find("input[name=sortOrdr]").val(num);
           	form.submit();
		});

    	/*$('#parentAdd').click(function(e) {
    		var knowlgMapNm = $('#parentNm').val();
    			
			if(knowlgMapNm == ''){
				alert("대분류명을 입력해주세요.");
				return false;
			}
			
			$.ajax({
				url : '/adm/insertKnowledgeMap.do',
				data : {
					knowlgMapNm : knowlgMapNm
				},
				dataType: "json",
				success : function(data) {
					var txtType = $(this).find('.txt').text();
					console.log(txtType);
	    			var myBox = $(this).closest('.map_cate_box');
	    			var inpList = myBox.find('.inp_set_list');
	    			var num = inpList.find('.inp_set').length + 1;
	    			console.log(num);
	    			var inpTags = '';
	    			inpTags += '<input type="hidden" name="knowledgeMapList['+num+'].knowlgMapNo" value="'+data.knowlgMapNo+'">';
	    			inpTags += '<input type="hidden" name="knowledgeMapList['+num+'].sortOrdr" value="'+num+'">';
   					inpTags += '<div class="inp_set" data-no="'+ data.knowlgMapNo +'">'; 
	    			inpTags +=       '<div class="row type0">';
	    			inpTags +=           '<div class="col-xs-10"><input type="text" class="form-control" placeholder="분류명을 입력해주세요." value="새 ' + txtType + num + '" /></div>';
	    			inpTags +=           '<div class="col-xs-2 text-center btns">';
	                inpTags +=               '<button type="button" class="btn btn-xs btn-danger del_btn">삭제</button>';
	                inpTags +=           '</div>';
	                inpTags +=       '</div>';
	                inpTags +=   '</div>';
	                inpList.append(inpTags);
	     		},
	     		error : function(){
	     		
	     		}
			});
		});*/
		
		$('#childAdd').click(function(e) {
           	e.preventDefault();
           	
			var myBox = $(this).closest('.map_cate_box');
			var inpList = myBox.find('.inp_set_list');
			var num = inpList.find('.inp_set').length + 1;
			
			var knowlgMapNm = $('#childNm').val();
			if(knowlgMapNm == ''){
				alert("소분류명을 입력해주세요.");
				return false;
			}
			
			var active = inpList.find('.inp_set').hasClass('active');
			if(active){
				alert("소분류 선택을 해제해주세요.");
				return false;
			}
			
           	var form = $("form[name=insertFrm]");
           	var upNo = form.find("input[name=upNo]").val();
			if(upNo == 0){
				alert("대분류를 선택해주세요.");
				return false;
			}
			
           	form.find("input[name=knowlgMapNm]").val(knowlgMapNm);
           	form.find("input[name=sortOrdr]").val(num);
           	form.submit();
		});
		
		/*$('#childAdd').click(function(e) {
			var knowlgMapNm = $('#childNm').val();
			$.ajax({
				url : '/adm/insertKnowledgeMap.do',
				data : {
					knowlgMapNm : knowlgMapNm
				},
				dataType: "json",
				success : function(data) {
					var txtType = $(this).find('.txt').text();
					console.log(txtType);
	    			var myBox = $(this).closest('.map_cate_box');
	    			var inpList = myBox.find('.inp_set_list');
	    			var num = inpList.find('.inp_set').length + 1;
	    			console.log(num);
	    			var inpTags = '';
	    			inpTags += '<div class="inp_set">';
	    			inpTags +=       '<div class="row type0">';
	    			inpTags +=           '<div class="col-xs-10"><input type="text" class="form-control" placeholder="분류명을 입력해주세요." value="'+menuNm+'" /></div>';
	    			inpTags +=           '<div class="col-xs-2 text-center btns">';
	                inpTags +=               '<button type="button" class="btn btn-xs btn-danger del_btn">삭제</button>';
	                inpTags +=           '</div>';
	                inpTags +=       '</div>';
	                inpTags +=   '</div>';
	                inpList.append(inpTags);
	     		},
	     		error : function(){
	     		
	     		}
			});
		});*/
		
   		$('.map_cate_box').on('click', '.del_btn', function(e) {
            e.preventDefault();
           	if(confirm('정말 삭제하시겠습니까?')){
                const $this = $(this);
                const knowlgMapNo = $(this).data('no');

                $.ajax({
                    url: '/adm/deleteKnowledgeMap.do',
                    type: 'post',
                    data: JSON.stringify({ knowlgMapNo: knowlgMapNo }),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        const target = $this.data('target');
                        const isTab = !!$('.dev-tab[data-type=' + target + ']').length;
                        if (isTab) {
                            $('.dev-tab[data-type=' + target + ']').click();
                        } else {
                            $('.inp_set[data-no=' + target + ']').click();
                        }
                    },
                    error: function () {
                        alert('처리 중 오류가 발생했습니다.');
                    }
                });
           	}
   		});
   		/*$('.map_cate_box').on('click', '.del_btn', function(e) {
   			var mySet = $(this).closest('.inp_set');
   			var r = confirm('정말 삭제하시겠습니까?');
   			if (r) {
   				mySet.remove();
   			} else {
   				return false;
   			}
   		});*/

     	$('.sort_list').each(function() {
     		var myList = $(this);
     		myList.sortable({
     			cancel: '.empty',
     		});
     		myList.disableSelection();
     	});     	
     	
     	$('.map_cate_box').on('click', '.inp_set', function(e) {
     		var no =  $(this).data('no');

     		if(no != undefined){
	     		$.ajax({
	     			url : '/adm/knowledgeMap.do',
	     			data : {
	     				upNo : no
	     			},
	     			dataType: "json",
	     			success : function(data) {
	     				$('#sub .inp_set').remove();
	     				var inpTags = '';
	     				for(var i=0; i < data.knowledgeMapList.length; i++){
	     					inpTags += '<input type="hidden" name="knowledgeMapList['+data.knowledgeMapList[i].knowlgMapNo+'].knowlgMapType" value="${knowlgMapType}">' 	     					
	     					inpTags += '<input type="hidden" name="knowledgeMapList['+data.knowledgeMapList[i].knowlgMapNo+'].knowlgMapNo" value="'+data.knowledgeMapList[i].knowlgMapNo+'">'
                        	inpTags += '<input type="hidden" name="knowledgeMapList['+data.knowledgeMapList[i].knowlgMapNo+'].sortOrdr" value="'+data.knowledgeMapList[i].sortOrdr+'">'
							inpTags += '<input type="hidden" name="knowledgeMapList['+data.knowledgeMapList[i].knowlgMapNo+'].upNo" value="'+data.knowledgeMapList[i].upNo+'">'
	     					inpTags += '<div class="inp_set">';
	     					inpTags +=       '<div class="row type0">';
	     					inpTags +=           '<div class="col-xs-10"><input type="text" class="form-control" placeholder="분류명을 입력해주세요." name="knowledgeMapList['+data.knowledgeMapList[i].knowlgMapNo+'].knowlgMapNm" value="' + data.knowledgeMapList[i].knowlgMapNm + '" /></div>';
	     					inpTags +=           '<div class="col-xs-2 text-center btns">';
	      					inpTags +=               '<button type="button" class="btn btn-xs btn-danger del_btn" data-no="'+ data.knowledgeMapList[i].knowlgMapNo +'" data-target=' + data.knowledgeMapList[i].upNo + '>삭제</button>';
	      					inpTags +=           '</div>';
	      					inpTags +=       '</div>';
	      					inpTags +=   '</div>';
	     				}
	     				$('#sub').append(inpTags);
	     			},
	     			error : function(){
	     			
	     			}
	     		});
     		}
     	
     		var myList = $(this).closest('.inp_set_list');
         	var target = $(e.target);
         	var myInp = $(this).find('input[type="text"]');
         	if(target.is('button')){
            	 return false;
         	} else {
             	myList.find('> .inp_set').not($(this)).removeClass('active');
             	myList.find('> .inp_set input[type="text"]').attr('readonly', 'readonly');
             	$(this).addClass('active');
             	myInp.removeAttr('readonly').focus();
             	var upNo = $(this).data('no');
               	var form = $("form[name=insertFrm]");
               	form.find("input[name=upNo]").val(upNo);
         	}
         	e.stopPropagation();
     	});
     	
     	$('.dev-tab').on('click', function(e) {
           	e.preventDefault();
           	var type = $(this).data('type');
           	var form = $("form[name=insertFrm]");
           	form.find("input[name=knowlgMapType]").val(type);
           	form.find("input[name=knowlgMapNo]").val(0);
           	form.find("input[name=knowlgMapNm]").val("");
           	form.find("input[name=upNo]").val(0);
           	form.find("input[name=sortOrdr]").val(0);
           	form.attr("action", "/adm/knowledgeMapList.do");
           	form.submit();
        });
     	
     	/*$('.dev-tab').on('click', function(e) {
     		var type = $(this).data('type');
     		$.ajax({
     			url : '/adm/knowledgeMap.do',
     			data : {
     				knowlgMapType : type
     			},
     			dataType: "json",
     			success : function(data) {
     				$('#main .inp_set').remove();
     				var inpTags = '';
   					for(var i=0; i < data.knowledgeMapList.length; i++){
   						if(data.knowledgeMapList[i].upNo == 0){
	       					inpTags += '<div class="inp_set" data-no="'+ data.knowledgeMapList[i].knowlgMapNo +'">'; 
	       					inpTags +=       '<div class="row type0">';
	       					inpTags +=           '<div class="col-xs-10"><input type="text" class="form-control" placeholder="분류명을 입력해주세요." value="' + data.knowledgeMapList[i].knowlgMapNm + '" /></div>';
	       					inpTags +=           '<div class="col-xs-2 text-center btns">';
	        				inpTags +=               '<button type="button" class="btn btn-xs btn-danger del_btn">삭제</button>';
	        				inpTags +=           '</div>';
	        				inpTags +=       '</div>';
	        				inpTags +=   '</div>';
   						}
       				}
     				$('#main').append(inpTags);
     				$('ip')
     			},
     			error : function(){
     			
     			}
     		});
     	});*/
     	
		$('input[type="text"]').keydown(function() {
			if (event.keyCode === 13) {
				event.preventDefault();
			};
		});
 	});
</script>