<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/js/egovframework/com/wkp/paging.js"></script>
<script>

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
      	form.find("input[name=useYn]").val($("#useYn").val());	
      	form.find("input[name=search_value]").val($("#search_value").val());
      	form.attr("action", "commBnr.do");
      	form.submit();
    }
	
	
});

</script>
<div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">
                            배너 관리                                    </h2>
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
                    <li>커뮤니케이션 관리</li>
                                        <li class="active">배너 관리</li>
                                    </ol>
                                <div id="contents">


                                        <!-- 총게시물, 게시물 검색 -->
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-5 brd_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${total_count }</span>  / 페이지 <span class="text-black">${total_page }</span></p>
                            </div>
                             <div class="col-xs-7 text-right">
                                <div class="form-inline bbs_srch_frm" >
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="form-group">
                                            <label for="useYn" class="sr-only">상태정렬</label>
                                            <select id="useYn" name="useYn" class="form-control">
                                                <option value="">전체</option>
                                                <option value="Y" <c:if test="${useYn == 'Y'}">selected</c:if>>노출</option>
                                                <option value="N" <c:if test="${useYn == 'N'}">selected</c:if>>미노출</option>
                                            </select>
                                        </div>
                                        <div class="input-group">
                                            <label for="search_value" class="sr-only">검색어 입력</label>
                                            <input type="text" id="search_value" name="search_value" class="form-control flow-enter-search" value="${search_value }" placeholder="커뮤니티명 입력" data-search-button="btn_search"/>
                                            <span class="input-group-btn"><button  class="btn btn-default" id="btn_search" >검색</button></span>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //총게시물, 게시물 검색 -->
                    <!-- 게시판 목록 -->
                    <table class="table text-center table-bordered table-hover brd_list">
                        <caption class="sr-only">게시판 목록</caption>
                        <colgroup>
                            <col style="width:9%;">
                            <col>
                            <col style="width:30%;">
                            <col style="width:10%;">
                            <col style="width:12%;">
                            <col style="width:10%;">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">배너 이미지</th>
                            <th scope="col">커뮤니티명</th>
                            <th scope="col">등록자</th>
                            <th scope="col">등록일</th>
                            <th scope="col">노출상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list }" var="banner" varStatus="status">
                        <tr>
                            <td><c:out value="${total_count - (page-1) * rows - status.index}"/></td>
                            <td>
                                <span class="bnr_img"><a href="commBnrDetail.do?bannerNo=${banner.bannerNo }"><img src="${banner.fileStreCours }${banner.streFileNm }" alt="" /></a></span>
                            </td>
                            <td>
                                <p class="subject">
                                    <a href="commBnrDetail.do?bannerNo=${banner.bannerNo }">${banner.title }</a>
                                </p>
                            </td>
                            <td>${banner.registId}</td>
                            <td><fmt:formatDate value="${banner.registDtm}" pattern="yyyy-MM-dd"/></td>
                            <td>
                            <c:if test="${banner.useYn=='Y' }"><span class="text-primary">노출</span></c:if>
                            <c:if test="${banner.useYn=='N' }"><span class="text-danger">미노출</span></c:if>
                            
                            </td>
                        </tr>
                        </c:forEach>
                        <c:if test="${fn:length(list) == 0}">
                        <!-- 데이터 없을시 -->
                        <tr>
                            <td colspan="6" class="empty">등록된 배너가 없습니다.</td>
                        </tr>
                        <!-- //데이터 없을시 -->
                        </c:if>
                        </tbody>
                    </table>
                    <!-- //게시판 목록 -->
                            <form name="pagingForm" method="GET" action="">
                            
                            <input type="hidden" name="rows" value="${rows}"/>
								<input type="hidden" name="page" value="${page}"/>
								<input type="hidden" name="useYn" value="${useYn}"/>
								<input type="hidden" name="search_value" value="${search_value}"/>
						   </form>            <!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul id="pagination" class="pagination pagination-sm">
                            
                        </ul>
                    </nav>
                    <!-- //페이지 네비 -->                    <div class="btn_area text-right">
                        <a href="commBnrRegist.do" class="btn btn-blue min-lg btn-lg">등록</a>
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