<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">부서별 마일리지</h2>
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
                    <li>마일리지 관리</li>
					<li class="active">부서별 마일리지</li>
				</ol>
				<div id="contents">
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-5 brd_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${orgMileageList.pageNavigation.totalItemCount }</span>  / 페이지 <span class="text-black">${orgMileageList.pageNavigation.pageIndex }</span></p>
                            </div>
                             <div class="col-xs-7 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="srchFrm" modelAttribute="orgMileageVO">
                                	<input type="hidden" name="page" value="${orgMileageList.pageNavigation.pageIndex }">
                                    <input type="hidden" name="ouCode" value="">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="input-group">
                                            <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                            <input type="text" id="brdSrchStr" name="searchText" class="form-control" placeholder="검색어" />
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
                                    <col style="width:10%;" />
                                    <col />
                                    <col style="width:20%;" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">번호</th>
                                        <th scope="col">부서</th>
                                        <th scope="col"><button type="button" class="tbl_btn sort_tog">마일리지 <i class="fa fa-caret-down"></i></button></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="orgMileage" items="${orgMileageList.list }" varStatus="status">
                                    <!-- 루프 -->
                                    <tr>
                                        <td>${orgMileageList.pageNavigation.totalItemCount - ((orgMileageList.pageNavigation.pageIndex - 1) * orgMileageList.pageNavigation.itemCountPerPage + status.index) }</td>
                                        <td>${orgMileage.ou }</td>
                                        <td><a href=javascript:;"" class="dev-detail" data-code="${orgMileage.ouCode }"><span class="text-blue">${orgMileage.totalScore }</span></a></td>
                                    </tr>
                                    <!-- //루프 -->
                                </c:forEach>
                                </tbody>
                            </table>
                   <!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul class="pagination pagination-sm">
                        <c:if test="${orgMileageList.pageNavigation.totalItemCount > 0 }">
                            <c:if test="${orgMileageList.pageNavigation.canPreviousSection == true }">
                            <li>
                                <a href="javascript:;" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" aria-label="Previous" title="이전" onclick="return false;" class="dev-page" data-page="${orgMileageList.pageNavigation.numberStart-1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach var="i" begin="${orgMileageList.pageNavigation.numberStart }" end="${orgMileageList.pageNavigation.numberEnd }" step="1">
                            <li <c:if test="${i == orgMileageList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" onclick="return false;" class="dev-page" data-page="${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${orgMileageList.pageNavigation.canNextSection == true}">
                            <li>
                                <a href="javascript:;" aria-label="Next" title="다음" class="dev-page" data-page="${orgMileageList.pageNavigation.numberEnd+1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" aria-label="Next" title="마지막" class="dev-page" data-page="${orgMileageList.pageNavigation.maxNumber }">
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
			</div>
			<!-- //cont_body -->
				
            <div id="footer">
                <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
            </div>
            <!-- //FOOTER -->
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
        
        $('.dev-detail').on('click', function (e) {
        	e.preventDefault();
            var ouCode = $(this).data('code');
            var form = $("form[name=srchFrm]");
            form.find("input[name=ouCode]").val(ouCode);
            form.attr("action", "/adm/orgMileageDetail.do");
            form.submit();
        });

    });
</script>