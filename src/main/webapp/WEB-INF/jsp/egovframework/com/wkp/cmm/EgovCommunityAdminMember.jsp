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

$(document).ready(function(){

    $('#rlsUserChk').off('click').on('click', function () {
        // 체크된 개인 항목
        const userList = [];
        $('input:checkbox:not(:disabled)[name="userList"]').each(function (e) {
            if (this.checked) {
                const sid = $(this).val();
                if (userList.indexOf(sid) === -1) {
                    userList.push(sid);
                }
            }
        });

        if(userList.length == 0){
            alert("커뮤니티에 초대할 사용자를 선택해 주세요.");
            return;
        }

        var param ={ cmmntyNo: cmmntyNo,
            userList:userList,
            cmmntyNm:'${community.cmmntyNm}'};

        $.post("inviteMember.do",
            param,
            function(data, status) {
                var json = JSON.parse(data);
                if(json.success){
                    alert('초대 하였습니다.');
                    location.reload();
                }else{
                    alert(json.err_msg);
                }
            }
        );
    });
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
                                            <c:choose>
                                                <c:when test="${mem.inviteYn eq 'Y' and mem.aprvYn eq 'N' and mem.acceptResult eq 'REJECT'}">
                                                    <td>초대를 거절한 유저입니다.</td>
                                                </c:when>
                                                <c:when test="${mem.inviteYn eq 'Y' and mem.aprvYn eq 'N'}">
                                                    <td>초대중인 유저입니다.</td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td>${mem.strRegDate }</td>
                                                </c:otherwise>
                                            </c:choose>
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
                                <a href="#selectGrpPopup" class="btn btn-primary" data-toggle="modal" data-target="#selectGrpPopup">멤버 초대</a>
                            </div>
                            
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                </div>
                <!-- //row -->
            </div>

<!-- 조직그룹 선택 팝업 -->
<div class="modal fade" id="selectGrpPopup" tabindex="-1" role="dialog" aria-labelledby="selectGrpPopupLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="selectGrpPopupLabel">개인 선택</h4>
            </div>
            <div class="modal-body">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#selectGrpTab2" aria-controls="selectGrpTab2" role="tab" data-toggle="tab">개인</a></li>
                </ul>
                <div class="tab-content">
                    <div id="selectGrpTab2" class="tab-pane active" role="tabpanel">
                        <div class="srch_area">
                            <fieldset>
                                <legend class="sr-only">이름 검색영역</legend>
                                <div class="input-group">
                                    <label for="userText" class="sr-only">이름 입력</label>
                                    <input type="text" id="userText" name="userText" class="form-control flow-enter-search" placeholder="이름 검색(2글자 이상)" data-search-button="userBtn">
                                    <span class="input-group-btn"><a href="javascript:;" id="userBtn" class="btn btn-default">검색</a></span>
                                </div>
                            </fieldset>
                        </div>
                        <div class="hummingbird-treeview well chk_tree_area">
                            <%--<div class="checkbox">
                                <label for="allSrchChk"><input type="checkbox" id="allSrchChk" class="all_chk" /> 전체선택</label>
                            </div>--%>
                            <ul id="userList" class="chk_tree_list hummingbird-base treeview">
                                <c:forEach var="top" items="${topList}" varStatus="topStatus">
                                    <li class="flow-action-userList">
                                        <i class="fa fa-plus"></i> <label for="allSrchChk-${topStatus.index}"><input type="checkbox" id="allSrchChk-${topStatus.index}" class="flow-action-checkUserList" />${top.ou}</label>
                                        <ul class="flow-user-list" data-ou-code="${top.ouCode}">
                                            <c:forEach var="parent" items="${top.nextDepthList}" varStatus="parentStatus">
                                                <li>
                                                    <i class="fa fa-plus" data-code="${parent.ouCode}"></i> <label for="allSrchChk-${topStatus.index}-${parentStatus.index}"><input type="checkbox" id="allSrchChk-${topStatus.index}-${parentStatus.index}" />${parent.ou}</label>
                                                    <ul class="not_depth_list flow-user-list" data-ou-code="${parent.ouCode}">
                                                        <c:forEach var="child" items="${parent.nextDepthList}" varStatus="childStatus">
                                                            <li>
                                                                <i class="fa fa-plus"></i> <label for="allSrchChk-${topStatus.index}-${parentStatus.index}-${childStatus.index}"><input type="checkbox" id="allSrchChk-${topStatus.index}-${parentStatus.index}-${childStatus.index}" />${child.ou}</label>
                                                                <ul class="flow-user-list" data-ou-code="${child.ouCode}">
                                                                </ul>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="rlsUserChk" class="btn btn-blue" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>