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
    
    $('#btn_staff_mem').click(function(){
    	var ids = new Array();
    	$('input:checkbox').each(function() {
    		if($(this).prop('checked')){
    			if(this.id != 'all'){
    				ids.push(this.id);
    			}
    		}
        });

    	if(ids.length == 0){
    		alert("회원을 선택해 주세요.");
    		return;
    	}
    	
    	var param ={ cmmntyNo: cmmntyNo,
    			mberNo:ids}; 
		
		$.post("staffMember.do",
 		   param, 
		   function(data, status) {
			  var json = JSON.parse(data);
		      if(json.success){
		    	 alert('적용 하였습니다.');
		    	 location.reload();
			  }else{
				 alert(json.err_msg);
			  } 
			} 
		);
		
    });
    
    $('#btn_del_mem').click(function(){
    	var ids = new Array();
    	$('input:checkbox').each(function() {
    		if($(this).prop('checked')){
    			if(this.id != 'all'){
    				ids.push(this.id);
    			}
    		}
        });

    	if(ids.length == 0){
    		alert("회원을 선택해 주세요.");
    		return;
    	}
    	
    	var param ={ cmmntyNo: cmmntyNo,
    			mberNo:ids}; 
		
		$.post("delMember.do",
 		   param, 
		   function(data, status) {
			  var json = JSON.parse(data);
		      if(json.success){
		    	 alert('적용 하였습니다.');
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
      	form.attr("action", "communityAdminMember.do");
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
                            <h2>커뮤니티 관리</h2>
                        </div>
                        <div class="page-body">
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" ><a href="communityAdmin.do?cmmntyNo=${community.cmmntyNo}">정보</a></li>
                                <li role="presentation" ><a href="communityAdminConfirm.do?cmmntyNo=${community.cmmntyNo}">가입요청 관리</a></li>
                                <li role="presentation" class="active"><a href="communityAdminMember.do?cmmntyNo=${community.cmmntyNo}">회원 관리</a></li>
                                <li role="presentation"><a href="communityAdminStaff.do?cmmntyNo=${community.cmmntyNo}">스텝 관리</a></li>
                                
                            </ul>
                            <!-- 총게시물, 게시물 검색 -->
                            <div class="brd_top">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-6 data_total">
                                        <p><i class="fa fa-file-text-o" aria-hidden="true"></i> 총 인원수 <span class="text-primary">${total_count }</span> / 페이지 <span class="text-black">${total_page }</span></p>
                                    </div>
                                    <div class="col-xs-12 col-sm-6 text-right">
                                        
                                            <fieldset>
                                                <legend class="sr-only">게시글 검색</legend>
                                                <div class="form-group">
                                                    <label for="search_type" class="sr-only">검색대상</label>
                                                    <select id="search_type" name="search_type" class="form-control">
                                                        <option value="">전체</option>
                                                        <option value="01" <c:if test="${search_type == '01'}">selected</c:if>>이름 + 닉네임</option>
                                                        <option value="02" <c:if test="${search_type == '01'}">selected</c:if>>부서</option>
                                                        
                                                    </select>
                                                </div>
                                                <div class="input-group">
                                                    <label for="search_value" class="sr-only">검색어 입력</label>
                                                    <input type="text" id="search_value" name="search_value" class="form-control" placeholder="검색어" value="${search_value }" />
                                                    <span class="input-group-btn"><button id="btn_search" class="btn btn-default">검색</button></span>
                                                </div>
                                            </fieldset>
                                        
                                    </div>
                                </div>
                            </div>
                            <!-- //총게시물, 게시물 검색 -->
                            <!-- 게시판 목록 -->
                            <div class="table-responsive">
                                <table class="table text-center table-bordered table-hover brd_list all_chks_frm">
                                    <caption class="sr-only">게시판 목록</caption>
                                    <colgroup>
                                        <col style="width:5%;">
                                        <col style="width:20%;">
                                        <col>
                                        <col>
                                        <col>
                                        <col style="width:15%;">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col"><label for="all" class="sr-only">전체선택</label><input type="checkbox" name="all" id="all" class="all_chk" /></th>
                                            <th scope="col">이름(닉네임)</th>
                                            <th scope="col">부서</th>
                                            <th scope="col">게시글 수</th>
                                            <th scope="col">댓글 수</th>
                                            <th scope="col">가입일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach items="${list}" var="mem">
                                        <tr>
                                            <td><label for="${mem.mberNo }" class="sr-only">선택</label><input type="checkbox" name="${mem.mberNo }" id="${mem.mberNo }" /></td>
                                            <td class="text-primary">${mem.displayName }(${mem.cmmntyNicknm })</td>
                                            <td>${mem.ou }</td>
                                            <td><span class="text-blue">${mem.freeCount }</span>개</td>
                                            <td><span class="text-blue">${mem.commentCount }</span>개</td>
                                            <td>${mem.strRegDate }</td>
                                        </tr>
                                        </c:forEach>
                                        <c:if test="${fn:length(list)==0 }">
                                        <tr>
                                            <td colspan="6" class="empty">회원이 없습니다.</td>
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
                            
                            <div class="btn_area">
                                <a href="#" class="btn btn-danger" id="btn_del_mem">강제탈퇴</a>
                                <a href="#" class="btn btn-primary" id="btn_staff_mem">스텝등록</a>
                            </div>
                            
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                </div>
                <!-- //row -->
            </div>