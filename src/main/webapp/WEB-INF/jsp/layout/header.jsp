<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" 	uri="http://tiles.apache.org/tags-tiles" %>
<tiles:importAttribute name="menuList"/>
<tiles:importAttribute name="surveyCnt"/>
<tiles:importAttribute name="communityCnt"/>
<tiles:importAttribute name="errorCnt"/>
<tiles:importAttribute name="myErrorCnt"/>
<tiles:importAttribute name="mySurveyCnt"/>
<tiles:importAttribute name="myCommunityCnt"/>
<tiles:importAttribute name="myRequestCnt"/>
<c:set var="path" value="${fn:substring(requestScope['javax.servlet.forward.servlet_path'],0,5) }" />
<c:forEach var="menu" items="${menuList }" >
	<c:if test="${fn:contains(menu.menuUrl, path) }">
		<c:set var="menuDesc" value="${menu.menuDesc }" scope="application"/>
	</c:if>
</c:forEach>
<header id="header">
    <nav class="navbar navbar-default">
        <div class="top_line">
            <div class="container top">
                <div class="row type0">
                    <div class="col-xs-4">
                        <c:if test="${not empty loginVO }"><p class="log_msg"><strong class="text-black">${loginVO.displayName}</strong>님<span class="hidden-xs">의 방문을 환영합니다.</span> <a href="#myPopup" data-toggle="modal" data-target="#myPopup" class="alert_btn"><i class="fa fa-bell"><span class="sr-only">알림</span></i></a></p></c:if>
                    </div>
                    <div class="col-xs-8 text-right">
                        <div class="top_nav">
                            <ul>
                            	<c:if test="${not empty loginVO }">
                                <li><a href="/myp/mypage.do"><strong class="text-black">MY PAGE</strong></a><%--<c:if test="${loginVO.roleCd eq 'ROLE_ADMIN' || loginVO.roleCd eq 'ROLE_ORG' || loginVO.roleCd eq 'ROLE_KNOWLEDGE' || loginVO.roleCd eq 'ROLE_COMMUNITY' || loginVO.roleCd eq 'ROLE_SURVEY' }"><span class="hidden-xs">(<a href="/adm/surveySetup.do">설문조사 <span class="text-blue">${surveyCnt}</span></a>, <a href="/adm/commRequest.do">커뮤니티 <span class="text-blue">${communityCnt }</span></a>, <a href="/adm/errorList.do">오류 신고 <span class="text-blue">${errorCnt }</span></a>)</span></c:if>--%></li>
                                <li class="btn_area"><a href="/usr/logout.do" title="로그아웃"><i class="ti-power-off visible-xs-inline"></i><span class="hidden-xs">LOGOUT</span></a></li>
								<c:if test="${loginVO.roleCd eq 'ROLE_ADMIN' || loginVO.roleCd eq 'ROLE_ORG' || loginVO.roleCd eq 'ROLE_KNOWLEDGE' || loginVO.roleCd eq 'ROLE_COMMUNITY' || loginVO.roleCd eq 'ROLE_SURVEY' }"><li class="btn_area"><a href="/adm/index.do" title="관리자">관리자</a></li></c:if> 
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="navbar-header">
                <button type="button" id="mMenuBtn" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">메뉴</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <h1 class="logo_top">
                    <a href="/" class="navbar-brand"><img src="/images/egovframework/com/wkp/logo03.png" alt="로고" /></a><!-- [D] 220329 - img 경로 변경 -->
                </h1>
            </div>
            <div class="gnb_wrap hidden-xs hidden-sm">
                <ul id="gnbList" class="nav navbar-nav navbar-right">
                <c:forEach var="menu" items="${menuList }">
                <li class="gnb_menu">
                    <a href="${menu.menuUrl }" class="dev-menu" accesskey="${menu.sortOrdr }" data-desc="${menu.menuDesc }"><strong>${menu.menuNm }</strong></a>
                </li>
                </c:forEach>
                </ul>
            </div>
        </div>
    </nav>
    <div id="mSidebar" class="hidden-lg hidden-md">
        <div class="m_side_wrap">
            <div class="side_header">
                <h2><i class="fa fa-bars" aria-hidden="true"></i> 전체메뉴</h2>
                <button type="button" class="btn_close"><i class="ti-close" aria-hidden="true"></i><span class="sr-only">메뉴닫기</span></button>
            </div>
            <ul id="sideMenuList">
            <c:forEach var="menu" items="${menuList }">
            <li class="m_side_menu">
                <a href="${menu.menuUrl }">${menu.menuNm }</a>
            </li>
            </c:forEach>
            </ul>
        </div>
    </div>
</header>

<!-- 나의알림 팝업 -->
<div class="modal fade" id="myPopup" tabindex="-1" role="dialog" aria-labelledby="myPopupLabel">
    <div class="modal-dialog" role="document">
        <form class="modal-content form-horizontal">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myPopupLabel"><strong><i class="fa fa-bell" aria-hidden="true"></i> ${loginVO.displayName }님 알림</strong></h4>
            </div>
            <div class="modal-body">
            	<table class="table text-center table-bordered table-hover brd_list">
	                <caption class="sr-only">게시판 목록</caption>
	                <colgroup>
	                    <col>
	                    <col>
	                    <col>
						<col>
	                </colgroup>
	                <thead>
	                    <tr>
							<th scope="col">지식요청</th>
	                        <%--<th scope="col">오류신고</th>--%>
	                        <th scope="col">설문조사</th>
	                        <th scope="col">커뮤니티</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<tr>
							<td><a href="/req/requestList.do">${myRequestCnt }</a></td>
	                		<%--<td><a href="/myp/errorList.do">${myErrorCnt }</a></td>--%>
	                		<td><a href="/srv/list.do">${mySurveyCnt }</a></td>
	                		<td><a href="/cmu/community.do">${myCommunityCnt }</a></td>
	                	</tr>
	                </tbody>
	            </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
            </div>
        </form>
    </div>
</div>
<!-- //나의알림 팝업 -->