<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(function() {
	var cmmntyNo = ${community.cmmntyNo};
    $('#btn_save').click(function(){
    	var gd = CKEDITOR.instances.cont.getData();
		var cont = btoa(unescape(encodeURIComponent(gd)));
        var showYn = $('input[name=showYn]:checked').val();
        var formData = new FormData();
	    formData.append("cmmntyNo", cmmntyNo);

	    formData.append("title", $('#title').val());
	    formData.append("cont", cont);
	    formData.append("showYn", showYn);
	    //formData.append("change_file1", change_file1);
	    //formData.append("change_file2", change_file2);
	    formData.append("file1", $('#file1')[0].files[0]);
	    
	    $.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "writeCommunityNotice.do",
	        data: formData,
	        processData: false,
	        contentType: false,
	        cache: false,
	        timeout: 600000,
	        success: function (data) {
	            location.href="communityNoticeList.do?cmmntyNo=${community.cmmntyNo }";
	        },
	        error: function (e) {
	            alert('저장 할 수 없습니다.');
	        }
	    });
    });
    	

});
</script>

<div class="container sub_cont">
                <div class="row layout_side_row">
                    <%@ include file="EgovCommunitySide.jsp" %>   
                    <!-- //ASIDE -->
                    <div id="contents" class="col-md-9">
                        <div class="page-header sub_title">
                            <h2>공지사항</h2>
                        </div>
                        <div class="page-body">
                            <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
                            <!-- 글작성 -->
                            <div id="writeFrm" class="form-horizontal">
                                <fieldset>
                                    <legend class="sr-only">게시판 글작성</legend>
                                    <div class="brd_write_area">
                                        <div class="form-group">
                                            <label for="title" class="col-sm-2 control-label"><span class="req">*</span> 제목</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="title" placeholder="제목를 입력하세요" required />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="cont" class="col-sm-2 control-label"><span class="req">*</span> 내용</label>
                                            <div class="col-sm-10">
                                               <textarea class="form-control" name="cont" rows="10" id="cont"
                                              required multiple></textarea>
                                              
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="file1" class="col-sm-2 control-label">첨부파일</label>
                                            <div class="col-sm-10">
                                                <input type="file" class="form-control" id="file1" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="showY" class="col-sm-2 control-label">공개범위</label>
                                            <div class="col-sm-10 tree_chk_area">
                                                <label for="showY" class="radio-inline">
                                                    <input type="radio" id="showY" name="showYn" value="Y" checked=""> 전체공개
                                                </label>
                                                <label for="showN" class="radio-inline">
                                                    <input type="radio" id="showN" name="showYn" value="N"> 멤버공개
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <button class="btn btn-blue" id="btn_save">작성완료</button>
                                        <a href="communityNoticeList.do?cmmntyNo=${community.cmmntyNo }" class="btn btn-black">취소</a>
                                    </div>
                                </fieldset>
                            </form>
                            <!-- //글작성 -->
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                </div>
                <!-- //row -->
            </div>



<script type="text/javascript" src="<c:url value='/js/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script type="text/javascript">
    CKEDITOR.replace('cont');
</script>            