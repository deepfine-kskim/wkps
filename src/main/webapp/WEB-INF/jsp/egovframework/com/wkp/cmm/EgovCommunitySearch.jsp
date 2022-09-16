<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
      	form.find("input[name=search_type]").val($("#search_type").val());	
      	form.find("input[name=search_value]").val($("#search_value").val());
      	form.attr("action", "communitySearch.do");
      	form.submit();
    }


});

</script>
<div class="container sub_cont">
                <div id="contents">
                    <div class="comm_main_section">
                        <div class="comm_top">
                            <div class="row type5">
                                <div class="col-sm-12">
                                    <p class="user_alarm"><strong class="text-primary">${user.displayName }</strong>님<a href="#myAlarmPopup" data-toggle="modal" data-target="#myAlarmPopup" class="alert_btn"><i class="fa fa-bell"><span class="sr-only">알림</span></i> <span class="ico_new"><i class="xi-new"><span class="sr-only">새알림</span></i></span></a></p> <a href="./communityMake.html" class="btn btn-primary"><i class="ti-pencil-alt" aria-hidden="true"></i> 커뮤니티 만들기</a>
                                </div>
                            </div>
                            <div class="well well-primary outline comm_srch_box text-center">
                                <form class="form-inline comm_srch_frm">
                                    <fieldset>
                                        <legend class="sr-only">커뮤니티 검색</legend>
                                        <div class="form-group">
                                            <label for="search_type" class="sr-only">검색대상</label>
                                            <select id="search_type" name="search_type" class="form-control" id="search_type">
                                                <option value="01" <c:if test="${search_type == '01'}">selected</c:if>>커뮤니티 명</option>
                                                <option value="02" <c:if test="${search_type == '02'}">selected</c:if>>커뮤니티 설명</option>
                                                <option value="03" <c:if test="${search_type == '03'}">selected</c:if>>키워드</option>
                                            </select>
                                        </div>
                                        <div class="input-group">
                                            <label for="search_value" class="sr-only">검색어 입력</label>
                                            <input type="text" id="search_value" name="search_value" class="form-control" placeholder="검색어" value="${search_value}" />
                                            <span class="input-group-btn"><button class="btn btn-default" id="btn_search">검색</button></span>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <!-- //comm_top -->
                        <div class="comm_srch_area">
                        	<c:if test="${fn:length(list) > 0}">
                            <ul class="comm_card_list row_list">
	                            <c:forEach items="${list }" var="cmmnty">
                                <li class="col-xs-6 col-sm-4 col-md-3">
                                    <a href="communityMain.do?cmmntyNo=${cmmnty.cmmntyNo}" class="frame">
                                        <div class="caption_box">
                                            <strong class="subject">${cmmnty.cmmntyNm}</strong>
                                            <p class="desc">${cmmnty.cmmntyDesc}</p>
                                        </div>
                                        <div class="tags">
                                        	<c:if test="${cmmnty.keyword01 != null}"><span>#${cmmnty.keyword01}</span></c:if>
                                            <c:if test="${cmmnty.keyword02 != null}"><span>#${cmmnty.keyword02}</span></c:if>
                                            <c:if test="${cmmnty.keyword03 != null}"><span>#${cmmnty.keyword03}</span></c:if>
                                            <c:if test="${cmmnty.keyword04 != null}"><span>#${cmmnty.keyword04}</span></c:if>
                                            <c:if test="${cmmnty.keyword05 != null}"><span>#${cmmnty.keyword05}</span></c:if>
                                            <c:if test="${cmmnty.keyword06 != null}"><span>#${cmmnty.keyword06}</span></c:if>
                                            <c:if test="${cmmnty.keyword07 != null}"><span>#${cmmnty.keyword07}</span></c:if>
                                            <c:if test="${cmmnty.keyword08 != null}"><span>#${cmmnty.keyword08}</span></c:if>
                                            <c:if test="${cmmnty.keyword09 != null}"><span>#${cmmnty.keyword09}</span></c:if>
                                            <c:if test="${cmmnty.keyword10 != null}"><span>#${cmmnty.keyword10}</span></c:if> 
	                                        
                                        </div>
                                    </a>
                                </li>
                                </c:forEach>
                            </ul>
                            
                            <!-- 페이지 네비 -->
                            <form name="pagingForm" method="GET" action="">
								<input type="hidden" name="page" value="${page}"/>
								<input type="hidden" name="search_type" value="${search_type}"/>
								<input type="hidden" name="search_value" value="${search_value}"/>
						   </form>
                            <nav class="text-center">
                                <ul id="pagination" class="pagination pagination-sm">
                                    
                                </ul>
                            </nav>
                            <!-- //페이지 네비 -->
                            </c:if>
                            <c:if test="${fn:length(list) == 0} ">
                            <!-- 검색결과 없을시 -->
                            <ul class="comm_card_list row_list">
                                <li class="col-xs-12 empty">
                                    <p class="frame">검색 결과가 없습니다.</p>
                                </li>
                            </ul>
                            </c:if>
                        </div>
                    </div>
                    <!-- 알림팝업 -->
                    <div class="modal fade" id="alertPopup" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
                        <div class="modal-dialog modal-sm" role="document">
                            <form class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="alertPopupLabel">알림</h4>
                                </div>
                                <div class="modal-body">
                                    <p class="text-center">A 커뮤니티는 이런 이유로<br /> 가입이 <span class="text-danger">반려처리</span> 되었습니다.</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default outline" data-dismiss="modal">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- //알림팝업 -->
                    <!-- 나의알림 팝업 -->
                    <div class="modal fade" id="myAlarmPopup" tabindex="-1" role="dialog" aria-labelledby="myAlarmPopupLabel">
                        <div class="modal-dialog" role="document">
                            <form class="modal-content form-horizontal">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myAlarmPopupLabel"><strong><i class="fa fa-bell" aria-hidden="true"></i> 홍길동님 알림</strong></h4>
                                </div>
                                <div class="modal-body">
                                    <ul class="alarm_list">
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#">A 커뮤니티</a></strong></div>
                                                    <ul class="brd_latest_list reply_type">
                                                        <li>
                                                            <a href="#">
                                                                <p class="tit">게시글 제목 게시글 제목 게시글 제목</p>
                                                                <span class="date">2020.08.30</span>
                                                                <div class="reply">
                                                                    <i class="fa fa-level-up fa-rotate-90 text-danger ico"><span class="sr-only">댓글</span></i>
                                                                    댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용
                                                                </div>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <a href="#">
                                                                <p class="tit">게시글 제목 게시글 제목 게시글 제목</p>
                                                                <span class="date">2020.08.30</span>
                                                                <div class="reply">
                                                                    <i class="fa fa-level-up fa-rotate-90 text-danger ico"><span class="sr-only">댓글</span></i>
                                                                    댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용
                                                                </div>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#">B 커뮤니티</a></strong></div>
                                                    <ul class="brd_latest_list reply_type">
                                                        <li>
                                                            <a href="#">
                                                                <p class="tit">게시글 제목 게시글 제목 게시글 제목</p>
                                                                <span class="date">2020.08.30</span>
                                                                <div class="reply">
                                                                    <i class="fa fa-level-up fa-rotate-90 text-danger ico"><span class="sr-only">댓글</span></i>
                                                                    댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용 댓글내용
                                                                </div>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#">C 커뮤니티</a></strong></div>
                                                    <div class="msg_box">
                                                        <span class="text-primary">가입신청</span>이 <span class="text-success">정상 처리</span> 되었습니다.
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#">D 커뮤니티</a></strong></div>
                                                    <div class="msg_box">
                                                        <span class="text-primary">가입신청</span>이 <span class="text-danger">거절</span> 되었습니다.
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <li class="alarm_item">
                                            <div class="panel panel-default widget_panel">
                                                <div class="panel-body">
                                                    <div class="subject"><strong><a href="#">F 커뮤니티</a></strong></div>
                                                    <div class="msg_box">
                                                        <span class="text-primary">개설신청</span>이 <span class="text-danger">거절</span> 되었습니다.
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger outline" data-dismiss="modal">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- //나의알림 팝업 -->
                    <script src="/js/egovframework/com/wkp/comm.js"></script>
                </div>
                <!-- //CONTENTS -->
            </div>