<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/jsp/tld/CommonUtil.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="container sub_cont">
	<div id="contents">
	    <div class="page-header">
	        <h2>지식요청</h2>
        	<div>${menuDesc }</div>
	    </div>
	    <!-- //page-header -->
        <div class="page-body">
            <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
            <!-- 글작성 -->
            <form:form id="writeFrm" class="form-horizontal" action="/req/insertRequest.do" modelAttribute="reqVO" method="post" encType="multipart/form-data">
                <fieldset>
                    <legend class="sr-only">게시판 글작성</legend>
                    <div class="brd_write_area">
                        <%--
                        <div class="form-group">
                            <label for="inpCate" class="col-sm-1 control-label"><span class="req">*</span> 유형</label>
                            <div class="col-sm-3">
                                <form:select id="typeSel" path="knowlgMapType" class="form-control">
                                    <option value="">선택해주세요.</option>
                                    <option value="REPORT">행정자료</option>
                                    <option value="REFERENCE">업무참고자료</option>
                                    <option value="PERSONAL">개인행정지식</option>
                                </form:select>
                            </div>
                        </div>
                        --%>
                        <div class="form-group">
                            <label for="inpSubject" class="col-sm-1 control-label"><span class="req">*</span>제목</label>
                            <div class="col-sm-10 col-md-10 col-lg-7">
                                <input type="text" class="form-control" name="title" id="inpSubject" placeholder="제목를 입력하세요" required />
                            </div>
                            <div class="col-lg-3 col-lg-push-0 col-md-10 col-md-push-2">
                                <div class="checkbox-inline">
                                    <label for="anonYn"><input type="checkbox" name="anonYn" id="anonYn" value="Y" />익명게시물 설정</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inpText" class="col-sm-1 control-label"><span class="req">*</span>내용</label>
                            <div class="col-sm-11">
                                <textarea class="form-control" name="cont" id="inpText" required></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inpFile1" class="col-sm-1 control-label">첨부파일</label>
                            <div class="col-sm-11">
                                <input type="file" class="form-control" id="inpFile1" name="file" />
                            </div>
                        </div>
                    </div>
                    <div class="text-right">
                        <button type="submit" class="btn btn-blue">작성완료</button>
                        <a href="/req/requestList.do" class="btn btn-black">취소</a>
                    </div>
                </fieldset>
            </form:form>
            <!-- //글작성 -->
        </div>
        <!-- //page-body -->
    </div>
    <!-- CONTENTS -->
</div>
<form:form name="requestFrm" modelAttribute="reqVO">
	<input type="hidden" name="page" value="${page }"> 
	<input type="hidden" name="searchText" value="${searchText }"/>
</form:form>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script type="text/javascript">
    CKEDITOR.replace('inpText');
    
	$(function() {
        var form = $("#writeFrm");
        form.submit(function() {
            if($('#typeSel').val() === ''){
            	alert("유형을 선택해주세요.");
            	return false;
            }
            
            var content = CKEDITOR.instances.inpText.getData();
            if(content == "" || content == "<br>" || content == "<br />" || content == "&nbsp;" ) {
                alert("질문의 내용을 입력해주세요.");
                return false;
            }
        });
        
        $('.dev-cancle').on('click', function (e) {
        	e.preventDefault();
            var form = $("form[name=requestFrm]");
            form.attr("action", "/req/requestList.do");
            form.submit();
        });

    });
</script>