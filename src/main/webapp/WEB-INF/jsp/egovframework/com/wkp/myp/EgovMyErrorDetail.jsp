<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
        <div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>지식 신고/등록</h2>
                </div>
                <!-- //page-header -->

                <div class="page-body">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="/myp/errorList.do">오류 신고</a></li>
                        <li role="presentation"><a href="/myp/approvalList.do">지식 등록</a></li>
                    </ul>
                    <div class="brd_view_area">
                        <div class="view_header">
                            <strong class="subject">${errorStatementDetail.statmntTitle }</strong>
                            <div class="row type0 info_view">
                                <div class="col-xs-12 col-sm-4">
                                    <span class="info_txt">분류 : <span class="text-danger">오류신고</span></span>
                                </div>
                                <div class="col-xs-12 col-sm-8 info_txts">
                                    <span class="info_txt">등록일 : </span><span class="data">${errorStatementDetail.registDtm }</span>
                                </div>
                            </div>
                            <div class="row type0 info_view">
                                <div class="col-sm-12">
                                    <span class="info_txt"><b>오류 지식</b> : <span class="text-danger">[행정자료]</span> <span>[ 대주제 > 소주제 ]  <a href="#" class="text-primary underline">${errorStatementDetail.title }</a></span></span>
                                </div>
                            </div>
                        </div>
                        <div class="view_body">
                            <div class="panel panel-sm panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">내용</h3>
                                </div>
                                <div class="panel-body">
									${errorStatementDetail.cont }
                                </div>
                            </div>
                            <c:if test="${errorStatementDetail.answerYn eq 'Y'}">
                            <div class="panel panel-sm panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title">답변</h3>
                                </div>
                                <div class="panel-body">
                                    ${errorStatementDetail.answerCont }
                                </div>
                                <div class="panel-footer">
                                    <div class="info_box">
                                        <span class="info_txt name">처리자 : <span class="data">${errorStatementDetail.answerDisplayName }(${errorStatementDetail.answerOu })</span></span>
                                        <span class="info_txt">처리일 : </span><span class="data">${errorStatementDetail.answerDtm }</span>
                                    </div>
                                </div>
                            </div>
                            </c:if>
                        </div>
                    </div>
                    <!-- //brd_view_area -->

                    <!-- 이전/다음 -->
                    <ul class="list-group post_nav">
	                    <li class="list-group-item">
						<c:choose>
							<c:when test="${errorStatementPre != null }">
							<a href="javascript:;" class="dev-detail" data-no="${errorStatementPre.statmntNo }"><strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i>이전글</strong> : ${errorStatementPre.statmntTitle}</a>
							</c:when>
							<c:otherwise>
							<a href="javascript:;"><strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i>이전글</strong> : 이전 글이 없습니다.</a>
							</c:otherwise>
						</c:choose>
						</li>
	                    <li class="list-group-item">
	                    <c:choose>
	                    	<c:when test="${errorStatementNext != null}">
	                    		<a href="javascript:;" class="dev-detail" data-no="${errorStatementNext.statmntNo}"><strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : ${errorStatementNext.statmntTitle}</a>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<a href="javascript:;"><strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : 다음 글이 없습니다.</a>
	                    	</c:otherwise>
						</c:choose>
	                    </li>
                    </ul>
                    <!-- //이전/다음 -->
                    <div class="row brd_foot_btns">
                        <div class="col-sm-6">
                            <a href="/myp/mypage.do" class="btn btn-black outline">마이페이지</a>
                        </div>
                        <div class="col-sm-6 text-right">
                            <a href="javascript:;" class="btn btn-black dev-page">목록</a>
                        </div>
                    </div>
                </div>
                <!-- //page-body -->
                
            </div>
            <!-- //CONTENTS -->
        </div>
<form:form name="errorFrm" modelAttribute="noticeVO">
	<input type="hidden" name="page" value="${errorStatementDetail.page }">
	<input type="hidden" name="statmntNo" value="0"> 
	<input type="hidden" name="searchText" value="${errorStatementDetail.searchText }"/>
</form:form>
<script>
    $(function () {

        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
            var page = $(this).data('page');
            var form = $("form[name=errorFrm]");
            form.attr("action", "/myp/errorList.do");
            form.submit();
        });
        
        $('.dev-detail').on('click', function (e) {
        	e.preventDefault();
            var statmntNo = $(this).data('no');
            var form = $("form[name=errorFrm]");
            form.find("input[name=statmntNo]").val(statmntNo);
            form.submit();
        });
        
    });
</script>
<c:if test="${not empty myBG }">
<style>
body{
	background-image:url("${myBG[0].fileStreCours }${myBG[0].streFileNm }");
	background-repeat: no-repeat;
	background-size: cover;
}
</style>
</c:if>