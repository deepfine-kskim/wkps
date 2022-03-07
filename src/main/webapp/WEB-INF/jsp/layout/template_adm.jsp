<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<head lang="ko">
	<meta charset="utf-8">
	<link rel="shortcut icon" href="/images/egovframework/com/favicon.ico">
	<link rel="icon" href="/images/egovframework/com/favicon.ico">
	<title>관리자</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="format-detection" content="telephone=no">
	<meta name="author" content="이프 커뮤니케이션">
	<link rel="stylesheet" href="/css/egovframework/com/wkp/font-awesome.min.css">
	<link rel="stylesheet" href="/css/egovframework/com/wkp/xeicon.min.css">
	<link rel="stylesheet" href="/css/egovframework/com/wkp/themify-icons.min.css">
	<link rel="stylesheet" href="/css/egovframework/com/wkp/bootstrap.min.css">
	<link rel="stylesheet" href="/css/egovframework/mgt/wkp/base.css">
	<link rel="stylesheet" href="/css/egovframework/mgt/wkp/adm.css">
	<script src="/js/egovframework/mgt/wkp/jquery-1.11.3.min.js"></script>
	<script src="/js/egovframework/mgt/wkp/jquery-ui.min.js"></script>
	<script src="/js/egovframework/mgt/wkp/moment.js"></script>
</head>
<body>
	<div id="adm-wrap">
		<div id="adm-sidebar">
			<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri'] }"></c:set>
			<div class="side_header">
				<h1><a href="/adm/index.do"><img src="/images/egovframework/mgt/wkp/logo_adm.png" alt="관리자" /></a></h1>
			</div>
			<div class="side_body">
				<ul class="side_menu_list">
					<!--
					<li class="menu <c:if test="${url == '/adm/orgMileageList.do' || url == '/adm/userMileageList.do' || url == '/adm/orgMileageDetail.do' || url == '/adm/userMileageDetail.do' }">active</c:if>"><a href="/adm/orgMileageList.do">마일리지 관리</a>
						<ul class="sub_menu_list">
							<li class="sub_menu <c:if test="${url == '/adm/orgMileageList.do' || url == '/adm/orgMileageDetail.do'}">active</c:if>"><a href="/adm/orgMileageList.do">부서별 마일리지</a></li>
							<li class="sub_menu <c:if test="${url == '/adm/userMileageList.do' || url == '/adm/userMileageDetail.do'}">active</c:if>"><a href="/adm/userMileageList.do">개인별 마일리지</a></li>
						</ul>
					</li>
					 -->
					<li class="menu <c:if test="${url == '/adm/excellentUser.do' || url == '/adm/excellentOrg.do' || url == '/adm/manager.do' || url == '/adm/requestManagerList.do' }">active</c:if>"><a href="/adm/excellentUser.do">사용자 관리</a>
						<ul class="sub_menu_list">
							<li class="sub_menu <c:if test="${url == '/adm/excellentUser.do' }">active</c:if>"><a href="/adm/excellentUser.do">우수 사용자</a></li>
							<li class="sub_menu <c:if test="${url == '/adm/excellentOrg.do' }">active</c:if>"><a href="/adm/excellentOrg.do">우수 부서</a></li>
							<li class="sub_menu <c:if test="${url == '/adm/manager.do' }">active</c:if>"><a href="/adm/manager.do">관리자 관리</a></li>
							<!-- <li class="sub_menu <c:if test="${url == '/adm/requestManagerList.do' }">active</c:if>"><a href="/adm/requestManagerList.do">부서 지식관리자 관리</a></li> -->
						</ul>
					</li>
					<li class="menu <c:if test="${url == '/adm/approvalList.do' || url == '/adm/approvalDetail.do' || url == '/adm/recommendList.do' || url == '/adm/personalizeList.do' || url == '/adm/knowledgeMapList.do' || url == '/adm/errorList.do' || url == '/adm/errorDetail.do' }">active</c:if>"><a href="/adm/recommendList.do">지식 관리</a>
						<ul class="sub_menu_list">
							<!-- <li class="sub_menu <c:if test="${url == '/adm/approvalList.do' || url == '/adm/approvalDetail.do'}">active</c:if>"><a href="/adm/approvalList.do">지식 승인 관리</a></li> -->
			                <li class="sub_menu <c:if test="${url == '/adm/recommendList.do' }">active</c:if>"><a href="/adm/recommendList.do">추천 지식 관리</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/personalizeList.do' }">active</c:if>"><a href="/adm/personalizeList.do">맞춤 지식 관리</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/errorList.do' || url == '/adm/errorDetail.do' }">active</c:if>"><a href="/adm/errorList.do">오류 신고</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/knowledgeMapList.do' }">active</c:if>"><a href="/adm/knowledgeMapList.do">지식 맵 관리</a></li>
		                </ul>
		            </li>
		            <li class="menu <c:if test="${url == '/adm/surveySetup.do' }">active</c:if>"><a href="/adm/surveySetup.do">설문조사 관리</a></li>
		            <li class="menu <c:if test="${url == '/adm/noticeList.do' || url == '/adm/faqList.do' }">active</c:if>"><a href="/adm/noticeList.do">게시판 관리</a>
		                <ul class="sub_menu_list">
			                <li class="sub_menu <c:if test="${url == '/adm/noticeList.do' }">active</c:if>"><a href="/adm/noticeList.do">공지사항 관리</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/faqList.do' }">active</c:if>"><a href="/adm/faqList.do">FAQ</a></li>
		                </ul>
		            </li>
		            <li class="menu <c:if test="${url == '/adm/commRequest.do' || url == '/adm/commBnr.do' }">active</c:if>"><a href="/adm/commRequest.do">커뮤니티 관리</a>
		                <ul class="sub_menu_list">
		    	            <li class="sub_menu <c:if test="${url == '/adm/commRequest.do' }">active</c:if>"><a href="/adm/commRequest.do">승인 관리</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/commBnr.do' }">active</c:if>"><a href="/adm/commBnr.do">배너 관리</a></li>
		                </ul>
		            </li>
			        <li class="menu <c:if test="${url == '/adm/menuList.do' }">active</c:if>"><a href="/adm/menuList.do">메뉴 관리</a></li>
			        <li class="menu <c:if test="${url == '/adm/statConnect.do' || url == '/adm/statKnowledgeList.do' || url == '/adm/statKnowledge.do' || url == '/adm/statInterestsList.do' || url == '/adm/statSearch.do' || url == '/adm/statQna.do' }">active</c:if>"><a href="/adm/statConnect.do">통계</a>
			            <ul class="sub_menu_list">
			            	<li class="sub_menu <c:if test="${url == '/adm/statConnect.do' }">active</c:if>"><a href="/adm/statConnect.do">접속 통계</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/statKnowledgeList.do' }">active</c:if>"><a href="/adm/statKnowledgeList.do">지식 통계</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/statInterestsList.do' }">active</c:if>"><a href="/adm/statInterestsList.do">관심분야 통계</a></li>
			            	<li class="sub_menu <c:if test="${url == '/adm/statKnowledge.do' }">active</c:if>"><a href="/adm/statKnowledge.do">지식 등록 통계</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/statQna.do' }">active</c:if>"><a href="/adm/statQna.do">Q&A 통계</a></li>
			                <li class="sub_menu <c:if test="${url == '/adm/statSearch.do' }">active</c:if>"><a href="http://105.0.1.229:7581/files/admin/index.html" target="_blank">검색 통계</a></li>
			            </ul>
			        </li>
			        <li class="menu <c:if test="${url == '/adm/log.do' }">active</c:if>"><a href="/adm/log.do">로그관리</a></li>
				</ul>
			</div>
		</div>
		<!-- //adm-sidebar -->
    	<div id="adm-contents">
			<tiles:insertAttribute name="contents" />
    	</div>
    	<!-- //adm-contents -->
	</div>
	<!-- //adm-WRAP -->
<script src="/js/egovframework/mgt/wkp/bootstrap.min.js"></script>
<script src="/js/egovframework/mgt/wkp/bootstrap-datetimepicker.min.js"></script>
<script src="/js/egovframework/mgt/wkp/hummingbird-treeview-1.3.js"></script>
<script src="/js/egovframework/mgt/wkp/adm.js"></script>
</body>
</html>