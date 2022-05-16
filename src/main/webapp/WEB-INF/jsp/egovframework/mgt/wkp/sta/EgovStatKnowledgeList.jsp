<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">지식 등록 현황</h2>
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
                    <li>통계</li>
                    <li class="active">지식 등록 현황</li>
                </ol>
                <div id="contents">
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-3 brd_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${knowledgeList.pageNavigation.totalItemCount }</span>  / 페이지 <span class="text-black">${knowledgeList.pageNavigation.pageIndex }</span></p>
                            </div>
                             <div class="col-xs-9 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="srchFrm" modelAttribute="knowledgeVO">
                                    <input type="hidden" name="page" value="${knowledgeList.pageNavigation.pageIndex }">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="input-group">
                                            <input type="text" class="form-control inp_date datetime text-center" id="inpStartDate" name="searchStartDate" placeholder="시작날짜" value="${knowledgeVO.searchStartDate}"/>
                                            <span class="input-group-addon">~</span>
                                            <input type="text" class="form-control inp_date datetime text-center" id="inpEndDate" name="searchEndDate" placeholder="종료날짜" value="${knowledgeVO.searchEndDate}"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="brdSrchSel" class="sr-only">검색대상</label>
                                            <select id="brdSrchSel" name="searchCondition" class="form-control">
                                                <option value="">선택해주세요.</option>
                                                <option value="TITLE" <c:if test="${knowledgeVO.searchCondition eq 'TITLE'}">selected="selected"</c:if>>제목</option>
                                                <option value="DISPLAY_NAME" <c:if test="${knowledgeVO.searchCondition eq 'DISPLAY_NAME'}">selected="selected"</c:if>>작성자</option>
                                                <option value="OU" <c:if test="${knowledgeVO.searchCondition eq 'OU'}">selected="selected"</c:if>>부서</option>
                                            </select>
                                        </div>
                                        <div class="input-group">
                                            <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                            <input type="text" id="brdSrchStr" name="searchKeyword" class="form-control" placeholder="검색어" value="${knowledgeVO.searchKeyword}"/>
                                            <span class="input-group-btn"><button type="submit" class="btn btn-default">검색</button></span>
                                        </div>
                                    </fieldset>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    <!-- //총게시물, 게시물 검색 -->
                    <table class="table table-bordered text-center table-hover">
                        <caption class="sr-only">게시판 리스트</caption>
                        <colgroup>
                            <col style="width:8%;" />
                            <col style="width:11%;" />
                            <col />
                            <col />
                            <col style="width:12%;" />
                            <col style="width:12%;" />
                            <col style="width:12%;" />
                            <col style="width:11%;" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">유형</th>
                                <th scope="col">제목</th>
                                <th scope="col">작성자</th>
                                <th scope="col">부서</th>
                                <th scope="col">추천수</th>
                                <th scope="col">조회수</th>
                                <th scope="col">등록일</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="knowledge" items="${knowledgeList.list }" varStatus="status">
                            <tr>
                                <td>${knowledgeList.pageNavigation.totalItemCount - ((knowledgeList.pageNavigation.pageIndex - 1) * knowledgeList.pageNavigation.itemCountPerPage + status.index) }</td>
                                <td>
                            	<c:choose>
                            	<c:when test="${interests.knowlgMapType eq 'REPORT' }">행정자료</c:when>
                            	<c:when test="${interests.knowlgMapType eq 'REFERENCE' }">업무참고자료</c:when>
                            	<c:otherwise>개인행정지식</c:otherwise>
                            	</c:choose>
                                </td>
                                <td class="text-left">
                                    <a href="#">${knowledge.title}</a>
                                    <c:if test="${knowledge.isNew}"><span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span></c:if>
                                </td>
                                <td>${knowledge.displayName }</td>
                                <td>${knowledge.ou }</td>
                                <td>${knowledge.recommendCnt }</td>
                                <td>${knowledge.inqCnt }</td>
                                <td>${knowledge.registDtm }</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul class="pagination pagination-sm">
                        <c:if test="${knowledgeList.pageNavigation.totalItemCount > 0 }">
                            <c:if test="${knowledgeList.pageNavigation.canPreviousSection == true }">
                            <li>
                                <a href="#" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Previous" title="이전" onclick="return false;"
                                   class="dev-page" data-page="${knowledgeList.pageNavigation.numberStart-1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach var="i" begin="${knowledgeList.pageNavigation.numberStart }" end="${knowledgeList.pageNavigation.numberEnd }" step="1">
                            <li <c:if test="${i == knowledgeList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" onclick="return false;" class="dev-page" data-page="${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${knowledgeList.pageNavigation.canNextSection == true }">
                            <li>
                                <a href="#" aria-label="Next" title="다음" class="dev-page" data-page="${knowledgeList.pageNavigation.numberEnd+1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Next" title="마지막" class="dev-page"
                                   data-page="${knowledgeList.pageNavigation.maxNumber }">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                        </c:if>
                        </ul>
                    </nav>
                    <!-- //페이지 네비 -->
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
            var form = $("form[name=srchFrm]");
            form.find("input[name=page]").val(page);
            form.submit();
        });

    });
</script>