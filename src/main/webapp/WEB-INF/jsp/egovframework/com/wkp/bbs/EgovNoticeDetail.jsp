<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
        <div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>공지사항</h2>
        			<div>${menuDesc }</div>
                </div>
                <!-- //page-header -->

                <div class="page-body">
                    <div class="brd_view_area">
                        <div class="view_header">
                            <strong class="subject">${noticeDetail.title }</strong>
                            <div class="row type0 info_view">
                                <div class="col-xs-12 col-sm-4">
                                    <span>작성일 : </span><span class="data">${noticeDetail.registDtm }</span>
                                </div>
                                <div class="col-xs-12 col-sm-8 info_txts">
                                    <span class="info_txt">조회 : <span class="data">${noticeDetail.inqCnt }</span></span>
                                    <span class="info_txt name">작성자 : <span class="data">${noticeDetail.displayName }</span></span>
                                </div>
                            </div>
                        </div>
                        <div class="view_body">
                        	${fn:replace(fn:replace(fn:replace(noticeDetail.cont, "&lt;", "<"), "&gt;", ">"),"&quot;","\'") }
                        </div>
                        <c:if test="${not empty fileList }">
                        <div class="info_grp files">
                        	<c:forEach var="file" items="${fileList }">
                        	<p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger" download>${file.orignlFileNm }</a> (${file.fileMg }K) <a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${file.fileStreCours }${file.streFileNm }" data-fid="NOTICE_${noticeDetail.noticeNo }">미리보기</a></p>
                        	</c:forEach>
                        </div>
                        </c:if>
                    </div>
                    <c:if test="${not empty fileList and fileType eq 'VIDEO' }">
                    <div class="data_area file_video">
						<c:forEach var="file" items="${fileList }">
	                    <video width="100%" controls="">
	                    	<source src="${file.fileStreCours}${file.streFileNm}" type="video/mp4">
	                    </video>
	                    </c:forEach>
                    </div>
                    </c:if>                    
                    <!-- //brd_view_area -->
	                <!-- 이전/다음 -->
	                <ul class="list-group post_nav">
	                    <li class="list-group-item">
						<c:choose>
							<c:when test="${noticePre != null }">
							<a href="javascript:;" class="dev-detail" data-noticeno="${noticePre.noticeNo }"><strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i>이전글</strong> : ${noticePre.title}</a>
							</c:when>
							<c:otherwise>
							<a href="javascript:;"><strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i>이전글</strong> : 이전 글이 없습니다.</a>
							</c:otherwise>
						</c:choose>
						</li>
	                    <li class="list-group-item">
	                    <c:choose>
	                    	<c:when test="${noticeNext != null}">
	                    		<a href="javascript:;" class="dev-detail" data-noticeno="${noticeNext.noticeNo}"><strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : ${noticeNext.title}</a>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<a href="javascript:;"><strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : 다음 글이 없습니다.</a>
	                    	</c:otherwise>
						</c:choose>
	                    </li>
	                </ul>
	                <!-- //이전/다음 -->
                    <div class="row brd_foot_btns">
                        <div class="col-sm-6 text-right">
                            <a href="javascript:;" class="btn btn-black dev-page">목록</a>
                        </div>
                    </div>
                </div>
                <!-- //page-body -->


            </div>
            <!-- //CONTENTS -->
        </div>
<form:form name="noticeFrm" modelAttribute="noticeVO">
	<input type="hidden" name="page" value="${noticeDetail.page }">
	<input type="hidden" name="noticeNo" value="0"> 
	<input type="hidden" name="searchText" value="${noticeDetail.searchText }"/>
</form:form>
		
<script>
    $(function () {

        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
            var page = $(this).data('page');
            var form = $("form[name=noticeFrm]");
            form.attr("action", "/bbs/noticeList.do");
            form.submit();
        });
        
        $('.dev-detail').on('click', function (e) {
        	e.preventDefault();
            var noticeNo = $(this).data('noticeno');
            var form = $("form[name=noticeFrm]");
            form.find("input[name=noticeNo]").val(noticeNo);
            form.submit();
        });
        
    });
</script>