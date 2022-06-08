<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/jsp/tld/CommonUtil.tld" %>

<div class="container sub_cont">
	<div id="contents">
	    <div class="page-header">
	        <h2>개선의견</h2>
	    </div>
	    <!-- //page-header -->
        <div class="page-body">
            <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
            <!-- 글작성 -->
            <form id="writeFrm" name="writeFrm" class="form-horizontal" method="post" encType="multipart/form-data">
                <input type="hidden" value="<c:out value="${result.improvementNo}"/>" name="improvementNo">
                <fieldset>
                    <legend class="sr-only">게시판 글작성</legend>
                    <div class="brd_write_area">
                        <div class="form-group">
                            <label for="inpSubject" class="col-sm-1 control-label"><span class="req">*</span>제목</label>
                            <div class="col-sm-11">
                                <input type="text" class="form-control no-enter-submit" name="title" id="inpSubject" placeholder="제목를 입력하세요" required value="<c:out value="${result.title}"/>"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inpText" class="col-sm-1 control-label"><span class="req">*</span>내용</label>
                            <div class="col-sm-11">
                                <textarea class="form-control" rows="10" id="inpText" required multiple><c:out value="${result.cont}"/></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inpFile1" class="col-sm-1 control-label">첨부파일</label>
                            <div class="col-sm-11">
                                <input type="file" class="form-control" id="inpFile1" name="file" />
                                <%--<c:if test="${not empty result.atchFileNo}">
                                    <a href="/cmm/fms/FileDown.do?atchFileNo=${result.atchFileNo }&fileSn=${result.fileSn }" class="text-danger">${result.orignlFileNm}</a> (${cutil:out(result.fileSize)})
                                    <a href="/cmm/fms/deleteFileInfs.do?atchFileNo=${result.atchFileNo }&fileSn=${result.fileSn }"><i class="remove">x</i></a>
                                    <input type="hidden" name="atchFileNo" value="${result.atchFileNo}">
                                </c:if>--%>
                            </div>
                        </div>
                    </div>
                    <div class="text-right">
                        <button type="button" class="btn btn-blue flow-action-submit">작성완료</button>
                        <a href="/qna/improvementList.do" class="btn btn-black">취소</a>
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
<script type="text/javascript" src="<c:url value='/js/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script type="text/javascript">
    CKEDITOR.replace('inpText');
    $(document).ready(function () {
        $('.flow-action-submit').off('click').on('click', function () {
            if ($("#inpSubject").val() == '') {
                alert("제목을 입력해주세요.");
                return false;
            }

            var content = CKEDITOR.instances.inpText.getData();
            if(content == "" || content == "<br>" || content == "<br />" || content == "&nbsp;" ) {
                alert("내용을 입력해주세요.");
                return false;
            }

            if (confirm('답변이 달린 후에는 수정/삭제가 불가능합니다. 등록하시겠습니까?')) {
                const formData = new FormData(document.writeFrm);
                formData.append("cont", content);

                $.ajax({
                    url: "/qna/improvementSave.do",
                    type: 'post',
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: 'json',
                    enctype: 'multipart/form-data',
                    success: function (data) {
                        location.href = '/qna/improvementList.do';
                    },
                    error: function (error) {
                        alert('처리 중 오류가 발생했습니다.');
                    }
                });
            }
        });
    });
</script>