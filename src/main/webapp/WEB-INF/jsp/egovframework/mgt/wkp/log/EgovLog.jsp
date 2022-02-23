<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .tooltip-main {
        width: 1200px;
        height: 200px;
        border-radius: 50%;
        font-weight: 700;
        background: #f3f3f3;
        border: 1px solid #737373;
        color: #737373;
        margin: 4px 5px 0 5px;
        float: right;
        text-align: left !important;
    }

    .tooltip-qm {
        float: left;
        margin: -2px 0px 3px 4px;
        font-size: 12px;
    }

    .tooltip-inner {
        max-width: 1190px !important;
        height: 185px;
        font-size: 12px;
        padding: 10px 15px 10px 20px;
        background: #FFFFFF;
        color: rgb(0, 0, 0);
        border: 1px solid #737373;
        text-align: left;
    }

    .tooltip.show {
        opacity: 1;
    }

    .bs-tooltip-auto[x-placement^=bottom] .arrow::before,
    .bs-tooltip-bottom .arrow::before {
        border-bottom-color: #f00;
        /* Red */
    }
</style>

        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">로그관리</h2>
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
            		<li class="active">로그관리</li>
            	</ol>
				<div id="contents">
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-5 brd_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span
                                        class="text-primary">${logList.pageNavigation.totalItemCount}</span> / 페이지 <span
                                        class="text-black">${page}</span></p>
                            </div>
                             <div class="col-xs-7 text-right">
                                <form class="form-inline bbs_srch_frm" name="searchForm" action="#">
                                    <input type="hidden" name="page">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="form-group">
                                            <label for="searchKey" class="sr-only">검색대상</label>
                                            <select id="searchKey" name="searchKey" class="form-control">
                                                <option value="REGISTER_ID">이름</option>
                                            </select>
                                        </div>
                                        <div class="input-group">
                                            <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                            <input type="text" id="brdSrchStr" name="searchText" class="form-control" value="${searchText}" placeholder="검색어" />
                                            <span class="input-group-btn"><button type="submit" class="btn btn-default">검색</button></span>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                    <table class="table table-bordered text-center table-hover">
                        <caption class="sr-only">접속통계 리스트</caption>
                        <thead>
                            <tr>
                                <th scope="col" >일자</th>
                                <th scope="col" >이름</th>
                                <th scope="col" >접근</th>
                                <th scope="col" >상태</th>
                                <th scope="col" >대상</th>
                                <th scope="col" >IP</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${!empty logList.list && fn:length(logList.list) > 0}">
                                <c:forEach var="item" items="${logList.list }" varStatus="status">
                                    <tr>
                                        <td><fmt:formatDate value="${item.registDtm}"
                                                            pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>${item.registerFullName}</td>
                                        <td>${item.logType.value}</td>
                                        <td>${item.logSubjectType.value}</td>
                                        <td>${fn:substringBefore(fn:substringAfter(item.cont, 'title":'),',') }</td>
                                        <td>${item.userIp}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <!-- 데이터 없을시 -->
                                <tr>
                                    <td colspan="6" class="empty">등록된 게시물이 없습니다.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                            <!-- 루프 -->
                        </tbody>
                    </table>
					<!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul class="pagination pagination-sm">
                            <c:set var="paging" value="${logList.pageNavigation}"/>
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
                </div>
                <!-- //CONTENTS --> 
                <script>
                    $(document).ready(function() {
                        $('.radio_tab_cont').not('.radio_tab_cont.active').hide();
                        $('.brd_top').on('change', '.radio_tab', function() {
                            var myPar = $(this).closest('.brd_top');
                            var inpVal = $(this).find('input[type="radio"]').attr('class');
                            myPar.find('.radio_tab_cont').hide();
                            myPar.find('#' + inpVal + 'Cont').show();
                        });
                    });
                </script>
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
        $('[data-toggle="tooltip"]').tooltip({ boundary: 'window' });

        $('.dev-page').on('click', function () {
            var page = $(this).data("page");
            goPage(page);
        });

    });

    function goPage(page) {
        var form = $("form[name=searchForm]");
        form.find("input[name=page]").val(page);
        form.submit();
    }
</script>