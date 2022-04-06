<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container sub_cont">
    <div id="contents">
	    <div class="page-header">
	        <h2>이용안내</h2>
        	<div><c:out value="${menuDesc}"/></div>
	    </div>
	    <!-- //page-header -->
	    <div class="page-body">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation"><a href="/qna/faqList.do">FAQ</a></li>
                <li role="presentation"><a href="/qna/list.do">Q&A</a></li>
				<li role="presentation" class="active"><a href="/qna/improvementList.do">홈페이지 개선요청</a></li>
            </ul>
	        <!-- 총게시물, 게시물 검색 -->
	        <div class="brd_top">
	            <div class="row">
	                <div class="col-xs-12 col-sm-6 data_total">
	                    <p>
	                        <i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${pageNavigation.totalItemCount}</span> / 페이지 <span class="text-black"><c:out value="${improvementVO.page}"/></span>
	                    </p>
	                </div>
	                <div class="col-xs-12 col-sm-6 text-right">
	                    <form class="form-inline bbs_srch_frm" name="searchForm">
	                        <fieldset>
	                            <legend class="sr-only">게시글 검색</legend>
	                            <div class="form-group">
	                                <label for="brdSrchSel" class="sr-only">검색대상</label>
	                                <select id="brdSrchSel" name="searchType" class="form-control">
	                                    <option value="TITLE" <c:if test="${improvementVO.searchType == 'TITLE'}">selected="selected"</c:if>>제목</option>
	                                    <option value="DISPLAY_NAME" <c:if test="${improvementVO.searchType == 'DISPLAY_NAME'}">selected="selected"</c:if>>작성자</option>
	                                </select>
								</div>
								<div class="input-group">
									<label for="brdSrchStr" class="sr-only">검색어 입력</label>
									<input type="hidden" name="page" value="<c:out value="${improvementVO.page}"/>">
									<input type="hidden" name="improvementNo">
									<input type="text" id="brdSrchStr" name="searchText" class="form-control flow-enter-search" placeholder="검색어" data-search-button="srchBtn" value="<c:out value="${improvementVO.searchText}"/>"/>
									<span class="input-group-btn"><button type="button" id="srchBtn" class="btn btn-default">검색</button></span>
								</div>
							</fieldset>
	                    </form>
	                </div>
	            </div>
	        </div>
	        <!-- //총게시물, 게시물 검색 -->
	        <!-- 게시판 목록 -->
	        <div class="table-responsive">
	            <table class="table text-center table-hover brd_list">
	                <caption class="sr-only">게시판 목록</caption>
	                <colgroup>
	                    <col style="width:9%;">
	                    <col>
	                    <col style="width:10%;">
	                    <col style="width:15%;">
	                </colgroup>
	                <thead>
	                <tr>
	                    <th scope="col">번호</th>
	                    <th scope="col">제목</th>
	                    <th scope="col">작성자</th>
	                    <th scope="col">등록일</th>
	                </tr>
	                </thead>
	                <tbody>
	                <jsp:useBean id="today" class="java.util.Date"/>
	                <fmt:formatDate var="now" value="${today}" pattern="yyyyMMdd"/>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<fmt:formatDate var="registDtm" value="${result.registDtm}" pattern="yyyyMMdd"/>
						<tr>
							<td>${pageNavigation.totalItemCount - ((pageNavigation.pageIndex - 1) * pageNavigation.itemCountPerPage + status.index)}</td>
							<td class="text-left">
								<p class="subject">
									<a href="javascript:;" class="dev-detail" data-improvement-no="<c:out value="${result.improvementNo}"/>"><c:out value="${result.title}"/></a>
									<c:if test="${now-registDtm <= 3 }">
										<span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span>
									</c:if>
								</p>
							</td>
							<td><c:out value="${result.displayName}"/></td>
							<td><fmt:formatDate value="${result.registDtm}" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) eq 0}">
						<!-- 데이터 없을시 -->
						<tr>
							<td colspan="4" class="empty">등록된 게시글이 없습니다.</td>
						</tr>
						<!-- //데이터 없을시 -->
					</c:if>
	                </tbody>
	            </table>
	        </div>
	        <!-- //게시판 목록 -->
	        <!-- 페이지 네비 -->
	        <nav class="text-center">
	            <ul class="pagination pagination-sm">
	                <c:if test="${pageNavigation.totalItemCount > 0}">
	                    <c:if test="${pageNavigation.canPreviousSection == true}">
	                        <li>
	                            <a href="#" aria-label="Previous" title="처음" class="dev-page" data-page="1">
	                                <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
	                            </a>
	                        </li>
	                        <li>
	                            <a href="#" aria-label="Previous" title="이전" onclick="return false;" class="dev-page" data-page="${pageNavigation.numberStart-1}">
	                                <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
	                            </a>
	                        </li>
	                    </c:if>
	                    <c:forEach var="i" begin="${pageNavigation.numberStart}" end="${pageNavigation.numberEnd}" step="1">
	                        <li <c:if test="${i == improvementVO.page}">class="active"</c:if>><a href="#" onclick="return false;" class="dev-page" data-page="${i}">${i}</a></li>
	                    </c:forEach>
	                    <c:if test="${pageNavigation.canNextSection == true}">
	                        <li>
	                            <a href="#" aria-label="Next" title="다음" class="dev-page" data-page="${pageNavigation.numberEnd+1}">
	                                <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
	                            </a>
	                        </li>
	                        <li>
	                            <a href="#" aria-label="Next" title="마지막" class="dev-page" data-page="${pageNavigation.maxNumber}">
	                                <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
	                            </a>
	                        </li>
	                    </c:if>
	                </c:if>
	            </ul>
	        </nav>
	        <!-- //페이지 네비 -->
	        <div class="btn_area text-right">
	            <a href="/qna/improvementForm.do" class="btn btn-blue"><i class="ti-pencil-alt"></i> 글작성</a>
	        </div>
	    </div>
	    <!-- //page-body -->
	</div>
	<!-- //CONTENTS -->
</div>

<script>
    $(function () {
        $('.dev-page').on('click', function () {
            const page = $(this).data('page');
			const form = $('form[name=searchForm]');
			form.find('input[name=page]').val(page);
			form.attr('action', '/qna/improvementList.do');
			form.submit();
        });

        $('.dev-detail').on('click', function () {
            const improvementNo = $(this).data('improvement-no');
            const form = $('form[name=searchForm]');
            form.find('input[name=improvementNo]').val(improvementNo);
            form.attr('action', '/qna/improvementDetail.do');
            form.submit();
        });

		$("#srchBtn").click(function () {
			const form = $("form[name=searchForm]");
			form.find("input[name=page]").val(1);
			form.attr('action', '/qna/improvementList.do');
			form.submit();
		});
    });
</script>