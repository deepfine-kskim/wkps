<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">오류 신고</h2>
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
                    <li>지식 관리</li>
                    <li class="active">오류 신고</li>
                </ol>
                <div id="contents">
                    <div class="well well-white well-lg">
                        <div class="brd_view_area mb_0">
                            <div class="view_header">
                                <strong class="subject">${errorStatementDetail.statmntTitle }</strong>
                                <div class="row type0 info_view">
                                    <div class="col-xs-4">
                                        <span class="info_txt">분류 : <span class="text-danger">오류신고</span></span>
                                    </div>
                                    <div class="col-xs-8 info_txts">
                                        <span class="info_txt name">작성자 : <span class="data">${errorStatementDetail.displayName }(${errorStatementDetail.ou })</span></span>
                                        <span class="info_txt">등록일 : </span><span class="data">${errorStatementDetail.registDtm }</span>
                                    </div>
                                </div>
                                <div class="row type0 info_view">
                                    <div class="col-sm-12">
                                        <span class="info_txt"><b>오류 지식</b> : <span class="text-danger">[행정자료]</span> <span>[ 공정 > 기본소득 ]  <a href="#" class="text-primary underline">${errorStatementDetail.title }</a></span></span>
                                    </div>
                                </div>
                            </div>
                            <div class="view_body">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">내용</h3>
                                    </div>
                                    <div class="panel-body">
                                        ${errorStatementDetail.cont }
                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">답변</h3>
                                    </div>
                                    <form:form name="answerFrm" action="/adm/updateErrorStatementAnswer.do" modelAttribute="errorStatementVO">
                                    <form:hidden path="statmntNo"/>
                                    <div class="panel-body form-horizontal">
                                        <div class="form-group">
                                            <label for="inpMemo" class="sr-only control-label">답변</label>
                                            <div class="col-sm-12">
                                                <textarea class="form-control" rows="4" id="inpMemo" name="answerCont" required="required" placeholder="답변을 입력해주세요."></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="panel-footer text-center">
                                        <button type="submit" class="btn btn-blue min-md">확인</button>
                                        <button type="reset" class="btn btn-black min-md">취소</button>
                                    </div>
                                    </form:form>
                                </div>

								<c:if test="${errorStatementDetail.answerYn eq 'Y'}">
                                <div class="panel panel-default">
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
                    </div>
                    <div class="text-right">
                        <a href="/adm/errorList.do" class="btn btn-black btn-lg min-lg">목록</a>
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
<script type="text/javascript" src="<c:url value='/js/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script type="text/javascript">
    CKEDITOR.replace('inpMemo');
</script>