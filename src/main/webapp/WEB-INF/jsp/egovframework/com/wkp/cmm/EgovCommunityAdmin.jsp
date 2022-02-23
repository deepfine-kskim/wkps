<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<script>

var cmmntyNo = ${community.cmmntyNo};
var community_url = '/cmu/community.do';
$(function() {
	
	$('#entrust_nomember').hide();
	
	$('#btn_entrust').click(function(){
		
		var ids = new Array();
    	$('input:radio[name="r_entrust"]').each(function() {
    		if($(this).prop('checked')){
    			ids.push(this.value);
    		}
        });

    	if(ids.length == 0){
    		alert("위임할 회원을 선택해 주세요.");
    		return;
    	}
		
		var ret = confirm("정말로 위임 하시겠습니까?");
		if(!ret){
			return;
		}
		
		var param ={ cmmntyNo : cmmntyNo,
				targetMberNo : ids[0]
				}; 
		
		$.post("entrust.do",
			   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){
		    	 location.replace(community_url);
			  }else{
				 alert(json.err_msg);
			  } 
			} 
		);
	});
	
	 <c:if test="${role=='Y'}">
	$('#btn_closure').click(function(){
		var ret = confirm("정말로 폐쇄 하시겠습니까?");
		if(!ret){
			return;
		}
		
		var param ={ cmmntyNo : cmmntyNo
				}; 
		
		$.post("closeCommunity.do",
			   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){
		    	 location.replace(community_url);
			  }else{
				 alert(json.err_msg);
			  } 
			} 
		);
	});
	
	$('#btn_save').click(function(){
		
		var memAprvYn = 'N';
		var memPubYn = 'N';
		
		if($("#cmmntyNm").val() == ''){
			alert("커뮤니티명을 입력해 주세요.");
			return;
		}
		
		if($("#cmmntyDesc").val() == ''){
			alert("커뮤니티 설명을 입력해 주세요.");
			return;
		}
		if($("input:checkbox[id='memAprvYn']").is(":checked") == true){
			memAprvYn = 'Y';
		}
		if($("input:radio[id='memPubY']").is(":checked") == true){
			memPubYn = 'Y';
		}
		
		var tags = $("#inpKeyword").tagsinput('items');
		
		var param ={ cmmntyNo : cmmntyNo, 
				cmmntyNm : $("#cmmntyNm").val(),
				cmmntyDesc : $("#cmmntyDesc").val(),
				memAprvYn: memAprvYn,
				memPubYn: memPubYn,
				keyword:tags
				}; 
		
		$.post("modifyCommunity.do",
			   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){
		    	 alert('수정하였습니다.');
			  }else{
				 alert(json.err_msg);
			  } 
			} 
		);
		
		
		
	});
	</c:if>
	
	$('#btn_search_entrust').click(function(){
		search_entrust($('#entrustKeyword').val());
		
	});
	
	function search_entrust(search_value){
		var param ={ cmmntyNo : cmmntyNo, 
				nickname : $("#entrustKeyword").val()
				}; 
		
		$.post("findOwnerMember.do",
			   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){

		  		
		  		if(json.list.length == 0){
		  			$('#entrust_nomember').show();
		  		}else{
		  			$('#entrust_nomember').hide();
		  		}
		  		
		  		$('#list_entrust').empty();
		  		
		    	for(var i = 0; i < json.list.length; i++){
		    		var data = '';
		    		
		    		data +='<li>';
		    		data +='<div class="radio">';
		    		data +='<label for="entrust'+i+'">';
		    		data +='<input type="radio" id="entrust'+i+'" name="r_entrust" value="'+json.list[i].mberNo+'"/>';
		    		data += json.list[i].cmmntyNicknm;
		    		data +='</label>';
		    		data +='</div>';
		    		data +='</li>';
		    		
		    		$('#list_entrust').append(data);
		    	}
		    	
			  }else{
				 alert(json.err_msg);
			  } 
			} 
		);
		
		
		
		
	}
});

</script>
<div class="container sub_cont">
                <div class="row layout_side_row">
                    <%@ include file="EgovCommunitySide.jsp" %>  
                    <!-- //ASIDE -->
                    <div id="contents" class="col-md-9">
                        <div class="page-header sub_title">
                            <h2>커뮤니티 관리</h2>
                        </div>
                        <div class="page-body">
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" class="active"><a href="communityAdmin.do?cmmntyNo=${community.cmmntyNo}">정보</a></li>
                                <li role="presentation"><a href="communityAdminConfirm.do?cmmntyNo=${community.cmmntyNo}">가입요청 관리</a></li>
                                <li role="presentation"><a href="communityAdminMember.do?cmmntyNo=${community.cmmntyNo}">회원 관리</a></li>
                                <li role="presentation"><a href="communityAdminStaff.do?cmmntyNo=${community.cmmntyNo}">스텝 관리</a></li>
                            </ul>
                            <div class="form-horizontal">
                                <div class="well mb_10">
                                    <fieldset>
                                        <legend class="sr-only">게시판 글작성</legend>
                                        <div class="brd_write_area">
                                            <div class="form-group">
                                                <label for="cmmntyNm" class="col-md-2 control-label"><span class="req">*</span> 커뮤니티 명</label>
                                                <div class="col-md-8">
                                                    <input type="text" class="form-control" id="cmmntyNm" required="required" <c:if test="${role!='Y'}">disabled</c:if> value="${community.cmmntyNm }" />
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="checkbox-inline">
                                                        <label for="memAprvYn"><input type="checkbox" name="memAprvYn" id="memAprvYn" <c:if test="${role!='Y'}">disabled</c:if> <c:if test="${community.memAprvYn =='Y' }">checked</c:if> />승인후 가입</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="cmmntyDesc" class="col-md-2 control-label"><span class="req">*</span> 커뮤니티 설명</label>
                                                <div class="col-md-10">
                                                    <textarea class="form-control" rows="5" id="cmmntyDesc" required="required" <c:if test="${role!='Y'}">disabled</c:if>>${community.cmmntyDesc }</textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="inpKeyword" class="col-md-2 control-label">검색 키워드</label>
                                                <div class="col-md-10">
                                                    <input type="text" id="inpKeyword" name="inpKeyword" data-role="tagsinput" class="form-control inp_keyword" <c:if test="${role!='Y'}">disabled</c:if> value="${community.strKeyword}" />
                                                    <p class="help-block"><i class="fa fa-exclamation-circle text-danger"></i> 최대 10개까지 등록 가능합니다. 입력후 엔터키를 눌러주세요.</p>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="mbPublic1" class="col-md-2 control-label">회원목록 공개여부</label>
                                                <div class="col-md-3">
                                                    <label for="memPubY" class="radio-inline">
                                                        <input type="radio" id="memPubY" name="memPubYn" value="Y" <c:if test="${role!='Y'}">disabled</c:if> <c:if test="${community.memPubYn =='Y' }">checked</c:if> /> 공개
                                                    </label>
                                                    <label for="memPubN" class="radio-inline">
                                                        <input type="radio" id="memPubN" name="memPubYn" value="N" <c:if test="${role!='Y'}">disabled</c:if> <c:if test="${community.memPubYn =='N' }">checked</c:if> /> 비공개
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                            <c:if test="${role=='Y'}">
                            <div class="row type0">
                                <div class="col-xs-6">
                                    <a href="#entrustCommPopup" class="btn btn-primary outline" data-toggle="modal" data-target="#entrustCommPopup">커뮤니티 위임</a>
                                    <a href="#" class="btn btn-danger" id="btn_closure">폐쇄</a>
                                </div>
                                <div class="col-xs-6 text-right">
                                    <button class="btn btn-primary" id="btn_save">확인</button>
                                    <a href="${menuList[3].menuUrl }" class="btn btn-black">취소</a>
                                </div>
                            </div>
                            </c:if>
                            
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                    <!-- 커뮤니티 위임 팝업 -->
                    <div class="modal fade" id="entrustCommPopup" tabindex="-1" role="dialog" aria-labelledby="entrustCommPopupLabel">
                        <div class="modal-dialog modal-sm" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="entrustCommPopupLabel">커뮤니티 위임</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="srch_area">
                                        <fieldset>
                                            <legend class="sr-only">닉네임 검색</legend>
                                            <div class="input-group">
                                                <label for="entrustKeyword" class="sr-only">닉네임 검색</label>
                                                <input type="text" id="entrustKeyword" name="srchKeyword" class="form-control" placeholder="닉네임 검색">
                                                <span class="input-group-btn"><button class="btn btn-default" id="btn_search_entrust">검색</button></span>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div class="tab-content">
                                        <div class="well chk_tree_area">
                                            <ul class="radio_list" id="list_entrust">
                                                
                                            </ul>
                                        </div>
                                        <!-- 검색결과 없음 -->
                                        <div class="well text-center mb_0" id="entrust_nomember">
                                            <p>검색 결과가 없습니다</p>
                                        </div>
                                        <!-- //검색결과 없음 -->
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" id="btn_entrust">확인</button>
                                    <button type="button" class="btn btn-black" data-dismiss="modal">취소</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //커뮤니티 위임 팝업 -->
                </div>
                <!-- //row -->
            </div>