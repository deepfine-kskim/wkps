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
    
    $('#btn_del_staff').click(function(){
    	var ids = new Array();
    	var chkOwner = false;
    	$('input:checkbox').each(function() {
    		if($(this).prop('checked')){
    			
    			if(this.id == 'owner'){
    				chkOwner = true;
    			}
    			
    			if(this.id != 'all'){
    				ids.push(this.id);
    			}
    		}
        });
		
    	if(chkOwner){
    		alert("운영자 회원을 삭제할 수 없습니다.");
    		return;
    	}
    	
    	if(ids.length == 0){
    		alert("회원을 선택해 주세요.");
    		return;
    	}
    	
    	var param ={ cmmntyNo: cmmntyNo,
    			mberNo:ids}; 
		
		$.post("delStaffMember.do",
 		   param, 
		   function(data, status) {
			  var json = JSON.parse(data);
		      if(json.success){
		    	 alert('삭제 하였습니다.');
		    	 location.reload();
			  }else{
				 alert(json.err_msg);
			  } 
			} 
		);
		
    });
    
    $('#btn_change_role').click(function(){
    	var ids = new Array();
    	var roles = new Array();
    	$('input:checkbox').each(function() {
    		{
    			if(this.id != 'all' && this.id != 'owner'){
    				ids.push(this.id);
    				roles.push($('#cmmntyRoleCd_'+this.id).val());
    				
    			}
    		}
        });

    	if(ids.length == 0){
    		alert("회원을 선택해 주세요.");
    		return;
    	}
    	
    	var param ={ cmmntyNo: cmmntyNo,
    			mberNo:ids,
    			roleCd : roles}; 
		
		$.post("changeStaffRole.do",
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
      	form.attr("action", "communityAdminStaff.do");
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
                                <li role="presentation" ><a href="communityAdminMember.do?cmmntyNo=${community.cmmntyNo}">회원 관리</a></li>
                                <li role="presentation" class="active"><a href="communityAdminStaff.do?cmmntyNo=${community.cmmntyNo}">스텝 관리</a></li>
                                
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
                                                    <input type="text" id="search_value" name="search_value" class="form-control" placeholder="검색어" value="${search_value }"/>
                                                    <span class="input-group-btn"><button class="btn btn-default">검색</button></span>
                                                </div>
                                            </fieldset>
                                        
                                    </div>
                                </div>
                            </div>
                            <!-- //총게시물, 게시물 검색 -->
                            <!-- 게시판 목록 -->
                            <div class="table-responsive">
                                <table class="table text-center table-bordered table-hover brd_list all_chks_frm min_tbl">
                                    <caption class="sr-only">게시판 목록</caption>
                                    <colgroup>
                                        <col style="width:40px">
                                        <col>
                                        <col>
                                        <col style="width:150px">
                                        <col style="width:15%;">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col"><label for="all" class="sr-only">전체선택</label><input type="checkbox" name="all" id="all" class="all_chk" /></th>
                                            <th scope="col">이름(닉네임)</th>
                                            <th scope="col">부서</th>
                                            <th scope="col">권한</th>
                                            <th scope="col">등록일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                        <c:forEach items="${list}" var="mem">
                                        <tr <c:if test="${mem.cmmntyRoleCd == '00' }">class="primary"</c:if>>
                                            <td>
                                            <c:if test="${mem.cmmntyRoleCd == '00' }">
                                            <label for="owner" class="sr-only">선택</label><input type="checkbox" name="owner" id="owner" />
                                            </c:if>
                                            <c:if test="${mem.cmmntyRoleCd != '00' }">
                                            <label for="${mem.mberNo }" class="sr-only">선택</label><input type="checkbox" name="${mem.mberNo }" id="${mem.mberNo }" />
                                            </c:if>
                                            </td>
                                            <td class="text-primary">${mem.displayName }(${mem.cmmntyNicknm })</td>
                                            <td>${mem.ou }</td>
                                            
                                            <c:if test="${mem.cmmntyRoleCd == '00' }">
                                            <td class="text-danger">운영자</td>
                                            </c:if>
                                            
                                            <c:if test="${mem.cmmntyRoleCd != '00' }">
                                            <td>
                                                <label for="cmmntyRoleCd_${mem.mberNo }" class="sr-only">권한선택</label>
                                                <select class="form-control" id="cmmntyRoleCd_${mem.mberNo }" name="cmmntyRoleCd_${mem.mberNo }">
                                                    <option <c:if test="${mem.cmmntyRoleCd == '01' }">selected</c:if> value="01">게시판 스텝</option>
                                                    <option <c:if test="${mem.cmmntyRoleCd == '02' }">selected</c:if> value="02">회원관리 스텝</option>
                                                </select>
                                            </td>
                                            </c:if>
                                            <td>${mem.strRegDate }</td>
                                        </tr>
                                        </c:forEach>
                                        <c:if test="${fn:length(list)==0 }">
                                        <tr>
                                            <td colspan="5" class="empty">검색결과가 없습니다.</td>
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
                                <ul id="pagination" class="pagination pagination-sm">
                                    
                                </ul>
                            </nav>
                            <!-- //페이지 네비 -->
                            
                            <div class="row type0">
                                <div class="col-xs-6">
                                    <a href="#" class="btn btn-danger" id="btn_del_staff">스텝삭제</a>
                                </div>
                                <div class="col-xs-6 text-right">
                                    <button class="btn btn-blue" id="btn_change_role">확인</button>
                                </div>
                            </div>
                            
                        </div>
                        <!-- //page-body -->
                    </div>
                    <!-- //CONTENTS -->
                </div>
                <!-- //row -->
            </div>