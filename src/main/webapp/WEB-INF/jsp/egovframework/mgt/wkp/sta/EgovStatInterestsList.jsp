<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">관심분야 통계</h2>
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
                    <li class="active">관심분야 통계</li>
                </ol>
                <div id="contents">
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-5 brd_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${interestsList.pageNavigation.totalItemCount }</span>  / 페이지 <span class="text-black">${interestsList.pageNavigation.pageIndex }</span></p>
                            </div>
                             <div class="col-xs-7 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="srchFrm" modelAttribute="knowledgeVO">
                                    <input type="hidden" name="page" value="${interestsList.pageNavigation.pageIndex }">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="form-group">
                                            <label for="brdSrchSel" class="sr-only">검색대상</label>
                                            <select id="brdSrchSel"  name="brdSrchSel" class="form-control">
                                                <option>제목 + 내용</option>
                                                <option>제목</option>
                                                <option>내용</option>
                                            </select>
                                        </div>
                                        <div class="input-group">
                                            <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                            <input type="text" id="brdSrchStr" name="searchText" class="form-control" placeholder="검색어" value="${searchText }"/>
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
                            <col style="width:8%;" />
                            <col style="width:11%;" />
                            <col />
                            <col />
                            <col />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">유형</th>
								<th scope="col">대분류</th>
                                <th scope="col">소분류</th>
                                <th scope="col">등록수</th>
                            </tr>
                        </thead>
                        <tbody>                        	
                            <c:forEach var="interests" items="${interestsList.list }" varStatus="status">
                            <tr>
                            	<td>${interestsList.pageNavigation.totalItemCount - ((interestsList.pageNavigation.pageIndex - 1) * interestsList.pageNavigation.itemCountPerPage + status.index) }</td>
                            	<td>
                            	<c:choose>
                            	<c:when test="${interests.knowlgMapType eq 'REPORT' }">행정자료</c:when>
                            	<c:when test="${interests.knowlgMapType eq 'REFERENCE' }">업무참고자료</c:when>
                            	<c:otherwise>개인별지식</c:otherwise>
                            	</c:choose>
                            	</td>
                            	<td>${interests.upNm }</td>
                            	<td>${interests.knowlgMapNm }</td>
                            	<td>${interests.interestsCnt }</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul class="pagination pagination-sm">
                        <c:if test="${interestsList.pageNavigation.totalItemCount > 0 }">
                            <c:if test="${interestsList.pageNavigation.canPreviousSection == true }">
                            <li>
                                <a href="#" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Previous" title="이전" onclick="return false;"
                                   class="dev-page" data-page="${interestsList.pageNavigation.numberStart-1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach var="i" begin="${interestsList.pageNavigation.numberStart }" end="${interestsList.pageNavigation.numberEnd }" step="1">
                            <li <c:if test="${i == interestsList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" onclick="return false;" class="dev-page" data-page="${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${interestsList.pageNavigation.canNextSection == true }">
                            <li>
                                <a href="#" aria-label="Next" title="다음" class="dev-page" data-page="${interestsList.pageNavigation.numberEnd+1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="#" aria-label="Next" title="마지막" class="dev-page"
                                   data-page="${interestsList.pageNavigation.maxNumber }">
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
        	var page = $(this).data('page');
            var form = $("form[name=srchFrm]");
            form.find("input[name=page]").val(page);
            form.submit();
        });
        
    });
</script>