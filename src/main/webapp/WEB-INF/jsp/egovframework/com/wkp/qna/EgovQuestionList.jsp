<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container sub_cont">
    <div id="contents">
	    <div class="page-header">
	        <h2>이용안내</h2>
        	<div>${menuDesc }</div>
	    </div>
	    <!-- //page-header -->
	
	    <div class="page-body">
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="/qna/list.do">Q&A</a></li>
                <li role="presentation"><a href="/qna/faqList.do">FAQ</a></li>
            </ul>
	        <div class="well well-primary outline msg_box">
	        	<span class="text-primary">진행중인 질문</span>이 <a href="/qna/list.do?type=DOING" class="text-danger underline">${waitCount}건</a>이 있습니다.
	        </div>
	        <ul class="nav nav-tabs" role="tablist">
	            <c:forEach var="questionType" items="${questionTypes}">
	                <li role="presentation"
	                    <c:if test="${type.name() == questionType.name()}">class="active"</c:if>>
	                    <a href="/qna/list.do?type=${questionType.name()}">${questionType.value}</a>
	                </li>
	            </c:forEach>
	        </ul>
	        <!-- 총게시물, 게시물 검색 -->
	        <div class="brd_top">
	            <div class="row">
	                <div class="col-xs-12 col-sm-6 data_total">
	                    <p>
	                        <i class="fa fa-file-text-o" aria-hidden="true"></i>
	                        총 게시물 <span class="text-primary">${questionList.pageNavigation.totalItemCount}</span> /
	                        페이지
	                        <span class="text-black">${page}</span>
	                    </p>
	                </div>
	                <div class="col-xs-12 col-sm-6 text-right">
	                    <form class="form-inline bbs_srch_frm" name="searchForm">
	                        <fieldset>
	                            <legend class="sr-only">게시글 검색</legend>
	                            <div class="form-group">
	                                <label for="brdSrchSel" class="sr-only">검색대상</label>
	                                <select id="brdSrchSel" name="searchKey" class="form-control">
	                                    <option value="TITLE"  <c:if test="${searchKey == 'TITLE'}">selected="selected"</c:if>>제목</option>
	                                    <option value="REGISTER_ID"  <c:if test="${searchKey == 'REGISTER_ID'}">selected="selected"</c:if>>작성자</option>
	                                </select>
	                            </div>
	                            <div class="input-group">
	                                <label for="brdSrchStr" class="sr-only">검색어 입력</label>
	                                <input type="hidden" name="type" value="${type.name()}">
	                                <input type="hidden" name="page">
	                                <input type="hidden" name="questionNo">
	                                <input type="text" id="brdSrchStr" name="searchText" class="form-control"
	                                       placeholder="검색어" value="${searchText}"/>
	                                <span class="input-group-btn"><button type="submit"
	                                                                      class="btn btn-default">검색</button></span>
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
	                    <col style="width:8%;" class="hidden-xs hidden-sm">
	                </colgroup>
	                <thead>
	                <tr>
	                    <th scope="col">번호</th>
	                    <th scope="col">제목</th>
	                    <th scope="col">작성자</th>
	                    <th scope="col">등록일</th>
	                    <th scope="col">현황</th>
	                </tr>
	                </thead>
	                <tbody>
	                <jsp:useBean id="today" class="java.util.Date"/>
	                <fmt:formatDate var="now" value="${today}" pattern="yyyyMMdd"/>
	                <c:choose>
	                    <c:when test="${!empty questionList.list && fn:length(questionList.list) > 0}">
	                        <c:forEach var="item" items="${questionList.list }" varStatus="status">
	                            <fmt:formatDate var="registDtm" value="${item.registDtm}" pattern="yyyyMMdd"/>
	                            <tr>
	                                <td>${questionList.pageNavigation.totalItemCount - ((questionList.pageNavigation.pageIndex - 1) * questionList.pageNavigation.itemCountPerPage + status.index) }</td>
	                                <td class="text-left">
	                                    <p class="subject">
	                                        <a href="javascript:;" class="dev-detail" data-questionno="${item.questionNo}">${item.title}</a>
	                                        <c:if test="${now-registDtm <= 3 }">
	                                            <span class="brd_ico"><i class="xi-new"><span
	                                                    class="sr-only">새글</span></i></span>
	                                        </c:if>
	                                    </p>
	                                </td>
	                                <td>${item.registerName}</td>
	                                <td><fmt:formatDate value="${item.registDtm}" pattern="yyyy-MM-dd"/></td>
	                                <td>
	                                    <c:choose>
	                                        <c:when test="${item.slctnYn == 'Y'}">
	                                            <span>완료</span>
	                                        </c:when>
	                                        <c:otherwise>
	                                            <span class="text-blue">진행중</span>
	                                        </c:otherwise>
	                                    </c:choose>
	                                </td>
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
	                <c:set var="paging" value="${questionList.pageNavigation}"/>
	                <c:if test="${paging.totalItemCount > 0}">
	                    <c:if test="${paging.canPreviousSection == true}">
	                        <li>
	                            <a href="#" aria-label="Previous" title="처음" class="dev-page" data-page="1">
	                                <span aria-hidden="true"><i class="fa fa-angle-double-left"
	                                                            aria-hidden="true"></i></span>
	                            </a>
	                        </li>
	                        <li>
	                            <a href="#" aria-label="Previous" title="이전" onclick="return false;"
	                               class="dev-page" data-page="${paging.numberStart-1}">
	                                <span aria-hidden="true"><i class="fa fa-angle-left"
	                                                            aria-hidden="true"></i></span>
	                            </a>
	                        </li>
	                    </c:if>
	                    <c:forEach var="i" begin="${paging.numberStart}" end="${paging.numberEnd}" step="1">
	
	                        <li <c:if test="${i == page}">class="active"</c:if>><a href="#" onclick="return false;"
	                                                                               class="dev-page"
	                                                                               data-page="${i}">${i}</a></li>
	                    </c:forEach>
	
	                    <c:if test="${paging.canNextSection == true}">
	                        <li>
	                            <a href="#" aria-label="Next" title="다음" class="dev-page"
	                               data-page="${paging.numberEnd+1}">
	                                <span aria-hidden="true"><i class="fa fa-angle-right"
	                                                            aria-hidden="true"></i></span>
	                            </a>
	                        </li>
	                        <li>
	                            <a href="#" aria-label="Next" title="마지막" class="dev-page"
	                               data-page="${paging.maxNumber}">
	                                <span aria-hidden="true"><i class="fa fa-angle-double-right"
	                                                            aria-hidden="true"></i></span>
	                            </a>
	                        </li>
	                    </c:if>
	                </c:if>
	            </ul>
	        </nav>
	        <!-- //페이지 네비 -->
	        <div class="btn_area text-right">
	            <a href="/qna/questionWrite.do" class="btn btn-blue"><i class="ti-pencil-alt"></i> 글작성</a>
	        </div>
	    </div>
	    <!-- //page-body -->
	</div>
	<!-- //CONTENTS -->
</div>

<script>
    $(function () {

        $('.dev-page').on('click', function () {
            var page = $(this).data("page");
            goPage(page);
        });

        $('.dev-detail').on('click', function () {
            var questionNo = $(this).data('questionno');
            var form = $("form[name=searchForm]");
            form.find("input[name=questionNo]").val(questionNo);
            form.attr('action', '/qna/detail.do');
            form.submit();
        });

    });

    function goPage(page) {
        var form = $("form[name=searchForm]");
        form.find("input[name=page]").val(page);
        form.submit();
    }

</script>