<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>

$(function() {
	
	$('#btn_search').click(function(){
		location.href="communitySearch.do?search_type="+$('#search_type').val()+"&search_value="+$('#search_value').val();
	});
	

});


function reject(cmmntyNo){
	$('#alertPopup'+cmmntyNo).modal('show');
}

function goEventCommunity(eventNo,cmmntyNo){
	var param = {eventNo:eventNo};
	$.post("/cmu/clearEventCommunity.do",param,function(data, status){
	});
	
	location.href="communityMain.do?cmmntyNo="+cmmntyNo;
}

function goEventBoard(eventNo,cmmntyNo,pstgNo){
	var param = {eventNo:eventNo};
	$.post("/cmu/clearEventCommunity.do",param,function(data, status){
	});
	
	location.href="communityFreeView.do?cmmntyNo="+cmmntyNo+"&pstgNo="+pstgNo;
}

</script>
<div class="container sub_cont">
                <div id="contents">
                    <div class="comm_main_section">
                        <div class="comm_top">
                            <div class="row type5">
                                <div class="col-sm-6">
                                    <p class="user_alarm"><strong class="text-primary">${user.displayName }</strong>님<a href="#myAlarmPopup" data-toggle="modal" data-target="#myAlarmPopup" class="alert_btn"><i class="fa fa-bell"><span class="sr-only">알림</span></i> 
                                    <c:if test="${fn:length(list_event) > 0 }">
                                    <span class="ico_new">
                                    <i class="xi-new">
                                    <span class="sr-only">새알림</span>
                                    </i>
                                    </span>
                                    </c:if>
                                    </a></p> <a href="communityRegist.do" class="btn btn-primary"><i class="ti-pencil-alt" aria-hidden="true"></i> 커뮤니티 만들기</a>
                                </div>
                                <div class="col-sm-6 text-right">
                                    <form class="form-inline comm_srch_frm">
                                        <fieldset>
                                            <legend class="sr-only">커뮤니티 검색</legend>
                                            <div class="form-group">
                                                <label for="search_type" class="sr-only">검색대상</label>
                                                <select id="search_type" name="search_type" class="form-control">
                                                    <option value="01">커뮤니티 명</option>
                                                    <option value="02">커뮤니티 설명</option>
                                                    <option value="03">키워드</option>
                                                </select>
                                            </div>
                                            <div class="input-group">
                                                <label for="search_value" class="sr-only">검색어 입력</label>
                                                <input type="text" id="search_value" name="search_value" class="form-control" placeholder="검색어" />
                                                <span class="input-group-btn"><button type="button" class="btn btn-default" id="btn_search">검색</button></span>
                                            </div>
                                        </fieldset>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- //comm_top -->
                        <c:if test="${list_my == null or fn:length(list_my) == 0}">
                        <div class="comm_info_area">
                            <div class="row">
                                <div class="col-md-6 col-md-push-6">
                                    <div class="comm_bnr_wrap">
                                        <div class="comm_bnr_list owl-carousel owl-theme">
                                        	<c:forEach items="${list_banner }" var="banner">
                                            <div class="item">
                                                <c:if test="${not empty banner.link and banner.link ne '' }"><a href="${banner.link }"></c:if>
                                                    <img src=${banner.fileStreCours }${banner.streFileNm }" alt="${banner.title }" />
                                                <c:if test="${not empty banner.link and banner.link ne '' }"></a></c:if>
                                            </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 col-md-pull-6">
                                    <div class="comm_my_wrap">
                                        <div class="empty">
                                            가입한 커뮤니티가 없습니다.
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        </c:if>
                        <c:if test="${fn:length(list_my) > 0}">
                        <div class="comm_info_area">
                            <div class="row">
                                <div class="col-md-6 col-md-push-6">
                                    <div class="comm_bnr_wrap">
                                        <div class="comm_bnr_list owl-carousel owl-theme">
                                        	<c:forEach items="${list_banner}" var="banner">
                                            <div class="item">
                                                <c:if test="${not empty banner.link and banner.link ne '' }"><a href="${banner.link }"></c:if>
                                                    <img src="${banner.fileStreCours }${banner.streFileNm }" alt="${banner.title }" />
                                                <c:if test="${not empty banner.link and banner.link ne '' }"></a></c:if>
                                                </a>
                                            </div>
                                            </c:forEach>
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-md-pull-6">
                                    <div class="comm_my_wrap">
                                        <div class="comm_my_list owl-carousel owl-theme">
                                            <c:forEach items="${list_my}" var="my">
                                            <div class="item">
                                                <div class="panel panel-primary widget_panel">
                                                    <div class="panel-heading">
                                                        <div class="h6"><strong><a href="communityMain.do?cmmntyNo=${my.cmmntyNo}">${my.cmmntyNm}</a></strong>
                                                        <c:if test="${my.aprvYn == 'R'}">
                                                        <a href="#" onclick="reject(${my.cmmntyNo})" data-toggle="modal" class="text-danger txt_btn">[반려]</a>
                                                        </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="panel-body">
                                                        <p class="desc">
                                                            	${my.cmmntyDesc}
                                                        </p>
                                                        <ul class="brd_latest_list">
                                                            <c:forEach items="${my.listFree }" var="free">
                                                            <li>
                                                                <a href="communityFreeView.do?cmmntyNo=${free.cmmntyNo}&pstgNo=${free.pstgNo}">
                                                                    <p class="tit">${free.title }</p>
                                                                    <span class="date">${free.strRegDate}</span>
                                                                </a>
                                                            </li>
                                                            </c:forEach>
                                                            
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            </c:forEach>
                                            
                                        </div>
                                        <!-- //comm_my_list -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        <div class="comm_tabs_area">
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" class="active"><a href="#commMainTab1" aria-controls="commMainTab1" role="tab" data-toggle="tab">신규 커뮤니티</a></li>
                                <li role="presentation"><a href="#commMainTab2" aria-controls="commMainTab2" role="tab" data-toggle="tab">인기 커뮤니티</a></li>
                                <li role="presentation"><a href="#commMainTab3" aria-controls="commMainTab3" role="tab" data-toggle="tab">전체 커뮤니티</a></li>
                            </ul>
                            <div class="tab-content">
                                <div id="commMainTab1" class="tab-pane active" role="tabpanel">
                                    <ul class="comm_card_list row_list">
                                       <c:forEach items="${list_new}" var="cmuNew" end="11">
                                        <li class="col-xs-6 col-sm-4 col-md-3">
                                            <a href="communityMain.do?cmmntyNo=${cmuNew.cmmntyNo}" class="frame">
                                                <div class="caption_box">
                                                    <strong class="subject">${cmuNew.cmmntyNm}</strong>
                                                    <p class="desc">${cmuNew.cmmntyDesc}</p>
                                                </div>
                                                <div class="tags">
	                                                <c:if test="${cmuNew.keyword01 != null}"><span>#${cmuNew.keyword01}</span></c:if>
	                                                <c:if test="${cmuNew.keyword02 != null}"><span>#${cmuNew.keyword02}</span></c:if>
	                                                <c:if test="${cmuNew.keyword03 != null}"><span>#${cmuNew.keyword03}</span></c:if>
	                                                <c:if test="${cmuNew.keyword04 != null}"><span>#${cmuNew.keyword04}</span></c:if>
	                                                <c:if test="${cmuNew.keyword05 != null}"><span>#${cmuNew.keyword05}</span></c:if>
	                                                <c:if test="${cmuNew.keyword06 != null}"><span>#${cmuNew.keyword06}</span></c:if>
	                                                <c:if test="${cmuNew.keyword07 != null}"><span>#${cmuNew.keyword07}</span></c:if>
	                                                <c:if test="${cmuNew.keyword08 != null}"><span>#${cmuNew.keyword08}</span></c:if>
	                                                <c:if test="${cmuNew.keyword09 != null}"><span>#${cmuNew.keyword09}</span></c:if>
	                                                <c:if test="${cmuNew.keyword10 != null}"><span>#${cmuNew.keyword10}</span></c:if>    
	                                                    
                                                </div>
                                            </a>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div id="commMainTab2" class="tab-pane" role="tabpanel">
                                    <ul class="comm_card_list row_list">
                                        <c:forEach items="${list_best }" var="cmuBest" end="11">
                                        <li class="col-xs-6 col-sm-4 col-md-3">
                                            <a href="communityMain.do?cmmntyNo=${cmuBest.cmmntyNo}" class="frame">
                                                <div class="caption_box">
                                                    <strong class="subject">${cmuBest.cmmntyNm}</strong>
                                                    <p class="desc">${cmuBest.cmmntyDesc}</p>
                                                </div>
                                                <div class="tags">
                                                    <c:if test="${cmuBest.keyword01 != null}"><span>#${cmuBest.keyword01}</span></c:if>
	                                                <c:if test="${cmuBest.keyword02 != null}"><span>#${cmuBest.keyword02}</span></c:if>
	                                                <c:if test="${cmuBest.keyword03 != null}"><span>#${cmuBest.keyword03}</span></c:if>
	                                                <c:if test="${cmuBest.keyword04 != null}"><span>#${cmuBest.keyword04}</span></c:if>
	                                                <c:if test="${cmuBest.keyword05 != null}"><span>#${cmuBest.keyword05}</span></c:if>
	                                                <c:if test="${cmuBest.keyword06 != null}"><span>#${cmuBest.keyword06}</span></c:if>
	                                                <c:if test="${cmuBest.keyword07 != null}"><span>#${cmuBest.keyword07}</span></c:if>
	                                                <c:if test="${cmuBest.keyword08 != null}"><span>#${cmuBest.keyword08}</span></c:if>
	                                                <c:if test="${cmuBest.keyword09 != null}"><span>#${cmuBest.keyword09}</span></c:if>
	                                                <c:if test="${cmuBest.keyword10 != null}"><span>#${cmuBest.keyword10}</span></c:if> 
                                                </div>
                                            </a>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div id="commMainTab3" class="tab-pane" role="tabpanel">
                                    <ul class="comm_card_list row_list">
                                        <c:forEach items="${list_total }" var="cmuTotal">
                                        <li class="col-xs-6 col-sm-4 col-md-3">
                                            <a href="communityMain.do?cmmntyNo=${cmuTotal.cmmntyNo}" class="frame">
                                                <div class="caption_box">
                                                    <strong class="subject">${cmuTotal.cmmntyNm}</strong>
                                                    <p class="desc">${cmuTotal.cmmntyDesc}</p>
                                                </div>
                                                <div class="tags">
                                                    <c:if test="${cmuTotal.keyword01 != null}"><span>#${cmuTotal.keyword01}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword02 != null}"><span>#${cmuTotal.keyword02}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword03 != null}"><span>#${cmuTotal.keyword03}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword04 != null}"><span>#${cmuTotal.keyword04}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword05 != null}"><span>#${cmuTotal.keyword05}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword06 != null}"><span>#${cmuTotal.keyword06}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword07 != null}"><span>#${cmuTotal.keyword07}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword08 != null}"><span>#${cmuTotal.keyword08}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword09 != null}"><span>#${cmuTotal.keyword09}</span></c:if>
	                                                <c:if test="${cmuTotal.keyword10 != null}"><span>#${cmuTotal.keyword10}</span></c:if> 
                                                </div>
                                            </a>
                                        </li>
                                        </c:forEach>                                        
                                    </ul>
                                </div>
                            </div>
                            <!-- //tab-content -->
                        </div>
                    </div>
                    <!-- 알림팝업 -->
                    <c:forEach items="${list_my}" var="my">
                    <c:if test="${my.aprvYn == 'R'}">
                    <div class="modal fade" id="alertPopup${my.cmmntyNo}" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
                        <div class="modal-dialog modal-sm" role="document">
                            <form class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="alertPopupLabel">알림</h4>
                                </div>
                                <div class="modal-body" id="rejectComment">
                                    ${my.rejectComment}
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    </c:if>
                    </c:forEach>
                    <!-- //알림팝업 -->
                    <!-- 나의알림 팝업 -->
                    <div class="modal fade" id="myAlarmPopup" tabindex="-1" role="dialog" aria-labelledby="myAlarmPopupLabel">
                        <div class="modal-dialog" role="document">
                            <form class="modal-content form-horizontal">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myAlarmPopupLabel"><strong><i class="fa fa-bell" aria-hidden="true"></i> ${user.displayName }님 알림</strong></h4>
                                </div>
                                <div class="modal-body">
                                    <ul class="alarm_list">
                                    	<c:choose>
                                        <c:when test="${not empty list_event}">
                                        <c:forEach items="${list_event}" var="event">
                                        <c:if test="${event.eventType == '0' }">
                                        
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#" onclick="goEventCommunity(${event.eventNo},${event.cmmntyNo})">${event.cmmntyNm }</a></strong></div>
                                                    <ul class="brd_latest_list reply_type">
                                                        <li>
                                                            <a href="#" onclick="goEventBoard(${event.eventNo},${event.cmmntyNo},${event.pstgNo})">
                                                                <p class="tit">${event.pstgTitle }</p>
                                                                <span class="date">
                                                                <fmt:formatDate value="${event.pstgDtm }" pattern="yyyy.MM.dd"/>
                                                                </span>
                                                                <div class="reply">
                                                                    <i class="fa fa-level-up fa-rotate-90 text-danger ico"><span class="sr-only">댓글</span></i>
                                                                    ${event.pstgComment }
                                                                </div>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </li>
                                        
                                        </c:if>
                                        <c:if test="${event.eventType == '1' }">
                                        
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#" onclick="goEventCommunity(${event.eventNo},${event.cmmntyNo})">${event.cmmntyNm }</a></strong></div>
                                                    <div class="msg_box">
                                                        <span class="text-primary">가입신청</span>이 <span class="text-success">정상처리</span> 되었습니다.
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        
                                        </c:if>
                                        <c:if test="${event.eventType == '2' }">
                                        
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#" onclick="goEventCommunity(${event.eventNo},${event.cmmntyNo})">${event.cmmntyNm }</a></strong></div>
                                                    <div class="msg_box">
                                                        <span class="text-primary">가입신청</span>이 <span class="text-danger">거절</span> 되었습니다.
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        
                                        </c:if>
                                        <c:if test="${event.eventType == '3' }">
                                        
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#" onclick="goEventCommunity(${event.eventNo},${event.cmmntyNo})">${event.cmmntyNm }</a></strong></div>
                                                    <div class="msg_box">
                                                        <span class="text-primary">개설신청</span>이 <span class="text-success">정상처리</span> 되었습니다.
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        
                                        </c:if>
                                        
                                        <c:if test="${event.eventType == '4' }">
                                        
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#" onclick="goEventCommunity(${event.eventNo},${event.cmmntyNo})">${event.cmmntyNm }</a></strong></div>
                                                    <div class="msg_box">
                                                        <span class="text-primary">개설신청</span>이 <span class="text-danger">거절</span> 되었습니다.
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        
                                        </c:if>
                                        <c:if test="${event.eventType == '5' }">
                                        
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#" onclick="goEventCommunity(${event.eventNo},${event.cmmntyNo})">${event.cmmntyNm }</a></strong></div>
                                                    <div class="msg_box">
                                                        <span class="text-primary">가입요청</span>이 있습니다.
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        
                                        </c:if>
                                        </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="msg_box">알림이 없습니다.</div>
                                                </div>
                                            </div>
                                        </li>
                                        </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- //나의알림 팝업 -->
                    <script src="/js/egovframework/com/wkp/comm.js"></script>
                </div>
                <!-- //CONTENTS -->
            </div>