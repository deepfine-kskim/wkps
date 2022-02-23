<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" 	uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container sub_cont">
    <div id="contents">
        <div class="page-header">
            <h2>
                설문조사 </h2>
        </div>
        <!-- //page-header -->

        <div class="page-body" style="overflow-y: auto; height: 800px;">
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
                                    class="data">0</span></span>
                            <span class="info_txt name">작성자 : <span class="data">${detail.registerId}</span></span>
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
                </div>
            </div>
            <!-- //brd_view_area -->
            <script src="<c:url value='/js/egovframework/com/wkp/audioplayer.js'/>"></script>
            <script src="<c:url value='/js/egovframework/com/wkp/jquery.magnific-popup.min.js'/>"></script>

        </div>
        <!-- //page-body -->


    </div>
    <!-- //CONTENTS -->

</div>
<script>

    $(document).ready(function () {
        $(".dev-skip").each(function() {
            $(".dev-panel-" + $(this).data("skipno")).hide();
        });

        $(".dev-input-skip").on("click", function() {
            var parent = $(this).closest(".panel-default");
            var skipChild = parent.find(".dev-skip");

            skipChild.each(function() {
                $(".dev-panel-" + $(this).data("skipno")).hide();
            });

            $(".dev-panel-" + $(this).closest(".dev-skip").data("skipno")).show();

        });

        $('audio').audioPlayer();
    });
</script>