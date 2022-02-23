<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
        <div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>공지사항</h2>
        			<div>${menuDesc }</div>
                </div>
                <!-- //page-header -->

                <div class="page-body">
                    <!-- 총게시물, 게시물 검색 -->
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 data_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${noticeList.pageNavigation.totalItemCount }</span> / 페이지 <span class="text-black">${noticeList.pageNavigation.pageIndex }</span></p>
                            </div>
                            <div class="col-xs-12 col-sm-6 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="noticeFrm" modelAttribute="noticeVO">
                                    <input type="hidden" name="page" value="${noticeList.pageNavigation.pageIndex }">
                                    <input type="hidden" name="noticeNo" value="0">
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
                    <!-- 게시판 목록 -->
                    <div class="table-responsive">
                        <table class="table text-center table-bordered table-hover brd_list">
                        <caption class="sr-only">게시판 목록</caption>
                        <colgroup>
                            <col style="width:9%;">
                            <col>
                            <col style="width:10%;">
                            <col style="width:12%;">
                            <col style="width:8%;" class="hidden-xs hidden-sm">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">제목</th>
                                <th scope="col">작성자</th>
                                <th scope="col">등록일</th>
                                <th scope="col" class="hidden-xs hidden-sm">조회</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${!empty noticeList.list && fn:length(noticeList.list) > 0}">
							<c:forEach var="notice" items="${noticeList.list }" varStatus="status">
                            <tr>
                                <td><em class="notice">${noticeList.pageNavigation.totalItemCount - ((noticeList.pageNavigation.pageIndex - 1) * noticeList.pageNavigation.itemCountPerPage + status.index) }</em></td>
                                <td class="text-left">
                                    <p class="subject">
                                        <a href="javascript:;" class="dev-detail" data-noticeno="${notice.noticeNo}">${notice.title }</a>
                                        <c:if test="${notice.isNew }"><span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span></c:if>
                                    </p>
                                </td>
                                <td>${notice.displayName }</td>
                                <td>${notice.registDtm }</td>
                                <td class="hidden-xs hidden-sm">${notice.inqCnt }</td>
                            </tr>
                            </c:forEach>
                            <!-- 데이터 없을시 -->
                            </c:when>
                            <c:otherwise>
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
                        <c:if test="${noticeList.pageNavigation.totalItemCount > 0 }">
                            <c:if test="${noticeList.pageNavigation.canPreviousSection == true }">
                            <li>
                                <a href="#" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Previous" title="이전" onclick="return false;"
                                   class="dev-page" data-page="${noticeList.pageNavigation.numberStart-1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach var="i" begin="${noticeList.pageNavigation.numberStart }" end="${noticeList.pageNavigation.numberEnd }" step="1">
                            <li <c:if test="${i == noticeList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" class="dev-page" data-page="${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${noticeList.pageNavigation.canNextSection == true}">
                            <li>
                                <a href="#" aria-label="Next" title="다음" class="dev-page" data-page="${noticeList.pageNavigation.numberEnd+1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Next" title="마지막" class="dev-page"
                                   data-page="${noticeList.pageNavigation.maxNumber }">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                        </c:if>
                        </ul>
                    </nav>
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
            var form = $("form[name=noticeFrm]");
            form.find("input[name=page]").val(page);
            form.submit();
        });
        
        $('.dev-detail').on('click', function (e) {
        	e.preventDefault();
            var noticeNo = $(this).data('noticeno');
            var form = $("form[name=noticeFrm]");
            form.find("input[name=noticeNo]").val(noticeNo);
            form.attr("action", "/bbs/noticeDetail.do");
            form.submit();
        });
        
    });
</script>