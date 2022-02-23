<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">공지사항 관리</h2>
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
                    <li>게시판 관리</li>
                    <li class="active">공지사항 관리</li>
                </ol>
                <div id="contents">
                    <div class="well well-white well-lg">
	                    <div class="brd_view_area">
	                        <div class="view_header">
	                            <strong class="subject">${noticeDetail.title }</strong>
	                            <div class="row type0 info_view">
	                                <div class="col-xs-12 col-sm-4">
	                                    <span>작성일 : </span><span class="data">${noticeDetail.registDtm }</span>
	                                </div>
	                                <div class="col-xs-12 col-sm-8 info_txts">
	                                    <span class="info_txt">조회 : <span class="data">${noticeDetail.inqCnt }</span></span>
	                                    <span class="info_txt name">작성자 : <span class="data">${noticeDetail.registerId }</span></span>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="view_body">
	                            ${fn:replace(fn:replace(fn:replace(noticeDetail.cont, "&lt;", "<"), "&gt;", ">"),"&quot;","\'") }
	                        </div>
	                        <c:if test="${not empty fileList }">
	                        <div class="info_grp files">
	                        	<c:forEach var="file" items="${fileList }">
		                        <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger">${file.orignlFileNm }</a> (${file.fileMg }K)</p>
	                        	</c:forEach>                            
	                        </div>
	                        </c:if>
	                    </div>
	                    <!-- //brd_view_area -->
                    </div>
                    <div class="row brd_foot_btns">
                        <div class="col-sm-6">
                            <a href="/adm/updateNoticeView.do?noticeNo=${noticeDetail.noticeNo }" class="btn btn-black">수정</a>
                            <a href="/adm/deleteNotice.do?noticeNo=${noticeDetail.noticeNo }" class="btn btn-danger">삭제</a>
                        </div>
                        <div class="col-sm-6 text-right">
                            <a href="javascript:;" class="btn btn-black btn-lg dev-page">목록</a>
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
<form:form name="noticeFrm" action="/adm/noticeList.do" modelAttribute="noticeVO">
	<input type="hidden" name="page" value="${noticeDetail.page }">
	<input type="hidden" name="searchText" value="${noticeDetail.searchText }"/>
</form:form>
<script>
    $(function () {

        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
            var form = $("form[name=noticeFrm]");
            form.submit();
        });
        
    });
</script>