<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
        <div class="container sub_cont">
        	<div class="page-header">
        		<h2>지식백과</h2>
        		<div>${menuDesc }</div>
            </div>
            <!-- //page-header -->
            <div class="row layout_side_row">
                <div id="aside" class="col-md-3">
					<ul class="nav nav-tabs nav-justified side_tabs">
                        <li <c:if test="${knowledgeDetail.knowlgMapType eq 'REPORT' }">class="active"</c:if>><a href="javasrcipt:;" class="dev-type" data-type="REPORT">행정자료</a></li>
                        <li <c:if test="${knowledgeDetail.knowlgMapType eq 'REFERENCE' }">class="active"</c:if>><a href="javasrcipt:;" class="dev-type" data-type="REFERENCE">업무참고자료</a></li>
                        <li <c:if test="${knowledgeDetail.knowlgMapType eq 'PERSONAL' }">class="active"</c:if>><a href="javasrcipt:;" class="dev-type" data-type="PERSONAL">개인별지식</a></li>
                    </ul>
                    <div class="side_card_box mside_tog">
                        <div class="side_top hidden-sm hidden-lg hidden-md">
                            <strong class="name">지식분류</strong>
                            <span class="m_btn hidden-sm hidden-md hidden-lg"><i class="fa fa-chevron-down"></i></span>
                        </div>
                        <div class="mside_tog_cont">
                            <ul class="tree_list tree_line list-group">
                            	<c:forEach var="main" items="${knowledgeMapList }" varStatus="status"> 
                            	<c:if test="${main.upNo eq 0}">
                                <li class="list-group-item<c:if test="${knowledgeDetail.upNo eq main.knowlgMapNo }"> active</c:if>">
                                    <a href="#">${main.knowlgMapNm }</a>
									<ul class="list-group sub_list">
									<c:forEach var="sub" items="${knowledgeMapList }">
                                   	<c:if test="${sub.upNo eq main.knowlgMapNo }">
                                        <li>
                                        	<a href="javascript:;" class="lnk<c:if test="${knowledgeDetail.knowlgMapNo eq sub.knowlgMapNo }"> on</c:if>" data-no="${sub.knowlgMapNo }">${sub.knowlgMapNm }</a>
                                        </li> 
									</c:if>
									</c:forEach>
                            		</ul>
                                </li>
                                </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <!-- side_card_box -->
                    <div class="row type5">
                        <div class="col-sm-6 col-md-12">
                            <div class="side_card_box ranking_area box1 mside_tog">
                                <div class="side_top">
                                    <strong class="name text-black">지식 챔피언</strong>
                                    <span class="m_btn hidden-sm hidden-md hidden-lg"><i class="fa fa-chevron-down"></i></span>
                                </div>
                                <div class="mside_tog_cont">
                                    <div class="side_cont_wrap">
                                        <ol class="ranking_list">
                                        	<c:forEach var="excellenceUser" items="${excellenceUserList }">
                                            <li>
                                                <strong class="text-primary">${excellenceUser.rki }위</strong> ${excellenceUser.displayName } <span class="text-muted">(${excellenceUser.ou })</span>
                                            </li>
                                            </c:forEach>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <!-- side_card_box -->
                        </div>
                        <div class="col-sm-6 col-md-12">
                            <div class="side_card_box ranking_area box2 mside_tog">
                                <div class="side_top">
                                    <strong class="name text-black">지식 부서</strong>
                                    <span class="m_btn hidden-sm hidden-md hidden-lg"><i class="fa fa-chevron-down"></i></span>
                                </div>
                                <div class="mside_tog_cont">
                                    <div class="side_cont_wrap">
                                        <ol class="ranking_list">
                                        	<c:forEach var="excellenceOrg" items="${excellenceOrgList }">
                                            <li>
                                                <strong class="text-primary">${excellenceOrg.rki }위</strong> ${excellenceOrg.ou }
                                            </li>
                                            </c:forEach>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            <!-- side_card_box -->
                        </div>
                    </div>
                </div>
                <!-- //ASIDE -->
                <div id="contents" class="col-md-9">
                    <div class="page-body">
                    	<div class="brd_view_area wiki_view">
                    	    <div class="view_header">
                    	        <div class="subject">
                                    <div class="cate_info">
										<span class="text-danger">
										<c:choose>
											<c:when test="${knowledgeDetail.knowlgMapType eq 'REPORT' }">[행정자료]</c:when>
											<c:when test="${knowledgeDetail.knowlgMapType eq 'REFERENCE' }">[업무참고자료]</c:when>
											<c:otherwise>[개인별지식]</c:otherwise>
										</c:choose>
										</span>
                                            <div class="wiki_breadcrumb">
                                                <ol class="breadcrumb">
													<li>${knowledgeDetail.upNm }</li>
                                                    <li class="active">${knowledgeDetail.knowlgMapNm }</li>
                                                </ol>
                                            </div>
                                    </div>
									${knowledgeDetail.title }
                                </div>
                                <div class="row type0 info_view">
                                    <div class="col-xs-12 col-sm-4">
                                        <span>최근 수정일 : </span><span class="data">${lastUpdated }</span>
                                    </div>
                                    <div class="col-xs-12 col-sm-8 info_txts">
                                        <span class="info_txt name">등록일 : <span class="data">${knowledgeDetail.registDtm }</span></span>
                                    </div>
                                    <!-- <div class="col-xs-12 col-sm-8 info_txts">
                                        <span class="info_txt name">작성자 : <span class="data">${knowledgeDetail.displayName }(${knowledgeDetail.ou })</span></span>
                                    </div> -->
                                </div>
                            </div>
                            <c:if test="${not empty fileList }">
                            <div class="info_grp files">
		                    	<c:forEach var="file" items="${fileList }">
		                        <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger">${file.orignlFileNm }</a> (${file.fileMg }K) <a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${file.fileStreCours }${file.streFileNm }" data-fid="KNO_${knowledgeDetail.knowlgNo }">미리보기</a></p>
		                        </c:forEach>
                            </div>
                            </c:if>
                            <div class="view_body">
                                <dl class="well_dl">
                                    <dt>요약</dt><!-- 09.15 리뷰용 수정 -->
                                    <dd class="well well-primary outline">
                                        ${knowledgeDetail.summry }
                                    </dd>
                                </dl>
                                <dl class="wiki_index">
                                    <dt>목차</dt>
                                    <dd>
                                        <ul class="wiki_index_list">
											<c:forEach var="contents" items="${knowledgeContentsList }">
                                            <li>
												<a href="#wikiDoc${contents.sortOrdr }"><span class="num">${contents.sortOrdr }.</span> ${contents.subtitle }</a>
                                            </li>
											</c:forEach>
                                        </ul>
                                    </dd>
                                </dl>
								<c:forEach var="contents" items="${knowledgeContentsList }">
								<div id="wikiDoc${contents.sortOrdr }" class="wiki_box">
                                    <div class="wiki_header">
                                        <h2 class="h2"><span class="num">${contents.sortOrdr }.</span> ${contents.subtitle }</h2>
                                        <c:if test="${loginVO.sid eq knowledgeDetail.registerId || loginVO.ouCode eq knowledgeDetail.ouCode }"><a href="javascript:;" class="edit_lnk text-danger mdfBtn" data-ordr="${contents.sortOrdr }">[편집]</a></c:if>
                                    </div>
                                    <div class="wiki_body">
                                        <div class="wiki_paras">
                                        	${fn:replace(fn:replace(fn:replace(contents.cont, "&lt;", "<"), "&gt;", ">"),"&quot;","\'") }
                                        </div>
                                    </div>
                                </div>
								</c:forEach>
								<c:if test="${not empty relateKnowledgeList }">
                                <div class="panel panel-primary panel-sm wiki_panel">
                                    <div class="panel-heading">
                                        <strong class="panel-title">관련 지식</strong>
                                    </div>
                                    <div class="panel-body">
                                        <ul class="dot_list">
											<c:forEach var="relate" items="${relateKnowlgVO }">
												<c:url value="/kno/knowledgeDetail.do" var="url">
													<c:param name="title" value="${relate.title }" />
												</c:url>
	                                            <li><a href="${url }" target="_blank" title="새창열림">${relate.title }</a>
	                                            <%-- <a href="/kno/deleteRelateKnowlg.do?relateKnowlgNo=${relate.relateKnowlgNo }&sortOrdr=${relate.sortOrdr }">&nbsp;&nbsp;<i class="remove">x</i></a><span class="sr-only">삭제</span> --%>  
	                                            </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                                <c:if test="${not empty knowledgeHistoryList }">
                                <div class="panel panel-primary panel-sm wiki_panel">
                                    <div class="panel-heading">
                                        <strong class="panel-title">지식이력</strong>
                                    </div>
                                    <div class="panel-body">
                                        <ul class="dot_list">
                                        	<c:forEach var="history" items="${knowledgeHistoryList }">
                                        	<c:url value="/kno/knowledgeDetail.do" var="url">
                                        		<c:param name="title" value="${history.title }"/>
                                        		<c:param name="knowledgeNo" value="${history.knowlgNo }"/>
                                        	</c:url>
                                            <li><a href="${url }" target="_blank" title="새창열림">${history.displayName }(${history.ou }) <span class="date">${history.registDtm }</span></a>
                                            <%-- <a href="/kno/deleteknowlg.do?title=${history.title }&knowlgNo=${history.knowlgNo }">&nbsp;&nbsp;<i class="remove">x</i></a><span class="sr-only">삭제</span> --%>
                                            </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                            </div>
                        </div>
                        <!-- //brd_view_area -->
                        <div class="wiki_keywords">
                        	<a href="#">${knowledgeDetail.keyword }</a>
                        </div>
                        <div class="wiki_btns">
                            <ul>
                            	<c:url var="copyUrl" value="http://105.0.1.229/kno/knowledgeDetail.do">
                            		<c:param name="title" value="${knowledgeDetail.title }"/>
                            		<c:param name="knowledgeNo" value="${knowledgeDetail.knowlgNo }"/>
                            	</c:url>
                                <li><button type="button" class="btn btn-sm btn-primary outline" data-clipboard-text="${copyUrl }">링크복사</button></li>
                                <li><button type="button" id="bookmarkBtn" class="btn btn-sm btn-primary outline on">즐겨찾기</button></li>
                                <li><a href="#reportPopup" data-toggle="modal" data-target="#reportPopup"  class="btn btn-sm btn-primary outline">오류신고</a></li>
                                <li><button type="button" id="recommendBtn" class="btn btn-sm btn-primary outline tog_on_btn like_btn<c:if test="${isRecommend }"> on</c:if>">추천 <span id="recommendCnt" class="text-danger">(${recommendCount })</span></button></li> 
                            </ul>
                        </div>
                        <div class="row brd_foot_btns">
                        	<c:choose>
                            <c:when test="${knowledgeDetail.copertnWritngYn eq 'Y' || loginVO.sid eq knowledgeDetail.registerId || loginVO.ouCode eq knowledgeDetail.ouCode }">
                            <div class="col-sm-6">
                            	<a href="javascript:;" id="updBtn" class="btn btn-black">수정</a>
                            	<c:if test="${knowledgeDetail.registerId == user.sid or user.sid == 'admin'}">
                                	<a href="javascript:;" id="delBtn" class="btn btn-danger">삭제</a>
                                </c:if>
                            </div>
                            <div class="col-sm-6 text-right">
                            <c:choose>
                            	<c:when test="${not empty cmmntyNo && cmmntyNo != 0 }">
                                <a href="/cmu/communityKnowledgeList.do?cmmntyNo=${cmmntyNo }" class="btn btn-black">목록</a>
                                </c:when>
                                <c:otherwise>
                                <a href="javascript:;" class="btn btn-black dev-list">목록</a>
                                </c:otherwise>
                            </c:choose>
                            </div>
                            </c:when>
                            <c:otherwise>
                            <div class="col-sm-12 text-right">
                            <c:choose>
                            	<c:when test="${not empty cmmntyNo && cmmntyNo != 0 }">
                                <a href="/cmu/communityKnowledgeList.do?cmmntyNo=${cmmntyNo }" class="btn btn-black">목록</a>
                                </c:when>
                                <c:otherwise>
                                <a href="javascript:;" class="btn btn-black dev-list">목록</a>
                                </c:otherwise>
                            </c:choose>
                            </div>
                            </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <!-- //page-body -->
                </div>
                <!-- CONTENTS -->
                
                <!-- 오류지식 신고 팝업 -->
                <div class="modal fade" id="reportPopup" tabindex="-1" role="dialog" aria-labelledby="reportPopupLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <form:form class="modal-content" action="/kno/insertErrorStatement.do" modelAttribute="errorStatmentVO">
                        	<input type="hidden" name="title" value="${knowledgeDetail.title }">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="reportPopupLabel"><strong>오류 지식 신고</strong> </h4>
                            </div>
                            <div class="modal-body">
                                <div class="brd_view_area wiki_view">
                                    <div class="view_header">
                                        <div class="subject">
                                            <div class="cate_info">
                                                <span class="text-danger">[행정자료]</span>
                                                <div class="wiki_breadcrumb">
                                                    <ol class="breadcrumb">
                                                        <li>일반현황</li>
                                                        <li class="active">인구</li>
                                                    </ol>
                                                </div>
                                            </div>
                                           	 ${knowledgeDetail.title }
                                        </div>
                                    </div>
                                </div>
                                <div class="well">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <strong class="col-sm-2 control-label">오류유형</strong>
                                            <div class="col-sm-10">
                                                <input class="form-control" type="text" name="statmntTitle" required="required" placeholder="오류유형을 입력하세요">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="inpText" class="col-sm-2 control-label">오류내용</label>
                                            <div class="col-sm-10">
                                                <textarea class="form-control" rows="6" id="inpText" name="cont" required="required" placeholder="오류내용을 입력하세요"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">확인</button>
                                <button type="button" class="btn btn-black" data-dismiss="modal">취소</button>
                            </div>
                        </form:form>
                    </div>
                </div>
                <!-- //오류지식 신고 팝업 -->
            </div>
            <!-- //row -->
        </div>
        <!-- CONTENTS -->
<form:form name="knowledgeFrm" modelAttribute="knowledgeVO">
<input type="hidden" name="title" value="${knowledgeDetail.title }">
<input type="hidden" name="knowlgNo" value="${knowledgeDetail.knowlgNo }">
<input type="hidden" name="knowlgMapType" value="${knowledgeDetail.knowlgMapType }">
<input type="hidden" name="knowlgMapNo" value="${knowlgMapNo }">
<input type="hidden" name="sortOrdr" value="0">
<input type="hidden" name="cmmntyNo" value="${empty cmmntyNo?0:cmmntyNo}">
</form:form>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>" ></script>
<script src="/js/egovframework/com/wkp/clipboard.min.js"></script> 
<script>
	CKEDITOR.replace('inpText');

	$(function(){
			
		$('#bookmarkBtn').click(function(){
			var title = '${knowledgeDetail.title }';
			$.ajax({
     			url : '/kno/insertBookmark.do',
     			data : {
     				title : title
     			},
     			global : false,
     			dataType : "json",
     			success : function(data) {
     				alert("즐겨찾기에 추가되었습니다.");
     			},
     			error : function(){
     				alert("이미 추가되었습니다.");
     			}
     		});
		});
		
		$('.mdfBtn').click(function(e){
			e.preventDefault();
			var ordr = $(this).data('ordr'); 
			var form = $("form[name=knowledgeFrm]");
			form.find("input[name=sortOrdr]").val(ordr);
            form.attr("action", "/kno/modifyKnowledgeView.do");
			form.submit();
		});
		
		$('#updBtn').click(function(e){
			e.preventDefault();
			var form = $("form[name=knowledgeFrm]");
            form.attr("action", "/kno/updateKnowledgeView.do");
			form.submit();
		});
		
		$('#delBtn').click(function(e){
			e.preventDefault();
			if(confirm('삭제하시겠습니까?\n삭제 시 지식이력도 모두 삭제되며 복구는 불가능합니다.')){
				var form = $("form[name=knowledgeFrm]");
            	form.attr("action", "/kno/deleteKnowledge.do");
				form.submit();
			}
		});
		 
        $("#recommendBtn").click(function(e) {
            $.ajax({
                url: "/kno/updateRecommend.do",
                data: {
                	knowlgNo : '${knowledgeDetail.knowlgNo }'
                },
                dataType: 'json',
                type: "POST",
                global: false,
                success: function (data) {
                	if(data.isRecommend) {
                		$("#recommendBtn").addClass("on");
                	} else {
                		$("#recommendBtn").removeClass("on");
                	}
                	$('#recommendCnt').html(data.count);
                },
                error: function (error) {
                    alert("추천 중 에러가 발생하였습니다.");
                }
            });
        });
        
     	$('.dev-type').on('click', function(e) {
        	e.preventDefault();
     		var type = $(this).data('type');
            var form = $("form[name=knowledgeFrm]");
            form.find("input[name=knowlgMapType]").val(type);
            form.find("input[name=knowlgMapNo]").val(0);
            form.attr("action", "/kno/knowledgeList.do");
            form.submit();
     	});
     	
     	$('.lnk').on('click', function(e) {
        	e.preventDefault();
     		var no = $(this).data('no');
            var form = $("form[name=knowledgeFrm]");
            form.find("input[name=knowlgMapNo]").val(no);
            form.attr("action", "/kno/knowledgeList.do");
            form.submit();
     	});
     	
        $('.dev-list').on('click', function (e) {
        	e.preventDefault();
            var form = $("form[name=knowledgeFrm]");
            form.attr("action", "/kno/knowledgeList.do");            
            form.submit();
        });
		
	});
	
	var clipboard = new ClipboardJS('.btn');
	
	clipboard.on('success', function(e) {
	    alert('URL이 복사 되었습니다. 원하시는 곳에 붙여넣기 해 주세요.');
	});
	
	clipboard.on('error', function(e) {
		alert('이 브라우저는 지원하지 않습니다.');
	});
</script>