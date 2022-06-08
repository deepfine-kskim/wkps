<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="container sub_cont">
    <div id="contents">
        <div class="page-header">
            <h2>지식 수정요청/승계</h2>
        </div>
        <!-- //page-header -->

        <div class="page-body">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="/myp/modificationList.do">지식 수정요청</a></li>
                <li role="presentation"><a href="/myp/succeedList.do">지식 승계</a></li>
            </ul>
            <div class="brd_view_area wiki_view">
                <div class="view_header">
                    <div class="subject">
                        <div class="cate_info">
                            <span class="text-danger">
							    <c:choose>
                                    <c:when test="${result.knowlgMapType eq 'REPORT'}">[행정자료]</c:when>
                                    <c:when test="${result.knowlgMapType eq 'REFERENCE'}">[업무참고자료]</c:when>
                                    <c:otherwise>[개인행정지식]</c:otherwise>
                                </c:choose>
							</span>
                            <div class="wiki_breadcrumb">
                                <ol class="breadcrumb">
                                    <li>${result.upNm}</li>
                                    <li class="active">${result.knowlgMapNm}</li>
                                </ol>
                            </div>
                        </div>
                        <c:out value="${result.title}"/>
                    </div>
                    <div class="row type0 info_view">
                        <div class="col-xs-12 col-sm-4">
                            <span>요청자 : </span><span class="data"><c:out value="${result.displayName}"/>(<c:out value="${result.ou}"/>)</span>
                        </div>
                        <div class="col-xs-12 col-sm-8 info_txts">
                            <span class="info_txt name">요청일 : <span class="data"><c:out value="${result.registDtm}"/></span></span>
                        </div>
                    </div>
                </div>
                <div class="view_body">
                    <dl class="well_dl">
                        <dt>수정 내용 요약</dt>
                        <dd class="well well-primary outline">
                            ${result.requestContent}
                        </dd>
                    </dl>
                    <c:forEach var="content" items="${contentList}" varStatus="status">
                        <c:if test="${status.first}">
                            <c:if test="${not empty content.subtitle}">
                                <dl class="wiki_index">
                                    <dt>목차</dt>
                                    <dd>
                                        <ul class="wiki_index_list">
                                            <c:forEach var="indexContents" items="${contentList}">
                                                <li>
                                                    <a href="#wikiDoc${indexContents.sortOrdr}"><span class="num">${indexContents.sortOrdr}.</span> ${indexContents.subtitle}</a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </dd>
                                </dl>
                            </c:if>
                        </c:if>
                        <c:if test="${not empty content.subtitle}">
                            <div id="wikiDoc${content.sortOrdr}" class="wiki_box">
                                <div class="wiki_header">
                                    <h2 class="h2"><span class="num">${content.sortOrdr}.</span> ${content.subtitle}</h2>
                                </div>
                                <div class="wiki_body">
                                    <div class="wiki_paras">
                                            ${content.cont}
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${empty content.subtitle}">
                            <div id="wikiDoc${content.sortOrdr}" class="wiki_box">
                                <div class="wiki_body">
                                    <div class="wiki_paras">
                                            ${content.cont}
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <!-- //brd_view_area -->

            <!-- //이전/다음 -->
            <div class="row brd_foot_btns">
                <div class="col-sm-6">
                    <a href="javascript:;" id="updBtn" class="btn btn-blue">적용</a>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="javascript:;" class="btn btn-black dev-page">목록</a>
                </div>
            </div>
        </div>
        <!-- //page-body -->

    </div>
    <!-- //CONTENTS -->
</div>
<form name="searchForm">
    <input type="hidden" name="page" value="${knowledgeVO.page}">
    <input type="hidden" name="searchText" value="${knowledgeVO.searchText}"/>
</form>
<form name="knowledgeFrm">
    <input type="hidden" name="title" value="${result.title}">
    <input type="hidden" name="requestNo" value="${knowledgeVO.requestNo}">
</form>
<script>
    $(function () {
        $('.dev-page').on('click', function (e) {
            const form = $("form[name=searchForm]");
            form.attr('action', '/myp/modificationList.do');
            form.submit();
        });

        $('#updBtn').click(function(e){
            e.preventDefault();
            const form = $("form[name=knowledgeFrm]");
            form.attr("action", "/kno/updateKnowledgeView.do");
            form.submit();
        });
    });
</script>
<c:if test="${not empty myBG }">
<style>
body{
	background-image:url("${myBG[0].fileStreCours }${myBG[0].streFileNm }");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
</c:if>