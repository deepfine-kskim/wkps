<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">지식 승인 관리</h2>
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
                    <li class="active">지식 승인 관리</li>
                </ol>
                <div id="contents">
                    <table class="table table-bordered">
                        <caption class="sr-only hidden">처리상태</caption>
                        <colgroup>
                            <col style="width:15%;" />
                            <col style="width:15%;" />
                            <col style="width:15%;" />
                            <col />
                            <col style="width:15%;" />
                            <col style="width:15%;" />
                        </colgroup>
                        <tr>
                            <th>상태</th>
                            <td><a href="#alertPopup" class="text-danger lnk_txt" data-toggle="modal" data-target="#alertPopup">[승인대기]</a></td>
                            <th>처리자</th>
                            <td>${knowledgeDetail.displayName }(${knowledgeDetail.ou })</td>
                            <th>처리일</th>
                            <td>${knowledgeDetail.registDtm }</td>
                        </tr>
                    </table>
                    <div class="well well-white well-lg">
                                                <div class="brd_view_area wiki_view">
                            <div class="view_header">
                                <div class="subject">
                                    <div class="cate_info">
                                        <span class="text-danger">
                                        <c:choose>
											<c:when test="${knowlgMapType eq 'REPORT' }">[행정자료]</c:when>
											<c:when test="${knowlgMapType eq 'REFERENCE' }">[업무참고자료]</c:when>
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
                                    <div class="col-xs-12">
                                        <span>작성일 : </span><span class="data">${knowledgeDetail.registDtm }</span>
                                        <span class="info_txt name">작성자 : <span class="data">${knowledgeDetail.displayName }(${knowledgeDetail.ou })</span></span>
                                    </div>
                                </div>
                            </div>
                            <div class="info_grp files">
		                    	<c:forEach var="file" items="${fileList }">
		                        <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${file.atchFileNo }&fileSn=${file.fileSn }" class="text-danger">${file.orignlFileNm }</a> (${file.fileMg }K) <a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${file.fileStreCours }${file.streFileNm }" data-fid="KNO_${knowledgeDetail.knowlgNo }">미리보기</a></p>
		                        </c:forEach>
                            </div>
                            <div class="view_body">
                                <dl class="well_dl">
                                    <dt>요약</dt>
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
									</div>
                                    <div class="wiki_body">
                                    	<div class="wiki_paras">
                                    		${fn:replace(fn:replace(fn:replace(contents.cont, "&lt;", "<"), "&gt;", ">"),"&quot;","\'")}
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
											<c:forEach var="relate" items="${relateKnowledgeList }">
											<c:url value="/kno/knowledgeDetail.do" var="url">
												<c:param name="title" value="${relate }" />
											</c:url>
                                            <li><a href="${url }" target="_blank" title="새창열림">${relate }</a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                            </div>
                        </div>
                        <!-- //brd_view_area -->
                    </div>
                    <div class="row mb_15">
                        <div class="col-xs-6">
                            <button type="button" id="aprvBtn" class="btn btn-blue min-lg">승인</button>
                            <a href="#rejectionPopup" class="btn btn-danger min-lg" data-toggle="modal" data-target="#rejectionPopup">반려</a>
                        </div>
                        <div class="col-xs-6 text-right">
                            <a href="/adm/approvalList.do" class="btn btn-black btn-lg min-lg">목록</a>
                        </div>
                    </div>
                </div>
                <!-- //CONTENTS -->


				<!-- 팝업 영역 시작 -->
                <!-- 알림팝업 -->
                <div class="modal fade" id="alertPopup" tabindex="-1" role="dialog" aria-labelledby="alertPopupLabel">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="alertPopupLabel">알림</h4>
                            </div>
                            <div class="modal-body">
                                <p class="text-center">이런 이유로 <br /> <span class="text-danger">반려</span> 되었습니다.</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //알림팝업 -->

                <!-- 반려사유 작성 팝업 -->
                <div id="rejectionPopup" class="modal fade" role="dialog" aria-labelledby="rejectionPopupLabel">
                    <div class="modal-dialog" role="document">
                        <form:form class="modal-content form-horizontal" name="aprvFrm" modelAttribute="knowledgeVO">
                        	<input type="hidden" name="knowlgNo" value="${knowledgeDetail.knowlgNo }">
                        	<input type="hidden" name="title" value="${knowledgeDetail.title }">
                        	<input type="hidden" name="aprvYn" value="N">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <div class="h4 modal-title" id="rejectionPopupLabel">반려사유</div>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="col-sm-12 control-label sr-only">반려사유</label>
                                    <div class="col-sm-12">
                                        <textarea class="form-control" name="aprvCont" rows="4" placeholder="반려 사유를 작성해 주세요." required></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer text-center">
                                <button type="button" id="rjtBtn" class="btn btn-blue min-md">확인</button>
                                <button type="button" class="btn btn-default min-md" data-dismiss="modal">취소</button>
                            </div>
                        </form:form>
                    </div>
                </div>
                <!-- //반려사유 작성 팝업 --><!-- //팝업 영역 종료 -->


                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->     
<script>
    $(function () {
    
		$('#aprvBtn').on('click', function () {
			if(confirm("승인 하시겠습니까?") == true) {
				var form = $("form[name=aprvFrm]");
	            form.find("input[name=aprvYn]").val('Y');
	            form.attr("action", "/adm/updateApproval.do");
	            form.submit();
			} else {
				return false;
			}
            
		});
		
		$('#rjtBtn').on('click', function () {
			if(confirm("반려 하시겠습니까??") == true) {
	            var form = $("form[name=aprvFrm]");
	            form.find("input[name=aprvYn]").val('N');
	            form.attr("action", "/adm/updateApproval.do");
	            form.submit();
			} else {
				return false;
			}
		});
	
	});
</script>