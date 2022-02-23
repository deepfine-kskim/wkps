<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<script src="/js/egovframework/com/wkp/paging.js"></script>
<script>
var cmmntyNo = ${community.cmmntyNo};
$(function() {
    $('.dev-page').on('click', function (e) {
    	e.preventDefault();
        var page = $(this).data('page');
        var form = $("form[name=knowledgeFrm]");
        form.find("input[name=page]").val(page);
        form.submit();
    });
    
    $('.dev-detail').on('click', function (e) {
    	e.preventDefault();
        var knowlgNo = $(this).data('knowlgno');
        var title = $(this).data('title');
        var form = $("form[name=knowledgeFrm]");
        form.find("input[name=knowlgNo]").val(knowlgNo);
        form.find("input[name=title]").val(title);
        form.attr("action", "/kno/knowledgeDetail.do?cmmntyNo="+cmmntyNo);
        form.submit();
    });
    
 	$('.dev-type').on('click', function(e) {
    	e.preventDefault();
 		var type = $(this).data('type');
        var form = $("form[name=knowledgeFrm]");
        form.find("input[name=knowlgMapType]").val(type);
        form.submit();
 	});	
});
</script>
<div class="container sub_cont">
                <div class="row layout_side_row">
                    <%@ include file="EgovCommunitySide.jsp" %>  
                    <!-- //ASIDE -->
                    <div id="contents" class="col-md-9">
                        <div class="page-header sub_title">
                            <h2>지식 게시판</h2>
                        </div>
                        <div class="page-body">
                            <div class="row type5 top_opt_row">
                                <div class="col-xs-12 col-sm-4">
                                </div>
                                <form:form class="form-inline bbs_srch_frm" name="knowledgeFrm" modelAttribute="knowledgeVO">
                                <div class="col-xs-12 col-sm-8 text-right">
                                	<input type="hidden" name="page" value="${knowledgeList.pageNavigation.pageIndex}">
                                	<input type="hidden" name="knowlgNo" value="0">
                                	<input type="hidden" name="title" value="">
                                	<input type="hidden" name="knowlgMapType" value="${knowlgMapType}">
                                    <div class="form-inline bbs_srch_frm">
                                        <fieldset>
                                            <legend class="sr-only">게시글 검색</legend>
                                            <div class="form-group">
                                                <label for="wikiSrchSel" class="sr-only">검색대상</label>
                                                <select id="wikiSrchSel" class="form-control">
                                                    <option>제목 + 내용</option>
                                                    <option>제목</option>
                                                    <option>내용</option>
                                                </select>
                                            </div>
                                            <div class="input-group">
                                                <label for="wikiSrchStr" class="sr-only">검색어 입력</label>
                                                <input type="text" id="wikiSrchStr" name="wikiSrchStr" class="form-control" placeholder="검색어" />
                                                <span class="input-group-btn"><button type="submit" class="btn btn-default">검색</button></span>
                                            </div>
                                        </fieldset>
                                    </div>
                                </div>
                                </form:form>
                            </div>
                            <!-- //row -->
                            <!-- 게시판 목록 -->
                            <div class="table-responsive">
                                <table class="table text-center table-bordered table-hover brd_list">
                                    <caption class="sr-only">게시판 목록</caption>
                                    <colgroup>
                                        <col style="width:9%;">
                                        <col style="width:9%;">
                                        <col>
                                        <col style="width:10%;">
                                        <col style="width:12%;">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">번호</th>
                                            <th scope="col">유형</th>
                                            <th scope="col">제목</th>
                                            <th scope="col">작성자</th>
                                            <th scope="col">등록일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                    	<c:when test="${not empty knowledgeList.list && fn:length(knowledgeList.list) > 0 }">
                                    	<c:forEach var="knowledge" items="${knowledgeList.list }" varStatus="status">
                                        <tr>
                                            <td>${knowledgeList.pageNavigation.totalItemCount - ((knowledgeList.pageNavigation.pageIndex - 1) * knowledgeList.pageNavigation.itemCountPerPage + status.index) }</td>
                                            <td class="text-primary">
                                            	개인별지식
                                            </td>
                                            <td class="text-left">
                                                <p class="subject">
                                                    <a href="javascript:;" class="dev-detail" data-knowlgno="${knowledge.knowlgNo }" data-title="${knowledge.title }">${knowledge.title }</a>
                                                    <span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span>
                                                </p>
                                            </td>
                                            <td>${knowledge.displayName }</td>
                                            <td>${knowledge.registDtm }</td>
                                        </tr>
                                    	</c:forEach>
                                    	</c:when>
                                        <c:otherwise>
                                        <!-- 데이터 없을시 -->
                                        <tr>
                                            <td colspan="5" class="empty">등록된 게시글이 없습니다.</td>
                                        </tr>
                                        <!-- //데이터 없을시 -->
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <!-- //게시판 목록 -->
                            <!-- 페이지 네비 -->
                            <nav class="text-center">
		                        <ul class="pagination pagination-sm">
		                        <c:if test="${knowledgeList.pageNavigation.totalItemCount > 0 }">
		                            <c:if test="${knowledgeList.pageNavigation.canPreviousSection == true }">
		                            <li>
		                                <a href="javascript:;" aria-label="Previous" title="처음" class="dev-page" data-page="1">
		                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
		                                </a>
		                            </li>
		                            <li>
		                                <a href="javascript:;" aria-label="Previous" title="이전" onclick="return false;" class="dev-page" data-page="${knowledgeList.pageNavigation.numberStart-1 }">
		                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
		                                </a>
		                            </li>
		                            </c:if>
		                            
		                            <c:forEach var="i" begin="${knowledgeList.pageNavigation.numberStart }" end="${knowledgeList.pageNavigation.numberEnd }" step="1">
		                            <li <c:if test="${i == knowledgeList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" class="dev-page" data-page="${i}">${i}</a></li>
		                            </c:forEach>
		
		                            <c:if test="${knowledgeList.pageNavigation.canNextSection == true}">
		                            <li>
		                                <a href="javascript:;" aria-label="Next" title="다음" class="dev-page" data-page="${knowledgeList.pageNavigation.numberEnd+1 }">
		                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
		                                </a>
		                            </li>
		                            <li>
		                                <a href="javascript:;" aria-label="Next" title="마지막" class="dev-page" data-page="${knowledgeList.pageNavigation.maxNumber }">
		                                    <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
		                                </a>
		                            </li>
		                            </c:if>
		                        </c:if>
		                        </ul>
                            </nav>
                            <!-- //페이지 네비 -->
                            <div class="btn_area text-right">
                                <a href="/kno/insertKnowledgeView.do?cmmntyNo=${community.cmmntyNo}" class="btn btn-blue"><i class="ti-pencil-alt"></i> 등록하기</a>
                            </div>
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                    <!-- 게시판관리 팝업 -->
                    <div class="modal fade" id="brdSettingPopup" tabindex="-1" role="dialog" aria-labelledby="brdSettingPopupLabel">
                        <div class="modal-dialog" role="document">
                            <form class="modal-content form-horizontal">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="brdSettingPopupLabel"><strong>게시판 관리</strong></h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label for="brdTitle" class="col-sm-3 control-label">게시판 제목</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="brdTitle" name="brdTitle" value="자유게시판" />
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <strong class="col-sm-3 control-label">이용권한</strong>
                                        <div class="col-sm-8">
                                            <label for="brdAut1" class="radio-inline">
                                                <input type="radio" id="brdAut1" name="brdAut"> 게시판 스텝
                                            </label>
                                            <label for="brdAut2" class="radio-inline">
                                                <input type="radio" id="brdAut2" name="brdAut"> 회원관리 스텝
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                                    <button type="button" class="btn btn-black" data-dismiss="modal">취소</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- //게시판관리 팝업 -->
                </div>
                <!-- //row -->
            </div>