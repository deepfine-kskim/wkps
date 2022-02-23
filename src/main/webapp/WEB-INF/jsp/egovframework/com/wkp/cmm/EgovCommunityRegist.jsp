<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(function() {
	
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
		
		var param ={ cmmntyNm : $("#cmmntyNm").val(),
				cmmntyDesc : $("#cmmntyDesc").val(),
				memAprvYn: memAprvYn,
				memPubYn: memPubYn,
				keyword:tags
				}; 
		
		$.post("registCommunity.do",
			   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){
		    	 $('#alertPopup').modal('show');
			  }else{
				 alert('신청 정보를 다시 확인해 주세요.');
			  } 
			} 
		);
	});
	$('#alertOk').click(function(){
		location.replace("community.do");
	});

});

</script>
<div class="container sub_cont">
                <div id="contents">
                    <div class="page-header sub_title">
                        <h2>커뮤니티 개설</h2>
                    </div>
                    <div class="page-body">
                        <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
                        <form id="writeFrm" class="form-horizontal">
                            <div class="well mb_10">
                                <fieldset>
                                    <legend class="sr-only">게시판 글작성</legend>
                                    <div class="brd_write_area">
                                        <div class="form-group">
                                            <label for="cmmntyNm" class="col-md-2 control-label"><span class="req">*</span> 커뮤니티 명</label>
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" id="cmmntyNm" required="required" />
                                            </div>
                                            <div class="col-md-2">
                                                <div class="checkbox-inline">
                                                    <label for="memAprvYn"><input type="checkbox" name="memAprvYn" id="memAprvYn" checked="checked" />승인후 가입</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="cmmntyDesc" class="col-md-2 control-label"><span class="req">*</span> 커뮤니티 설명</label>
                                            <div class="col-md-10">
                                                <textarea class="form-control" rows="5" id="cmmntyDesc" required="required"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inpKeyword" class="col-md-2 control-label">검색 키워드</label>
                                            <div class="col-md-10">
                                                <input type="text" id="inpKeyword" name="inpKeyword" data-role="tagsinput" class="form-control inp_keyword" />
                                                <p class="help-block"><i class="fa fa-exclamation-circle text-danger"></i> 최대 10개까지 등록 가능합니다. 입력후 엔터키를 눌러주세요.</p>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="mbPublic1" class="col-md-2 control-label">회원목록 공개여부</label>
                                            <div class="col-md-3">
                                                <label for="memPubY" class="radio-inline">
                                                    <input type="radio" id="memPubY" name="memPubYn" value="Y" checked/> 공개
                                                </label>
                                                <label for="memPubN" class="radio-inline">
                                                    <input type="radio" id="memPubN" name="memPubYn" value="N"/> 비공개
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="text-right">
                                <a href="#" class="btn btn-blue" id="btn_save">개설신청</a>
                                <a href="community.do" class="btn btn-black">취소</a>
                            </div>
                        </form>
                        <!-- //글작성 -->
                    </div>
                    <!-- 알림팝업 -->
                    <div class="modal fade" id="alertPopup" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
                        <div class="modal-dialog modal-sm" role="document">
                            <form class="modal-content">
                                <div class="modal-header sr-only">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="alertPopupLabel">알림</h4>
                                </div>
                                <div class="modal-body text-center">신청 되었습니다.<br />
                                	<strong class="text-danger">관리자 승인 후</strong> 개설 가능합니다. <br />
                                </div>
                                <div class="modal-footer text-center">
                                    <button type="button" class="btn btn-blue btn-sm" id="alertOk">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- //알림팝업 -->
                    <script src="/js/egovframework/com/wkp/comm.js"></script>
                </div>
                <!-- //CONTENTS -->
            </div>