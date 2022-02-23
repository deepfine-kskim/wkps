<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="cont_wrap">
    <div class="cont_header">
        <div class="row">
            <div class="col-xs-6">
                <h2 class="page_title">설문조사 관리</h2>
            </div>
            <div class="col-xs-6 text-right">
                <p class="msg"><strong class="text-primary">${user.displayName}</strong>님! 반갑습니다.</p>
                <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
            </div>
        </div>
    </div>
    <!-- //cont_header -->
    <div class="cont_body">
        <ol class="breadcrumb">
            <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
            <li class="active">설문조사 관리</li>
        </ol>
        <div id="contents">
            <table class="table table-bordered">
                <caption class="sr-only hidden">처리상태</caption>
                <colgroup>
                    <col style="width:10%;" />
                    <col style="width:10%;" />
                    <col style="width:10%;" />
                    <col style="width:10%;" />
                    <col style="width:10%;" />
                    <col />
                    <col style="width:10%;" />
                    <col style="width:12%;" />
                </colgroup>
                <tr>
                    <th>설문 공개여부</th>
					<td>
						<c:choose>
                            <c:when test="${detail.rlsYn eq 'Y'}">공개</c:when>
                            <c:otherwise>비공개</c:otherwise>
                        </c:choose>
					</td>
                    <th>상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${detail.aprvState.name() eq 'CANCEL'}">
                                <a href="#alertPopup" class="text-danger lnk_txt" data-toggle="modal" data-target="#alertPopup">${detail.aprvState.value}</a></td>
                            </c:when>
                            <c:otherwise>
                                ${detail.aprvState.value}
                            </c:otherwise>
                        </c:choose>

                    <th>처리자</th>
                    <td>${detail.checkRegisterName} (${detail.checkRegisterOu})</td>
                    <th>처리일</th>
                    <td>
                        <c:if test="${detail.checkDtm  != null}">
                            <fmt:formatDate value="${detail.checkDtm}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </c:if>
                    </td>
                </tr>
            </table>
            <div class="well well-white well-lg">
                <div class="brd_view_area">
                    <div class="view_header">
                        <strong class="subject">${detail.title}</strong>
                        <div class="row type0 info_view">
                            <div class="col-xs-12 col-sm-4">
                                <span><strong class="text-black">설문기간</strong> : </span><span class="data text-danger">
                                <fmt:formatDate value="${detail.bngnDtm}" pattern="yyyy-MM-dd HH:mm"/>
                                         ~
                                <fmt:formatDate value="${detail.endDtm}" pattern="yyyy-MM-dd HH:mm"/></span>
                            </div>
                            <div class="col-xs-12 col-sm-8 info_txts">
                                <span class="info_txt"><strong class="text-black">설문참여수</strong> : <span class="data">${joinCount}</span></span>
                                <span class="info_txt name">작성자 : <span class="data">${detail.registerName}</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="view_body">
                        <div class="text-black mb_5 block"><strong>설문내용</strong></div>
                        <div class="well mb_0">
                            ${detail.surveyDesc}
                        </div>
                    </div>
                    <div class="panel_list_set">
                        <c:forEach var="question" items="${detail.questionList}" varStatus="qStatus">
                            <div class="panel panel-default poll_panel dev-panel-${question.orderNo}" data-surveyno="${detail.surveyNo}" data-questionno="${question.surveyQusNo}" data-type="${question.qusTypeCd.name()}" data-esntlyn="${question.esntlYn}" data-orderno="${question.orderNo}">
                                <div class="panel-heading">
                                    <div class="panel-title">
                                        <strong>${question.orderNo}. ${question.cont}</strong>
                                        <c:if test="${question.esntlYn == 'Y'}">
                                            <span class="text-danger fs_13">필수</span>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="panel-body <c:if test="${question.qusTypeCd.name() == 'DESCRIPTION'}">poll</c:if>">
                                    <c:choose>
                                        <c:when test="${question.qusTypeCd.name() == 'DESCRIPTION'}">
                                            <label for="item${qStatus.count}-txt"
                                                   class="sr-only">${question.orderNo}. ${question.cont}</label>
                                            <c:forEach var="example" items="${question.surveyExampleList}" varStatus="eStatus">
                                                <input type="hidden" name="item${qStatus.count}-ra-grp${qStatus.count}" value="${example.surveyExampleNo}" class="dev-input-no">
                                            </c:forEach>
                                            <textarea class="form-control dev-input-cont" rows="4" name="item${qStatus.count}-txt" id="item${qStatus.count}-txt"
                                                      placeholder="답변 안내문"
                                                      required="required"></textarea>

                                        </c:when>
                                        <c:when test="${question.qusTypeCd.name() == 'SINGLE'}">
                                            <c:forEach var="example" items="${question.surveyExampleList}" varStatus="eStatus">
                                                <c:choose>
                                                    <c:when test="${example.orderNo >= 9999}">
                                                        <div class="row etc_set">
                                                            <div class="col-xs-12">
                                                                <div class="form-inline">
                                                                    <div class="radio-inline">
                                                                        <label for="item${qStatus.count}-ra${eStatus.count}"><input type="radio" id="item${qStatus.count}-ra${eStatus.count}"
                                                                                                                                    name="item${qStatus.count}-ra-grp${qStatus.count}" value="${example.surveyExampleNo}" class="dev-input-no">기타)</label>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="item${qStatus.count}-ra-etc" class="sr-only">기타</label>
                                                                        <input type="text" id="item${qStatus.count}-ra-etc"
                                                                               class="inline_lg_inp form-control dev-input-cont">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="row">
                                                            <div class="col-xs-12">
                                                                <div class="radio-inline">
                                                                    <label for="item${qStatus.count}-ra${eStatus.count}"><input type="radio" id="item${qStatus.count}-ra${eStatus.count}"
                                                                                                                                name="item${qStatus.count}-ra-grp${qStatus.count}" value="${example.surveyExampleNo}" class="dev-input-no" >${example.orderNo})
                                                                            ${example.cont}</label>
                                                                </div>
                                                                <c:if test="${example.fileType.name() != 'NONE'}">
                                                                    <c:choose>
                                                                        <c:when test="${example.fileType.name() == 'IMAGE'}">
                                                                            <div class="data_area file_img">
                                                                                <a href="${example.fileStreCours}${example.streFileNm}" class="zoom_pop">
                                                                                    <img src="${example.fileStreCours}${example.streFileNm}" alt="">
                                                                                </a>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:when test="${example.fileType.name() == 'VIDEO'}">
                                                                            <div class="data_area file_video">
                                                                                <video width="100%" controls="">
                                                                                    <source type="video/mp4" src="${example.fileStreCours}${example.streFileNm}">
                                                                                </video>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="data_area file_audio">
                                                                                <div class="audio_wrap">
                                                                                    <div class="audioplayer audioplayer-stopped">
                                                                                        <audio controls="" style="width: 0px; height: 0px; visibility: hidden;">
                                                                                            <source type="audio/mpeg" src="${example.fileStreCours}${example.streFileNm}">
                                                                                        </audio>
                                                                                        <div class="audioplayer-playpause" title="Play"><a href="#">Play</a>
                                                                                        </div>
                                                                                        <div class="audioplayer-time audioplayer-time-current">00:00</div>
                                                                                        <div class="audioplayer-bar">
                                                                                            <div class="audioplayer-bar-loaded" style="width: 6.02194%;"></div>
                                                                                            <div class="audioplayer-bar-played"></div>
                                                                                        </div>
                                                                                        <div class="audioplayer-time audioplayer-time-duration">00:28</div>
                                                                                        <div class="audioplayer-volume">
                                                                                            <div class="audioplayer-volume-button" title="Volume"><a href="#">Volume</a>
                                                                                            </div>
                                                                                            <div class="audioplayer-volume-adjust">
                                                                                                <div>
                                                                                                    <div style="height: 100%;"></div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </c:when>
                                        <c:when test="${question.qusTypeCd.name() == 'MULTI'}">
                                            <c:forEach var="example" items="${question.surveyExampleList}" varStatus="eStatus">
                                                <div class="row">
                                                    <div class="col-xs-12">
                                                        <div class="checkbox-inline">
                                                            <label for="item${qStatus.count}-chk${eStatus.count}"><input type="checkbox" id="item${qStatus.count}-chk${eStatus.count}"
                                                                                                                         name="item${qStatus.count}-chk${eStatus.count}" class="dev-input-no" value="${example.surveyExampleNo}">${example.cont}</label>
                                                        </div>
                                                        <c:if test="${example.fileType.name() != 'NONE'}">
                                                            <c:choose>
                                                                <c:when test="${example.fileType.name() == 'IMAGE'}">
                                                                    <div class="data_area file_img">
                                                                        <a href="${example.fileStreCours}${example.streFileNm}" class="zoom_pop">
                                                                            <img src="${example.fileStreCours}${example.streFileNm}" alt="">
                                                                        </a>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${example.fileType.name() == 'VIDEO'}">
                                                                    <div class="data_area file_video">
                                                                        <video width="100%" controls="">
                                                                            <source type="video/mp4" src="${example.fileStreCours}${example.streFileNm}">
                                                                        </video>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="data_area file_audio">
                                                                        <div class="audio_wrap">
                                                                            <div class="audioplayer audioplayer-stopped">
                                                                                <audio controls="" style="width: 0px; height: 0px; visibility: hidden;">
                                                                                    <source type="audio/mpeg" src="${example.fileStreCours}${example.streFileNm}">
                                                                                </audio>
                                                                                <div class="audioplayer-playpause" title="Play"><a href="#">Play</a>
                                                                                </div>
                                                                                <div class="audioplayer-time audioplayer-time-current">00:00</div>
                                                                                <div class="audioplayer-bar">
                                                                                    <div class="audioplayer-bar-loaded" style="width: 6.02194%;"></div>
                                                                                    <div class="audioplayer-bar-played"></div>
                                                                                </div>
                                                                                <div class="audioplayer-time audioplayer-time-duration">00:28</div>
                                                                                <div class="audioplayer-volume">
                                                                                    <div class="audioplayer-volume-button" title="Volume"><a href="#">Volume</a>
                                                                                    </div>
                                                                                    <div class="audioplayer-volume-adjust">
                                                                                        <div>
                                                                                            <div style="height: 100%;"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <%-- 여기는 스킵 --%>
                                            <c:forEach var="example" items="${question.surveyExampleList}" varStatus="eStatus">
                                                <div class="row dev-skip" data-skipno="${example.skipNo}">
                                                    <div class="col-xs-12">
                                                        <div class="radio-inline">
                                                            <label for="item${qStatus.count}-ra${eStatus.count}"><input type="radio" id="item${qStatus.count}-ra${eStatus.count}"
                                                                                                                        name="item${qStatus.count}-ra-grp${qStatus.count}" class="dev-input-no dev-input-skip" value="${example.surveyExampleNo}">${example.orderNo})
                                                                    ${example.cont}</label>
                                                        </div>
                                                        <c:if test="${example.fileType.name() != 'NONE'}">
                                                            <c:choose>
                                                                <c:when test="${example.fileType.name() == 'IMAGE'}">
                                                                    <div class="data_area file_img">
                                                                        <a href="${example.fileStreCours}${example.streFileNm}" class="zoom_pop">
                                                                            <img src="${example.fileStreCours}${example.streFileNm}" alt="">
                                                                        </a>
                                                                    </div>
                                                                </c:when>
                                                                <c:when test="${example.fileType.name() == 'VIDEO'}">
                                                                    <div class="data_area file_video">
                                                                        <video width="100%" controls="">
                                                                            <source type="video/mp4" src="${example.fileStreCours}${example.streFileNm}">
                                                                        </video>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="data_area file_audio">
                                                                        <div class="audio_wrap">
                                                                            <div class="audioplayer audioplayer-stopped">
                                                                                <audio controls="" style="width: 0px; height: 0px; visibility: hidden;">
                                                                                    <source type="audio/mpeg" src="${example.fileStreCours}${example.streFileNm}">
                                                                                </audio>
                                                                                <div class="audioplayer-playpause" title="Play"><a href="#">Play</a>
                                                                                </div>
                                                                                <div class="audioplayer-time audioplayer-time-current">00:00</div>
                                                                                <div class="audioplayer-bar">
                                                                                    <div class="audioplayer-bar-loaded" style="width: 6.02194%;"></div>
                                                                                    <div class="audioplayer-bar-played"></div>
                                                                                </div>
                                                                                <div class="audioplayer-time audioplayer-time-duration">00:28</div>
                                                                                <div class="audioplayer-volume">
                                                                                    <div class="audioplayer-volume-button" title="Volume"><a href="#">Volume</a>
                                                                                    </div>
                                                                                    <div class="audioplayer-volume-adjust">
                                                                                        <div>
                                                                                            <div style="height: 100%;"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- //brd_view_area -->
                <script src="<c:url value='/js/egovframework/com/wkp/audioplayer.js'/>"></script>
                <script>
                    $(document).ready(function() {
                        $( 'audio' ).audioPlayer();
                    });
                </script>
            </div>
            <div class="row mb_15">
                <div class="col-xs-6">
                    <c:if test="${detail.aprvState.name() eq 'WAIT'}">
                        <button type="button" class="btn btn-blue min-lg dev-confirm" data-type="DOING">승인</button>
                        <a href="#rejectionPopup" class="btn btn-danger min-lg" data-toggle="modal" data-target="#rejectionPopup">반려</a>
                    </c:if>
                    <c:if test="${detail.aprvState.name() ne 'WAIT'}">
						<c:choose>
                            <c:when test="${detail.rlsYn eq 'N'}">
                            	<button type="button" class="btn btn-black min-lg dev-release" data-rlsyn="Y">공개</button>
                            </c:when>
                            <c:otherwise>
                            	<button type="button" class="btn btn-gray min-lg dev-release" data-rlsyn="N">비공개</button>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>
                <div class="col-xs-6 text-right">
                    <a href="/adm/surveySetup.do" class="btn btn-black btn-lg min-lg">목록</a>
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
                        <p class="text-center">
                            ${detail.checkCont}
                        </p>
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
                <form class="modal-content form-horizontal">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <div class="h4 modal-title" id="rejectionPopupLabel">반려사유</div>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-12 control-label sr-only">반려사유</label>
                            <div class="col-sm-12">
                                <textarea class="form-control" rows="4" placeholder="반려 사유를 작성해 주세요." id="dev-check-cont"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer text-center">
                        <button type="button" class="btn btn-blue min-md dev-confirm" data-type="CANCEL">확인</button>
                        <button type="button" class="btn btn-default min-md" data-dismiss="modal">취소</button>
                    </div>
                </form>
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
    $(document).ready(function () {
        var isSubmit = true;
        $(".dev-confirm").on("click", function(e) {
            var data = {
                  "surveyNo": '${detail.surveyNo}'
                , "type" : $(this).data("type")
                , "checkCont" : $("#dev-check-cont").val()
            }

            if(isSubmit) {
                isSubmit = false;
                $.ajax({
                    url: "/adm/updateSurveyState.do",
                    data: data,
                    dataType: 'json',
                    type: "POST",
                    cache:false,
                    success: function (data) {
                        if (data.result) {
                            alert("완료하였습니다.");
                            location.reload();
                        } else {
                            alert("통신 중에 에러가 발생하였습니다.");
                            isSubmit = true;
                        }
                    },
                    error: function (error) {
                        alert("통신 중에 에러가 발생하였습니다.");
                        isSubmit = true;
                    },
                    complete: function () {
                        isSubmit = true;
                    }
                });
            }
        });
        
        $(".dev-release").on("click", function(e) {
        	
        	var data = {
                  "surveyNo": '${detail.surveyNo}'
                , "rlsYn" : $(this).data("rlsyn")
            }

            if(isSubmit) {
                isSubmit = false;
                $.ajax({
                    url: "/adm/updateSurveyRelease.do",
                    data: data,
                    dataType: 'json',
                    type: "POST",
                    cache:false,
                    success: function (data) {
                        if (data.result) {
                            alert("완료하였습니다.");
                            location.reload();
                        } else {
                            alert("통신 중에 에러가 발생하였습니다.");
                            isSubmit = true;
                        }
                    },
                    error: function (error) {
                        alert("통신 중에 에러가 발생하였습니다.");
                        isSubmit = true;
                    },
                    complete: function () {
                        isSubmit = true;
                    }
                });
            }
        });
    });
</script>