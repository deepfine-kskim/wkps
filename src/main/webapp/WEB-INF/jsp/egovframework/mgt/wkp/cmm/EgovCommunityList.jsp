<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
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
      	form.find("input[name=aprvYn]").val($("#aprvYn").val());
      	form.find("input[name=search_type]").val($("#search_type").val());	
      	form.find("input[name=search_value]").val($("#search_value").val());
      	form.attr("action", "commRequest.do");
      	form.submit();
    }
	
	
});

</script>
<div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">승인 관리</h2>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="msg"><strong class="text-primary">${user.displayName }</strong>님! 반갑습니다.</p>
                        <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
                    </div>
                </div>
            </div>
            <!-- //cont_header -->
            <div class="cont_body">
                                <ol class="breadcrumb">
                    <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
                    <li>커뮤니케이션 관리</li>
                                        <li class="active">승인 관리</li>
                                    </ol>
                                <div id="contents">
                                        <!-- 총게시물, 게시물 검색 -->
                    <div class="brd_top">
                        <div class="row">
                            <div class="col-xs-5 brd_total">
                                <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 게시물 <span class="text-primary">${total_count }</span>  / 페이지 <span class="text-black">${total_page }</span></p>
                            </div>
                             <div class="col-xs-7 text-right">
                                <div class="form-inline bbs_srch_frm">
                                    <fieldset>
                                        <legend class="sr-only">게시글 검색</legend>
                                        <div class="form-group">
                                            <label for="aprvYn" class="sr-only">상태정렬</label>
                                            <select id="aprvYn" name="aprvYn" class="form-control">
                                                <option value="">전체</option>
                                                <option value="N" <c:if test="${aprvYn == 'N' }">selected</c:if>>승인대기</option>
                                                <option value="R" <c:if test="${aprvYn == 'R' }">selected</c:if>>반려</option>
                                                <option value="Y" <c:if test="${aprvYn == 'Y' }">selected</c:if>>승인완료</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="search_type" class="sr-only">검색대상</label>
                                            <select id="search_type" name="search_type" class="form-control">
                                                <option value="">이름 + 설명</option>
                                                <option value="01">이름</option>
                                                <option value="02">설명</option>
                                            </select>
                                        </div>
                                        <div class="input-group">
                                            <label for="search_value" class="sr-only">검색어 입력</label>
                                            <input type="text" id="search_value" name="search_value" class="form-control" placeholder="검색어" value="${search_value }"/>
                                            <span class="input-group-btn"><button class="btn btn-default" id="btn_search">검색</button></span>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //총게시물, 게시물 검색 -->                    <!-- 게시판 목록 -->
                    <table class="table text-center table-bordered table-hover brd_list">
                        <caption class="sr-only">게시판 목록</caption>
                        <colgroup>
                            <col style="width:9%;">
                            <col>
                            <col style="width:10%;">
                            <col style="width:12%;">
                            <col style="width:10%;">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">커뮤니티명</th>
                            <th scope="col">개설자</th>
                            <th scope="col">등록일</th>
                            <th scope="col">상태</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${list }" var="community" varStatus="status">
                        <tr>
                        
                            <td><c:out value="${total_count - (page-1) * rows - status.index}"/></td>
                            <td class="text-left">
                                <p class="subject">
                                    <a href="commRequestDetail.do?cmmntyNo=${community.cmmntyNo }">${community.cmmntyNm }</a>
                                    <c:if test="${community.isNew }"><span class="brd_ico"><i class="xi-new"><span class="sr-only">새글</span></i></span></c:if>
                                </p>
                            </td>
                            <td>${community.cmmntyNicknm}</td>
                            <td>
                            
                            <fmt:formatDate value="${community.registDtm}" pattern="yyyy-MM-dd"/>
                            
                            </td>
                            <td>
                            <c:if test="${community.aprvYn == 'Y' }">
                            <span class="text-black">승인완료</span>
                            </c:if>
                            <c:if test="${community.aprvYn == 'N' }">
                            <span class="text-warning">승인대기</span>
                            </c:if>
                            <c:if test="${community.aprvYn == 'R' }">
                            <span class="text-danger">반려</span>
                            </c:if>
                            </td>
                        </tr>
                        </c:forEach>
                        
                        </tbody>
                    </table>
                    <!-- //게시판 목록 -->
                           <form name="pagingForm" method="GET" action="">
								<input type="hidden" name="page" value="${page}"/>
								<input type="hidden" name="rows" value="${rows}"/>
								<input type="hidden" name="aprvYn" value="${aprvYn}"/>
								<input type="hidden" name="search_type" value="${search_type}"/>
								<input type="hidden" name="search_value" value="${search_value}"/>
						   </form>             <!-- 페이지 네비 -->
                    <nav class="text-center">
                        <ul id="pagination" class="pagination pagination-sm">
                            
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