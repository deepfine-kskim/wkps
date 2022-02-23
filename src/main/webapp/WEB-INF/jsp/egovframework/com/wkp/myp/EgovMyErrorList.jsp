<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
        <div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>지식 신고/등록</h2>
                </div>
                <!-- //page-header -->

                <div class="page-body">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="/myp/errorList.do">오류 신고</a></li>
                        <li role="presentation"><a href="/myp/approvalList.do">지식 등록</a></li>
                    </ul>
                    <!-- 총게시물, 게시물 검색 -->
                    <div class="brd_top">
                        <div class="row type0">
                            <div class="col-xs-12 col-sm-4 data_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${errorStatementList.pageNavigation.totalItemCount }</span>  / 페이지 <span class="text-black">${errorStatementList.pageNavigation.pageIndex }</span></p>
                            </div>
                            <div class="col-xs-12 col-sm-8 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="searchForm" modelAttribute="errorStatementVO">
                                    <input type="hidden" name="page" value="${errorStatementList.pageNavigation.pageIndex }">
                                    <input type="hidden" name="statmntNo" value="0">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="form-group">
                                            <label for="brdSortSel" class="sr-only">답변검색</label>
                                            <form:select id="brdSortSel" path="answerYn" class="form-control">
                                                <option>전체</option>
                                                <form:option value="N">답변대기</form:option>
                                                <form:option value="Y">답변완료</form:option>
                                            </form:select>
                                        </div>
                                        <div class="input-group">
                                            <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                            <form:input type="text" id="brdSrchStr" path="searchText" class="form-control" placeholder="제목 검색" />
                                            <span class="input-group-btn"><button type="submit" class="btn btn-default">검색</button></span>
                                        </div>
                                    </fieldset>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    <!-- //총게시물, 게시물 검색 -->

                    <!-- 게시판 목록 -->
                    <div class="table-responsive">
                        <table class="table text-center table-bordered table-hover brd_list">
                            <caption class="sr-only">게시판 목록</caption>
                            <colgroup>
                                <col style="width:10%;">
                                <col>
                                <col style="width:12%;">
                                <col style="width:13%;">
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">제목</th>
                                <th scope="col">상태</th>
                                <th scope="col">등록일</th>
                            </tr>
                            </thead>
                            <tbody>
	                        <c:choose>
	                        <c:when test="${not empty errorStatementList.list }">
	                        <c:forEach var="errorStatement" items="${errorStatementList.list }" varStatus="status">
	                        <tr>
	                            <td>${errorStatementList.pageNavigation.totalItemCount - ((errorStatementList.pageNavigation.pageIndex - 1) * errorStatementList.pageNavigation.itemCountPerPage + status.index) }</td>
	                            <td class="text-left">
	                                <p class="subject">
	                                    <a href="javascript:;" class="dev-detail" data-no="${errorStatement.statmntNo }">${errorStatement.statmntTitle }</a>
                                    	<c:if test="${errorStatement.isNew }"><span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span></c:if>
	                                </p>
	                            </td>
	                            <c:choose>
	                            	<c:when test="${errorStatement.answerYn eq 'Y'}"><td>답변완료</td></c:when>
	                            	<c:otherwise><td>답변대기</td></c:otherwise>
	                            </c:choose>
	                            <td>${errorStatement.registDtm }</td>
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
                        <c:if test="${errorStatement.pageNavigation.totalItemCount > 0 }">
                            <c:if test="${errorStatement.pageNavigation.canPreviousSection == true }">
                            <li>
                                <a href="#" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Previous" title="이전" onclick="return false;"
                                   class="dev-page" data-page="${errorStatement.pageNavigation.numberStart-1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach var="i" begin="${errorStatement.pageNavigation.numberStart }" end="${errorStatement.pageNavigation.numberEnd }" step="1">
                            <li <c:if test="${i == errorStatement.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" onclick="return false;" class="dev-page" data-page="${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${errorStatement.pageNavigation.canNextSection == true }">
                            <li>
                                <a href="#" aria-label="Next" title="다음" class="dev-page" data-page="${errorStatement.pageNavigation.numberEnd+1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Next" title="마지막" class="dev-page"
                                   data-page="${errorStatement.pageNavigation.maxNumber }">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                        </c:if>
                        </ul>
                    </nav>
                    <!-- //페이지 네비 -->
                    <div class="btn_area">
                        <div class="row type0">
                            <div class="col-xs-12">
                                <a href="/myp/mypage.do" class="btn btn-black outline">마이페이지</a>
                            </div>
                        </div>
                    </div>
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
            var form = $("form[name=searchForm]");
            form.find("input[name=page]").val(page);
            form.submit();
        });
        
        $('.dev-detail').on('click', function () {
            var statmntNo = $(this).data('no');
            var form = $("form[name=searchForm]");
            form.find("input[name=statmntNo]").val(statmntNo);
            form.attr("action", "/myp/errorDetail.do");
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