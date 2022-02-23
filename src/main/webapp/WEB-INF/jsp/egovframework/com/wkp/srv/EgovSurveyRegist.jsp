<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld" %>

<div class="container sub_cont">
    <div id="contents">
        <div class="page-header">
            <h2>설문조사 </h2>
       		<div>${menuDesc }</div>
        </div>
        <!-- //page-header -->
        <!-- //page-header -->
        <div class="page-body">
            <!-- 일정쓰기 -->
            <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
            <form id="writeFrm" class="form-horizontal" method="post">
                <input type="hidden" name="aprvState" id="aprvState" value="${detail.aprvState.name()}"/>
                <input type="hidden" name="bngnDtm" id="bngnDtm" value="${detail.bngnDtm}"/>
                <input type="hidden" name="endDtm" id="endDtm" value="${detail.endDtm}"/>
                <input type="hidden" name="surveyNo" id="surveyNo" value="${detail.surveyNo}"/>

                <fieldset>
                    <legend class="sr-only">게시판 글작성</legend>
                    <div class="brd_write_area">
                        <div class="form-group">
                            <label for="svRls1" class="col-sm-2 control-label"><span class="req">*</span>설문 공개여부</label>
                            <div class="col-sm-3">
                                <label for="svRls1" class="radio-inline">
                                    <input type="radio" id="svRls1" name="rlsYn"
                                           value="Y" ${detail.rlsYn == 'Y' ? 'checked':'' } /> 공개
                                </label>
                                <label for="svRls2" class="radio-inline">
                                    <input type="radio" id="svRls2" name="rlsYn"
                                           value="N" ${detail.rlsYn == 'N' ? 'checked':'' }/> 비공개
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <strong class="col-sm-2 control-label"><span class="req">*</span> 시작일시</strong>
                            <div class="col-sm-5 col-lg-5">
                                <div class="row type1">
                                	
                                    <div class="col-xs-6">
                                        <lable for="inpStartDate" class="sr-only">시작날짜</lable>
                                        <input type="text" class="form-control inp_date datetime" id="inpStartDate"
                                               name="inpStartDate" placeholder="시작날짜" required="required"
                                               value="<fmt:formatDate value="${detail.bngnDtm}" pattern="yyyy-MM-dd"/>"/>
                                    </div>
                                    <div class="col-xs-6">
                                        <lable for="inpStartTime" class="sr-only">시작시간</lable>
                                        <input type="text" class="form-control inp_time datetime" id="inpStartTime"
                                               name="inpStartTime" placeholder="시작시간" required="required"
                                               value="<fmt:formatDate value="${detail.bngnDtm}" pattern="HH:mm"/>"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <strong class="col-sm-2 control-label"><span class="req">*</span> 종료일시</strong>
                            <div class="col-sm-5 col-lg-5">
                                <div class="row type1">
                                    <div class="col-xs-6">
                                        <lable for="inpEndDate" class="sr-only">종료날짜</lable>
                                        <input type="text" class="form-control inp_date datetime" id="inpEndDate"
                                               name="inpEndDate" placeholder="종료날짜" required="required"
                                               value="<fmt:formatDate value="${detail.endDtm}" pattern="yyyy-MM-dd"/>"/>
                                    </div>
                                    <div class="col-xs-6">
                                        <lable for="inpEndTime" class="sr-only">종료시간</lable>
                                        <input type="text" class="form-control inp_time datetime" id="inpEndTime"
                                               name="inpEndTime" placeholder="종료시간" required="required"
                                               value="<fmt:formatDate value="${detail.endDtm}" pattern="HH:mm"/>"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group inp_set_area">
                            <label for="svTarget1" class="col-sm-2 control-label">
                                <span class="req">*</span> 설문 대상자</label>
                            <div class="col-sm-10 tree_chk_area">
                                <label for="svTarget1" class="radio-inline">
                                    <input type="radio" id="svTarget1" name="targetYn"
                                           value="N" ${detail.targetYn == 'N' ? 'checked':'' } /> 전체
                                </label>
                                <label for="svTarget2" class="radio-inline">
                                    <input type="radio" id="svTarget2" name="targetYn" value="Y"
                                           class="inp_tog" ${!detail.targetYn == 'Y'? 'checked':'' }/> 지정
                                </label>
                                <a href="#selectGrpPopup" class="btn btn-xs btn-primary inp_tog_cont"
                                   data-toggle="modal" data-target="#selectGrpPopup">부서/개인/그룹 선택</a>
                                <div id="rlsList" class="tag_grp_area"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="svTargetRls1" class="col-sm-2 control-label"><span class="req">*</span>설문 대상자 외 공개여부</label>
                            <div class="col-sm-3">
                                <label for="svTargetRls1" class="radio-inline">
                                    <input type="radio" id="svTargetRls1" name="targetRlsYn"
                                           value="Y" ${detail.targetRlsYn == 'Y' ? 'checked':'' } /> 공개
                                </label>
                                <label for="svTargetRls2" class="radio-inline">
                                    <input type="radio" id="svTargetRls2" name="targetRlsYn"
                                           value="N" ${detail.targetRlsYn == 'N' ? 'checked':'' }/> 비공개
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="svPublic1" class="col-sm-2 control-label"><span class="req">*</span> 결과
                                공개여부</label>
                            <div class="col-sm-3">
                                <label for="svPublic1" class="radio-inline">
                                    <input type="radio" id="svPublic1" name="resltRlsYn"
                                           value="Y" ${detail.resltRlsYn == 'Y' ? 'checked':'' } /> 공개
                                </label>
                                <label for="svPublic2" class="radio-inline">
                                    <input type="radio" id="svPublic2" name="resltRlsYn"
                                           value="N" ${detail.resltRlsYn == 'N' ? 'checked':'' }/> 비공개
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="postSubject" class="col-sm-2 control-label"><span class="req">*</span>
                                제목</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="postSubject" name="title"
                                       placeholder="제목를 입력하세요" required value="${detail.title}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inpText" class="col-sm-2 control-label"><span class="req">*</span> 설문내용</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" rows="8" id="inpText" name="surveyDesc"
                                          placeholder="내용을 입력하세요" required multiple>${detail.surveyDesc}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-10 col-sm-push-2 item_panel_area">
                                <c:forEach var="question" items="${detail.questionList}">
                                    <div id="item${question.orderNo}-panel" class="panel panel-default item_panel">
                                       	<div class="panel-heading">
                                            <%-- <strong class="panel-title"><span class="order-id">${question.orderNo}</span>. 설문항목</strong> <button type="button" class="btn btn-danger btn-sm del_panel_btn">항목삭제</button> --%>
                                            <strong class="panel-title"><span class="order-id" style="float: left;">${question.orderNo}</span>. 설문항목</strong><button type="button" class="btn btn-danger btn-sm del_panel_btn" style="float: right; margin-left:5px;">항목삭제</button><button type="button" class="btn btn-primary btn-sm add_panel_btn" style="float: right; padding: -10px;">설문항목 중간 추가</button>
                                        </div>
                                        <div class="panel-body">
                                            <div class="form-horizontal">
                                                <div class="form-group">
                                                    <label for="item${question.orderNo}-type" class="col-sm-2 control-label sel_type_lable">항목형식</label>
                                                    <div class="col-sm-4">
                                                        <select id="item${question.orderNo}-type" name="item${question.orderNo}-type" class="form-control sel_tab">
                                                            <option value="0">선택해주세요.</option>
                                                            <option value="1" <c:if test="${question.qusTypeCd == 'DESCRIPTION'}">selected</c:if>>서술형</option>
                                                            <option value="2" <c:if test="${question.qusTypeCd == 'SINGLE'}">selected</c:if>>단일선택형</option>
                                                            <option value="3" <c:if test="${question.qusTypeCd == 'MULTI'}">selected</c:if>>복수선택형</option>
                                                            <option value="4" <c:if test="${question.qusTypeCd == 'SKIP'}">selected</c:if>>건너뛰기 형</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <label for="item${question.orderNo}-req" class="checkbox-inline">
                                                            <input type="checkbox" id="item${question.orderNo}-req" name="item${question.orderNo}-req" <c:if test="${question.esntlYn =='Y'}">checked="checked"</c:if> class="dev-must-check"/> 필수
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="tab-content item_tab1" <c:if test="${question.qusTypeCd == 'DESCRIPTION'}">style="display: block;"</c:if>>
                                                    <div class="form-group">
                                                        <label for="item${question.orderNo}-tit1" class="col-sm-2 control-label">질문</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" id="item${question.orderNo}-tit1" name="item${question.orderNo}-tit1" class="form-control dev-example-input" placeholder="질문을 입력하세요" value="${question.cont}" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="tab-content item_tab2" <c:if test="${question.qusTypeCd == 'SINGLE'}">style="display: block;"</c:if>>
                                                    <div class="form-group">
                                                        <label for="item${question.orderNo}-tit2" class="col-sm-2 control-label">질문</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" id="item${question.orderNo}-tit2" name="item${question.orderNo}-tit2" class="form-control" placeholder="단일선택 질문을 입력하세요" value="${question.cont}" />
                                                        </div>
                                                    </div>
                                                    <div class="inp_list ra_grp">
                                                        <c:forEach var="example" items="${question.surveyExampleList}" varStatus="status">
                                                            <c:if test="${example.orderNo < 9999}">
                                                            <div class="form-group dev-group">
                                                                <label for="item${question.orderNo}-ra${example.orderNo}" class="col-sm-2 control-label"><span class="num">${example.orderNo}</span>)</label>
                                                                <div class="col-sm-8 col-md-7 col-lg-8">
                                                                    <input type="text" id="item${question.orderNo}-ra${example.orderNo}" name="item${question.orderNo}-ra${example.orderNo}" class="form-control dev-example-input" placeholder="단일선택 내용을 입력하세요" value="${example.cont}" />

                                                                    <c:if test="${example.atchFileNo != null && example.atchFileNo > 0}">
                                                                        <div class="form-group inner_frm_grp file_set">
                                                                            <div class="col-xs-9 col-sm-10 dev-file-wrap">
                                                                                <a href="${example.fileStreCours}${example.streFileNm}" target="_blank" class="text-danger dev-file-link" data-filetype="${example.fileType.name()}">${example.orignlFileNm}</a> (${cutil:out(example.fileSize)})
                                                                                <input type="hidden" name="file" value="${example.atchFileNo}" class="dev-upload-file-num">
                                                                            </div>
                                                                            <div class="col-xs-3 col-sm-2">
                                                                                <button type="button" class="btn btn-xs btn-danger file_del ico_btn outline">삭제</button>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                </div>
                                                                <div class="col-sm-2 col-md-3 col-lg-2 btn_area">
                                                                    <button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button>
                                                                    <c:if test="${status.index > 0}">
                                                                    <button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">항목삭제</span></button>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            </c:if>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="etc_area" <c:if test="${ question.surveyExampleList[fn:length(question.surveyExampleList)-1].orderNo >= 9999 }">style="display: block;"</c:if>>
                                                        <div class="form-group dev-group">
                                                            <label for="item${question.orderNo}-ra-etc" class="col-sm-2 control-label"><span class="num">기타</span>)</label>
                                                            <div class="col-sm-8 col-md-7 col-lg-8">
                                                                <input type="text" id="item${question.orderNo}-ra-etc" name="item${question.orderNo}-ra-etc" class="form-control dev-example-input" placeholder="단일선택 기타항목 사용" readonly="readonly" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="text-right">
                                                        <c:choose>
                                                            <c:when test="${ question.surveyExampleList[fn:length(question.surveyExampleList)-1].orderNo >= 9999 }">
                                                                <button type="button" class="btn btn-black add_etc_btn"><i class="fa fa-close" aria-hidden="true"></i> 기타 항목 삭제</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="button" class="btn btn-black add_etc_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 기타 항목 추가</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 단일선택 항목 추가</button>
                                                    </div>
                                                </div>
                                                <div class="tab-content item_tab3" <c:if test="${question.qusTypeCd == 'MULTI'}">style="display: block;"</c:if>>
                                                    <div class="form-group">
                                                        <label for="item${question.orderNo}-tit3" class="col-sm-2 control-label">질문</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" id="item${question.orderNo}-tit3" name="item${question.orderNo}-tit3" class="form-control" placeholder="복수선택 질문을 입력하세요" value="${question.cont}" />
                                                        </div>
                                                    </div>
                                                    <div class="inp_list chk_grp">
                                                        <c:forEach var="example" items="${question.surveyExampleList}" varStatus="status">
                                                        <div class="form-group dev-group">
                                                            <label for="item${question.orderNo}-chk${example.orderNo}" class="col-sm-2 control-label"><span class="num">${example.orderNo}</span>)</label>
                                                            <div class="col-sm-8 col-md-7 col-lg-8">
                                                                <input type="text" id="item${question.orderNo}-chk${example.orderNo}" name="item${question.orderNo}-chk${example.orderNo}" class="form-control dev-example-input" placeholder="복수선택 내용을 입력하세요" value="${example.cont}" />
                                                                <c:if test="${example.atchFileNo != null && example.atchFileNo > 0}">
                                                                    <div class="form-group inner_frm_grp file_set">
                                                                        <div class="col-xs-9 col-sm-10 dev-file-wrap">
                                                                            <a href="${example.fileStreCours}${example.streFileNm}" target="_blank" class="text-danger">${example.orignlFileNm}</a> (${cutil:out(example.fileSize)})
                                                                            <input type="hidden" name="file" value="${example.atchFileNo}" class="dev-upload-file-num">
                                                                        </div>
                                                                        <div class="col-xs-3 col-sm-2">
                                                                            <button type="button" class="btn btn-xs btn-danger file_del ico_btn outline">삭제</button>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                            <div class="col-sm-2 col-md-3 col-lg-2 btn_area">
                                                                <button type="button" class="btn btn-default outline ico_btn file_add"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">첨부</span></button>
                                                                <c:if test="${status.index > 0}">
                                                                <button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">삭제</span></button>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="text-right">
                                                        <button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 복수선택 항목 추가</button>
                                                    </div>
                                                </div>
                                                <div class="tab-content item_tab4 skip_type_box" <c:if test="${question.qusTypeCd == 'SKIP'}">style="display: block;"</c:if>>
                                                    <div class="form-group">
                                                        <label for="item${question.orderNo}-tit4" class="col-sm-2 control-label">질문</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" id="item${question.orderNo}-tit4" name="item${question.orderNo}-tit4" class="form-control" placeholder="건너뛰기 형 질문을 입력하세요" value="${question.cont}" />
                                                        </div>
                                                    </div>
                                                    <div class="inp_list skip_grp">
                                                        <c:forEach var="example" items="${question.surveyExampleList}" varStatus="status">
                                                        <div class="form-group dev-group">
                                                            <label for="item${question.orderNo}-skip${example.orderNo}" class="col-sm-2 control-label"><span class="num">${example.orderNo}</span>)</label>
                                                            <div class="col-sm-8 col-md-7 col-lg-8">
                                                                <input type="text" id="item${question.orderNo}-skip${example.orderNo}" name="item${question.orderNo}-skip${example.orderNo}" class="form-control dev-example-input" placeholder="건너뛰기 형 단일선택 내용을 입력하세요" value="${example.cont}" />
                                                                <div class="form-inline skip_num_inp">
                                                                    <label for="item${question.orderNo}-skip${example.orderNo}-num${example.orderNo}" class="text-primary control-label"> 선택시
                                                                        <input type="text" id="item${question.orderNo}-skip1-num1" name="item${question.orderNo}-skip1-num1" class="form-control dev-example-skip" readonly="readonly" maxlength="2" value="${example.skipNo}" />
                                                                        번 항목으로 건너뛰기</label>
                                                                </div>
                                                                <c:if test="${example.atchFileNo != null && example.atchFileNo > 0}">
                                                                    <div class="form-group inner_frm_grp file_set">
                                                                        <div class="col-xs-9 col-sm-10 dev-file-wrap">
                                                                            <a href="${example.fileStreCours}${example.streFileNm}" target="_blank" class="text-danger">${example.orignlFileNm}</a> (${cutil:out(example.fileSize)})
                                                                            <input type="hidden" name="file" value="${example.atchFileNo}" class="dev-upload-file-num">
                                                                        </div>
                                                                        <div class="col-xs-3 col-sm-2">
                                                                            <button type="button" class="btn btn-xs btn-danger file_del ico_btn outline">삭제</button>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                            <div class="col-sm-2 col-md-3 col-lg-2 btn_area">
                                                                <button type="button" class="btn btn-default outline ico_btn file_add" title="파일첨부"><i class="ti-save" aria-hidden="true"></i> <span class="sr-only">파일첨부</span></button>
                                                                <c:if test="${status.index > 0}">
                                                                    <button type="button" class="btn btn-black ico_btn inp_del" title="삭제"><i class="ti-close" aria-hidden="true"></i> <span class="sr-only">삭제</span></button>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        </c:forEach>
                                                    </div>
                                                    <div class="text-right">
                                                        <button type="button" class="btn btn-black add_inp_btn"><i class="fa fa-plus-square" aria-hidden="true"></i> 건너뛰기 항목 추가</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                                <!-- //panel -->
                            </div>
                            <!-- <div style="font-size: 8pt; float: right; color: gray;">
                            	※설명 항목에 대한 설명 입니다.<br><br>
                            	서술형     : 질문에 대하여 서술식으로 답변을 적는 형태<br>
                            	단일선택형 : 한가지 답변만 선택하는 형태<br>
                            	복수선택형 : 여러가지 답변을 선택하는 형태<br>
                            	건너뛰기형 : 해당 답변을 클릭 시 연결된 문항이 생성되는 형태
                            </div> -->
                            <div class="row text-center">
                                <div class="col-sm-10 col-sm-push-2">
                                    <button type="button" class="btn btn-lg btn-primary" id="itemSetPlus"><i
                                            class="ti-plus" aria-hidden="true"></i> 설문항목 추가하기
                                    </button>
                                </div>
                            </div>
                    <hr/>
                    <div class="row type0">
                        <div class="col-sm-6">
                                <a href="javascript:;"
                                   class="btn btn-warning dev-preview"><i class="fa fa-window-maximize" aria-hidden="true"></i> 미리보기</a>
                        </div>
                        <div class="col-sm-6 text-right">
                            <button type="button" class="btn btn-blue outline submit-btn" id="tempButton" data-state="TEMPORARY">임시저장
                            </button>
                            <button type="button" class="btn btn-blue submit-btn" data-state="WAIT">승인신청</button>
                            <a href="/srv/list.do" class="btn btn-black">취소</a>
                        </div>
                    </div>
                </fieldset>
            </form>
            <!-- // 일정쓰기-->
            <script type="text/javascript" src="<c:url value='/js/egovframework/com/wkp/surveyFrm.js'/>"></script>

            <!-- 조직그룹 선택 팝업 -->
                <div class="modal fade" id="selectGrpPopup" tabindex="-1" role="dialog" aria-labelledby="selectGrpPopupLabel">
                    <div class="modal-dialog" role="document">
	                    <div class="modal-content">
	                        <div class="modal-header">
	                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	                            <h4 class="modal-title" id="selectGrpPopupLabel">부서/개인/그룹 선택</h4>
	                        </div>
	                        <div class="modal-body">
	                            <ul class="nav nav-tabs" role="tablist">
	                                <li role="presentation" class="active"><a href="#selectGrpTab1" aria-controls="selectGrpTab1" role="tab" data-toggle="tab">부서</a></li>
	                                <li role="presentation"><a href="#selectGrpTab2" aria-controls="selectGrpTab2" role="tab" data-toggle="tab">개인</a></li>
	                                <li role="presentation"><a href="#selectGrpTab3" aria-controls="selectGrpTab3" role="tab" data-toggle="tab">그룹</a></li>
	                            </ul>
	                            <div class="tab-content">
	                                <div id="selectGrpTab1" class="tab-pane active" role="tabpanel">
	                                    <div class="srch_area">
	                                        <fieldset>
	                                            <legend class="sr-only">이름 검색영역</legend>
	                                            <div class="input-group">
	                                                <label for="orgText" class="sr-only">이름 입력</label>
	                                                <input type="text" id="orgText" name="orgText" class="form-control" placeholder="부서 검색(2글자 이상)">
	                                                <span class="input-group-btn"><a href="javascript:;" id="orgBtn" class="btn btn-default">검색</a></span>
	                                            </div>
	                                        </fieldset>
	                                    </div>
	                                    <div class="hummingbird-treeview well chk_tree_area">
	                                        <div class="checkbox">
	                                            <label for="allChk1"><input type="checkbox" id="allChk1" class="all_chk" /> 전체선택</label>
	                                        </div>
	                                        <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
	                                        <ul id="orgList" class="chk_tree_list hummingbird-base treeview">
	                                        	<c:forEach var="top" items="${topList }" varStatus="topStatus">
                                                <li>
                                                	<i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }" value="${top.ouCode }" data-id="customChk-${topStatus.index+1 }" data-name="${top.ou }" />${top.ou }</label>
                                                    <ul>
                                                    	<c:forEach var="parent" items="${parentList }" varStatus="parentStatus">
                                                    	<c:if test="${parent.parentOuCode eq top.ouCode }">
                                                        <li>
                                                            <i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }-${parentStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }-${parentStatus.index+1 }" value="${parent.ouCode }"data-id="customChk-${topStatus.index+1 }-${parentStatus.index+1 }" data-name="${parent.ou }" />${parent.ou }</label>
                                                            <ul class="not_depth_list">
                                                            	<c:forEach var="child" items="${childList }" varStatus="childStatus">
                                                            	<c:if test="${child.parentOuCode eq parent.ouCode }">
                                                                <li>
                                                                	<i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" value="${child.ouCode }" data-id="customChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" data-name="${child.ou }" />${child.ou }</label>
                                                                </li>
                                                                </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </li>
                                                        </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </li>
                                                </c:forEach>
	                                        </ul>
	                                    </div>
	                                </div>
	                                <div id="selectGrpTab2" class="tab-pane" role="tabpanel">
	                                    <div class="srch_area">
	                                        <fieldset>
	                                            <legend class="sr-only">이름 검색영역</legend>
	                                            <div class="input-group">
	                                                <label for="userText" class="sr-only">이름 입력</label>
	                                                <input type="text" id="userText" name="userText" class="form-control" placeholder="이름 검색(2글자 이상)">
	                                                <span class="input-group-btn"><a href="javascript:;" id="userBtn" class="btn btn-default">검색</a></span>
	                                            </div>
	                                        </fieldset>
	                                    </div>
	                                    <div class="hummingbird-treeview well chk_tree_area">
	                                        <div class="checkbox">
	                                            <label for="allSrchChk"><input type="checkbox" id="allSrchChk" class="all_chk" /> 전체선택</label>
	                                        </div>
	                                        <ul id="userList" class="chk_tree_list hummingbird-base treeview">
	                                        	<c:forEach var="top" items="${topList }" varStatus="topStatus">
                                                <li>
                                                	<i class="fa fa-plus" data-code="${top.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }" />${top.ou }</label>
                                                    <ul>
                                                    	<c:forEach var="parent" items="${parentList }" varStatus="parentStatus">
                                                    	<c:if test="${parent.parentOuCode eq top.ouCode }">
                                                        <li>
                                                            <i class="fa fa-plus" data-code="${parent.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }" />${parent.ou }</label>
                                                            <ul class="not_depth_list">
                                                            	<c:forEach var="child" items="${childList }" varStatus="childStatus">
                                                            	<c:if test="${child.parentOuCode eq parent.ouCode }">
                                                                <li>
                                                                	<i class="fa fa-plus" data-code="${child.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" />${child.ou }</label>
                                                                	<ul>
                                                                	</ul>
                                                                </li>
                                                                </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </li>
                                                        </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </li>
                                                </c:forEach>
	                                        </ul>
	                                    </div>
	                                </div>
	                                <div id="selectGrpTab3" class="tab-pane" role="tabpanel">
	                                <c:choose>
	                                	<c:when test="${not empty groupList }">
	                                    <div class="hummingbird-treeview well chk_tree_area">
	                                        <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
	                                        <div class="checkbox">
	                                            <label for="allSrchGrp"><input type="checkbox" id="allSrchGrp" class="all_chk" /> 전체선택</label>
	                                        </div>
	                                        <ul id="grpList" class="chk_tree_list hummingbird-base treeview">
	                                        	<c:forEach var="group" items="${groupList }" varStatus="status">
	                                        	<li><label for="allSrchGrp-${status.index }"><input id="allSrchGrp-${status.index }" name="groupList" data-id="allSrchGrp-${status.index }" type="checkbox" value="${group.groupNo }" data-name="${group.groupNm }">${group.groupNm }</label></li>
	                                        	</c:forEach>
	                                        </ul>
	                                    </div>
	                                    </c:when>
										<c:otherwise>
	                                    <!-- 검색결과 없음 -->
	                                    <div class="well text-center mb_0">
	                                        <p>등록된 그룹이 없습니다</p>
	                                    </div>
	                                    <!-- //검색결과 없음 -->
	                                    </c:otherwise>
	                                </c:choose>
	                                    <p class="mt_5 fs_95"><span class="text-danger">※</span> 그룹 편집은  <a href="/myp/mypage.do" class="text-danger underline">마이 페이지</a>에서 가능합니다</p>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" id="rlsChk" class="btn btn-blue" data-dismiss="modal">확인</button>
	                        </div>
	                    </div>
                    </div>
                </div>
                <!-- //조직그룹 선택 팝업 -->
        </div>
        <!-- //page-body -->
        <script type="text/javascript" src="<c:url value='/js/egovframework/com/wkp/calendarW.js'/>"></script>
    </div>
    <!-- //CONTENTS -->
</div>


<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/utl/fileUpload.js'/>"></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>"></script>
<script type="text/javascript">
    CKEDITOR.replace('inpText');

    var isPreview = false;
    
    $(document).keydown(function(e) {
        if(e.target.nodeName != "INPUT"){
            if(e.keyCode == 8){
                return false;
           }
        }
        
        if(e.target.readOnly){ // readonly일 경우 true
            if(e.keyCode == 8){
                return false;
           }
        }
    });
    
    $(document).ready(function () {
        var isSubmit = true;
        var isTypeNull = false;
        $(document).on("click",".submit-btn", function (e) {
            e.preventDefault();

            var question = "관리자 승인이 완료 되면 진행중인 설문에 노출됩니다. 진행하시겠습니까?";

            if(isPreview){
            	question = "미리보기 시 등록중인 설문이 임시저장됩니다. 진행하시겠습니다?";
            }
            var url = "/srv/writeProc.do";
            var surveyNo = null;
            var title = $("#postSubject");

            <c:if test="${detail.surveyNo != null or detail.surveyNo > 0}">
                question = "수정하시겠습니까?";
                url = "/srv/updateProc.do";
                surveyNo = '${detail.surveyNo}';
            </c:if>

            if (confirm(question)) {
                if (isSubmit) {
                    isSubmit = false;
                    
                    if($("#inpStartDate").val() == '' || $("#inpStartTime").val() == '' ||
            				$("#inpEndDate").val() == '' || $("#inpEndTime").val() == ''){
            			alert("날짜를 정확하게 입력해 주세요.");
            			isSubmit = true;
            			return false;
            		}
            		
            		if($("#inpStartDate").val() > $("#inpEndDate").val()){
            			alert("시작 날짜가 종료 날짜 이후 입니다.");
            			isSubmit = true;
            			return false;
            		}
            		
            		if($("#inpStartDate").val() >= $("#inpEndDate").val() &&
            				$("#inpStartTime").val() > $("#inpEndTime").val()){
            			alert("시작 시간이 종료 시간 이후 입니다.");
            			isSubmit = true;
            			return false;
            		}
            		
            		var begin = new Date($("#inpStartDate").val()+" "+$("#inpStartTime").val());
            		var end = new Date($("#inpEndDate").val()+" "+$("#inpEndTime").val());
            		if(begin.getTime() >= end.getTime()){
            			alert("시작날짜와 종료날짜를 다시 확인해 주세요.");
            			isSubmit = true;
            			return false;
            		}

                    if (title.val() == '') {
                        alert("설문 제목을 입력해주세요.");
                        isSubmit = true;
                        return false;
                    }

                    var content = CKEDITOR.instances.inpText.getData();
                    if(content == "" || content == "<br>" || content == "<br />" || content == "&nbsp;" ) {
                        alert("설문의 내용을 입력해주세요.");
                        isSubmit = true;
                        return false;
                    }
                    
                    $(".item_panel").each(function(index, item) {
                        var question = new Object();
                        var _this = $(this);

                        question.orderNo = _this.find(".order-id").html();

                        var qusType = $("#item"+ question.orderNo +"-type");

                        if(qusType.val() == "1") {
                            question.qusTypeCd = "DESCRIPTION";
                        } else if(qusType.val() == "2") {
                            question.qusTypeCd = "SINGLE";
                        } else if(qusType.val() == "3") {
                            question.qusTypeCd = "MULTI";
                        } else if(qusType.val() == "4") {
                            question.qusTypeCd = "SKIP";
                        } else{
                        	isTypeNull = true;
                        	return false;
                        }
                    });

                    if(isTypeNull){
                    	alert("설문 유형을 선택해주세요.");
            			isSubmit = true;
                    	isTypeNull = false;
                    	return false;
                    }
                    
                    var orgList = new Array();
                    var userList = new Array();
                    var groupList = new Array();

                    $('input:hidden[name="orgListHidden"]').each(function(e){
                        {
                            orgList.push($(this).val());
                        }
                    });

                    $('input:hidden[name="userListHidden"]').each(function(e){
                        {
                            userList.push($(this).val());
                        }
                    });

                    $('input:hidden[name="groupListHidden"]').each(function(e){
                        {
                            groupList.push($(this).val());
                        }
                    });

                    var data = {
                          "aprvState": $(this).data("state")
                        , "bngnDtm": $("#inpStartDate").val() + " " + $("#inpStartTime").val()
                        , "endDtm": $("#inpEndDate").val() + " " + $("#inpEndTime").val()
                        , "surveyNo": surveyNo
                        , "title": title.val()
                        , "surveyDesc": content
                        , "resltRlsYn": $("input[name='resltRlsYn']:checked").val()
                        , "targetYn": $("input[name='targetYn']:checked").val()
                        , "orgList" : orgList
                        , "userList" : userList
                        , "groupList" : groupList
                        , "rlsYn" : $("input[name='rlsYn']:checked").val()
                        , "targetRlsYn" : $("input[name='targetRlsYn']:checked").val()
                    }

                    var questionList = new Array();
                    $(".item_panel").each(function(index, item) {
                        var question = new Object();
                        var _this = $(this);

                        question.orderNo = _this.find(".order-id").html();
                        console.log('question.orderNo - ' + question.orderNo)

                        var qusType = $("#item"+ question.orderNo +"-type");

                        //alert(qusType.val());
                        if(qusType.val() == "1") {
                            question.qusTypeCd = "DESCRIPTION";
                        } else if(qusType.val() == "2") {
                            question.qusTypeCd = "SINGLE";
                        } else if(qusType.val() == "3") {
                            question.qusTypeCd = "MULTI";
                        } else if(qusType.val() == "4") {
                            question.qusTypeCd = "SKIP";
                        }

                        question.cont = $("#item"+question.orderNo+"-tit"+qusType.val()).val();
                        var esntlYn = $("#item" + question.orderNo + "-req");
                        if(esntlYn.is(":checked")) {
                            question.esntlYn = "Y";
                        } else {
                            question.esntlYn = "N";
                        }


                        if(qusType.val() != "1") {
                            var exampleList = new Array();
                            _this.find(".dev-group:visible").each(function(index, item) {
                                var __this = $(this);
                                var example = new Object();

                                example.cont = __this.find(".dev-example-input").val();
                                example.skipNo= __this.find(".dev-example-skip").val();

                                if(!example.skipNo) {
                                    example.skipNo = "";
                                }

                                var fileWrap = __this.find(".dev-file-wrap");
                                if(fileWrap) {
                                    var fileNum = fileWrap.find(".dev-upload-file-num").val();
                                    if(fileNum) {
                                        example.atchFileNo = fileNum;
                                    }
                                }

                                var order = __this.children(".col-sm-2").children(".num").text();

                                if("기타" == order) {
                                    order = "9999";
                                }

                                example.orderNo=order;
                                exampleList.push(example);
                            });

                            question.surveyExampleList = exampleList;
                        } else {
                            var exampleList = new Array();
                            var example = new Object();
                            example.cont = _this.find(".form-group").find(".dev-example-input").val();
                            example.skipNo = "";
                            example.orderNo="0";
                            exampleList.push(example);
                            question.surveyExampleList = exampleList;
                        }


                        questionList.push(question);
                    });

                    data.questionList = questionList

                    $.ajax({
                        url: url,
                        data: JSON.stringify(data),
                        dataType: 'json',
                        contentType: 'application/json',
                        type: "POST",
                        cache:false,
                        success: function (response) {
                            if (response.result) {
                                $("#surveyNo").val(response.data.surveyNo);
                                if(data.aprvState == 'WAIT') {
                                    location.href="/srv/list.do";
                                } else {
                                    if(isPreview) {
                                        previewPopup();
                                        location.href="/srv/surveyUpdate.do?surveyNo="+response.data.surveyNo; 
                                    } else {
                                        alert("임시저장 되었습니다.");
                                        location.href="/srv/surveyUpdate.do?surveyNo="+response.data.surveyNo;
                                    }

                                }
                                isSubmit = true;
                            } else {
                                alert("등록에 실패하였습니다.");
                                isSubmit = true;
                            }
                        },
                        error: function (error) {
                            isSubmit = true;
                            alert("진행 중 에러가 발생하였습니다.");
                        },
                        complete: function () {
                            isSubmit = true;
                        }
                    });
                }
            } else{
            	isPreview = false;
            }
        });

        $(".dev-preview").on("click", function() {
            isPreview = true;
            $("#tempButton").trigger("click");
        });

        $("#orgBtn").click(function(e){
            var ou = $("input[name=orgText]").val();

            if(ou == ''){
				alert("부서를 입력해주세요.");
				return false;
			}
            
            $.ajax({
                url : '/org/orgList.do',
                data : {
                    ou : ou
                },
                dataType: "json",
                success : function(data) {
                    //$('#orgList li').remove();
                    for(var i=0; i < data.orgList.length; i++){
                    	$('#orgList').prepend('<li>---------------------------------------------------------------------------------</li>');
                        $('#orgList').prepend('<li><label for="chk-'+i+'"><input id="chk-'+i+'" name="orgList" data-id="customChk-'+i+'" type="checkbox" value="'+data.orgList[i].ouCode+'" data-name="'+data.orgList[i].ou+'">'+data.orgList[i].ou+'</label></li>');
                    }
                },
                error : function(){
                	$('#orgList').prepend('<li>---------------------------------------------------------------------------------</li>');
                	$('#orgList').prepend('<li>검색 결과가 없습니다.</li>');
                }
            });
        });

        $("#userBtn").click(function(e){
            var displayName = $("input[name=userText]").val();
            
            if(displayName == ''){
				alert("이름을 입력해주세요.");
				return false;
			}
            
            $.ajax({
                url : '/usr/userList.do',
                data : {
                    displayName : displayName
                },
                dataType: "json",
                success : function(data) {
                    //$('#userList li').remove();
                    for(var i=0; i < data.userList.length; i++){
                    	$('#userList').prepend('<li>---------------------------------------------------------------------------------</li>');
                        $('#userList').prepend('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-ou="'+data.userList[i].ou+'" data-name="'+data.userList[i].displayName+'">'+ data.userList[i].ou + ' ' + data.userList[i].displayName+'</label></li>');
                    }
                },
                error : function(){
                	$('#userList').prepend('<li>---------------------------------------------------------------------------------</li>');
                	$('#userList').prepend('<li>검색 결과가 없습니다.</li>');
                }
            });
        });

        var orgLi = [];
        $("#rlsChk").click(function(e){
            //$('#rlsList').empty();
            
           /*  $('input:checkbox[name="orgList"]').each(function(e){
                if(this.checked){
                    $('#rlsList').append('<span class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="orgListHidden" value="'+$(this).val()+'"></span>');
                }
            });

            $('input:checkbox[name="userList"]').each(function(e){
                if(this.checked){
                    $('#rlsList').append('<span class="tag_btn label label-default">'+$(this).data('ou') + ' ' +$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="userListHidden" value="'+$(this).val()+'"></span>');
                }
            });

            $('input:checkbox[name="groupList"]').each(function(e){
                if(this.checked){
                    $('#rlsList').append('<span class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="groupListHidden" value="'+$(this).val()+'"></span>');
                }
            }); */
            
            /* $('input:checkbox[name="orgList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#orgName').text();
					
					if(list != '') {
						var listSplit = list.split('x삭제');
						for(var i = 0; i < listSplit.length; i++) {
							if(listSplit[i] == $(this).data('name')) {
								alert('동일한 부서가 선택되어 있습니다.');
								return false;
							}
						}
					}
					$('#rlsList').append('<span id="orgName" class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
				}
			});
			
			$('input:checkbox[name="userList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#usersName').text();
					
					if(list != '') {
						var listSplit = list.split('x삭제');
						for(var i = 0; i < listSplit.length; i++) {
							if(listSplit[i] == $(this).data('ou') + ' ' + $(this).data('name')) {
								alert('동일한 사용자가 선택되어 있습니다.');
								return false;
							}
						}
					}
					
					$('#rlsList').append('<span id="usersName" class="tag_btn label label-default">'+$(this).data('ou')+' '+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
				}
			});
			
			$('input:checkbox[name="groupList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#groupName').text();
					
					if(list != '') {
						var listSplit = list.split('x삭제');
						for(var i = 0; i < listSplit.length; i++) {
							if(listSplit[i] == $(this).data('name')) {
								alert('동일한 그룹이 선택되어 있습니다.');
								return false;
							}
						}
					}
					$('#rlsList').append('<span id="groupName" class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');		
				}
			});
            
            $( 'input[name="allChk1"]' ).attr( 'checked', false );
			$( 'input[name="orgList"]' ).attr( 'checked', false );
			$( 'input[name="allSrchChk"]' ).attr( 'checked', false );
			$( 'input[name="userList"]' ).attr( 'checked', false );
			$( 'input[name="allSrchGrp"]' ).attr( 'checked', false );
			$( 'input[name="groupList"]' ).attr( 'checked', false ); */
			
			$('input:checkbox[name="orgList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#orgName').text();
					var data = $(this).data('name');
					
					//console.log("orgLi.indexOf(data) - " + orgLi.indexOf(data));
					if(orgLi.indexOf(data) < 0) {
						orgLi.push(data);
					}
					
					//console.log("orgLi - " + orgLi);
					//console.log("orgLi - " + orgLi);
					//console.log("list.indexOf(data) - " + list.indexOf(data));
					//console.log("data - " + data);

					if(list.indexOf(data) < 0) {
						$('#rlsList').append('<span id="orgName" class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="orgListHidden" value="'+$(this).val()+'"></span>');
					}
				}
			});
			
			$('input:checkbox[name="userList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#usersName').text();
					var data = $(this).data('name');
					
					//console.log("orgLi.indexOf(data) - " + orgLi.indexOf(data));
					if(orgLi.indexOf(data) < 0) {
						orgLi.push(data);
					}
					
					//console.log("orgLi - " + orgLi);
					//console.log("orgLi - " + orgLi);
					//console.log("list.indexOf(data) - " + list.indexOf(data));
					//console.log("data - " + data);

					if(list.indexOf(data) < 0) {
						$('#rlsList').append('<span id="usersName" class="tag_btn label label-default">'+$(this).data('ou') + ' ' +$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="userListHidden" value="'+$(this).val()+'"></span>');
					}
				}
			});
			
			$('input:checkbox[name="groupList"]').each(function(e){
				if(this.checked){
					var list = $('#rlsList').children('#groupName').text();
					var data = $(this).data('name');
					
					//console.log("orgLi.indexOf(data) - " + orgLi.indexOf(data));
					if(orgLi.indexOf(data) < 0) {
						orgLi.push(data);
					}
					
					//console.log("orgLi - " + orgLi);
					//console.log("orgLi - " + orgLi);
					//console.log("list.indexOf(data) - " + list.indexOf(data));
					//console.log("data - " + data);

					if(list.indexOf(data) < 0) {
						$('#rlsList').append('<span id="groupName" class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="groupListHidden" value="'+$(this).val()+'"></span>');
					}
				}
			});
			
			$( 'input[name="allChk1"]' ).attr( 'checked', false );
			//$( 'input[name="orgList"]' ).attr( 'checked', false );
			$( 'input[name="allSrchChk"]' ).attr( 'checked', false );
			//$( 'input[name="userList"]' ).attr( 'checked', false );
			$( 'input[name="allSrchGrp"]' ).attr( 'checked', false );
			//$( 'input[name="groupList"]' ).attr( 'checked', false );
        });

        
        $("#userList .fa").click(function(e){
			var tmp = $(this);
			var ouCode = $(this).data('code');
     		$.ajax({
     			url : '/usr/userList.do',
     			data : {
     				ouCode : ouCode
     			},
     			dataType: "json",
     			success : function(data) {
     				for(var i=data.userList.length-1; i >= 0; i--){
     					tmp.next().next().prepend('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'" data-ou="'+data.userList[i].ou+'">'+data.userList[i].ou+' '+data.userList[i].displayName+'</label></li>');
     				}
     			},
     			error : function(){
     				alert("에러가 발생하였습니다.");
     			}
     		});
		});		

    }); // end ready()

    function previewPopup() {
        isPreview = false;
        var surveyNo = $("#surveyNo").val();
        if(surveyNo) {
            popupwindow("/srv/detailPopup.do?surveyNo=" + surveyNo,"_blank", 1000, 900 );
        }
    }
    

    function popupwindow(url, title, w, h) {
        var y = window.outerHeight / 2 + window.screenY - ( h / 2)
        var x = window.outerWidth / 2 + window.screenX - ( w / 2)
        return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + y + ', left=' + x);
    }

</script>



<!-- <form name="uploadForm" method="post" action="/cmm/fms/upload.do" target="frameUpload" enctype="multipart/form-data">
</form>

<iframe name="frameUpload" style="display: none;"></iframe> -->