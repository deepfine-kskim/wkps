<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">접속 통계</h2>
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
                                        <li class="active">접속 통계</li>
                                    </ol>
                                <div id="contents">
                    <div class="brd_top">
                        <div class="row type0">
                             <div class="col-xs-12">
                                 <div class="well mb_0">
                                 <form class="form-inline bbs_srch_frm" name="searchForm">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
<%--                                        <div class="form-group sta_radios">--%>
<%--                                            <label class="radio-inline radio_tab">--%>
<%--                                                <input type="radio" class="radio1" name="staSel" checked="checked"> 일별--%>
<%--                                            </label>--%>
<%--                                            <label class="radio-inline radio_tab">--%>
<%--                                                <input type="radio" class="radio2" name="staSel"> 월별--%>
<%--                                            </label>--%>
<%--                                            <label class="radio-inline radio_tab">--%>
<%--                                                <input type="radio" class="radio3" name="staSel"> 연도별--%>
<%--                                            </label>--%>
<%--                                        </div>--%>
                                        <div id="radio1Cont" class="form-group date_select radio_tab_cont active">
                                            <select class="form-control" name="year">
                                                <c:forEach var="i" begin="2020" end="${nowYear}" step="1">
                                                    <option value="${i}" <c:if test="${i == year}">selected</c:if>>${i}</option>
                                                </c:forEach>
                                            </select>
                                            <label>년</label>
<%--                                            <select class="form-control">--%>
<%--                                                <option>08</option>--%>
<%--                                            </select>--%>
<%--                                            <label>월</label>--%>
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
<%--                                        <div id="radio2Cont" class="form-group date_select radio_tab_cont">--%>
<%--                                            <select class="form-control">--%>
<%--                                                <option>2020</option>--%>
<%--                                            </select>--%>
<%--                                            <label>년</label>--%>
<%--                                            <select class="form-control">--%>
<%--                                                <option>08</option>--%>
<%--                                            </select>--%>
<%--                                            <label>월</label>--%>

<%--                                            <span class="dash">~</span>--%>

<%--                                            <select class="form-control">--%>
<%--                                                <option>2020</option>--%>
<%--                                            </select>--%>
<%--                                            <label>년</label>--%>
<%--                                            <select class="form-control">--%>
<%--                                                <option>08</option>--%>
<%--                                            </select>--%>
<%--                                            <label>월</label>--%>

<%--                                            <button type="button" class="btn btn-default">검색</button>--%>
<%--                                        </div>--%>
<%--                                        <div id="radio3Cont" class="form-group date_select radio_tab_cont">--%>
<%--                                            <select class="form-control">--%>
<%--                                                <option>2020</option>--%>
<%--                                            </select>--%>
<%--                                            <label>년</label>--%>

<%--                                            <span class="dash">~</span>--%>

<%--                                            <select class="form-control">--%>
<%--                                                <option>2020</option>--%>
<%--                                            </select>--%>
<%--                                            <label>년</label>--%>

<%--                                            <button type="button" class="btn btn-default">검색</button>--%>
<%--                                        </div>--%>
                                    </fieldset>
                                </form>
                                </div>
                            </div>
                        </div>
                    </div>
<%--                    <p class="mb_5"><span class="text-danger">※</span> <span class="underline text-black">일자 클릭 시 시간대별 현황</span>을 보실 수 있습니다.  당일 데이터는 명일 확인 가능합니다.</p>--%>
                    <table class="table table-bordered text-center table-hover">
                        <caption class="sr-only">접속통계 리스트</caption>
                        <colgroup>
                            <col>
                            <col style="width:22%;">
                            <col style="width:22%;">
                            <col style="width:22%;">
                            <col style="width:22%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">일자</th>
                                <th scope="col">방문자수</th>
                                <th scope="col">전일 대비 방문자수</th>
                                <th scope="col">방문횟수</th>
                                <th scope="col">전일 대비 방문횟수</th>
                            </tr>
                        </thead>
                        <tbody>

                            <!-- 루프 -->
                            <c:choose>
                                <c:when test="${!empty statics.staticsConnectVoList && fn:length(statics.staticsConnectVoList) > 0}">
                                    <c:forEach var="item" items="${statics.staticsConnectVoList}">
                                        <tr>
                                            <td>${item.dt}</td>
                                            <td>${item.visitUserCount}</td>
                                            <td><span class="${item.preVisitUserCount > 0 ? 'text-danger': item.preVisitUserCount < 0 ? 'text-primary':''}">${item.preVisitUserCount}</span></td>
                                            <td>${item.visitCount}</td>
                                            <td><span class="${item.preVisitCount > 0 ? 'text-danger':item.preVisitCount < 0 ?'text-primary':''}">${item.preVisitCount}</span></td>
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
                                    <strong>${statics.totalConnectUserCount}</strong>
                                </td>
                                <td>
                                    <strong>${statics.totalPreConnectUserCount}</strong>
                                </td>
                                <td>
                                    <strong>${statics.totalConnectCount}</strong>
                                </td>
                                <td>
                                    <strong>${statics.totalPreConnectCount}</strong>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                    <div>
                        <button type="button" class="btn btn-danger dev-download-excel">다운로드</button>
                    </div>
                </div>
                <!-- //CONTENTS -->
                <!-- 시간대별 통계 팝업 -->
                <div class="modal fade" id="alertPopup" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="alertPopupLabel">시간대별 통계</h4>
                            </div>
                            <div class="modal-body">
                                <div>
                                    <table class="table-bordered table table-condensed table-hover text-center mb_0">
                                        <caption class="sr-only hidden">시간대별 통계표</caption>
                                        <colgroup>
                                            <col style="width:50%;">
                                            <col style="width:50%;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th>08시 ~ 09시</th>
                                                <td>10</td>
                                            </tr>
                                            <tr>
                                                <th>09시 ~ 10시</th>
                                                <td>20</td>
                                            </tr>
                                            <tr>
                                                <th>11시 ~ 12시</th>
                                                <td>30</td>
                                            </tr>
                                            <tr>
                                                <th>12시 ~ 13시</th>
                                                <td>40</td>
                                            </tr>
                                            <tr>
                                                <th>13시 ~ 14시</th>
                                                <td>50</td>
                                            </tr>
                                            <tr>
                                                <th>14시 ~ 15시</th>
                                                <td>60</td>
                                            </tr>
                                            <tr>
                                                <th>15시 ~ 16시</th>
                                                <td>70</td>
                                            </tr>

                                        </tbody>

                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger">다운로드</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- // 시간대별 통계 팝업 -->
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
                            form.attr("action", "/adm/statConnectExcelDownload.do");
                            form.attr("method", "post");
                            form.submit();
                        });

                        $(".dev-search").on("click", function() {
                            var form = $("form[name=searchForm]");
                            form.attr("action", "/adm/statConnect.do");
                            form.attr("method", "get");
                            form.submit();
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