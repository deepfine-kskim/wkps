<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
var cmmntyNo = ${community.cmmntyNo};
var noticeNo = [];
noticeNo[0] = ${notice.noticeNo};

$(function() {
    
    $('#btn_del').click(function(){  	
    	
    	var result = confirm("정말 삭제하시겠습니까?");
    	if(!result){
    	    return;
    	}
    	
    	var param ={ cmmntyNo: cmmntyNo,
    			noticeNo: noticeNo}; 
		
		$.post("deleteCommunityNotice.do",
 		   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){
			    	location.href = "/cmu/communityNoticeList.do?cmmntyNo="+cmmntyNo;
 			  } else{
 				 alert(json.err_msg);
 			  } 
			} 
		);
    });

});
</script>
<div class="container sub_cont">
                <div class="row layout_side_row">
                    ﻿<%@ include file="EgovCommunitySide.jsp" %>      
                    <!-- //ASIDE -->
                    <div id="contents" class="col-md-9">
                        <div class="page-header sub_title">
                            <h2>공지사항</h2>
                        </div>
                        <div class="page-body">
                            <div class="brd_view_area">
                                <div class="view_header">
                                    <strong class="subject">${notice.title }</strong>
                                    <div class="row type0 info_view">
                                        <div class="col-xs-12 col-sm-4">
                                            <span>작성일 : </span><span class="data">${notice.strRegDate}</span>
                                        </div>
                                        <div class="col-xs-12 col-sm-8 info_txts">
                                            <span class="info_txt">조회 : <span class="data">${notice.inqCnt}</span></span>
                                            <span class="info_txt name">작성자 : <span class="data">${notice.cmmntyNicknm}</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="view_body">
                                	
                                	<c:out value="${notice.cont }" escapeXml="false"/>
                                </div>
                                <c:if test="${fn:length(notice.attach)>0}">
                                <div class="info_grp files">
                                    <c:forEach var="file" items="${notice.attach}">
			                        	<p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger">${file.orignlFileNm }</a></p>
			                        </c:forEach>
                                </div>
                                </c:if>
                                <c:if test="${(notice.link1 != null and notice.link1 != '') or (notice.link2 != null and notice.link2 != '')}">
                                <div class="info_grp lnks">
                                	
                                    
                                    <c:if test="${notice.link1 != null and notice.link1 != ''}"> 
                                    <p>링크1 : <a href="${notice.link1}" class="text-primary" target="_blank" title="새창열림">${notice.link1}</a></p>
                                    </c:if>
                                    
                                    
                                    <c:if test="${notice.link2 != null and notice.link2 != ''}"> 
                                    <p>링크2 : <a href="${notice.link2}" class="text-primary" target="_blank" title="새창열림">${notice.link2}</a></p>
                                    </c:if>
                                </div>
                                </c:if>
                            </div>
                            <!-- //brd_view_area -->
                            <!-- 이전/다음 -->
                            <ul class="list-group post_nav">
                            	<c:if test="${prev != null }">
                                <li class="list-group-item"><a href="communityNoticeView.do?cmmntyNo=${community.cmmntyNo }&noticeNo=${prev.noticeNo}" class="text-overflow dblong"><strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> 이전글</strong> : ${prev.title }</a></li>
                                </c:if>
                                <c:if test="${next != null }">
                                <li class="list-group-item"><a href="communityNoticeView.do?cmmntyNo=${community.cmmntyNo }&noticeNo=${next.noticeNo}" class="text-overflow dblong"><strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : ${next.title }</a></li>
                                </c:if>
                            </ul>
                            <!-- //이전/다음 -->
                            <div class="row brd_foot_btns">
                                <div class="col-sm-6">
                                <c:if test="${role=='Y'}">
                                    <a href="communityNoticeModify.do?cmmntyNo=${community.cmmntyNo }&noticeNo=${notice.noticeNo}" class="btn btn-black">수정</a>
                                    <a href="#" class="btn btn-danger" id="btn_del">삭제</a>
                                </c:if>
                                </div>
                                <div class="col-sm-6 text-right">
                                    <a href="communityNoticeList.do?cmmntyNo=${community.cmmntyNo }" class="btn btn-black">목록</a>
                                    <c:if test="${role=='Y'}">
                                    <a href="communityNoticeWrite.do?cmmntyNo=${community.cmmntyNo }" class="btn btn-blue"><i class="ti-pencil-alt" aria-hidden="true"></i> 글작성</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                </div>
                <!-- //row -->
            </div>