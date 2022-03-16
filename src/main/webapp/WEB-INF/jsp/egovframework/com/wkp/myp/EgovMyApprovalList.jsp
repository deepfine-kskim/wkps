<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
       <div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>지식 신고/등록</h2>
                </div>
                <!-- //page-header -->

                <div class="page-body">
                    <ul class="nav nav-tabs" role="tablist">
                        <%--<li role="presentation"><a href="/myp/errorList.do">오류 신고</a></li>--%>
                        <li role="presentation" class="active"><a href="/myp/approvalList.do">지식 등록</a></li>
                    </ul>
                    <p class="help-block text-right text-black mb_5"><span class="text-danger">※ [반려사유]</span> 클릭 시 반려 사유를 확인하실 수 있습니다.</p>
                    <!-- 총게시물, 게시물 검색 -->
                    <div class="brd_top">
                        <div class="row type0">
                            <div class="col-xs-12 col-sm-4 data_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${knowledgeList.pageNavigation.totalItemCount }</span>  / 페이지 <span class="text-black">${knowledgeList.pageNavigation.pageIndex }</span></p>
                            </div>
                            <div class="col-xs-12 col-sm-8 text-right">
                                <form:form class="form-inline bbs_srch_frm" name="searchForm" modelAttribute="knowledgeVO">
									<input type="hidden" name="page" value="${knowledgeList.pageNavigation.pageIndex }">
                                   	<input type="hidden" name="knowlgNo" value="0">
                                   	<input type="hidden" name="title" value="">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="input-group">
                                            <label for="brdSrchStr" class="sr-only">검색어 입력</label>
                                            <input type="text" id="brdSrchStr" name="brdSrchStr" class="form-control" placeholder="제목 검색" />
                                            <span class="input-group-btn"><button type="submit" class="btn btn-default">검색</button></span>
                                        </div>
                                    </fieldset>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    <!-- //총게시물, 게시물 검색 -->


                    <!-- 게시판 목록 -->
                    <div class="table-responsive">
                        <table class="table text-center table-bordered table-hover brd_list">
                            <caption class="sr-only">게시판 목록</caption>
                            <colgroup>
                                <col style="width:9%;">
                                <col style="width:9%;">
                                <col>
                                <col style="width:10%;">
                                <col style="width:12%;">
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">유형</th>
                                <th scope="col">제목</th>
                                <th scope="col">상태</th>
                                <th scope="col">등록일</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
	                            <c:when test="${not empty knowledgeList.list }">
	                            <c:forEach var="knowledge" items="${knowledgeList.list }" varStatus="status">
	                            	<tr>
	                            		<td>${knowledgeList.pageNavigation.totalItemCount - ((knowledgeList.pageNavigation.pageIndex - 1) * knowledgeList.pageNavigation.itemCountPerPage + status.index) }</td>
	                            		<td class="text-primary">
			                           		<c:choose>
			                           		<c:when test="${knowledge.knowlgMapType eq 'REPORT' }">행정자료</c:when>
			                           		<c:when test="${knowledge.knowlgMapType eq 'REFERENCE' }">업무참고자료</c:when>
			                           		<c:otherwise>개인별지식</c:otherwise>
			                           		</c:choose>
	                            		</td>
	                            		<td class="text-left">
	                            			<p class="subject">
	                            				<!-- <a href="javascript:;" class="dev-detail" data-knowlgno="${knowledge.knowlgNo }" data-title="${knowledge.title }"></a> -->
	                            				${knowledge.title }
	                            				<c:if test="${knowledge.isNew }"><span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span></c:if>
	                            			</p>
	                            		</td>
	                            		<c:choose>
	                            		<c:when test="${knowledge.aprvYn eq 'Y'}">
	                            			<td>승인완료</td>
	                            		</c:when>
	                            		<c:when test="${knowledge.aprvYn eq 'N' and empty knowledge.aprvCont}">
	                            			<td class="text-blue">승인대기</td>
	                            		</c:when>
	                            		<c:otherwise>
                                        	<td><a href="#alertPopup" data-toggle="modal" data-target="#alertPopup" class="text-danger dev-reject" data-no="${status.index }">[반려사유]</a></td>
	                            		</c:otherwise>
	                            		</c:choose>
	                            		<td>${knowledge.registDtm }</td>
	                            	</tr>
	                            </c:forEach>
	                            </c:when>
                            	<c:otherwise>
                            	<!-- 데이터 없을시 -->
                            	<tr>
                            		<td colspan="5" class="empty">등록된 게시글이 없습니다.</td>
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
                        <c:if test="${knowledgeList.pageNavigation.totalItemCount > 0 }">
                            <c:if test="${knowledgeList.pageNavigation.canPreviousSection == true }">
                            <li>
                                <a href="javascript:;" aria-label="Previous" title="처음" class="dev-page" data-page="1">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" aria-label="Previous" title="이전" onclick="return false;" class="dev-page" data-page="${knowledgeList.pageNavigation.numberStart-1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                            
                            <c:forEach var="i" begin="${knowledgeList.pageNavigation.numberStart }" end="${knowledgeList.pageNavigation.numberEnd }" step="1">
                            <li <c:if test="${i == knowledgeList.pageNavigation.pageIndex }">class="active"</c:if>><a href="javascript:;" class="dev-page" data-page="${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${knowledgeList.pageNavigation.canNextSection == true}">
                            <li>
                                <a href="javascript:;" aria-label="Next" title="다음" class="dev-page" data-page="${knowledgeList.pageNavigation.numberEnd+1 }">
                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" aria-label="Next" title="마지막" class="dev-page" data-page="${knowledgeList.pageNavigation.maxNumber }">
                                    <span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>
                                </a>
                            </li>
                            </c:if>
                        </c:if>
                        </ul>
                    </nav>
                  		<!-- //페이지 네비 -->
                    <div class="btn_area">
                        <div class="row type0">
                            <div class="col-xs-12">
                                <a href="/myp/mypage.do" class="btn btn-black outline">마이페이지</a>
                            </div>
                        </div>
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


            </div>
            <!-- //CONTENTS -->
        </div>
<script>
    $(function () {
    	var aprvContArr = new Array();
        <c:forEach var="item" items="${knowledgeList.list }">
        	aprvContArr.push({aprvCont:"${item.aprvCont }"});
        </c:forEach>    	
    	
        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
            var page = $(this).data('page');
            var form = $("form[name=searchForm]");
            form.find("input[name=page]").val(page);
            form.submit();
        });
        
        $('.dev-detail').on('click', function (e) {
        	e.preventDefault();
            var knowlgNo = $(this).data('knowlgno');
            var title = $(this).data('title');            
            var form = $("form[name=searchForm]");
            form.find("input[name=knowlgNo]").val(knowlgNo);
            form.find("input[name=title]").val(title);
            form.attr("action", "/kno/knowledgeDetail.do");
            form.submit();
        });
        
        $('.dev-reject').on('click', function (e) {
        	e.preventDefault();
            var no = $(this).data('no');
           $('#result').html(aprvContArr[no].aprvCont);
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