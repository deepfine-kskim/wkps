<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
        <div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>이용안내</h2>
        			<div>${menuDesc }</div>
                </div>
                <!-- //page-header -->

                <div class="page-body">
		            <ul class="nav nav-tabs" role="tablist">
		                <li role="presentation"><a href="/qna/list.do">Q&A</a></li>
		                <li role="presentation" class="active"><a href="/qna/faqList.do">FAQ</a></li>
		            </ul>
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" <c:if test="${faqType eq 'KNOWLEDGE'}">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="KNOWLEDGE">지식백과</a></li>
                        <li role="presentation" <c:if test="${faqType eq 'REQUEST'}">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="REQUEST">지식요청</a></li>
                        <li role="presentation" <c:if test="${faqType eq 'SURVEY'}">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="SURVEY">설문조사</a></li>
                        <li role="presentation" <c:if test="${faqType eq 'COMMUNITY'}">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="COMMUNITY">커뮤니티</a></li>
                        <li role="presentation" <c:if test="${faqType eq 'QNA'}">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="QNA">Q&A</a></li>
                        <li role="presentation" <c:if test="${faqType eq 'FAQ'}">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="FAQ">FAQ</a></li>
                        <li role="presentation" <c:if test="${faqType eq 'NOTICE'}">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="NOTICE">공지사항</a></li>
                        <li role="presentation" <c:if test="${faqType eq 'CALENDAR'}">class="active"</c:if>><a href="javascript:;" class="dev-type" data-type="CALENDAR">일정</a></li>
                    </ul>
                    <!-- 총게시물, 게시물 검색 -->
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 data_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${faqList.pageNavigation.totalItemCount }</span> / 페이지 <span class="text-black">${faqList.pageNavigation.pageIndex }</span></p>
                            </div>
                            <div class="col-xs-12 col-sm-6 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="faqFrm" modelAttribute="faqVO"> 
                                    <input type="hidden" name="page" value="${faqList.pageNavigation.pageIndex }">
									<input type="hidden" name="faqType" value="${faqType }">
                                    <input type="hidden" name="faqNo" value="0">
                                    <fieldset> 
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="form-group">
                                            <label for="brdSrchSel" class="sr-only">검색대상</label>
                                            <form:select id="brdSrchSel" path="searchType" class="form-control">
                                                <option value="TITLE">제목</option>
                                                <option value="REGISTER_ID">작성자</option>
                                            </form:select>
                                        </div>
                                        <div class="input-group">
                                            <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                            <input type="text" id="brdSrchStr" name="searchText" class="form-control" placeholder="검색어" value="${searchText }"/>
                                            <span class="input-group-btn"><button type="submit" class="btn btn-default">검색</button></span>
                                        </div>
                                    </fieldset>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    <!-- //총게시물, 게시물 검색 -->
                    <!-- 게시판 FAQ 리스트 -->
                    <div class="panel-group faq" id="faqList">
                    <c:choose>
                        <c:when test="${!empty faqList.list && fn:length(faqList.list) > 0}">
                    	<c:forEach var="faq" items="${faqList.list }" varStatus="status" >
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <a class="panel-title accordion-toggle collapsed" data-toggle="collapse" data-parent="#faqList" href="#collapse${status.index }">    <!--- / href 속성값 아이디 맞출것 -->
                                    <span class="faq_q">${faq.title }</span>
                                </a>
                            </div>
                            <div id="collapse${status.index }" class="panel-collapse collapse">    <!--- / 아이디값 1씩 증가할것 -->
                                <div class="panel-body">
                                    <div class="faq_a text-justify">
										${fn:replace(fn:replace(fn:replace(faq.cont, "&lt;", "<"), "&gt;", ">"), "&quot;","\'") }
                                    </div>
                                    <c:if test="${not empty faq.fileList }">
			                        <div class="info_grp files">
			                        	<c:forEach var="file" items="${faq.fileList }">
			                        	<p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger" download>${file.orignlFileNm }</a> (${file.fileMg }K) <a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${file.fileStreCours }${file.streFileNm }" data-fid="REQUEST_${requestDetail.requstNo }">미리보기</a></p>
			                        	</c:forEach>
			                        </div>
			                        </c:if>
                                </div>
                            </div>
                        </div>
						</c:forEach>
						</c:when>
					</c:choose>
                    </div>
                    <!-- //게시판 FAQ 리스트 -->
                    <!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul class="pagination pagination-sm">
                        <c:if test="${faqList.pageNavigation.totalItemCount > 0 }">
                            <c:if test="${faqList.pageNavigation.canPreviousSection == true }">
                            <li>
                                <a href="#" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Previous" title="이전" onclick="return false;"
                                   class="dev-page" data-page="${faqList.pageNavigation.numberStart-1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach var="i" begin="${faqList.pageNavigation.numberStart }" end="${faqList.pageNavigation.numberEnd }" step="1">
                            <li <c:if test="${i == faqList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" onclick="return false;" class="dev-page" data-page="${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${faqList.pageNavigation.canNextSection == true}">
                            <li>
                                <a href="#" aria-label="Next" title="다음" class="dev-page" data-page="${faqList.pageNavigation.numberEnd+1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Next" title="마지막" class="dev-page"
                                   data-page="${faqList.pageNavigation.maxNumber }">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                        </c:if>
                        </ul>
                    </nav>
                    <!-- //페이지 네비 -->

                </div>
                <!-- //page-body -->


            </div>
            <!-- //CONTENTS -->
        </div>
        
<script>
    $(function () {

        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
        	var page = $(this).data('page');
            var form = $("form[name=faqFrm]");
            form.find("input[name=page]").val(page);
            form.submit();
        });
        
        $('.dev-type').on('click', function () {
            var faqType = $(this).data('type');
            var form = $("form[name=faqFrm]");
            form.find("input[name=faqType]").val(faqType);
            form.submit();
        });
        
    });
</script>