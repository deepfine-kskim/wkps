<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<script>

$(function() {
	
    $('#btn_save').click(function(){
    	
	    var formData = new FormData();

	    if( $('#title').val() != ''){
		    formData.append("title", $('#title').val());
	    } else{
			alert("제목을 입력해주세요.");
			return false;
	    }

	    /*
	    if( $('#link').val() != ''){
		    formData.append("link", $('#link').val());
	    } else{
			alert("링크를 입력해주세요.");
			return false;
	    }
		*/
		
	    formData.append("link", $('#link').val());
		
	    if( $('#image')[0].files[0] != undefined){
		    formData.append("image", $('#image')[0].files[0]);
	    } else{
			alert("이미지를 등록해주세요.");
			return false;
	    }
	    
	    formData.append("etc", $('#etc').val());
	    formData.append("useYn",$("input:radio[name='useYn']:checked").val());

	    $.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "writeCommunityBanner.do",
	        data: formData,
	        processData: false,
	        contentType: false,
	        cache: false,
	        timeout: 600000,
	        success: function (data) {
	            location.href="commBnr.do";
	        },
	        error: function (e) {
	            alert('저장 할 수 없습니다.');
	        }
	    });
    });
    
    $('#btn_preview').click(function(){
    	if($('#image')[0].files[0] == null){
    		alert('이미지를 선택해 주세요.');
    		return;
    	}
    	var reader = new FileReader(); 
    	reader.onload = function(event) { 
    		
    		$('#img_priview').attr("src", event.target.result);
    		 
    	}; 
    	reader.readAsDataURL($('#image')[0].files[0]);

    });
	
});

</script>
<div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">
                            배너 관리                                    </h2>
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
                    <li>커뮤니케이션 관리</li>
                                        <li class="active">배너 관리</li>
                                    </ol>
                                <div id="contents">
                    <!-- 글작성 -->
                    <div class="well well-lg well-white">
                    <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
                    <div id="writeFrm" class="form-horizontal">
                        <fieldset>
                            <legend class="sr-only">게시판 글작성</legend>
                            <div class="brd_write_area">
                                <div class="form-group">
                                    <label for="title" class="col-xs-2 control-label"><span class="req">*</span> 커뮤니티 명</label>
                                    <div class="col-xs-7">
                                        <input type="text" class="form-control" id="title" required />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="image" class="col-xs-2 control-label"><span class="req">*</span>배너 이미지</label>
                                    <div class="col-xs-7">
                                        <input type="file" class="form-control" id="image" required />
                                    </div>
                                    <div class="col-xs-3">
                                        <button type="button" class="btn btn-warning" id="btn_preview">미리보기</button>
                                    </div>
                                    <div class="col-xs-12 col-xs-push-2">
                                        <p class="help-block"><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 커뮤니티 배너는 700 X 300 픽셀에 최적화 되어 있습니다.</p>
                                        <div class="bnr_preview">
                                            <img id="img_priview" class="img-responsive" alt=""/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="link" class="col-xs-2 control-label">링크</label>
                                    <div class="col-xs-7">
                                        <input type="text" class="form-control" id="link" placeholder="URL을 입력하세요">
                                    </div>
                                </div>
                                <div class="inp_set_area">
                                <div class="form-group">
                                    <label for="svPublic1" class="col-xs-2 control-label"><span class="req">*</span> 노출여부</label>
                                    <div class="col-xs-10">
                                        <label for="svPublic1" class="radio-inline">
                                            <input type="radio" id="svPublic1" name="useYn" class="inp_tog" checked value="Y"> 노출
                                        </label>
                                        <label for="svPublic2" class="radio-inline">
                                            <input type="radio" id="svPublic2" name="useYn" value="N"> 미노출
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group inp_tog_cont">
                                    <label for="svPublic1" class="col-xs-2 control-label">순서설정</label>
                                    <div class="col-xs-1">
                                        <input type="number" class="form-control" maxlength="2" min="1" max="99" />
                                    </div>
                                    <div class="col-xs-12 col-xs-push-2">
                                        <p class="help-block"><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i>순서를 설정합니다. 번호를 입력해주세요.</p>
                                    </div>
                                </div>
                                </div>
                                <div class="form-group">
                                    <label for="etc" class="col-xs-2 control-label">비고</label>
                                    <div class="col-xs-10">
                                        <textarea class="form-control" rows="3" id="etc"></textarea>
                                    </div>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    </div>
                    <div class="text-right">
                        <button class="btn btn-blue btn-lg" id="btn_save">작성완료</button>
                        <a href="commBnr.do" class="btn btn-black btn-lg">취소</a>
                    </div>

                    <!-- //글작성 -->
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