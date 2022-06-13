<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="cont_wrap">
    <div class="cont_header">
        <div class="row">
            <div class="col-xs-6">
                <h2 class="page_title">지식 수정요청 관리</h2>
            </div>
            <div class="col-xs-6 text-right">
                <p class="msg"><strong class="text-primary">${loginVO.displayName}</strong>님! 반갑습니다.</p>
                <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
            </div>
        </div>
    </div>
    <!-- //cont_header -->
    <div class="cont_body">
        <ol class="breadcrumb">
            <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
            <li>지식 관리</li>
            <li class="active">지식 수정요청 관리</li>
        </ol>
        <div id="contents">
        <!-- 총게시물, 게시물 검색 -->
            <div class="brd_top">
                <div class="row">
                    <div class="col-xs-5 brd_total">
                        <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${pageNavigation.totalItemCount}</span>  / 페이지 <span class="text-black">${pageNavigation.pageIndex}</span></p>
                    </div>
                     <div class="col-xs-7 text-right">
                         <form class="form-inline bbs_srch_frm" name="searchForm">
                            <input type="hidden" name="page" value="${knowledgeVO.page}">
                            <input type="hidden" name="searchType" value="TITLE">
                            <fieldset>
                                <legend class="sr-only">게시글 검색</legend>
                                <div class="input-group">
                                    <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                    <input type="text" id="brdSrchStr" name="searchText" class="form-control flow-enter-search" placeholder="제목 검색" data-search-button="srchBtn" value="<c:out value="${knowledgeVO.searchText}"/>"/>
                                    <span class="input-group-btn"><button type="button" id="srchBtn" class="btn btn-default">검색</button></span>
                                </div>
                            </fieldset>
                         </form>
                    </div>
                </div>
            </div>
            <!-- //총게시물, 게시물 검색 -->
            <!-- 게시판 목록 -->
            <table class="table text-center table-bordered table-hover brd_list all_chks_frm">
                <caption class="sr-only">게시판 목록</caption>
                <colgroup>
                    <col style="width:4%;">
                    <col style="width:6%;">
                    <col style="width:10%;">
                    <col>
                    <col style="width:15%;">
                    <col style="width:10%;">
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col"><label for="all" class="sr-only">전체선택</label><input type="checkbox" name="all" id="all" class="all_chk" /></th>
                        <th scope="col">번호</th>
                        <th scope="col">유형</th>
                        <th scope="col">제목</th>
                        <th scope="col">요청자</th>
                        <th scope="col">요청일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr>
                            <td><label for="chk_${status.index}" class="sr-only">선택</label><input type="checkbox" name="chk_${status.index}" id="chk_${status.index}" class="flow-check" data-request-no="<c:out value="${result.requestNo}"/>" data-owner-id="<c:out value="${result.ownerId}"/>" data-title="<c:out value="${result.title}"/>"/></td>
                            <td>${pageNavigation.totalItemCount - ((pageNavigation.pageIndex - 1) * pageNavigation.itemCountPerPage + status.index)}</td>
                            <td class="text-primary" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 0;"><c:out value="${result.parentKnowlgMapNm}"/></td>
                            <td class="text-left"><c:out value="${result.title}"/></td>
                            <td><c:out value="${result.displayName}(${result.ou})"/></td>
                            <td><c:out value="${result.registDtm}"/></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${fn:length(resultList) eq 0}">
                        <!-- 데이터 없을시 -->
                        <tr>
                            <td colspan="6" class="empty">등록된 게시글이 없습니다.</td>
                        </tr>
                        <!-- //데이터 없을시 -->
                    </c:if>
                </tbody>
            </table>
            <!-- //게시판 목록 -->
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
            <div class="btn_area">
                <button type="button" class="btn btn-blue flow-action-resend">알림 재전송</button>
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
            const page = $(this).data('page');
            const form = $("form[name=searchForm]");
            form.find("input[name=page]").val(page);
            form.attr("action", "/adm/modificationList.do");
            form.submit();
        });

        $("#srchBtn").click(function () {
            const form = $("form[name=searchForm]");
            form.find("input[name=page]").val(1);
            form.attr("action", "/adm/modificationList.do");
            form.submit();
        });

        $('.flow-action-resend').off('click').on('click', function () {
            const data = [];

            $('.flow-check:checked').each(function (i, item) {
                const requestNo = $(item).data('request-no');
                const ownerId = $(item).data('owner-id');
                const title = $(item).data('title');
                data.push({
                    requestNo: requestNo,
                    ownerId: ownerId,
                    title: title
                });
            });

            if (data.length === 0) {
                alert('알림을 재전송할 지식을 선택해주세요.');
                return false;
            }

            if (confirm('선택한 지식의 담당자에게 알림을 재전송하시겠습니까?')) {
                $.ajax({
                    url: "/adm/resendNotification.do",
                    type: 'post',
                    data: JSON.stringify(data),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        alert('알림이 재전송되었습니다.');
                    },
                    error: function (error) {
                        alert('처리 중 오류가 발생했습니다.');
                    }
                });
            }
        });
    });
</script>