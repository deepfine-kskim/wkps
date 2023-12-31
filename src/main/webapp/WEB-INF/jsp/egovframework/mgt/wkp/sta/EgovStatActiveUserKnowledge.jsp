<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">지식 통계</h2>
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
                    <li class="active">지식 통계</li>
                </ol>
                <div id="contents">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation"><a href="/adm/statKnowledge.do">지식 등록 통계</a></li>
                        <li role="presentation"><a href="/adm/statViewKnowledge.do">최다 조회 지식</a></li>
                        <li role="presentation"><a href="/adm/statRecommendKnowledge.do">최다 추천 지식</a></li>
                        <li role="presentation"><a href="/adm/statUserKnowledge.do">최다 게시자</a></li>
                        <li role="presentation"><a href="/adm/statRecommendUserKnowledge.do">최다 추천자</a></li>
                        <li role="presentation" class="active"><a href="/adm/statActiveUserKnowledge.do">최다 활동자</a></li>
                        <li role="presentation"><a href="/adm/statOrgKnowledge.do">최다 등록부서</a></li>
                    </ul>
                    <div class="brd_top">
                        <div class="row type0">
                            <div class="col-xs-12">
                                <div class="well mb_0">
                                    <form name="searchForm">
                                        <input type="hidden" name="page" value="${staticsKnowledgeVO.page}">
                                        <input type="hidden" name="type" value="statActiveUserKnowledge">
                                        <fieldset>
                                            <legend class="sr-only">게시글 검색</legend>
                                            <div class="form-row">
                                                <div class="form-group col-xs-4">
                                                    <label for="inpStartDate">조회기간</label>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control inp_date datetime text-center" id="inpStartDate" name="startDate" placeholder="시작날짜" value="${staticsKnowledgeVO.startDate}"/>
                                                        <span class="input-group-addon">~</span>
                                                        <input type="text" class="form-control inp_date datetime text-center" id="inpEndDate" name="endDate" placeholder="종료날짜" value="${staticsKnowledgeVO.endDate}"/>
                                                        <span class="input-group-btn"><button type="button" class="btn btn-default dev-search">검색</button></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered text-center table-hover">
                        <caption class="sr-only">최다 활동자 리스트</caption>
                        <colgroup>
                            <col style="width:6%;">
                            <col>
                            <col>
                            <col style="width:9%;">
                            <col style="width:9%;">
                            <col style="width:9%;">
                            <col style="width:9%;">
                            <col style="width:9%;">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">순위</th>
                            <th scope="col">성명</th>
                            <th scope="col">부서</th>
                            <th scope="col">마일리지 합계</th>
                            <th scope="col">조회</th>
                            <th scope="col">추천</th>
                            <th scope="col">등록</th>
                            <th scope="col">수정</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="result" items="${resultList}" varStatus="status">
                            <tr>
                                <td>${pageNavigation.totalItemCount - (pageNavigation.totalItemCount - ((pageNavigation.pageIndex - 1) * pageNavigation.itemCountPerPage) - status.count)}</td>
                                <td><c:out value="${result.displayName}"/></td>
                                <td><c:out value="${result.ou}"/></td>
                                <td><fmt:formatNumber value="${result.totalMileage}" pattern="#,###"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${result.viewCnt ne 0}">
                                            <fmt:formatNumber value="${result.viewCnt}" pattern="#,###"/>건 (<fmt:formatNumber value="${result.viewMileage}" pattern="#,###"/>점)
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${result.recCnt ne 0}">
                                            <fmt:formatNumber value="${result.recCnt}" pattern="#,###"/>건 (<fmt:formatNumber value="${result.recMileage}" pattern="#,###"/>점)
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${result.newCnt ne 0}">
                                            <fmt:formatNumber value="${result.newCnt}" pattern="#,###"/>건 (<fmt:formatNumber value="${result.newMileage}" pattern="#,###"/>점)
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${result.updCnt ne 0}">
                                            <fmt:formatNumber value="${result.updCnt}" pattern="#,###"/>건 (<fmt:formatNumber value="${result.updMileage}" pattern="#,###"/>점)
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${fn:length(resultList) eq 0}">
                            <tr>
                                <td colspan="8">등록된 데이터가 없습니다.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                    <div>
                        <%--<button type="button" class="btn btn-danger dev-download-excel">다운로드</button>--%>
                    </div>
                    <!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul class="pagination pagination-sm">
                            <c:if test="${pageNavigation.totalItemCount > 0 }">
                                <c:if test="${pageNavigation.canPreviousSection == true }">
                                    <li>
                                        <a href="javascript:;" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                            <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;" aria-label="Previous" title="이전" onclick="return false;" class="dev-page" data-page="${pageNavigation.numberStart-1 }">
                                            <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                        </a>
                                    </li>
                                </c:if>

                                <c:forEach var="i" begin="${pageNavigation.numberStart }" end="${pageNavigation.numberEnd }" step="1">
                                    <li <c:if test="${i == pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" class="dev-page" data-page="${i}">${i}</a></li>
                                </c:forEach>

                                <c:if test="${pageNavigation.canNextSection == true}">
                                    <li>
                                        <a href="javascript:;" aria-label="Next" title="다음" class="dev-page" data-page="${pageNavigation.numberEnd+1 }">
                                            <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:;" aria-label="Next" title="마지막" class="dev-page" data-page="${pageNavigation.maxNumber }">
                                            <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
                                        </a>
                                    </li>
                                </c:if>
                            </c:if>
                        </ul>
                    </nav>
                    <!-- //페이지 네비 -->
                    <div>
                        <button type="button" class="btn btn-danger dev-download-excel">다운로드</button>
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
    $(document).ready(function() {
        $(".dev-download-excel").on("click", function() {
            var form = $("form[name=searchForm]");
            form.attr("action", "/adm/knowledgeStatisticsExcelDownload.do");
            form.attr("method", "post");
            form.submit();
        });

        $('.dev-page').on('click', function (e) {
            e.preventDefault();
            const page = $(this).data('page');
            const form = $("form[name=searchForm]");
            form.find("input[name=page]").val(page);
            form.attr("action", "/adm/statActiveUserKnowledge.do");
            form.submit();
        });

        $(".dev-search").on("click", function() {
            const form = $("form[name=searchForm]");
            form.attr("action", "/adm/statActiveUserKnowledge.do");
            form.attr("method", "get");
            form.submit();
        });
    });
</script>