<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">개인별 마일리지</h2>
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
					<li class="active">개인별 마일리지</li>
				</ol>
				<div id="contents">
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-5 brd_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${userMileageList.pageNavigation.totalItemCount }</span>  / 페이지 <span class="text-black">${userMileageList.pageNavigation.pageIndex }</span></p>
                            </div>
                            <div class="col-xs-7 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="srchFrm" modelAttribute="userMileageVO">
                                    <input type="hidden" name="page" value="${userMileageList.pageNavigation.pageIndex }">
                                    <input type="hidden" name="sid" value="${sid }">
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
							<col />
							<col />
							<col />
							<col />
							<col style="width:20%;" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">일시</th>
								<th scope="col">이름</th>
								<th scope="col">부서</th>
								<th scope="col">유형</th>
								<th scope="col">대상</th>
								<th scope="col"><button type="button" class="tbl_btn sort_tog">마일리지 <i class="fa fa-caret-down"></i></button></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="userMileage" items="${userMileageList.list}" varStatus="status">
							<tr>
								<td>${userMileageList.pageNavigation.totalItemCount - ((userMileageList.pageNavigation.pageIndex - 1) * userMileageList.pageNavigation.itemCountPerPage + status.index) }</td>
								<td>${userMileage.registDtm }</td>
								<td>${userMileage.displayName }</td>
								<td>${userMileage.ou }</td>
								<td>${userMileage.mileageType }</td>
								<td>${userMileage.title }</td>
								<td><span class="text-blue">${userMileage.mileageScore }</span></td>
							</tr>
							</c:forEach>
						</tbody>
                    </table>
                   <!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul class="pagination pagination-sm">
                        <c:if test="${userMileageList.pageNavigation.totalItemCount > 0 }">
                            <c:if test="${userMileageList.pageNavigation.canPreviousSection == true }">
                            <li>
                                <a href="javascript:;" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" aria-label="Previous" title="이전" onclick="return false;" class="dev-page" data-page="${userMileageList.pageNavigation.numberStart-1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach var="i" begin="${userMileageList.pageNavigation.numberStart }" end="${userMileageList.pageNavigation.numberEnd }" step="1">
                            <li <c:if test="${i == userMileageList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" onclick="return false;" class="dev-page" data-page="${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${userMileageList.pageNavigation.canNextSection == true}">
                            <li>
                                <a href="javascript:;" aria-label="Next" title="다음" class="dev-page" data-page="${userMileageList.pageNavigation.numberEnd+1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" aria-label="Next" title="마지막" class="dev-page" data-page="${userMileageList.pageNavigation.maxNumber }">
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
        
    });
</script>