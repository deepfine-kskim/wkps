<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container sub_cont">
    <div id="contents">
        <div class="page-header">
            <h2>설문조사</h2>
       		<div>${menuDesc }</div>
        </div>
        <!-- //page-header -->

        <div class="page-body">
            <div class="brd_view_area">
                <div class="view_header">
                    <strong class="subject">${detail.title}</strong>
                    <div class="row type0 info_view">
                        <div class="col-xs-12 col-sm-4">
                            <span><strong class="text-black">설문기간</strong> : </span>
                            <span class="data text-danger">
                                  <fmt:formatDate value="${detail.bngnDtm}" pattern="yyyy-MM-dd HH:mm"/>
                                         ~
                                <fmt:formatDate value="${detail.endDtm}" pattern="yyyy-MM-dd HH:mm"/>
                            </span>
                        </div>
                        <div class="col-xs-12 col-sm-8 info_txts">
                            <span class="info_txt"><strong class="text-black">설문참여수</strong> : <span
                                    class="data">${joinCount}</span></span>
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
											<c:if test="${question.qusTypeCd.name() == 'MULTI'}">
                                        		&nbsp;<span class="text-black fs_13" style="text-align: justify; text-align-last: right;">※ 복수선택 가능</span>
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
                                                                    <div class="radio-inline" style="margin-right: 100px;">
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
                                                                <div class="radio-inline" style="margin-right: 100px;">
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
                                                                                        <audio controls="">
                                                                                            <source type="audio/mpeg" src="${example.fileStreCours}${example.streFileNm}">
                                                                                        </audio>
                                                                                        <!--
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
                                                                                        </div> -->
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
                                                    <div class="checkbox-inline" style="margin-right: 100px;">
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
                                                                            <audio controls="">
                                                                                <source type="audio/mpeg" src="${example.fileStreCours}${example.streFileNm}">
                                                                            </audio>
                                                                            <!-- <div class="audioplayer-playpause" title="Play"><a href="#">Play</a>
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
                                                                            </div> -->
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
                                                        <div class="radio-inline" style="margin-right: 100px;">
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
                                                                                <audio controls="">
                                                                                    <source type="audio/mpeg" src="${example.fileStreCours}${example.streFileNm}">
                                                                                </audio>
                                                                                <!-- <div class="audioplayer-playpause" title="Play"><a href="#">Play</a>
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
                                                                                </div> -->
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
                    <!-- //panel -->
                    <div class="row type0 mb_20">
                        <c:if test="${detail.aprvState.name() == 'DOING'}">                           
                            <c:choose>
                            <c:when test="${!isAnswer}">
                                <div class="col-xs-6">
                                    <button type="button" class="btn btn-default dev-reload">설문 초기화</button>
                                </div>
                                <div class="col-xs-6 text-right">
                                    <button type="button" class="btn btn-blue dev-answer-submit"><i class="ti-bar-chart-alt" aria-hidden="true"></i>설문 참여하기</button>
                                </div>
                            </c:when>
                            <c:otherwise>
								<div class="col-xs-6">
									이미 참여한 설문입니다.
								</div>
                            </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- //brd_view_area -->
            <script src="<c:url value='/js/egovframework/com/wkp/audioplayer.js'/>"></script>
            <script src="<c:url value='/js/egovframework/com/wkp/jquery.magnific-popup.min.js'/>"></script>

            <div class="row brd_foot_btns">

                    <div class="col-sm-6">
                    	<c:if test="${detail.aprvState.name() eq 'DONE' or detail.aprvState.name() eq 'DOING'}">
                    	 	<c:if test="${detail.resltRlsYn eq 'Y' or user.roleCd eq 'ROLE_ADMIN' or user.roleCd eq 'ROLE_SURVEY' or detail.registerId eq user.sid }">
                        		<a href="/srv/surveyResult.do?surveyNo=${detail.surveyNo}" class="btn btn-blue outline">결과보기</a>
                        	</c:if>
                        </c:if>
						<c:if test="${detail.registerId eq user.sid}">
                        	<c:if test="${detail.aprvState.name() eq 'TEMPORARY' or detail.aprvState.name() eq 'WAIT' or detail.aprvState.name() eq 'CANCEL' or detail.aprvState.name() eq 'DOING'}">
                            	<a href="javascript:;" class="btn btn-black dev-update">수정</a>
                            	<a href="#" class="btn btn-danger dev-delete">삭제</a>
                        	</c:if>
                        </c:if>
                        <c:if test="${detail.registerId != user.sid and user.roleCd eq 'ROLE_ADMIN' or user.roleCd eq 'ROLE_SURVEY'}">
                            <a href="#" class="btn btn-danger dev-delete">삭제</a>
                        </c:if>
                    </div>

                <div class="col-sm-6 text-right">
                    <a href="javascript:;" class="btn btn-black dev-page">목록</a>
                </div>
            </div>

        </div>
        <!-- //page-body -->


    </div>
    <!-- //CONTENTS -->

    <form name="searchForm">
        <input type="hidden" name="type" value="${type.name()}">
        <input type="hidden" name="page" value="${page}">
        <input type="hidden" name="searchText" value="${searchText}"/>
        <input type="hidden" name="surveyNo"/>
    </form>

</div>
<script>

    $(document).ready(function () {

        $(".dev-skip").each(function() {
            $(".dev-panel-" + $(this).data("skipno")).hide();
        });

        $(".dev-input-skip").on("click", function() {
            var parent = $(this).closest(".panel-default");
            var skipChild = parent.find(".dev-skip");

            skipChild.each(function(){
                $(".dev-panel-" + $(this).data("skipno")).hide();
            });

            $(".dev-panel-" + $(this).closest(".dev-skip").data("skipno")).show();

        });

        $('audio').audioPlayer();

        $('.dev-page').on('click', function () {
            goPage();
        });

        $(".dev-reload").on("click", function (e) {
            location.reload();
        });

        $(".dev-delete").on("click", function () {
            if (confirm("삭제 하시겠습니까?")) {
                var form = $("form[name=searchForm]");
                form.attr("action", "/srv/surveyDelete.do");
                form.attr("method", "post");
                form.find("input[name=surveyNo]").val('${detail.surveyNo}');
                form.submit();
            }
        });

        var isSubmit = true;

        $(".dev-answer-submit").on("click", function(e) {

            var answerList = new Array();
            var error;

            $(".panel-default:visible").each(function() {
                var answer = new Object();
                var _this = $(this);

                answer.surveyNo = _this.data("surveyno");
                answer.surveyQusNo = _this.data("questionno");
                var $type = _this.data("type");
                var $esntlyn = _this.data("esntlyn");

                if($type == 'DESCRIPTION') {
                    answer.qusAnswerCont = _this.find(".dev-input-cont").val();
                    if(answer.qusAnswerCont) {
                        answer.surveyExampleNo = _this.find(".dev-input-no").val();
                        answerList.push(answer);
                    } else {
                        if($esntlyn == "Y") {
                            $('body').animate({scrollTop : _this.offset().top}, 400);
                            error = "1";
                            return false;
                        }
                    }
                } else if($type == 'SINGLE' || $type == 'SKIP') {
                    answer.surveyExampleNo = _this.find(".dev-input-no:checked").val();
                    if(answer.surveyExampleNo) {
                        answerList.push(answer);
                    } else {
                        if($esntlyn == "Y") {
                            $('body').animate({scrollTop : _this.offset().top}, 400);
                            error = "1";
                            return false;
                        }
                    }
                } else if($type == 'MULTI') {
                    var checkList = _this.find(".dev-input-no:checked");
                    if(checkList.length > 0) {
                        checkList.each(function() {
                            var answerClone =  $.extend(true, {}, answer); //Depp Copy
                            answerClone.surveyExampleNo = $(this).val();
                            answerList.push(answerClone);
                        });
                    } else {
                        if($esntlyn == "Y") {
                            $('body').animate({scrollTop : _this.offset().top}, 400);
                            error = "1";
                            return false;
                        }
                    }
                }
            });

            if(error) {
                if(error == "1") {
                    alert("필수 질문에 답변 후 참여하기를 눌러주세요.");
                }

                return false;
            }

            var data = JSON.stringify(answerList);

            if(isSubmit) {
                isSubmit = false;
                $.ajax({
                    url: "/srv/surveyAnswer.do",
                    data: data,
                    dataType: 'json',
                    contentType: 'application/json',
                    type: "POST",
                    cache:false,
                    success: function (data) {
                        if (data.result) {
                            alert("설문을 등록하였습니다.. 리스트로 이동합니다.");
                            location.href="/srv/list.do"
                        } else {
                            alert("등록에 실패하였습니다.");
                            isSubmit = true;
                        }
                    },
                    error: function (error) {
                        isSubmit = true;
                        alert("설문 등록중 중 에러가 발생하였습니다.");
                    },
                    complete: function () {
                        isSubmit = true;
                    }
                });
            }
        });

        $(".dev-update").on("click", function(e) {
            location.href="/srv/surveyUpdate.do?surveyNo=${detail.surveyNo}"
        })

        /*if(${isAnswer}) {
            if('${detail.registerId}' != '${user.sid}') {
                alert("이미 참여한 설문입니다.");
                location.href="/srv/list.do"
            }
        }*/

    });

    function goPage() {
        var form = $("form[name=searchForm]");
        form.attr('action', '/srv/list.do');
        form.submit();
    }

</script>