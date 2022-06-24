<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    .my-custom-scrollbar {
        position: relative;
        height: 400px;
        overflow: auto;
    }
    .table-wrapper-scroll-y {
        display: block;
    }
</style>

<div class="container sub_cont">
    <div id="contents">
        <div class="page-header">
            <h2>설문조사</h2>
       		<div>${menuDesc }</div>
        </div>
        <!-- //page-header -->

        <div class="page-body">
            <ul class="nav nav-tabs" role="tablist">
                <c:forEach var="surveyType" items="${surveyTypes}">
                    <li role="presentation"
                        <c:if test="${type.name() == surveyType.name()}">class="active"</c:if>>
                        <a href="/srv/list.do?type=${surveyType.name()}">${surveyType.value}</a>
                    </li>
                </c:forEach>
            </ul>
            <!-- 총게시물, 게시물 검색 -->
            <div class="brd_top">
                <div class="row">
                    <div class="col-xs-12 col-sm-6 data_total">
                        <p>
                            <i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span
                                class="text-primary">${surveyList.pageNavigation.totalItemCount}</span> / 페이지 <span
                                class="text-black">${page}</span>
                        </p>
                    </div>
                    <div class="col-xs-12 col-sm-6 text-right">
                        <form class="form-inline bbs_srch_frm" name="searchForm" action="#">
                            <input type="hidden" name="type" value="${type.name()}">
                            <input type="hidden" name="page">
                            <input type="hidden" name="surveyNo">
                            <fieldset>
                                <legend class="sr-only">게시글 검색</legend>
                                <div class="form-group">
                                    <label for="brdSrchSel" class="sr-only">검색대상</label>
                                    <select id="brdSrchSel" name="searchKey" class="form-control">
                                        <c:forEach var="searchKeyItem" items="${searchKeyTypes}">
                                            <option value="${searchKeyItem.name()}"
                                                    <c:if test="${searchKey.name() == searchKeyItem.name()}">selected="selected"</c:if>>
                                                    ${searchKeyItem.value}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="input-group">
                                    <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                    <input type="text" id="brdSrchStr" name="searchText" class="form-control"
                                           value="${searchText}" placeholder="검색어"/>
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
                        <col style="width:9%;"/>
                        <col/>
                        <col style="width:20%;"/>
                        <col style="width:9%;"/>
                        <col style="width:10%;" class="hidden-xs hidden-sm"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">번호</th>
                        <th scope="col">설문주제</th>
                        <th scope="col">설문기간</th>
                        <th scope="col">상태</th>
                        <th scope="col" class="hidden-xs hidden-sm">작성자</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${!empty surveyList.list && fn:length(surveyList.list) > 0}">
                            <c:forEach var="item" items="${surveyList.list }" varStatus="status">
                                <fmt:formatDate var="registDtm" value="${item.registDtm}" pattern="yyyyMMdd"/>
                                <fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd"/>
                                <tr>
                                    <td>${surveyList.pageNavigation.totalItemCount - ((surveyList.pageNavigation.pageIndex - 1) * surveyList.pageNavigation.itemCountPerPage + status.index) }</td>
                                    <td class="text-left">
                                        <p class="subject">
                                            <c:if test="${item.mine}">
                                            <span class="brd_ico chk text-danger"><i
                                                    class="fa fa-check-square"></i><span class="txt">[참여]</span></span>
                                            </c:if>
                                            <a href="javascript:;" class="dev-detail"
                                               data-surveyno="${item.surveyNo}">${item.title}</a>
                                            <c:if test="${today-registDtm <= 3 }">
                                            <span class="brd_ico"><i class="xi-new" title="새글"><span
                                                    class="sr-only">새글</span></i></span>
                                            </c:if>
                                        </p>
                                    </td>
                                    <td class="days">
                                        <fmt:formatDate value="${item.bngnDtm}" pattern="yyyy-MM-dd"/>
                                        <span>~</span>
                                        <fmt:formatDate value="${item.endDtm}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                    <c:choose>
                                    	<c:when test="${item.aprvState.name() == 'DOING'}">
                                            <fmt:formatDate var="Htoday" value="${now}" pattern="yyyyMMddHHmmss"/>
                                            <fmt:formatDate var="BngDtm" value="${item.bngnDtm}" pattern="yyyyMMddHHmmss"/>
                                            <c:choose>
                                                <c:when test="${Htoday gt BngDtm}">
                                                    <span class="status_txt text-blue">${item.aprvState.value}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status_txt text-warning">설문 예정</span>
                                                </c:otherwise>
                                            </c:choose>
                                    	</c:when>
                                    	<c:when test="${item.aprvState.name() == 'CANCEL'}">
                                    		<a href="#alertPopup" data-toggle="modal" data-target="#alertPopup" class="status_txt text-danger dev-reject" data-no="${status.index }">${item.aprvState.value}</a>
                                    	</c:when>
                                    	<c:when test="${item.aprvState.name() == 'WAIT'}">
                                    		<span class="status_txt text-warning">${item.aprvState.value}</span>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<span class="status_txt text-black">${item.aprvState.value}</span>
                                    	</c:otherwise>
									</c:choose>
                                    </td>
                                    <td class="hidden-xs hidden-sm">${item.registerName}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- 데이터 없을시 -->
                            <tr>
                                <td colspan="5" class="empty">등록된 게시물이 없습니다.</td>
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
                    <c:set var="paging" value="${surveyList.pageNavigation}"/>
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
                <a href="#selectPopup" data-toggle="modal" data-target="#selectPopup" class="btn btn-blue outline"><i
                        class="ti-bar-chart-alt" aria-hidden="true"></i> 설문 재사용</a>
                <a href="./write.do" class="btn btn-blue"><i class="ti-bar-chart-alt" aria-hidden="true"></i> 설문
                    신규등록</a>
                <a href="http://105.0.1.13/handy/pollJoin4Handy_2.jsp?UserID=67A992EA15&K=WC" class="btn btn-blue outline" target="_blank"><i
                        class="ti-bar-chart-alt" aria-hidden="true"></i> 구 설문조사</a>
            </div>
        </div>
        <!-- //page-body -->
        <!-- 알림팝업 -->
        <div class="modal fade" id="alertPopup" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
            <div class="modal-dialog modal-sm" role="document">
                <form class="modal-content">
                    <div class="modal-header sr-only">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="alertPopupLabel">반려사유</h4>
                    </div>
                    <div class="modal-body">
                        <p class="text-center">아래와 사유로 인해<br /><span class="text-blue" id="result"></span><br /><span class="text-danger">반려</span> 되었습니다.</p>
                    </div>
                    <div class="modal-footer text-center">
                        <button type="button" class="btn btn-blue btn-sm" data-dismiss="modal">확인</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- //알림팝업 -->
        <!-- 선택팝업 -->
        <div class="modal fade" id="selectPopup" tabindex="-1" role="dialog" aria-labelledby="selectPopupLabel">
            <div class="modal-dialog modal-lg" role="document">
                <form class="modal-content" name="popupForm" action="/srv/write.do">
                    <input type="hidden" name="isNew" value="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="selectPopupLabel">기존 등록 설문 선택</h4>
                    </div>
                    <div class="modal-body">
                        <p class="well"><span class="text-danger">재사용</span> 하실 설문을 선택해 주세요.</p>
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <table class="table text-center table-hover brd_list">
                                <caption class="sr-only">게시판 목록</caption>
                                <colgroup>
                                    <col style="width:9%;">
                                    <col>
                                    <col style="width:20%;">
                                    <col style="width:9%;">
                                    <col style="width:10%;" class="hidden-xs hidden-sm">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">선택</th>
                                    <th scope="col">설문주제</th>
                                    <th scope="col">작성자</th>
                                </tr>
                                </thead>
                                <tbody>

                                <c:choose>
                                    <c:when test="${!empty mySurveyList && fn:length(mySurveyList) > 0}">
                                        <c:forEach var="myItem" items="${mySurveyList}" varStatus="status">
                                            <tr>
                                                <td>
                                        <span class="radio-inline td_type">
                                            <input type="radio" name="surveyNo" id="brdRadio${status.index}" value="${myItem.surveyNo}">
                                            <span class="sr-only">선택</span>
                                        </span>
                                                </td>
                                                <td class="text-left">
                                                    <p class="subject">
                                                        <label for="brdRadio${status.index}">${myItem.title}</label>
                                                    </p>
                                                </td>
                                                <td>${myItem.registerName}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 데이터 없을시 -->
                                        <tr>
                                            <td colspan="3" class="empty">데이터가 없습니다.</td>
                                        </tr>
                                        <!-- //데이터 없을시 -->
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer text-center">
                        <a href="javascript:;" class="btn btn-blue dev-preview-confirm">확인</a>
                        <button type="button" class="btn btn-black" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- //선택팝업 -->
        <!-- //CONTENTS -->
    </div>
</div>

<script>
    $(function () {
    	var checkContArr = new Array();
        <c:forEach var="item" items="${surveyList.list }">
        	checkContArr.push({checkCont:"${item.checkCont }"});
        </c:forEach>

        $('.dev-page').on('click', function () {
            var page = $(this).data("page");
            goPage(page);
        });

        $('.dev-detail').on('click', function () {
            var surveyNo = $(this).data('surveyno');
            var form = $("form[name=searchForm]");
            form.find("input[name=surveyNo]").val(surveyNo);
            form.attr('action', '/srv/detail.do');
            form.attr("method", "GET");
            form.submit();
        });

        $(".dev-preview-confirm").on("click", function(){
            var form = $("form[name=popupForm]");
            form.submit();
        });
        
        $('.dev-reject').on('click', function (e) {
        	e.preventDefault();
            var no = $(this).data('no');
           $('#result').html(checkContArr[no].checkCont);
        });

    });

    function goPage(page) {
        var form = $("form[name=searchForm]");
        form.find("input[name=page]").val(page);
        form.submit();
    }

</script>