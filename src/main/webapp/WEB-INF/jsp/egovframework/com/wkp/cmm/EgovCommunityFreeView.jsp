<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
var cmmntyNo = ${community.cmmntyNo};
var pstgNo = [];
pstgNo = ${free.pstgNo};

$(function() {
	
    $('#btn_save_comment').click(function(){
		if($('#comment').val() == '') {
			alert('댓글을 작성해 주세요.');
			return false;
		}
    	var param ={ cmmntyNo : cmmntyNo,
				pstgNo : pstgNo,
				comment: $('#comment').val()
				}; 
		
		$.post("writeCommunityComment.do",
			   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){
		    	 location.reload();
			  }else{
				 alert(json.err_msg);
			  } 
			} 
		);
		
    });
    
    $('#btn_del').click(function(){  	
    	
    	var result = confirm("정말 삭제하시겠습니까?");
    	if(!result){
    	    return;
    	}
    	
    	var param ={ cmmntyNo: cmmntyNo,
    			pstgNo: pstgNo}; 
		
		$.post("deleteCommunityFree.do",
 		   param, 
		   function(data, status) {
			var json = JSON.parse(data);
		      if(json.success){
		    	location.href = "/cmu/communityFreeList.do?cmmntyNo="+cmmntyNo;
 			  } else{
 				 alert(json.err_msg);
 			  } 
			} 
		);
    });

});

function del_comment(commentNo){
	var param ={ cmmntyNo : cmmntyNo,
			commentNo: commentNo
			}; 
	
	$.post("deleteCommunityComment.do",
		   param, 
	   function(data, status) {
		var json = JSON.parse(data);
	      if(json.success){
	    	 location.reload();
		  }else{
			 alert(json.err_msg);
		  } 
		} 
	);
}

function mod_comment(commentNo){
	var param ={ cmmntyNo : cmmntyNo,
			comment:$('#comment_'+commentNo).val(),
			commentNo: commentNo,
			cmmntyNo : cmmntyNo,
			pstgNo : pstgNo
			}; 
	
	$.post("updateCommunityComment.do",
		   param, 
	   function(data, status) {
		var json = JSON.parse(data);
	      if(json.success){
	    	 location.reload();
		  }else{
			 alert(json.err_msg);
		  } 
		} 
	);
}
</script>
<div class="container sub_cont">
                <div class="row layout_side_row">
                    ﻿<%@ include file="EgovCommunitySide.jsp" %>
                    <!-- //ASIDE -->
                    <div id="contents" class="col-md-9">
                        <div class="page-header sub_title">
                            <h2>자유게시판</h2>
                        </div>
                        <div class="page-body">
                            <div class="brd_view_area">
                                <div class="view_header">
                                    <strong class="subject">${free.title }</strong>
                                    <div class="row type0 info_view">
                                        <div class="col-xs-12 col-sm-4">
                                            <span>작성일 : </span><span class="data">${free.strRegDate}</span>
                                        </div>
                                        <div class="col-xs-12 col-sm-8 info_txts">
                                            <span class="info_txt">조회 : <span class="data">${free.inqCnt}</span></span>
                                            <span class="info_txt name">작성자 : <span class="data">${free.cmmntyNicknm}</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="view_body">
                                    <c:out value="${free.cont }" escapeXml="false"/>
                                </div>
                                <c:if test="${fn:length(free.attach)>0}">
                                
	                                <div class="info_grp files">
		                                <c:forEach var="file" items="${free.attach}">
				                        	<p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger">${file.orignlFileNm }</a></p>
				                        	<%-- <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${free.attach[0].atchFileNo }&fileSn=${free.attach[0].fileSn }" class="text-danger">${free.attach[0].orignlFileNm}</a> (${free.attach[0].fileSize})</p> --%>
				                        </c:forEach>
			                        </div>
	                                
	                                <%-- <div class="info_grp files">
	                                	<c:if test="${fn:length(free.attach)>0}">
	                                    <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${free.attach[0].atchFileNo }&fileSn=${free.attach[0].fileSn }" class="text-danger">${free.attach[0].orignlFileNm}</a> (${free.attach[0].fileSize})</p>
	                                    </c:if>
	                                    <c:if test="${fn:length(free.attach)>1}">
	                                    <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${free.attach[1].atchFileNo }&fileSn=${free.attach[1].fileSn }" class="text-danger">${free.attach[1].orignlFileNm}</a> (${free.attach[1].fileSize})</p>
	                                    </c:if>
	                                </div> --%>
                                </c:if>
                                <c:if test="${(free.link1 != null and free.link1 != '') or (free.link2 != null and free.link2 != '')}">
                                <div class="info_grp lnks">
                                	<c:if test="${free.link1 != null and free.link1 != ''}"> 
                                    <p>링크1 : <a href="${free.link1}" class="text-primary" target="_blank" title="새창열림">${free.link1}</a></p>
                                    </c:if>
                                    <c:if test="${free.link2 != null and free.link2 != ''}">
                                    <p>링크2 : <a href="${free.link2}" class="text-primary" target="_blank" title="새창열림">${free.link2}</a></p>
                                    </c:if>
                                </div>
                                </c:if>
                            </div>
                            <!-- //brd_view_area -->
                            <!-- 댓글 리스트 -->
                            <div class="well comment_list">
                                <c:forEach items="${free.comment}" var="comment">
                                <div class="loop">
                                    <div class="info">
                                        <strong>${comment.cmmntyNicknm }</strong>
                                        <span class="date">${comment.strRegDate }</span>
                                    </div>
                                    <p class="memo">
                                    <c:if test="${myMebrNo == comment.mberNo }">
                                        <textarea class="form-control" id="comment_${comment.commentNo}">${comment.comment }</textarea>
                                    </c:if>
                                    <c:if test="${myMebrNo != comment.mberNo }">
                                    ${comment.comment }
                                    </c:if>
                                    </p>
                                    <div class="btns text-right">
                                    <c:if test="${myMebrNo == comment.mberNo }">
                                        <button type="button" class="btn btn-xs btn-default outline" onclick="mod_comment(${comment.commentNo})">수정</button>
                                        <button type="button" class="btn btn-xs btn-default outline" onclick="del_comment(${comment.commentNo})">삭제</button>
                                    </c:if>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>
                            <!--- //댓글 리스트 -->
                            <!-- 댓글 작성 -->
                            
                                <fieldset>
                                    <legend class="sr-only">댓글작성</legend>
                                    <div class="well comment_write">
                                        <strong class="title">댓글작성</strong>
                                        <!-- 
                                        <div class="form-group">
                                            <label for="commentName" class="col-sm-2 col-lg-1 control-label">작성자</label>
                                            <div class="col-sm-3">
                                                <input type="text" class="form-control" id="commentName" required />
                                            </div>
                                            <label for="commentPw" class="col-sm-2 control-label">비밀번호</label>
                                            <div class="col-sm-3">
                                                <input type="password" class="form-control" id="commentPw" required />
                                            </div>
                                        </div>
                                         -->
                                       
                                        <div class="form-group">
                                            <label for="comment" class="sr-only">덧글내용</label>
                                            <div class="col-sm-12">
                                                <textarea class="form-control" id="comment" placeholder="댓글을 작성해주세요."></textarea>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <button class="btn btn-default" id="btn_save_comment">댓글등록</button>
                                        </div>
                                    </div>
                                </fieldset>
                            
                            <!-- //댓글 작성 -->
                            <!-- 이전/다음 -->
                            <ul class="list-group post_nav">
                            	<c:if test="${prev != null }">
                                <li class="list-group-item"><a href="communityFreeView.do?cmmntyNo=${community.cmmntyNo }&pstgNo=${prev.pstgNo}" class="text-overflow dblong"><strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> 이전글</strong> : ${prev.title } </a></li>
                                </c:if>
                                <c:if test="${next != null }">
                                <li class="list-group-item"><a href="communityFreeView.do?cmmntyNo=${community.cmmntyNo }&pstgNo=${next.pstgNo}" class="text-overflow dblong"><strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : ${next.title }</a></li>
                                </c:if>
                            </ul>
                            <!-- //이전/다음 -->
                            <div class="row brd_foot_btns">
                                <div class="col-sm-6">
                                <c:if test="${role=='Y'}">
                                    <a href="communityFreeModify.do?cmmntyNo=${community.cmmntyNo }&pstgNo=${free.pstgNo}" class="btn btn-black">수정</a>
                                    <a href="#" class="btn btn-danger" id="btn_del">삭제</a>
                                </c:if>
                                </div>
                                <div class="col-sm-6 text-right">
                                    <a href="communityFreeList.do?cmmntyNo=${community.cmmntyNo }" class="btn btn-black">목록</a>
                                    <a href="communityFreeWrite.do?cmmntyNo=${community.cmmntyNo }" class="btn btn-blue"><i class="ti-pencil-alt" aria-hidden="true"></i> 글작성</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- //CONTENTS -->
                </div>
                <!-- //row -->
            </div>