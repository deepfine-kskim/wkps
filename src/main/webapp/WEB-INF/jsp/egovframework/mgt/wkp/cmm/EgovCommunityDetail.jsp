<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
$(function() {
	var cmmntyNo = ${community.cmmntyNo};
    $('#btn_reject').click(function(){
    	var comment = $('#rejectComment').val();
    	if(comment == ''){
    		alert("반려 사유를 입력해주세요.");
    		return false;
    	}
    	
    	var param = {cmmntyNo : cmmntyNo,
    			aprv : 'R',
    			comment : comment};
    	
    	$.post('aprvCommunity.do',param,function(data,status){
    		var json = JSON.parse(data);
    		if(json.success){
    			alert('반려하였습니다.');
    			location.reload();
    		} else{
    			alert(json.err_msg);
    		}
    	});
    			
    });
    
    $('#btn_aprv').click(function(){
    	var param = {cmmntyNo : cmmntyNo,
    			aprv : 'Y'};
    	
    	$.post('aprvCommunity.do',param,function(data,status){
    		var json = JSON.parse(data);
    		if(json.success){
    			alert('승인하였습니다.');
    			location.reload();
    		} else{
    			alert(json.err_msg);
    		}
    	});
    });
    
});

</script>
<div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">승인 관리</h2>
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
                    <li class="active">승인 관리</li>
                </ol>
                <div id="contents">
                    <table class="table table-bordered">
                        <caption class="sr-only hidden">처리상태</caption>
                        <colgroup>
                            <col style="width:15%;" />
                            <col style="width:15%;" />
                            <col style="width:15%;" />
                            <col />
                            <col style="width:15%;" />
                            <col style="width:15%;" />
                        </colgroup>
                        <tr>
                            <th>상태</th>
                            <td>
                            <c:if test="${community.aprvYn == 'Y' }">
                            <span class="text-black">승인완료</span>
                            </c:if>
                            <c:if test="${community.aprvYn == 'N' }">
                            <span class="text-warning">승인대기</span>
                            </c:if>
                            <c:if test="${community.aprvYn == 'R' }">
                            <a href="#alertPopup" class="text-danger lnk_txt" data-toggle="modal" data-target="#alertPopup">[반려]</a>
                            </c:if>
                            
                            </td>
                            <th>처리자</th>
                            <td>${community.approverName }(${community.approverOu })</td>
                            <th>처리일</th>
                            <td><fmt:formatDate value="${community.aprvDtm }" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </table>
                    <div class="well well-white well-lg">
                        <div class="brd_view_area">
                            <div class="view_header">
                                <strong class="subject">${community.cmmntyNm}</strong>
                                <div class="row type0 info_view">
                                    <div class="col-xs-12">
                                        <span>개설일 : </span>
                                        <span class="data">
                                        <fmt:formatDate value="${community.registDtm}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <span class="info_txt name">개설자 : <span class="data">${community.owner.cmmntyNicknm}</span></span>
                                    </div>
                                </div>
                                <div class="row type0 info_view">
                                    <div class="col-xs-12">
                                        <span>검색키워드 : </span>
                                        <span class="keywords">
                                   			<c:if test="${community.keyword01 != null}"><span class="key">#${community.keyword01}</span></c:if>
                                            <c:if test="${community.keyword02 != null}"><span class="key">#${community.keyword02}</span></c:if>
                                            <c:if test="${community.keyword03 != null}"><span class="key">#${community.keyword03}</span></c:if>
                                            <c:if test="${community.keyword04 != null}"><span class="key">#${community.keyword04}</span></c:if>
                                            <c:if test="${community.keyword05 != null}"><span class="key">#${community.keyword05}</span></c:if>
                                            <c:if test="${community.keyword06 != null}"><span class="key">#${community.keyword06}</span></c:if>
                                            <c:if test="${community.keyword07 != null}"><span class="key">#${community.keyword07}</span></c:if>
                                            <c:if test="${community.keyword08 != null}"><span class="key">#${community.keyword08}</span></c:if>
                                            <c:if test="${community.keyword09 != null}"><span class="key">#${community.keyword09}</span></c:if>
                                            <c:if test="${community.keyword10 != null}"><span class="key">#${community.keyword10}</span></c:if> 
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="view_body">
                                <p>${community.cmmntyDesc}</p>
                            </div>
                        </div>
                        <!-- //brd_view_area -->
                    </div>
                    <div class="row mb_15">
                        <div class="col-xs-6">
                        	<c:if test="${community.aprvYn == 'N' }">
                            <button type="button" class="btn btn-blue min-lg" id="btn_aprv">승인</button>
                            <a href="#rejectionPopup" class="btn btn-danger min-lg" data-toggle="modal" data-target="#rejectionPopup">반려</a>
                            </c:if>
                        </div>
                        <div class="col-xs-6 text-right">
                            <a href="/adm/commRequest.do" class="btn btn-black btn-lg min-lg">목록</a>
                        </div>
                    </div>
                </div>
                <!-- //CONTENTS -->


<!-- 팝업 영역 시작 -->
                <!-- 알림팝업 -->
                <div class="modal fade" id="alertPopup" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="alertPopupLabel">알림</h4>
                            </div>
                            <div class="modal-body">
                                ${community.rejectComment }
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //알림팝업 -->

                <!-- 반려사유 작성 팝업 -->
                <div id="rejectionPopup" class="modal fade" role="dialog" aria-labelledby="rejectionPopupLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content form-horizontal">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <div class="h4 modal-title" id="rejectionPopupLabel">반려사유</div>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="col-sm-12 control-label sr-only">반려사유</label>
                                    <div class="col-sm-12">
                                        <textarea class="form-control" id="rejectComment" rows="4" placeholder="반려 사유를 작성해 주세요."></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer text-center">
                                <button type="button" class="btn btn-blue min-md" id="btn_reject" >확인</button>
                                <button type="button" class="btn btn-default min-md" data-dismiss="modal">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //반려사유 작성 팝업 --><!-- //팝업 영역 종료 -->


                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->