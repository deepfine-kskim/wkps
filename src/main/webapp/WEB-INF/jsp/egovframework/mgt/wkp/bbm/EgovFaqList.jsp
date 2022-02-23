<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">FAQ</h2>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="msg"><strong class="text-primary">${loginVO.displayName }</strong>님! 반갑습니다.</p>
                        <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
                    </div>
                </div>
            </div>
            <!-- //cont_header -->
            <div class="cont_body">
            	<ol class="breadcrumb">
                    <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
                    <li>게시판 관리</li>
                    <li class="active">FAQ</li>
                </ol>
                <div id="contents">
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
                            <div class="col-xs-5 brd_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${faqList.pageNavigation.totalItemCount }</span> / 페이지 <span class="text-black">${faqList.pageNavigation.pageIndex }</span></p>
                            </div>
                             <div class="col-xs-7 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="faqFrm" modelAttribute="faqVO">
                                    <input type="hidden" name="page" value="${faqList.pageNavigation.pageIndex }">
									<input type="hidden" name="faqType" value="${faqType }">
                                    <input type="hidden" name="faqNo" value="0">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="form-group">
                                            <label for="brdSrchSel" class="sr-only">검색대상</label>
                                            <select id="brdSrchSel" name="brdSrchSel" class="form-control">
                                                <option>제목 + 내용</option>
                                                <option>제목</option>
                                                <option>내용</option>
                                            </select>
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
                        	<c:forEach var="faq" items="${faqList.list }" varStatus="status">
                            <tr>
                                <td>${faqList.pageNavigation.totalItemCount - ((faqList.pageNavigation.pageIndex - 1) * faqList.pageNavigation.itemCountPerPage + status.index) }</td>
                                <td class="text-left">
                                    <p class="subject">
                                        <a href="javascript:;" class="dev-detail" data-faqno="${faq.faqNo }">${faq.title }</a>
                                    </p>
                                </td>
                                <td>${faq.registerId }</td>
                                <td>${faq.registDtm }</td>
                            </tr>
                        </c:forEach>
                            <!-- 데이터 없을시 -->
                            <!-- <tr>
                                <td colspan="5" class="empty">등록된 게시글이 없습니다.</td>
                            </tr> -->
                            <!-- //데이터 없을시 -->
                        </tbody>
                        </table>
                    </div>
                    <!-- //게시판 목록 -->
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
                    <div class="btn_area text-right">
                        <a href="/adm/insertFaqView.do" class="btn btn-blue min-lg btn-lg">등록</a>
                    </div>
                </div>
		        <!-- //CONTENTS -->
                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->
<script>
    $(function () {

        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
        	var page = $(this).data('page');
            var form = $("form[name=faqFrm]");
            form.find("input[name=page]").val(page);      
            form.submit();
        });
        
        $('.dev-detail').on('click', function () {
            var faqNo = $(this).data('faqno');
            var form = $("form[name=faqFrm]");
            form.find("input[name=faqNo]").val(faqNo);
            form.attr("action", "/adm/faqDetail.do");
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