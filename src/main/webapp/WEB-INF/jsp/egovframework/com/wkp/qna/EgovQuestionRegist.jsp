<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld" %>

<div class="container sub_cont">
	<div id="contents">
	    <div class="page-header">
	        <h2>Q&A</h2>
	    </div>
	    <!-- //page-header -->
        <div class="page-body">
            <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
            <!-- 글작성 -->
            <form id="writeFrm" class="form-horizontal" method="post" encType="multipart/form-data">
                <input type="hidden" value="${detail.questionNo}" name="questionNo">
                <fieldset>
                    <legend class="sr-only">게시판 글작성</legend>
                    <div class="brd_write_area">
                        <div class="form-group">
                            <label for="inpSubject" class="col-sm-1 control-label"><span class="req">*</span>제목</label>
                            <div class="col-sm-11">
                                <input type="text" class="form-control" name="title" id="inpSubject"
                                       placeholder="제목를 입력하세요" required value="${detail.title}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inpText" class="col-sm-1 control-label"><span class="req">*</span>내용</label>
                            <div class="col-sm-11">
                                <textarea class="form-control" name="cont" rows="10" id="inpText" required multiple>${detail.cont}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inpFile1" class="col-sm-1 control-label">첨부파일</label>
                            <div class="col-sm-11">
                                <input type="file" class="form-control" id="inpFile1" name="file" />
                                <c:if test="${not empty detail.atchFileNo}">
                                    <a href="/cmm/fms/FileDown.do?atchFileNo=${detail.atchFileNo }&fileSn=${detail.fileSn }" class="text-danger">${detail.orignlFileNm}</a> (${cutil:out(detail.fileSize)})
                                    <a href="/cmm/fms/deleteFileInfs.do?atchFileNo=${detail.atchFileNo }&fileSn=${detail.fileSn }"><i class="remove">x</i></a>
                                    <input type="hidden" name="atchFileNo" value="${detail.atchFileNo}">
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="text-right">
                        <button type="submit" class="btn btn-blue">작성완료</button>
                        <a href="/qna/list.do" class="btn btn-black">취소</a>
                    </div>
                </fieldset>
            </form>
            <!-- //글작성 -->
        </div>
        <!-- //page-body -->
    </div>
    <!-- CONTENTS -->
</div>


<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script type="text/javascript">
    CKEDITOR.replace('inpText');
    $(document).ready(function () {
        var form = $("#writeFrm");
        form.submit(function () {

            if ($("#inpSubject").val() == '') {
                alert("질문의 제목을 입력해주세요.");
                return false;
            }

            var content = CKEDITOR.instances.inpText.getData();
            if(content == "" || content == "<br>" || content == "<br />" || content == "&nbsp;" ) {
                alert("질문의 내용을 입력해주세요.");
                isSubmit = true;
                return false;
            }

            var question = "답변이 달린 후에는 수정/삭제가 불가능합니다. 등록하시겠습니까?";
            form.attr('action', '/qna/questionWriteProc.do');

            <c:if test="${detail.questionNo != null or detail.questionNo > 0}">
            question = "수정하시겠습니까?";
            form.attr('action', '/qna/questionUpdateProc.do');
            </c:if>

            if (!confirm(question)) {
                return false;
            }
        }); // end submit()

    }); // end ready()
</script>