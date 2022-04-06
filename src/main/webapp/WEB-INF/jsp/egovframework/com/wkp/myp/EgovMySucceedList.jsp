<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="container sub_cont">
    <div id="contents">
        <div class="page-header">
            <h2>지식 수정요청/승계</h2>
        </div>
        <!-- //page-header -->

        <div class="page-body">
            <ul class="nav nav-tabs" role="tablist">
                <%--<li role="presentation"><a href="/myp/errorList.do">오류 신고</a></li>--%>
                <%--<li role="presentation" class="active"><a href="/myp/approvalList.do">지식 등록</a></li>--%>
                <li role="presentation"><a href="/myp/modificationList.do">지식 수정요청</a></li>
                <li role="presentation" class="active"><a href="/myp/succeedList.do">지식 승계</a></li>
            </ul>
            <!-- 총게시물, 게시물 검색 -->
            <div class="brd_top">
                <div class="row type0">
                    <div class="col-xs-12 col-sm-4 data_total">
                        <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${pageNavigation.totalItemCount }</span>  / 페이지 <span class="text-black">${pageNavigation.pageIndex }</span></p>
                    </div>
                    <div class="col-xs-12 col-sm-8 text-right">
                        <form class="form-inline bbs_srch_frm" name="searchForm">
                            <input type="hidden" name="page" value="${knowledgeVO.page}">
                            <input type="hidden" name="searchType" value="TITLE">
                            <input type="hidden" name="requestNo">
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
            <div class="table-responsive">
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
                        <th scope="col">지식 소유 부서</th>
                        <th scope="col">등록일</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="result" items="${resultList}" varStatus="status">
                            <tr>
                                <td><label for="chk_${status.index}" class="sr-only">선택</label><input type="checkbox" name="chk_${status.index}" id="chk_${status.index}" class="flow-check" data-title="<c:out value="${result.title}"/>"/></td>
                                <td>${pageNavigation.totalItemCount - ((pageNavigation.pageIndex - 1) * pageNavigation.itemCountPerPage + status.index)}</td>
                                <td class="text-primary" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 0;"><c:out value="${result.parentKnowlgMapNm}"/></td>
                                <td class="text-left">
                                    <c:if test="${result.needSucceed eq 1}">
                                        <i class="fa fa-exclamation-circle text-danger" data-toggle="tooltip" title="지식 승계가 필요한 지식입니다."></i>
                                    </c:if>
                                    <c:out value="${result.title}"/>
                                </td>
                                <td><c:out value="${result.ownerOu}"/></td>
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
            </div>
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
                <a href="#selectOwner" data-toggle="modal" data-target="#selectOwner" class="btn btn-blue">담당자 변경</a>
            </div>
        </div>
        <!-- //page-body -->
    </div>
    <!-- //CONTENTS -->
</div>

<!-- 조직그룹 선택 팝업 -->
<div class="modal fade" id="selectOwner" tabindex="-1" role="dialog" aria-labelledby="selectOwnerLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="selectOwnerLabel">담당자 검색</h4>
            </div>
            <div class="modal-body">
                <div class="tab-content">
                    <div id="selectGrpTab1" class="tab-pane active" role="tabpanel">
                        <div class="srch_area">
                            <fieldset>
                                <legend class="sr-only">담당자 검색영역</legend>
                                <div class="input-group">
                                    <label for="ownerText" class="sr-only">담당자 이름 입력</label>
                                    <input type="text" id="ownerText" name="ownerText" class="form-control flow-enter-search" placeholder="선택한 지식을 승계받을 담당자를 검색해주세요." data-search-button="ownerBtn">
                                    <span class="input-group-btn"><a href="javascript:;" id="ownerBtn" class="btn btn-default">검색</a></span>
                                </div>
                            </fieldset>
                        </div>
                        <div class="hummingbird-treeview well chk_tree_area">
                            <ul id="ownerList" class="chk_tree_list hummingbird-base treeview">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-blue flow-action-succeed">승계</button>
            </div>
        </div>
    </div>
</div>
<!-- //조직그룹 선택 팝업 -->

<script>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip();

        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
            const page = $(this).data('page');
            const form = $("form[name=searchForm]");
            form.find("input[name=page]").val(page);
            form.attr("action", "/myp/succeedList.do");
            form.submit();
        });

        $("#srchBtn").click(function () {
            const form = $("form[name=searchForm]");
            form.find("input[name=page]").val(1);
            form.attr("action", "/myp/succeedList.do");
            form.submit();
        });

        $('.flow-action-succeed').off('click').on('click', function () {
            const $selectedOwner = $('#ownerList').find('[name=userList]:checked');
            const newOwner = $selectedOwner.data('ou') + ' ' + $selectedOwner.data('name');
            const newOwnerId = $selectedOwner.val();

            if ($selectedOwner.length === 0) {
                alert('지식을 승계받을 담당자를 선택해주세요.')
                return false;
            }

            if (confirm('선택한 지식을 ' + newOwner + '님에게 승계하시겠습니까?')) {
                const titleList = [];
                $('.flow-check:checked').each(function (i, item) {
                    titleList.push($(item).data('title'));
                });

                const data = {
                    ownerId: newOwnerId,
                    titleList: titleList
                };

                $.ajax({
                    url: "/myp/succeedSave.do",
                    type: 'post',
                    data: JSON.stringify(data),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        alert('정상적으로 처리되었습니다.');
                        const form = $("form[name=searchForm]");
                        form.submit();
                    },
                    error: function (error) {
                        alert('처리 중 오류가 발생했습니다.');
                    }
                });
            }
        });

        $('#selectOwner').off('show.bs.modal').on('show.bs.modal', function () {
            if ($('.flow-check:checked').length === 0) {
                alert('지식을 선택해주세요.');
                return false;
            }
        });

        $('#selectOwner').off('hide.bs.modal').on('hide.bs.modal', function () {
            $(this)
                .find('input[type="text"]').val('').end()
                .find('.flow-search-list').remove().end()
        });

        $('#ownerBtn').off('click').on('click', function (e) {
            $('.chk_tree_area').mCustomScrollbar('scrollTo', 'top', { scrollInertia: 0 });

            const ownerName = $("input[name=ownerText]").val();

            if ($.trim(ownerName) === '') {
                alert("담당자 이름을 입력해주세요.");
                return false;
            }

            $.ajax({
                url: '/usr/userList.do',
                data: {
                    displayName: ownerName
                },
                dataType: "json",
                success: function (data) {
                    $('#ownerList li.flow-search-list').remove();
                    $('#ownerList').prepend('<li class="flow-search-list">---------------------------------------------------------------------------</li>');
                    if (data.userList.length > 0) {
                        for (let i = 0; i < data.userList.length; i++) {
                            $('#ownerList').prepend('<li class="flow-search-list"><label for="allSrchChk-' + i + '"><input id="allSrchChk-' + i + '" name="userList" data-id="allSrchChk-' + i + '" type="radio" value="' + data.userList[i].sid + '" data-name="' + data.userList[i].displayName + '" data-ou="' + data.userList[i].ou + '"> ' + data.userList[i].ou + ' ' + data.userList[i].displayName + '</label></li>');
                        }
                    } else {
                        $('#ownerList').prepend('<li class="flow-search-list">검색 결과가 없습니다.</li>');
                    }
                },
                error: function () {
                    alert('처리 중 오류가 발생했습니다. 관리자에게 문의해주세요.');
                }
            });
        });
    });
</script>
<c:if test="${not empty myBG }">
<style>
body{
	background-image:url("${myBG[0].fileStreCours }${myBG[0].streFileNm }");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
</c:if>