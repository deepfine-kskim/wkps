<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 커뮤니티 가입 팝업 -->
<script>
var sideCmmntyNo = ${community.cmmntyNo};
var sideMemPubYn = '${community.memPubYn}';
function join(){
	var param = {cmmntyNo:sideCmmntyNo,
			nickname:$('#commJoinNickName').val()};
	
	$.post("/cmu/joinCommunity.do",param,function(data, status){
		var json = JSON.parse(data);
	      if(json.success){
	    	 alert('가입요청 되었습니다.');
	    	 location.reload();
		  }else{
			 alert(json.err_msg);
		  } 
	      
		
		$('#commJoinPopup').modal('hide');
	})
}
function clickMember(){
	location.href="/cmu/communityMember.do?cmmntyNo=${community.cmmntyNo }";
}
function out(){
	var ret = confirm('정말로 탈퇴 하시겠습니까?');
	if(!ret){
		return;
	}
	var param = {cmmntyNo:sideCmmntyNo};
	
	$.post("/cmu/outCommunity.do",param,function(data, status){
		var json = JSON.parse(data);
	      if(json.success){
	    	 alert('탈퇴 되었습니다.');
	    	 location.reload();
		  }else{
			 alert(json.err_msg);
		  } 
	})
}
function cancel(){
	var ret = confirm('정말로 취소 하시겠습니까?');
	if(!ret){
		return;
	}
	var param = {cmmntyNo:sideCmmntyNo};
	
	$.post("/cmu/outCommunity.do",param,function(data, status){
		var json = JSON.parse(data);
	      if(json.success){
	    	 alert('취소 되었습니다.');
	    	 location.reload();
		  }else{
			 alert(json.err_msg);
		  } 
	})
}
</script>
                    <div class="modal fade" id="commJoinPopup" tabindex="-1" role="dialog" aria-labelledby="commJoinPopupLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content form-horizontal">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="commJoinPopupLabel"><strong>커뮤니티 가입</strong></h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group mb_0">
                                        <label for="commJoinNickName" class="col-sm-3 control-label">커뮤니티 닉네임</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="commJoinNickName" name="commJoinNickName" placeholder="닉네임을 입력하세요." required="required" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-blue " onclick="join();">가입신청</button>
                                    <button type="button" class="btn btn-black" data-dismiss="modal">취소</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //커뮤니티 가입 팝업 -->
                    
<div id="aside" class="col-md-3">
                        <div class="side_card_box comm_data">
                            <strong class="name">
                            <c:if test="${role_adm == 'Y'}">
                            <a href="/cmu/admin/communityAdmin.do?cmmntyNo=${community.cmmntyNo }" class="adm_btn" title="관리자"><i class="glyphicon glyphicon-user" aria-hidden="true"></i> 관리자</a>
                            </c:if>
                            <a href="/cmu/communityMain.do?cmmntyNo=${community.cmmntyNo }">${community.cmmntyNm }</a></strong>
                            <ul class="ico_list info_list">
                                <li>
                                    <div class="row type0">
                                        <div class="col-xs-6">
                                            <span class="tit">개설자</span>
                                        </div>
                                        <div class="col-xs-6 text-right data">
                                            ${community.owner.displayName }
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="row type0">
                                        <div class="col-xs-6">
                                            <span class="tit">회원수</span>
                                        </div>
                                        <div class="col-xs-6 text-right data">
                                            <c:choose>
                                                <c:when test="${community.memPubYn eq 'Y'}">
                                                    <a href="#" onclick="clickMember()" class="text-danger underline">${community.memCount } 명</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${role_adm ne 'N'}">
                                                            <a href="#" onclick="clickMember()" class="text-danger underline">${community.memCount } 명</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${community.memCount } 명
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <div class="desc">
                                ${community.cmmntyDesc }
                            </div>
                            <div class="tags_area">
                            						<c:if test="${community.keyword01 != null}"><span class="tag_txt">#${community.keyword01}</span></c:if>
	                                                <c:if test="${community.keyword02 != null}"><span class="tag_txt">#${community.keyword02}</span></c:if>
	                                                <c:if test="${community.keyword03 != null}"><span class="tag_txt">#${community.keyword03}</span></c:if>
	                                                <c:if test="${community.keyword04 != null}"><span class="tag_txt">#${community.keyword04}</span></c:if>
	                                                <c:if test="${community.keyword05 != null}"><span class="tag_txt">#${community.keyword05}</span></c:if>
	                                                <c:if test="${community.keyword06 != null}"><span class="tag_txt">#${community.keyword06}</span></c:if>
	                                                <c:if test="${community.keyword07 != null}"><span class="tag_txt">#${community.keyword07}</span></c:if>
	                                                <c:if test="${community.keyword08 != null}"><span class="tag_txt">#${community.keyword08}</span></c:if>
	                                                <c:if test="${community.keyword09 != null}"><span class="tag_txt">#${community.keyword09}</span></c:if>
	                                                <c:if test="${community.keyword10 != null}"><span class="tag_txt">#${community.keyword10}</span></c:if>  
	                                                
	                                                
                            </div>
                            <c:if test="${ community.me == null}">
                            <div class="text-center btn_area">
                                <div class="row">
                                    <div class="col-xs-8 col-xs-offset-2"><a href="#commJoinPopup" data-toggle="modal" data-target="#commJoinPopup" class="btn btn-primary outline btn-block">가입하기</a></div>
                                </div>
                            </div>
                            </c:if>
                            <c:if test="${ community.me != null and community.me.aprvYn == 'Y' and community.me.mberNo != community.owner.mberNo}">
                            <div class="text-center btn_area">
                                <div class="row">
                                    <div class="col-xs-8 col-xs-offset-2"><a href="#" class="btn btn-danger outline btn-block" onclick="out()">탈퇴하기</a></div>
                                </div>
                            </div>
                            </c:if>
                            <c:if test="${ community.me != null and community.me.aprvYn == 'N'}">
                            <div class="text-center btn_area">
                                <div class="row">
                                    <div class="col-xs-7">
                                    <strong class="data_txt text-blue">[가입 신청중]</strong>
                                    </div>
                                    <div class="col-xs-5"><a href="#" class="btn btn-danger outline btn-block" onclick="cancel()">취소</a></div>
                                </div>
                            </div>
                            </c:if>
                        </div>
                        <div class="aside_menu_box">
                            <ul class="list-group">
                                <li class="list-group-item">
                                    <a href="/cmu/communityNoticeList.do?cmmntyNo=${community.cmmntyNo}">
                                        공지사항
                                        <span class="badge">${community.noticeCount}</span>
                                    </a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/cmu/communityFreeList.do?cmmntyNo=${community.cmmntyNo}">
                                        자유 게시판
                                        <span class="badge">${community.freeCount}</span>
                                    </a>
                                </li>
                                <li class="list-group-item">
                                    <a href="/cmu/community2FreeList.do?cmmntyNo=${community.cmmntyNo}">
                                        지식 게시판
                                        <span class="badge">${community.free2Count}</span>
                                    </a>
                                </li>
                                <%--
                                <li class="list-group-item">
                                    <a href="/cmu/communityKnowledgeList.do?cmmntyNo=${community.cmmntyNo}">
                                        지식 게시판
                                        <span class="badge">${community.knowledgeCount}</span>
                                    </a>
                                </li>
                                --%>
                            </ul>
                        </div>
                    </div>