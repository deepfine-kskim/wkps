<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/js/egovframework/com/wkp/paging.js"></script>
<script>
var cmmntyNo = ${community.cmmntyNo};
$(function() {
	var total_page = ${total_page};
	var rows = ${rows};
	var page = ${page};
	if(total_page > 0){
		$('#pagination')
	    .twbsPagination({
	        totalPages: total_page,
	        visiblePages: rows,
	        startPage : page,
	        initiateStartPageClick: false,
	        first: '<span aria-hidden="true"><i class="fa fa-angle-double-left" aria-hidden="true"></i></span>',
	        prev: '<span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>',
	        next: '<span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>',
	        last: '<span aria-hidden="true"><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>',
	        onPageClick: function(event, page) {
	        	
	        	search(page);
	        	
	            //$('#page-content').text('Page ' + page)
	        }
	    })	
	}
    $('#btn_search').click(function(){
    	search(1);
    });
    
    
    
    
    function search(page){
    	var form = $("form[name=pagingForm]");
    	
      	form.find("input[name=page]").val(page);
      	form.find("input[name=search_type]").val($("#search_type").val());	
      	form.find("input[name=search_value]").val($("#search_value").val());
      	form.attr("action", "communityMember.do");
      	form.submit();
    }
	
});

</script>
<div class="container sub_cont">
                <div class="row layout_side_row">
                    <%@ include file="EgovCommunitySide.jsp" %>  
                    <!-- //ASIDE -->
                    <div id="contents" class="col-md-9">
                        <div class="page-header sub_title">
                            <h2>전체회원 목록</h2>
                        </div>
                        <div class="page-body">
                            <!-- 게시판 목록 -->
                            <div class="table-responsive">
                                <table class="table text-center table-bordered table-hover brd_list">
                                    <caption class="sr-only">게시판 목록</caption>
                                    <colgroup>
                                        <col style="width:20%;">
                                        <col>
                                        <col>
                                        <col>
                                        <col style="width:15%;">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">닉네임</th>
                                            <th scope="col">부서</th>
                                            <th scope="col">게시글 수</th>
                                            <th scope="col">댓글 수</th>
                                            <th scope="col">가입일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${community.memPubYn == 'Y'}">
                                        <c:forEach items="${list}" var="mem">
                                        <tr>
                                            <td class="text-primary">${mem.cmmntyNicknm }</td>
                                            <td>${mem.ou }</td>
                                            <td><span class="text-blue">${mem.freeCount }</span>개</td>
                                            <td><span class="text-blue">${mem.commentCount }</span>개</td>
                                            <td>${mem.strRegDate }</td>
                                        </tr>
                                        </c:forEach>
                                        </c:if>
                                        <c:if test="${fn:length(list)==0 or community.memPubYn == 'N' }">
                                        <tr>
                                            <td colspan="5" class="empty">
                                            <c:if test="${fn:length(list)==0}">
                                            	회원이 없습니다.
                                            </c:if>
                                            <c:if test="${fn:length(list)>0 and community.memPubYn == 'N' }">
                                            	회원 목록을 공개하지 않은 커뮤니티 입니다
                                            </c:if>
                                            </td>
                                        </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                            <!-- //게시판 목록 -->
                            <!-- 페이지 네비 -->
                            <form name="pagingForm" method="GET" action="">
                            
                            	<input type="hidden" name="cmmntyNo" value="${community.cmmntyNo}"/>
								<input type="hidden" name="page" value="${page}"/>
								<input type="hidden" name="search_type" value="${search_type}"/>
								<input type="hidden" name="search_value" value="${search_value}"/>
						   </form>
                            <nav class="text-center">
                                <ul  id="pagination" class="pagination pagination-sm">
                                    
                                </ul>
                            </nav>
                            <!-- //페이지 네비 -->
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                    <!-- 알림팝업 -->
                    <div class="modal fade" id="alertPopup" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
                        <div class="modal-dialog modal-sm" role="document">
                            <form class="modal-content">
                                <div class="modal-header sr-only">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="alertPopupLabel">알림</h4>
                                </div>
                                <div class="modal-body text-center">
                                    회원 목록을<br />
                                    공개하지 않은 커뮤니티 입니다
                                </div>
                                <div class="modal-footer text-center">
                                    <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- //알림팝업 -->
                </div>
                <!-- //row -->
            </div>