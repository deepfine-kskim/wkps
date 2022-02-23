<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>	
<%
	String a = (String)session.getValue("SESSION_ID");
	
%>
		<!-- <link rel="stylesheet" href="/css/egovframework/com/wkp/jquery-ui.min.css" />	 -->
		<!-- JS -->	
<!-- 		<script type="text/javascript" src="js/jquery/jquery-1.11.0.js"></script>jQuery	
		<script type="text/javascript" src="js/jquery/jquery-ui.js"></script>jQuery UI	
		<script type="text/javascript" src="js/jquery/jquery.cookie.js"></script>Cookie -->	
		<script src="js/jquery.blockUI-2.7.0.min.js"/>
		<!-- <script src="/js/egovframework/com/wkp/jquery.cookie.js"></script>
    <script src="/js/egovframework/com/wkp/moment.js"></script>
    <script src="/js/egovframework/com/wkp/base.js"></script>
    <script src="/js/egovframework/com/wkp/jquery-ui.min.js"></script>
    <script src="/js/egovframework/com/wkp/metisMenu.min.js"></script>
    <script src="/js/egovframework/com/wkp/owl.carousel.min.js"></script>
    <script src="/js/egovframework/com/wkp/main.js"></script> -->
		
		<script type="text/javascript" src="js/jquery/jquery.fancytree.js"></script><!-- Fancy Tree -->	
		<script type="text/javascript" src="js/jquery/jquery.deserialize.min.js"></script><!-- Form deserialization -->	
		<!-- <script type="text/javascript" src="js/jquery/jquery.pagination.js"></script> --><!-- Pagination -->	
		<script type="text/javascript" src="js/jquery/jquery.justified.js"></script><!-- Image gallery -->	
		<script type="text/javascript" src="js/lightbox.js"></script><!-- Image lightbox -->	
	
 		<!-- <script type="text/javascript" src="js/bootstrap.js"></script> --><!--Bootstrap	 -->
<!-- 		<script type="text/javascript" src="js/jquery/jquery.konan.sf.js"></script> --><!-- KSF -->	
		<script type="text/javascript" src="js/jquery/i18n/jquery.konan.sf-ko.js"></script><!-- KSF localization -->	
		<script type="text/javascript" src="js/jquery/i18n/jquery.ui.datepicker-ko.js"></script><!-- Date picker localization -->	
		<script type="text/javascript" src="js/jquery/jquery.inputmask.bundle.js"></script>	
		<script type="text/javascript" src="js/search-ui.js"></script><!-- UI --> 	
		<script type="text/javascript" src="js/kwl-1.0.0.js"></script><!-- KLA -->	
		<script type="text/javascript" src="js/search.js"></script><!-- Events -->	
		<script type="text/javascript" src="js/search.ksf.js"></script><!-- KSF Events -->	
		<script type="text/javascript" src="js/pagenav.js"></script><!-- page -->	


		<form id="historyForm" action="search.do" method="get">	
			<input type="hidden" id="category" name="schCate" value="<c:out value="${params.category}" />"/>
			<input type="hidden" id="kwd" name="kwd" value="<c:out value="${params.kwd}" />"/>
			<input type="hidden" id="date" name="date" value="<c:out value="${params.date}" />"/>	
			<input type="hidden" id="preKwds" name="preKwds" value="<c:out value="${params.preKwds}" />"/>	
			<input type="hidden" id="startDate" name="startDate" value="<c:out value="${params.startDate}" />"/>	
			<input type="hidden" id="endDate" name="endDate" value="<c:out value="${params.endDate}" />"/>		
			<input type="hidden" id="page" name="page" value="0"/>	
			<input type="hidden" id="pageNum" name="pageNum" value="<c:out value="${params.pageNum}" />"/>	
			<input type="hidden" id="reSearch" name="reSearch" value="<c:out value="${params.reSearch}" />"/>	
			<input type="hidden" id="sort" name="sort" value="<c:out value="${params.sort}" />"/>		
			<%-- <input type="hidden" id="nowDate" name="nowDate" value="<c:out value="${params.nowDate}" />"/>	 --%>
			<%-- <input type="hidden" id="userid" name="userid" value="<c:out value="${params.userId}" />"/>	 --%>
			<!-- 상세검색 검색영역 -->
			<input type="hidden" id="schAreaAll" name="schArea" value="<c:out value="${params.schAreaAll}" />"/>
			<input type="hidden" id="schAreaTit" name="schArea1" value="<c:out value="${params.schArea1}" />"/>
			<input type="hidden" id="schAreaCont" name="schArea2" value="<c:out value="${params.schArea2}" />"/>
			<input type="hidden" id="schAreaFile" name="schArea3" value="<c:out value="${params.schArea3}" />"/>
				
		</form>	
		<div id="wrap">
        	<div id="skipNav">
         	   <a href="#contents">본문 바로가기</a>
        	    <a href="#gnbList">주메뉴 바로가기</a>
       		</div>
	
	
		<div id="page">
            <div class="container sub_cont">
                <div class="page-header">
                    <h2>통합검색 </h2>
                </div>
                <!-- //page-header -->
                <div class="row layout_side_row">
                    <div id="aside" class="col-sm-3 col-sm-push-9 col-lg-2 col-lg-push-10">
                    	<!-- 인기검색어 -->	
 							<jsp:include page="module/ppk.jsp"/>	 
						<!-- // 인기검색어 -->
                    </div>
                    <!-- //ASIDE -->
                    <div id="contents" class="col-sm-9 col-sm-pull-3 col-lg-10 col-lg-pull-2">
                        <div class="page-body">
                        <!-- 상단 검색 -->	<!-- <header> -->
							<jsp:include page="common/topSearch.jsp"/>	
						<!-- // 상단 검색 --><!-- </header> -->
                            <!-- //row -->
                            <div class="sch_result_area">
                                <div class="well well-primary outline msg_box">
									<string class="text-danger">${params.kwd }</string> 에 대한 검색결과 총 <span class="text-primary">${total }</span>건이 있습니다.<!-- 09.14 리뷰용 수정 -->
                                </div>
                                
                                <!-- 2020-11-20  추가 시작 -->
                                <div class="result_nav">
                                    <ul class="nav nav-pills">
                                        <li><a href="javascript:goCategory('kno')">지식백과 <span class="badge">${knoTotal}</span></a></li>
                                        <!-- <li><a href="javascript:goCategory('qna')">Q&A <span class="badge">${qnaTotal}</span></a></li> -->
                                        <li><a href="javascript:goCategory('srv')">설문조사 <span class="badge">${srvTotal}</span></a></li>
                                        <li><a href="javascript:goCategory('comm')">커뮤니티 <span class="badge">${commTotal}</span></a></li>
                                        <li><a href="javascript:goCategory('notice')">공지사항 <span class="badge">${noticeTotal}</span></a></li>
                                        <!-- <li><a href="javascript:goCategory('faq')">FAQ <span class="badge">${faqTotal}</span></a></li> -->
                                        <li><a href="javascript:goCategory('edmsRecv')">전자결재 접수함 <span class="badge">${edmsRecvTotal}</span></a></li>
                                        <li><a href="javascript:goCategory('edmsPost')">전자결재 생산함<span class="badge">${edmsPostTotal}</span></a></li>
                                    </ul>
                                </div>
                                <!-- 2020-11-20  추가 종료 -->
                                
                                <!-- 지식백과 검색결과 -->
                                <c:if test="${kno eq 'kno' || params.category eq 'TOTAL' }">	
									<jsp:include page="result/resultKnowledge.jsp"/>
								</c:if>
									<!-- 09-16 리뷰용 수정 -->
                                <!-- //section_sch_result -->
                                <!-- Q&A 검색결과 --> 
                                <%-- 
                                <c:if test="${qna eq 'qna' || params.category eq 'TOTAL' }">
                                    <jsp:include page="result/resultQna.jsp"/>
                                </c:if>
                                --%>
                                <!-- //section_sch_result -->
                                <!-- 설문조사 검색결과 -->
                                <c:if test="${srv eq 'srv' || params.category eq 'TOTAL' }">
                                    <jsp:include page="result/resultSurvey.jsp"/>
                                </c:if>
                                <!-- //section_sch_result -->
                                <!-- 커뮤니티 검색결과 -->
                                <c:if test="${comm eq 'comm' || params.category eq 'TOTAL' }">
                                    <jsp:include page="result/resultCommunity.jsp"/>
                                </c:if>
                                <!-- //section_sch_result -->
                                <!-- 공지사항&자료실 검색결과 -->
                                <c:if test="${notice eq 'notice' || params.category eq 'TOTAL' }">	
                                    <jsp:include page="result/resultNotice.jsp"/>
                                </c:if>
                                <!-- //section_sch_result -->
                                <!-- FAQ 검색결과 -->
                                <%--
                                <c:if test="${faq eq 'faq' || params.category eq 'TOTAL' }">	
                                    <jsp:include page="result/resultFaq.jsp"/>
                                </c:if>
                                --%>
                                <!-- 전자결재 접수함 검색결과 -->
                                <c:if test="${edmsRecv eq 'edmsRecv' || params.category eq 'TOTAL' }">	
                                    <jsp:include page="result/resultEdmsRecv.jsp"/>
                                </c:if>
                                <!-- 전자결재 생성함 검색결과 -->
                                <c:if test="${edmsPost eq 'edmsPost' || params.category eq 'TOTAL' }">	
                                    <jsp:include page="result/resultEdmsPost.jsp"/>
                                </c:if>
                                <!-- //section_sch_result -->
                            </div>
                        </div>
                        <!-- //page-body -->
                    </div>
                    <!-- CONTENTS -->
                </div>
                <!-- //row -->
            </div>
        </div>
        <!-- //PAGE -->
    </div>
    <!-- //WRAP -->
                    
<script>
$('#filePreviewPopup').on('show.bs.modal', function(e) {
    var data = $(e.relatedTarget).data('id');
    var down = $(e.relatedTarget).data('down-id');
    var downname = $(e.relatedTarget).data('down-name');
    $(e.currentTarget).find('output[name="file_text"]').val(data);
    $(e.currentTarget).find('input[name="downpath"]').val(down);
    $(e.currentTarget).find('input[name="downname"]').val(downname);
    // As pointed out in comments, 
    // it is unnecessary to have to manually call the modal.
    // $('#addBookDialog').modal('show');
});

function modalDown(){
	var down=$('#downpath').val();
	var downname=$('#downname').val();
	const a= document.createElement("a");
	a.href=down;
	a.download = downname;
	a.click();
	a.remove();
	//window.location=down;
	
}
</script>