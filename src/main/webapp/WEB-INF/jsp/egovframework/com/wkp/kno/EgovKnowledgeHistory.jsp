<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<div class="container sub_cont">
    <div class="page-header">
        <h2>지식백과</h2>
        <div>${menuDesc}</div>
    </div>
    <!-- //page-header -->
    <div class="row layout_side_row">
        <!-- //ASIDE -->
        <div id="contents" class="col-md-9">
            <div class="page-body">
                <div class="brd_view_area wiki_view">
                    <div class="view_header">
                        <div class="subject">
                            <div class="cate_info">
                                <span class="text-danger">
                                <c:choose>
                                    <c:when test="${knowledgeDetail.knowlgMapType eq 'REPORT'}">[행정자료]</c:when>
                                    <c:when test="${knowledgeDetail.knowlgMapType eq 'REFERENCE'}">[업무참고자료]</c:when>
                                    <c:otherwise>[개인행정지식]</c:otherwise>
                                </c:choose>
                                </span>
                                <div class="wiki_breadcrumb">
                                    <ol class="breadcrumb">
                                        <li>${knowledgeDetail.upNm}</li>
                                        <li class="active">${knowledgeDetail.knowlgMapNm}</li>
                                    </ol>
                                </div>
                            </div>
                            ${knowledgeDetail.title}
                        </div>
                        <div class="row type0 info_view">
                            <div class="col-xs-12 col-sm-4">
                                <span>작성자 : </span><span class="data">${knowledgeDetail.displayName}(${knowledgeDetail.ou})</span>
                            </div>
                            <div class="col-xs-12 col-sm-8 info_txts">
                                <span class="info_txt name">등록일 : <span class="data">${knowledgeDetail.registDtmStr}</span></span>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty fileList}">
                        <div class="info_grp files">
                            <c:forEach var="file" items="${fileList}">
                            <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo}&fileSn=${file.fileSn}" class="text-danger">${file.orignlFileNm}</a> (${file.fileMg}K) <a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${file.fileStreCours}${file.streFileNm}" data-fid="KNO_${knowledgeDetail.knowlgNo}">미리보기</a></p>
                            </c:forEach>
                        </div>
                    </c:if>
                    <div class="view_body">
                        <c:if test="${not empty knowledgeDetail.summry}">
                            <dl class="well_dl">
                                <dt>요약</dt><!-- 09.15 리뷰용 수정 -->
                                <dd class="well well-primary outline">
                                    ${knowledgeDetail.summry}
                                </dd>
                            </dl>
                        </c:if>
                        <c:forEach var="contents" items="${knowledgeContentsList}" varStatus="status">
                            <c:if test="${status.first}">
                                <c:if test="${not empty contents.subtitle}">
                                    <dl class="wiki_index">
                                        <dt>목차</dt>
                                        <dd>
                                            <ul class="wiki_index_list">
                                                <c:forEach var="indexContents" items="${knowledgeContentsList}">
                                                    <li>
                                                        <a href="#wikiDoc${indexContents.sortOrdr}"><span class="num">${indexContents.sortOrdr}.</span> ${indexContents.subtitle}</a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </dd>
                                    </dl>
                                </c:if>
                            </c:if>
                            <c:if test="${not empty contents.subtitle}">
                                <div id="wikiDoc${contents.sortOrdr}" class="wiki_box">
                                    <div class="wiki_header">
                                        <h2 class="h2"><span class="num">${contents.sortOrdr}.</span> ${contents.subtitle}</h2>
                                    </div>
                                    <div class="wiki_body">
                                        <div class="wiki_paras">
                                            ${contents.cont}
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${empty contents.subtitle}">
                                <div id="wikiDoc${contents.sortOrdr}" class="wiki_box">
                                    <div class="wiki_body">
                                        <div class="wiki_paras">
                                            ${contents.cont}
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${not empty relateKnowledgeList}">
                            <div class="panel panel-primary panel-sm wiki_panel">
                                <div class="panel-heading">
                                    <strong class="panel-title">관련 지식</strong>
                                </div>
                                <div class="panel-body">
                                    <ul class="dot_list">
                                        <c:forEach var="relate" items="${relateKnowlgVO}">
                                            <c:url value="/kno/knowledgeDetail.do" var="url">
                                                <c:param name="title" value="${relate.title}" />
                                            </c:url>
                                            <li><a href="${url}" target="_blank" title="새창열림">${relate.title}</a>
                                            <%-- <a href="/kno/deleteRelateKnowlg.do?relateKnowlgNo=${relate.relateKnowlgNo}&sortOrdr=${relate.sortOrdr}">&nbsp;&nbsp;<i class="remove">x</i></a><span class="sr-only">삭제</span> --%>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
                <!-- //brd_view_area -->
                <div class="wiki_keywords">
                    <a href="#">${knowledgeDetail.keyword}</a>
                </div>
            </div>
            <!-- //page-body -->
        </div>
        <!-- CONTENTS -->
    </div>
    <!-- //row -->
</div>
<!-- CONTENTS -->
<script type="text/javascript" src="<c:url value='/js/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script src="/js/egovframework/com/wkp/clipboard.min.js"></script>
<script>
	CKEDITOR.replace('inpText');

	var clipboard = new ClipboardJS('.btn');

	clipboard.on('success', function(e) {
	    alert('URL이 복사 되었습니다. 원하시는 곳에 붙여넣기 해 주세요.');
	});

	clipboard.on('error', function(e) {
		alert('이 브라우저는 지원하지 않습니다.');
	});
</script>