<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>
        <div class="container sub_cont">
            <div id="contents">
                <div class="page-header">
                    <h2>지식요청</h2>
        			<div>${menuDesc }</div>
                </div>
                <!-- //page-header -->

                <div class="page-body">
                    <div class="brd_view_area q_type">
                        <div class="view_header">
                            <strong class="subject">${requestDetail.title }</strong>
                            <div class="row type0 info_view">
                                <div class="col-sm-12">
                                    <span class="info_txt"><b>지식맵</b> : <span class="text-danger">
									<c:choose>
										<c:when test="${requestDetail.knowlgMapType eq 'REPORT' }">[행정자료]</c:when>
										<c:when test="${requestDetail.knowlgMapType eq 'REFERENCE' }">[업무참고자료]</c:when>
										<c:otherwise>[개인행정지식]</c:otherwise>
									</c:choose>
									</span> <span>[ ${requestDetail.upNm } > ${requestDetail.knowlgMapNm } ]</span></span>
                                </div>
                            </div>
                            <div class="row type0 info_view">
                                <div class="col-xs-12 col-sm-4">
                                    <span>작성일 : </span><span class="data">${requestDetail.registDtm }</span>
                                </div>
                                <div class="col-xs-12 col-sm-8 info_txts">
                                    <span class="info_txt">조회 : <span class="data">${requestDetail.inqCnt }</span></span>
                                    <span class="info_txt name">작성자 : <span class="data">${requestDetail.displayName }</span></span>
                                </div>
                            </div>
                        </div>
                        <div class="view_body">
	                        <div class="panel panel-sm panel-default">
	                            <div class="panel-heading">
	                                <h3 class="panel-title">내용</h3>
	                            </div>
	                            <div class="panel-body">
	                            	${fn:replace(fn:replace(fn:replace(requestDetail.cont, "&lt;", "<"), "&gt;", ">"),"&quot;","\'") }
	                            </div>
	                            <c:if test="${not empty fileList }">
		                        <div class="info_grp files">
		                        	<c:forEach var="file" items="${fileList }">
		                        	<p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger" download>${file.orignlFileNm }</a> (${file.fileMg }K) <a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${file.fileStreCours }${file.streFileNm }" data-fid="REQUEST_${requestDetail.requstNo }">미리보기</a></p>
		                        	</c:forEach>
		                        </div>
		                        </c:if>
	                        </div>
                    	</div>
                   	</div>
                    <!-- //brd_view_area -->
		            <div class="text-right mb_15 dev-answer-write">
		                <a href="#answerBox" class="btn btn-primary collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="answerBox">답변하기</a>
		            </div>
		            <div class="collapse" id="answerBox">
		                <div class="form-horizontal">
		                	<form:form id="answerForm" action="/req/insertRequestAnswer.do" modelAttribute="reqVO">
		                	<form:hidden path="requstNo"/>
		                    <div class="well frm_well">
		                    	<div class="form-group">
		                    		<label for="inpMemo" class="sr-only control-label">답변</label>
		                    		<div class="col-sm-12">
		                    			<textarea class="form-control" rows="4" id="inpMemo" name="cont" required="required" placeholder="답변을 입력해 주세요."></textarea>
		                    		</div>
		                    	</div>
		                        <hr/>
		                        <div class="text-center">
		                            <button type="submit" class="btn btn-blue dev-answer">확인</button>
		                            <button type="reset" class="btn btn-black" data-toggle="collapse" data-target="#answerBox" aria-expanded="false" aria-controls="answerBox">취소</button>
		                        </div>
		                    </div>
							</form:form>
		                    <!-- well -->
		                </div>
		            </div>
		            <!-- //answerBox -->
					<c:set var="selection" value="N"/>
					<c:if test="${answerList != null}">
						<c:forEach var="answer" items="${answerList}">
							<div class="brd_view_area a_type <c:if test="${answer.slctnYn == 'Y'}">selection <c:set var="selection" value="Y"/></c:if>">
								<div class="view_header">
									<strong class="subject"><span class="qna_ico">A</span>
										<c:if test="${answer.slctnYn == 'Y'}">
										<c:set var="isSlctnYn" value="${answer.slctnYn}"/>
										<span class="label label-danger"><i class="ti-check"></i> 채택</span></c:if>
									</strong>
									<div class="row type0 info_view">
										<div class="col-xs-12 col-sm-4">
											<span>작성일 : </span><span class="data"><fmt:formatDate value="${answer.registDtm}" pattern="yyyy-MM-dd"/></span>
										</div>
										<div class="col-xs-12 col-sm-8 info_txts">
                                    		<span class="info_txt name">작성자 : <span class="data">${answer.displayName}</span></span>
										</div>
									</div>
								</div>
								<div class="view_body">
									<div class="panel panel-sm panel-default">
										<div class="panel-heading">
											<h3 class="panel-title">답변</h3>
										</div>
										<div class="panel-body">
											${fn:replace(answer.cont, replaceChar, "<br/>")}
										</div>
									</div>
								</div>
								<div class="view_opt_area">
									<div class="row type5">
										<div class="col-xs-6">
											<c:if test="${selection == 'N' && loginVO.sid eq requestDetail.registerId}">
												<button type="button" class="btn btn-danger btn-xs dev-selection" data-requst-answer-no="${answer.requstAnswerNo}" data-requst-no="${answer.requstNo}"><i class="ti-check-box"></i>채택</button>
											</c:if>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>
	                <!-- 이전/다음 -->
	                <ul class="list-group post_nav">
	                    <li class="list-group-item">
						<c:choose>
							<c:when test="${requestPre != null }">
							<a href="javascript:;" class="dev-detail" data-no="${requestPre.requstNo }"><strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i>이전글</strong> : ${requestPre.title}</a>
							</c:when>
							<c:otherwise>
							<a href="javascript:;"><strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i>이전글</strong> : 이전 글이 없습니다.</a>
							</c:otherwise>
						</c:choose>
						</li>
	                    <li class="list-group-item">
	                    <c:choose>
	                    	<c:when test="${requestNext != null}">
	                    		<a href="javascript:;" class="dev-detail" data-no="${requestNext.requstNo }"><strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : ${requestNext.title}</a>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<a href="javascript:;"><strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : 다음 글이 없습니다.</a>
	                    	</c:otherwise>
						</c:choose>
	                    </li>
	                </ul>
	                <!-- //이전/다음 -->
		            <div class="row brd_foot_btns">
		                <c:if test="${requestDetail.registerId == loginVO.sid}">
		                	<div class="col-sm-6">
		                		<a href="javascript:;" class="btn btn-black dev-update" data-no="${requestDetail.requstNo }">수정</a>
		                		<a href="javascript:;" class="btn btn-danger dev-delete" data-no="${requestDetail.requstNo }">삭제</a>
		                    </div>
		                </c:if>
		                <div class="col-sm-6 text-right">
		                    <a href="javascript:;" class="btn btn-black dev-page">목록</a>
		                </div>
		            </div>
                </div>
                <!-- //page-body -->

            </div>
            <!-- //CONTENTS -->
        </div>
<form:form name="requestFrm" modelAttribute="reqVO">
	<input type="hidden" name="page" value="${requestDetail.page }">
	<input type="hidden" name="requstNo" value="0">
	<input type="hidden" name="searchText" value="${requestDetail.searchText }"/>
</form:form>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script>
	CKEDITOR.replace('inpMemo');
    $(function () {

        $('.dev-page').on('click', function (e) {
        	e.preventDefault();
            var page = $(this).data('page');
            var form = $("form[name=requestFrm]");
            form.attr("action", "/req/requestList.do");
            form.submit();
        });

        $('.dev-detail').on('click', function (e) {
        	e.preventDefault();
            var requstNo = $(this).data('no');
            var form = $("form[name=requestFrm]");
            form.find("input[name=requstNo]").val(Number(requstNo));
            form.submit();
        });

        $('.dev-update').on('click', function (e) {
        	e.preventDefault();
            var requstNo = $(this).data('no');
            var form = $("form[name=requestFrm]");
            form.find("input[name=requstNo]").val(Number(requstNo));
            form.attr("action", "/req/updateRequestView.do");
            form.submit();
        });

        $('.dev-delete').on('click', function (e) {
            if (confirm("삭제 하시겠습니까?")) {
	        	e.preventDefault();
	            var requstNo = $(this).data('no');
	            var form = $("form[name=requestFrm]");
	            form.find("input[name=requstNo]").val(Number(requstNo));
	            form.attr("action", "/req/deleteRequest.do");
	            form.submit();
            }
        });

		$(".dev-selection").on("click", function (e) {
			e.preventDefault();

			const data = {
				"requstAnswerNo": $(this).data("requst-answer-no")
			}

			if (confirm("해당 답변을 채택 하시겠습니까? 이후 수정은 불가능합니다.")) {
				$.ajax({
					url: "/req/updateAnswerSelection.do",
					data: JSON.stringify(data),
					contentType: 'application/json',
					dataType: 'json',
					type: "POST",
					success: function (data) {
						if (data) {
							location.reload();
						} else {
							alert("채택에 실패하였습니다.");
							location.reload();
						}
					},
					error: function (error) {
						alert("답변 채택 중 에러가 발생하였습니다.");
					}
				});
			}
		});
    });

</script>