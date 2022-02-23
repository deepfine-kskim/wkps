<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>

$(function() {
	
	var bannerNo = ${banner.bannerNo};
	
	$('#btn_delete').click(function(){
		var param = {bannerNo:bannerNo};
		
		$.post("deleteCommunityBanner.do",param,function(data,status){
			var json = JSON.parse(data);
			if(json.success){
				alert("삭제 되었습니다.");
				location.href="commBnr.do";
			}else{
				alert("삭제할 수 없습니다.");
			}
		});
	});
	
	$('#btn_modify').click(function(){
		location.href="commBnrModify.do?bannerNo="+bannerNo;
	});
	
});

</script>
<div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">
                            배너 관리                                    </h2>
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
                                        <li class="active">배너 관리</li>
                                    </ol>
                                <div id="contents">
                    <div class="well well-white well-lg">
                        <div class="brd_view_area">
                            <div class="view_header">
                                <strong class="subject">${banner.title }</strong>
                                <div class="row type0 info_view">
                                    <div class="col-xs-12">
                                        <span>등록일 : </span><span class="data"><fmt:formatDate value="${banner.registDtm}" pattern="yyyy-MM-dd"/></span>
                                        <span class="info_txt name">작성자 : <span class="data">${banner.registId}</span></span>
                                        <c:if test="${banner.useYn=='Y' }"><span class="info_txt">배너노출 : <span class="text-blue">노출</span></span></c:if>
                            			<c:if test="${banner.useYn=='N' }"><span class="info_txt">배너노출 : <span class="text-danger">미노출</span></span></c:if>
                                        
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="info_grp lnks">
                                <p>링크: <a href="${banner.link }" class="text-primary" target="_blank" title="새창열림">${banner.link }</a></p>
                            </div>
                            <div class="view_body">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">배너 이미지</h3>
                                    </div>
                                    <div class="panel-body">
                                        <img src="${banner.fileStreCours }${banner.streFileNm }" class="img-responsive" alt="이미지 설명" />
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">비고</h3>
                                    </div>
                                    <div class="panel-body">
                                        ${banner.etc }
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //brd_view_area -->
                    </div>
                    <div class="row brd_foot_btns">
                        <div class="col-sm-6">
                            <a href="#" class="btn btn-black" id="btn_modify">수정</a>
                            <a href="#" class="btn btn-danger" id="btn_delete">삭제</a>
                        </div>
                        <div class="col-sm-6 text-right">
                            <a href="commBnr.do" class="btn btn-black btn-lg">목록</a>
                        </div>
                    </div>
                </div>
                <!-- //CONTENTS -->
                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->