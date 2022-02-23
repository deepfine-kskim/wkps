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
    
    $('#btn_delete').click(function(){
    	
    	
    	
    	var ids = new Array();
    	$('input:checkbox').each(function() {
    		if($(this).prop('checked')){
    			if(this.id != 'all'){
    				ids.push(this.id);
    			}
    		}
        });

    	if(ids.length == 0){
    		alert("삭제할 게시글을 선택해 주세요.");
    		return;
    	}
    	
    	
    	var result = confirm("정말 삭제하시겠습니까?");
    	if(!result){
    	    return;
    	}
    	
    	var param ={ cmmntyNo: cmmntyNo,
    			noticeNo: ids}; 
		
		$.post("deleteCommunityNotice.do",
 		   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){
		    	location.reload();
 			  }else{
 				 alert(json.err_msg);
 			  } 
			} 
		);
    });
    
    function search(page){
    	var form = $("form[name=pagingForm]");
    	
      	form.find("input[name=page]").val(page);
      	form.find("input[name=search_type]").val($("#search_type").val());	
      	form.find("input[name=search_value]").val($("#search_value").val());
      	form.attr("action", "communityNoticeList.do");
      	form.submit();
    }
	
	
});

</script>
<div class="container sub_cont">
                <div class="row layout_side_row">
﻿<%@ include file="EgovCommunitySide.jsp" %>                    
                    <!-- //ASIDE -->
                    <div id="contents" class="col-md-9">
                        <div class="page-header sub_title">
                            <h2>공지사항</h2>
                        </div>
                        <div class="page-body">
                            <!-- 총게시물, 게시물 검색 -->
                            <div class="brd_top">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-6 data_total">
                                        <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${total_count }</span> / 페이지 <span class="text-black">${total_page }</span></p>
                                    </div>
                                    <div class="col-xs-12 col-sm-6 text-right">
                                        <form class="form-inline bbs_srch_frm" name="searchForm" action="#">
                                            <fieldset>
                                                <legend class="sr-only">게시글 검색</legend>
                                                <div class="form-group">
                                                    <label for="search_type" class="sr-only">검색대상</label>
                                                    <select id="search_type" name="search_type" class="form-control">
                                                        <option value="">제목 + 내용</option>
                                                        <option value="01" <c:if test="${search_type == '01'}">selected</c:if>>제목</option>
                                                        <option value="02" <c:if test="${search_type == '01'}">selected</c:if>>내용</option>
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <label for="search_value" class="sr-only">검색어 입력</label>
                                                    <input type="text" id="search_value" name="search_value" class="form-control" placeholder="검색어" value="${search_value }"/>
                                                    <span class="input-group-btn"><button class="btn btn-default"  id="btn_search">검색</button></span>
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
                                        <col style="width:8%;">
                                        <col style="width:9%;">
                                        <col>
                                        <col style="width:10%;" class="hidden-xs">
                                        <col style="width:12%;">
                                        <col style="width:8%;" class="hidden-xs hidden-sm">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col"><label for="all" class="sr-only">전체선택</label><input type="checkbox" name="all" id="all" class="all_chk" /></th>
                                            <th scope="col">번호</th>
                                            <th scope="col">제목</th>
                                            <th scope="col" class="hidden-xs">작성자</th>
                                            <th scope="col">등록일</th>
                                            <th scope="col" class="hidden-xs hidden-sm">조회</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <c:forEach items="${list }" var="board">
                                        <tr>
                                            <td><label for="brdChk1" class="sr-only">선택</label><input type="checkbox" name="${board.noticeNo }" id="${board.noticeNo }" /></td>
                                            <%-- <td>${board.noticeNo }</td> --%>
                                            <td><c:out value="${pageMaker.totalCount - (pageMaker.page-1) * pageMaker.perPageNum - status.index}"/></td>
                                            <td class="text-left">
                                                <p class="subject">
                                                    <a href="communityNoticeView.do?cmmntyNo=${board.cmmntyNo }&noticeNo=${board.noticeNo }">${board.title }</a>
                                                    <span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span>
                                                </p>
                                            </td>
                                            <td class="hidden-xs">${board.cmmntyNicknm}</td>
                                            <td>${board.strRegDate }</td>
                                            <td class="hidden-xs hidden-sm">${board.inqCnt }</td>
                                        </tr>
                                        </c:forEach>
                                        
                                        <!-- 데이터 없을시 -->
                                        <c:if test="${fn:length(list) == 0}">
                                        <tr>
                                            <td colspan="6" class="empty">등록된 게시글이 없습니다.</td>
                                        </tr>
                                        </c:if>
                                        <!-- //데이터 없을시 -->
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
                            	<ul id="pagination" class="pagination pagination-sm">
                                    
                                </ul>
                            </nav>
                            <!-- //페이지 네비 -->
                            <div class="btn_area">
                            <c:if test="${role=='Y'}">
                                <div class="row type0">
                            		<c:if test="${role_adm == 'Y'}">
                                    <div class="col-xs-6">
                                        <button type="button" class="btn btn-danger" id="btn_delete">선택삭제</button>
                                    </div>
                                    </c:if>
                                    <div class="col-xs-<c:if test="${role_adm == 'Y'}">6</c:if><c:if test="${role_adm != 'Y'}">12</c:if> text-right">
                                        <a href="communityNoticeWrite.do?cmmntyNo=${community.cmmntyNo }" class="btn btn-blue"><i class="ti-pencil-alt"></i> 글작성</a>
                                    </div>
                                </div>
                            </c:if>
                            </div>
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                </div>
                <!-- //row -->
            </div>