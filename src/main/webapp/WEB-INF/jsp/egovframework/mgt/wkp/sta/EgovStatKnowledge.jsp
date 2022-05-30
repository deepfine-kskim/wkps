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
                        <li role="presentation" class="active"><a href="/adm/statKnowledge.do">지식 등록 통계</a></li>
                        <li role="presentation"><a href="/adm/statViewKnowledge.do">최다 조회 지식</a></li>
                        <li role="presentation"><a href="/adm/statRecommendKnowledge.do">최다 추천 지식</a></li>
                        <li role="presentation"><a href="/adm/statUserKnowledge.do">최다 게시자</a></li>
                        <li role="presentation"><a href="/adm/statRecommendUserKnowledge.do">최다 추천자</a></li>
                        <li role="presentation"><a href="/adm/statActiveUserKnowledge.do">최다 활동자</a></li>
                        <li role="presentation"><a href="/adm/statOrgKnowledge.do">최다 등록부서</a></li>
                    </ul>
                    <div class="brd_top">
                        <div class="row type0">
                             <div class="col-xs-12">
                                 <div class="well mb_0">
                                 <form class="form-inline bbs_srch_frm" name="searchForm">
                                     <input type="hidden" name="statType" value="${statType}">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="form-group date_select radio_tab_cont active">
                                            <select class="form-control" name="year">
                                                <c:forEach var="i" begin="2020" end="${nowYear}" step="1">
                                                    <option value="${i}" <c:if test="${i == year}">selected</c:if>>${i}</option>
                                                </c:forEach>
                                            </select>
                                            <label>년</label>
                                        </div>
                                        <div class="form-group date_select radio_tab_cont active">
                                            <select class="form-control" name="month">
                                                <c:forEach var="i" begin="1" end="12" step="1">
                                                    <option value="${i}" <c:if test="${i == month}">selected</c:if>>${i}</option>
                                                </c:forEach>
                                            </select>
                                            <label>월</label>
                                            <button type="button" class="btn btn-default dev-search">검색</button>
                                        </div>
                                    </fieldset>
                                </form>
                                </div>
                            </div>
                        </div>
                    </div>
<%--                    <p class="mb_5"><span class="text-danger">※</span> <span class="underline text-black">일자 클릭 시 시간대별 현황</span>을 보실 수 있습니다.  당일 데이터는 명일 확인 가능합니다.</p>--%>
                    <table class="table table-bordered text-center table-hover">
                        <caption class="sr-only">지식 등록 통계 리스트</caption>
                        <colgroup>
                            <col style="width:10%;">
                            <col>
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">일자</th>
                                <th scope="col">지식 등록수</th>
                                <th scope="col">전일 대비 지식 등록수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 루프 -->
                            <c:choose>
                                <c:when test="${!empty statics.staticsKnowledgeVoList && fn:length(statics.staticsKnowledgeVoList) > 0}">
                                    <c:forEach var="item" items="${statics.staticsKnowledgeVoList}">
                                        <tr>
                                            <td>${item.dt}</td>
                                            <td>${item.knowledgeCount}</td>
                                            <td><span class="${item.preKnowledgeCount > 0 ? 'text-danger': item.preKnowledgeCount < 0 ? 'text-primary':''}">${item.preKnowledgeCount}</span></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5">데이터가 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            <!-- //루프 -->
                        </tbody>
                        <tfoot>
                            <tr class="danger text-black">
                                <td><strong>Total</strong></td>
                                <td>
                                    <strong>${statics.totalKnowledgeCount}</strong>
                                </td>
                                <td>
                                    <strong>${statics.totalPreKnowledgeCount}</strong>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
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
        $('.radio_tab_cont').not('.radio_tab_cont.active').hide();
        $('.brd_top').on('change', '.radio_tab', function() {
            var myPar = $(this).closest('.brd_top');
            var inpVal = $(this).find('input[type="radio"]').attr('class');
            myPar.find('.radio_tab_cont').hide();
            myPar.find('#' + inpVal + 'Cont').show();
        });

        $(".dev-download-excel").on("click", function() {
            var form = $("form[name=searchForm]");
            form.attr("action", "/adm/statKnowledgeExcelDownload.do");
            form.attr("method", "post");
            form.submit();
        });

        $(".dev-search").on("click", function() {
            var form = $("form[name=searchForm]");
            form.attr("action", "/adm/statKnowledge.do");
            form.attr("method", "get");
            form.submit();
        });

        $('.dev-type').on('click', function () {
            const statType = $(this).data('type');
            const form = $("form[name=searchForm]");
            form.find("input[name=statType]").val(statType);
            form.submit();
        });
    });
</script>