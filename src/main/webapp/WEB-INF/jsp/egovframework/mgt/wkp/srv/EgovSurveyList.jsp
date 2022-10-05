<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="cont_wrap">
    <div class="cont_header">
        <div class="row">
            <div class="col-xs-6">
                <h2 class="page_title">
                    설문조사 관리 </h2>
            </div>
            <div class="col-xs-6 text-right">
                <p class="msg"><strong class="text-primary">${user.displayName}</strong>님! 반갑습니다.</p>
                <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
            </div>
        </div>
    </div>
    <!-- //cont_header -->
    <div class="cont_body">
        <ol class="breadcrumb">
            <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
            <li class="active">설문조사 관리</li>
        </ol>
        <div id="contents">
            <!-- 총게시물, 게시물 검색 -->
            <!-- 총게시물, 게시물 검색 -->
            <div class="brd_top">
                <div class="row">
                    <div class="col-xs-5 brd_total">
                        <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span
                                class="text-primary">${surveyList.pageNavigation.totalItemCount}</span> / 페이지 <span
                                class="text-black">${page}</span></p>
                    </div>
                    <div class="col-xs-7 text-right">
                        <form class="form-inline bbs_srch_frm" name="searchForm" action="#">
                            <input type="hidden" name="page">
                            <input type="hidden" name="surveyNo">
                            <fieldset>
                                <legend class="sr-only">게시글 검색</legend>
                                <div class="form-group">
                                    <label for="brdSort" class="sr-only">상태정렬</label>
                                    <select id="brdSort" name="type" class="form-control">
                                        <c:forEach var="surveyType" items="${surveyState}">
                                            <option value="${surveyType.name()}"
                                                    <c:if test="${type.name() == surveyType.name()}">selected="selected"</c:if>>
                                                    ${surveyType.value}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
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
            <table class="table text-center table-bordered table-hover brd_list">
                <caption class="sr-only">게시판 목록</caption>
                <colgroup>
                    <col style="width:9%;"/>
                    <col/>
                    <col style="width:9%;"/>
                    <col style="width:20%;"/>
                    <col style="width:9%;"/>
                    <col style="width:10%;"/>
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">설문주제</th>
                    <th scope="col">작성자</th>
                    <th scope="col">설문기간</th>
                    <th scope="col">상태</th>
                    <th scope="col">등록일</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${!empty surveyList.list && fn:length(surveyList.list) > 0}">
                        <c:forEach var="item" items="${surveyList.list }" varStatus="status">
                            <fmt:formatDate var="registDtm" value="${item.registDtm}" pattern="yyyyMMdd"/>
                            <fmt:formatDate var="today" value="${now}" pattern="yyyyMMdd"/>
                            <tr>
                                <td>${surveyList.pageNavigation.totalItemCount - ((surveyList.pageNavigation.pageIndex - 1) * surveyList.pageNavigation.itemCountPerPage + status.index) }</td><!--  번호   -->
                                <td class="text-left">
                                    <p class="subject">
                                        <c:if test="${item.mine}">
                                            <span class="brd_ico chk text-danger"><i
                                                    class="fa fa-check-square"></i><span class="txt">[참여]</span></span>
                                        </c:if>
                                        <a href="javascript:;" class="dev-detail"
                                           data-surveyno="${item.surveyNo}">${item.title}</a>
                                        <c:if test="${today-registDtm <= 1 }">
                                            <span class="brd_ico"><i class="xi-new" title="새글"><span
                                                    class="sr-only">새글</span></i></span>
                                        </c:if>
                                    </p>
                                </td> <!--  제목   -->
                                <td class="hidden-xs hidden-sm">${item.registerName}</td> <!--  작성자   -->
                                <td class="days">
                                    <fmt:formatDate value="${item.bngnDtm}" pattern="yyyy-MM-dd"/>
                                    <span>~</span>
                                    <fmt:formatDate value="${item.endDtm}" pattern="yyyy-MM-dd"/>
                                </td> <!--  설문기간   -->
                                <td><span class="status_txt
                                                    <c:choose>
                                                        <c:when test="${item.aprvState.name() == 'DOING'}">
                                                            text-blue
                                                        </c:when>
                                                        <c:when test="${item.aprvState.name() == 'CANCEL'}">
                                                            text-danger
                                                        </c:when>
                                                        <c:when test="${item.aprvState.name() == 'WAIT'}">
                                                            text-warning
                                                        </c:when>
                                                        <c:otherwise>
                                                            text-black
                                                        </c:otherwise>
                                                    </c:choose>
                                                   ">
                                        ${item.aprvState.value}
                                </span></td> <!--  상태   -->
                                <td class="hidden-xs hidden-sm"><fmt:formatDate value="${item.registDtm}"
                                                                                pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <!--  등록일   -->
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- 데이터 없을시 -->
                        <tr>
                            <td colspan="6" class="empty">등록된 게시물이 없습니다.</td>
                        </tr>
                        <!-- //데이터 없을시 -->
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
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
        </div>
        <!-- //페이지 네비 -->
        <div id="footer">
            <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
        </div>
        <!-- //FOOTER -->
    </div>
    <!-- //cont_body -->
</div>

<script>
    $(function () {

        $('.dev-page').on('click', function () {
            var page = $(this).data("page");
            goPage(page);
        });

        $('.dev-detail').on('click', function () {
            var surveyNo = $(this).data('surveyno');
            var form = $("form[name=searchForm]");
            form.find("input[name=surveyNo]").val(surveyNo);
            form.attr('action', '/adm/surveySetupView.do');
            form.attr("method", "GET");
            form.submit();
        });

    });

    function goPage(page) {
        var form = $("form[name=searchForm]");
        form.find("input[name=page]").val(page);
        form.attr('action', '/adm/surveySetup.do');
        form.submit();
    }

</script>