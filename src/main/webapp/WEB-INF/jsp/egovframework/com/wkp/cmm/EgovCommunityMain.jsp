<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="container sub_cont">
                <div class="row layout_side_row">
﻿<%@ include file="EgovCommunitySide.jsp" %>                
                    
                    <!-- //ASIDE -->
                    <div id="contents" class="col-md-9">
                        <div class="row type10">
                            <div class="col-sm-12">
                                <div class="panel panel-primary widget_panel">
                                    <div class="panel-heading">
                                        <div class="h6"><i class="fa fa-bullhorn" aria-hidden="true"></i> <strong>공지사항</strong></div>
                                    </div>
                                    <div class="panel-body">
                                        <ul class="brd_latest_list">
                                        <c:forEach items="${notice}" var="notice">
                                            <li>
                                                <a href="communityNoticeView.do?cmmntyNo=${community.cmmntyNo}&noticeNo=${notice.noticeNo}">
                                                    <p class="tit">${notice.title }</p>
                                                    <span class="date">${notice.strRegDate }</span>
                                                </a>
                                            </li>
                                         </c:forEach>
                                            <!-- 데이터 없을시 -->
                                            <c:if test="${ fn:length(notice)==0}">
                                            <li class="empty">
                                                <div class="well mb_0">
                                                	등록된 게시글이 없습니다
                                                </div>
                                            </li>
                                            </c:if>
                                            <!--// 데이터 없을시 -->
                                        </ul>
                                        <a href="communityNoticeList.do?cmmntyNo=${community.cmmntyNo}" class="btn_more" title="더보기"><i class="ti-plus" aria-hidden="true"></i><span class="sr-only">더보기</span></a>
                                    </div>
                                </div>
                            </div>
                            <%-- Today 주석 처리 및 공지사항 class 명 변경 col-sm-7 -> col-sm-12로 2022-06-23 --%>
                            <%--
                            <div class="col-sm-5">
                                <div class="panel panel-warning widget_panel">
                                    <div class="panel-heading">
                                        <div class="h6"><i class="fa fa-calendar-check-o" aria-hidden="true"></i> <strong>TODAY</strong></div>
                                    </div>
                                    <div class="panel-body">
                                        <ul class="today_alert_list">
                                        <c:forEach items="${calendar}" var="cal">
                                            <li>
                                            	<i class="fa fa-comments-o"></i>
                                            	 ${cal.title }
                                            </li>
                                        </c:forEach>

                                            <!-- 데이터 없을시 -->
                                            <c:if test="${ fn:length(calendar)==0}">
                                            <li class="empty">
                                                <div class="well mb_0">
                                                   	등록된 일정이 없습니다
                                                </div>
                                            </li>
                                            </c:if>
                                            <!--// 데이터 없을시 -->
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            --%>
                        </div>
                        <div class="row type10 widget_set">
                            <%--
                            <div class="col-sm-6">
                                <div class="panel panel-info widget_panel">
                                    <div class="panel-heading">
                                        <div class="h6"><i class="fa fa-file-text-o" aria-hidden="true"></i> <strong>지식 게시판</strong></div>
                                    </div>
                                    <div class="panel-body p_0">
                                        <ul class="latest_list">
                                        <c:forEach items="${knowledgeList.list}" var="know">
                                        	<li><a href="/kno/knowledgeDetail.do?cmmntyNo=${community.cmmntyNo}&knowlgNo=${know.knowlgNo }">${know.title }</a></li>
                                        </c:forEach>
                                        
                                        </ul>
                                        <a href="communityKnowledgeList.do?cmmntyNo=${community.cmmntyNo}" class="btn_more" title="더보기"><i class="ti-plus" aria-hidden="true"></i><span class="sr-only">더보기</span></a>
                                    </div>
                                </div>
                            </div>
                            --%>
                        <div class="col-sm-6">
                            <div class="panel panel-info widget_panel">
                                <div class="panel-heading">
                                    <div class="h6"><i class="fa fa-file-text-o" aria-hidden="true"></i> <strong>지식 게시판</strong></div>
                                </div>
                                <div class="panel-body p_0">
                                    <ul class="latest_list">
                                        <c:forEach items="${freeKnowledgeList}" var="free">
                                            <li><a href="community2FreeView.do?cmmntyNo=${community.cmmntyNo}&pstgNo=${free.pstgNo}">${free.title }</a></li>
                                        </c:forEach>

                                        <!-- 데이터 없을시 -->
                                        <c:if test="${ fn:length(freeKnowledgeList)==0}">
                                            <li class="empty">등록된 게시글이 없습니다</li>
                                        </c:if>
                                        <!-- //데이터 없을시 -->
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="panel panel-info widget_panel">
                                <div class="panel-heading">
                                    <div class="h6"><i class="fa fa-file-text-o" aria-hidden="true"></i> <strong>자유 게시판</strong></div>
                                </div>
                                <div class="panel-body p_0">
                                    <ul class="latest_list">
                                        <c:forEach items="${free}" var="free">
                                            <li><a href="communityFreeView.do?cmmntyNo=${community.cmmntyNo}&pstgNo=${free.pstgNo}">${free.title }</a></li>
                                        </c:forEach>

                                        <!-- 데이터 없을시 -->
                                        <c:if test="${ fn:length(free)==0}">
                                            <li class="empty">등록된 게시글이 없습니다</li>
                                        </c:if>
                                        <!-- //데이터 없을시 -->
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>
                    <!-- //CONTENTS -->
                    <c:if test="${fn:length(calendar) > 0 }">
                    <!-- 스케쥴 팝업 -->
                    <div class="modal fade" id="popupShow" tabindex="-1" role="dialog" aria-labelledby="popupShowLabel">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" title="창닫기"><span aria-hidden="true">&times;</span></button>
                                    <h6 class="modal-title" id="popupShowLabel"><i class="fa fa-calendar"></i> Today Schedule</h6>
                                </div>
                                <div class="modal-body">
                                
                                <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                                  <div class="carousel-inner" role="listbox">
								  <c:forEach items="${calendar}" var="calendar" varStatus="status">
								  <div class="carousel-item item <c:if test="${status.index == 0 }">active</c:if>">
        
    
								  
								  
                                    <table class="table basic_col_tbl d-block w-100 " >
                                        <caption class="sr-only">오늘일정</caption>
                                        <colgroup>
                                            <col />
                                            <col />
                                        </colgroup>
                                        <tr>
                                            <th scope="row">날짜</th>
                                            <td>${calendar.beginDate} ${calendar.beginTime} ~ ${calendar.endDate} ${calendar.endTime}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">작성자</th>
                                            <td>${calendar.registerId}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">제목</th>
                                            <td>${calendar.title}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">내용</th>
                                            <td>${calendar.cont}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">장소</th>
                                            <td>
                                                ${calendar.plc}
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">주 참석자</th>
                                            <td>
                                                ${calendar.attendess}
                                            </td>
                                        </tr>
                                    </table>
                                    </div>
                                    </c:forEach>
								  </div>
								  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
								    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
								    <span class="sr-only">Previous</span>
								  </a>
								  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
								    <span class="carousel-control-next-icon" aria-hidden="true"></span>
								    <span class="sr-only">Next</span>
								  </a>
								</div>
                                    
                                    <!-- 
                                    <nav class="text-center">
                                        <ul class="pagination pagination-sm">
                                            <li>
                                                <a href="#" aria-label="Previous" title="이전">
                                                    <span aria-hidden="true"><i class="fa fa-angle-left" aria-hidden="true"></i></span>
                                                </a>
                                            </li>
                                            <li class="active"><a href="#">1</a></li>
                                            <li><a href="#">2</a></li>
                                            <li><a href="#">3</a></li>
                                            <li><a href="#">4</a></li>
                                            <li><a href="#">5</a></li>
                                            <li>
                                                <a href="#" aria-label="Next" title="다음">
                                                    <span aria-hidden="true"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                     -->
                                </div>
                                <div class="modal-footer">
                                    <div class="row">
                                        <div class="col-xs-6 text-left">
                                            <div class="checkbox-inline today_chk">
                                                <input type="checkbox" id="popupToday"> <label for="popupToday" class="popupToday-label">오늘하루 열지않기</label>
                                            </div>
                                        </div>
                                        <div class="col-xs-6 text-right">
                                            <button type="button" class="btn btn-sm btn-black close_btn" data-dismiss="modal">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //스케쥴 팝업 -->
                    </c:if>

                    <c:if test="${fn:length(listApply) > 0 }">
                    <div class="modal fade" id="applyPopup" tabindex="-1" role="dialog" aria-labelledby="applyPopupLabel">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content form-horizontal">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="applyPopupLabel"><strong><i class="fa fa-bell" aria-hidden="true"></i> ${user.displayName }님 알림</strong></h4>
                                </div>
                                <div class="modal-body">
                                    <ul class="alarm_list">
                                        <c:forEach items="${listApply}" var="event">
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
                                    </ul>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    </c:if>
                </div>
                <!-- //row -->
            </div>
            
<script>
$(function(){
	// 이미지 슬라이드 컨트롤를 사용하기 위해서는 carousel를 실행해야한다.
	$('.carousel').carousel({
	// 슬리아딩 자동 순환 지연 시간
	// false면 자동 순환하지 않는다.
	interval: 3000,
	// hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
	pause: "hover",
	// 순환 설정, true면 1 -> 2가면 다시 1로 돌아가서 반복
	wrap: true,
	// 키보드 이벤트 설정 여부(?)
	keyboard : true
	});
	
	var isApply = "${fn:length(listApply) > 0 }";
	if(isApply){
        setTimeout(function () {
            $('#applyPopup').modal('show');
        }, 50);
	}
});

function goEventCommunity(eventNo,cmmntyNo){
	var param = {eventNo:eventNo};
	$.post("/cmu/clearEventCommunity.do", param, function(data, status){});
	
	location.href = "/cmu/admin/communityAdminConfirm.do?cmmntyNo="+cmmntyNo;
}
</script>            