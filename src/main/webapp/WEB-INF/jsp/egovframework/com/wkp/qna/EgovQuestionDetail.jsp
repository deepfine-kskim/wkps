<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld" %>

<% pageContext.setAttribute("replaceChar", "\n"); %>
<div class="container sub_cont">
	<div id="contents">
	    <div class="page-header">
	        <h2>Q&A</h2>
	    </div>
	    <!-- //page-header -->
        <div class="page-body">
            <div class="brd_view_area q_type">
                <div class="view_header">
                    <strong class="subject"><span class="qna_ico">Q</span>${detail.title}</strong>
                    <div class="row type0 info_view">
                        <div class="col-xs-12 col-sm-4">
                            <span>작성일 : </span><span class="data"><fmt:formatDate value="${detail.registDtm}"
                                                                                  pattern="yyyy-MM-dd"/></span>
                        </div>
                        <div class="col-xs-12 col-sm-8 info_txts">
                            <span class="info_txt">답변수 :
                                <span class="data">
                                <c:choose>
                                    <c:when test="${detail.answerList != null}">
                                        ${fn:length(detail.answerList)}
                                    </c:when>
                                    <c:otherwise>
                                        0
                                    </c:otherwise>
                                </c:choose>
                                </span>
                            </span>
                            <span class="info_txt name">작성자 : <span class="data">${detail.registerName}</span></span>
                        </div>
                    </div>
                </div>
                <div class="view_body">
                    ${detail.cont}
                </div>
                <c:if test="${detail.atchFileNo != null && detail.atchFileNo > 0}">
                <div class="info_grp files">
                    <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${detail.atchFileNo }&fileSn=${detail.fileSn }" class="text-danger">${detail.orignlFileNm}</a> (${cutil:out(detail.fileSize)}) 
                    <a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${file.fileStreCours }${file.streFileNm }" data-fid="QNA_${detail.questionNo }">미리보기</a></p>
                </div>
                </c:if>
            </div>
            <!-- //brd_view_area -->
            <div class="text-right mb_15 dev-answer-write">
                <c:set var="isSlctnYn" value="N" />
                <a href="#answerBox" class="btn btn-primary collapsed" data-toggle="collapse" aria-expanded="false"
                   aria-controls="answerBox">답변하기</a>
            </div>
            <div class="collapse" id="answerBox">
                <div class="form-horizontal">
                    <div class="well frm_well">
                        <form id="answerForm">
                            <input type="hidden" name="questionNo" value="${detail.questionNo}">
                            <div class="form-group">
                                <label for="inpMemo" class="sr-only control-label">답변</label>
                                <div class="col-sm-12">
                                <textarea class="form-control" rows="4" id="inpMemo" name="cont"
                                          required="required" placeholder="답변을 입력해 주세요."></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inpFile1" class="sr-only control-label">첨부파일</label>
                                <div class="col-sm-12">
                                    <input type="file" class="form-control" id="inpFile1" name="file">
                                </div>
                            </div>
                        </form>
                        <hr/>
                        <div class="text-center">
                            <button type="button" class="btn btn-blue dev-answer">확인</button>
                            <button type="button" class="btn btn-black" data-toggle="collapse"
                                    data-target="#answerBox" aria-expanded="false" aria-controls="answerBox">취소
                            </button>
                        </div>
                    </div>
                    <!-- well -->
                </div>
            </div>
            <!-- //answerBox -->
            <!-- 채택 답변에 selection 클래스 추가 -->
            <c:set var="selection" value="N"/>
            <c:if test="${detail.answerList != null}">
                <c:forEach var="answerItem" items="${detail.answerList}">
                    <div class="brd_view_area a_type <c:if test="${answerItem.slctnYn == 'Y'}">selection <c:set var="selection" value="Y"/></c:if>">
                        <div class="view_header">
                            <strong class="subject"><span class="qna_ico">A</span>
                                <c:if test="${answerItem.slctnYn == 'Y'}">
                                    <c:set var="isSlctnYn" value="${answerItem.slctnYn}"/>
                                    <span class="label label-danger"><i
                                        class="ti-check"></i> 채택</span></c:if>
                            </strong>
                            <div class="row type0 info_view">
                                <div class="col-xs-12 col-sm-4">
                                    <span>작성일 : </span><span class="data"><fmt:formatDate
                                        value="${answerItem.registDtm}" pattern="yyyy-MM-dd"/></span>
                                </div>
                                <div class="col-xs-12 col-sm-8 info_txts">
                                    <span class="info_txt name">작성자 : <span
                                            class="data">${answerItem.registerName}</span></span>
                                </div>
                            </div>
                        </div>
                        <div class="view_body">
                            <p>${fn:replace(answerItem.cont, replaceChar, "<br/>")}</p>
                        </div>
                        <div class="view_opt_area">
                            <div class="row type5">

                                <div class="col-xs-6">
                                    <c:if test="${selection == 'N' && loginVO.sid eq detail.registerId}">
                                        <button type="button" class="btn btn-danger btn-xs dev-selection"
                                                data-answerno="${answerItem.answerNo}"
                                                data-questionno="${answerItem.questionNo}"><i
                                                class="ti-check-box"></i>채택
                                        </button>
                                    </c:if>
                                </div>

                                <div class="col-xs-6 text-right">
                                    <button type="button"
                                            class="btn btn-primary btn-xs outline like_btn tog_on_btn dev-recommendation <c:if test="${answerItem.mine}">on</c:if>" data-answerno="${answerItem.answerNo}">
                                        <i
                                                class="ti-heart"></i>추천 <span
                                            class="text-danger num dev-recommendation-count">${answerItem.recommendCount}</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <c:if test="${answerItem.atchFileNo != null}">
                        <div class="info_grp files">
                            <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${answerItem.atchFileNo }&fileSn=${answerItem.fileSn }" class="text-danger">${answerItem.orignlFileNm}</a> (${cutil:out(answerItem.fileSize)})</p>
                        </div>
                        </c:if>
                    </div>
                </c:forEach>
            </c:if>

            <!-- //brd_view_area -->
            <!-- 이전/다음 -->
            <form name="searchForm">
                <input type="hidden" name="type" value="${type.name()}">
                <input type="hidden" name="page" value="${page}">
                <input type="hidden" name="searchText" value="${searchText}"/>
                <input type="hidden" name="searchKey" value="${searchKey}"/>
                <input type="hidden" name="questionNo"/>
            </form>
            <ul class="list-group post_nav">
                <li class="list-group-item">
                    <c:choose>
                        <c:when test="${detailPre != null}">
                            <a href="javascript:;" class="dev-pre" data-questionno="${detailPre.questionNo}">
                                <strong>
                                    <i class="fa fa-chevron-circle-left" aria-hidden="true"></i>
                                    이전글</strong>
                                : ${detailPre.title}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:;">
                                <strong>
                                    <i class="fa fa-chevron-circle-left" aria-hidden="true"></i>
                                    이전글</strong>
                                : 이전 글이 없습니다.
                            </a>
                        </c:otherwise>
                    </c:choose>

                </li>
                <li class="list-group-item">
                    <c:choose>
                        <c:when test="${detailNext != null}">
                            <a href="javascript:;" class="dev-next" data-questionno="${detailNext.questionNo}">
                                <strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong>
                                : ${detailNext.title}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:;">
                                <strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong>
                                : 다음 글이 없습니다.
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
            <!-- //이전/다음 -->
            <div class="row brd_foot_btns">
                <c:if test="${detail.registerId == user.sid}">
                    <c:if test="${empty detail.answerList or fn:length(detail.answerList) < 1}">
                        <div class="col-sm-6">
                            <a href="/qna/questionUpdate.do?questionNo=${detail.questionNo}"
                               class="btn btn-black dev-update">수정</a>
                            <a href="#" class="btn btn-danger dev-delete">삭제</a>
                        </div>
                    </c:if>
                </c:if>
                <div class="col-sm-6 text-right">
                    <a href="javascript:;" class="btn btn-black dev-page">목록</a>
                </div>
            </div>
        </div>
        <!-- //page-body -->
     </div>
     <!-- CONTENTS -->
</div>

<script>
    $(function () {
        $(".dev-delete").on("click", function () {
            if (confirm("삭제 하시겠습니까?")) {
                var form = $("form[name=searchForm]");
                form.attr("action", "/qna/questionDelete.do");
                form.attr("method", "post");
                form.find("input[name=questionNo]").val('${detail.questionNo}');
                form.submit();
            }
        });

        $(".dev-next").on("click", function () {
            var form = $("form[name=searchForm]");
            form.attr("action", "/qna/detail.do");
            form.find("input[name=questionNo]").val($(this).data("questionno"));
            form.submit();
        });

        $(".dev-pre").on("click", function () {
            var form = $("form[name=searchForm]");
            form.attr("action", "/qna/detail.do");
            form.find("input[name=questionNo]").val($(this).data("questionno"));
            form.submit();
        });

        $('.dev-page').on('click', function () {
            goPage();
        });


        var isSubmit = true;
        $(".dev-answer").on("click", function (e) {
            e.preventDefault();

            if ($("#inpMemo").val() == '') {
                alert("답변을 입력해야 합니다.");
                return false;
            }

            var formData = new FormData();
            var form = $("#answerForm");
            formData.append("questionNo", form.find("input[name=questionNo]").val());
	        formData.append("cont", $("#inpMemo").val());
            formData.append("file", form.find("input[name=file]")[0].files[0]);

            if (isSubmit) {
                isSubmit = false;
                $.ajax({
                    url: "/qna/answerWriteProc.do",
                    data: formData,
                    enctype: 'multipart/form-data',
                    dataType: 'json',
                    processData: false,
                    contentType: false,
                    cache: false,
                    type: "POST",
                    timeout: 600000,
                    success: function (data) {
                        if (data.result) {
                            location.reload();
                        } else {
                            alert("답변 등록을 실패하였습니다.");
                            isSubmit = true;
                        }
                    },
                    error: function (error) {
                        alert("답변을 다는 중에 에러가 발생하였습니다.");
                        isSubmit = true;
                    },
                    complete: function () {
                        isSubmit = true;
                    }
                });
            }

        });

        $(".dev-selection").on("click", function (e) {
            e.preventDefault();

            var data = {
                "answerNo": $(this).data("answerno")
                , "questionNo": $(this).data("questionno")
            }

            if (confirm("해당 답변을 채택 하시겠습니까? 이후 수정은 불가능합니다.")) {
                if (isSubmit) {
                    isSubmit = false;
                    $.ajax({
                        url: "/qna/updateAnswerSelection.do",
                        data: data,
                        dataType: 'json',
                        type: "POST",
                        success: function (data) {
                            if (data.result) {
                                location.reload();
                            } else {
                                alert("채택에 실패하였습니다.");
                                location.reload();
                            }
                        },
                        error: function (error) {
                            isSubmit = true;
                            alert("답변 채택 중 에러가 발생하였습니다.");
                        },
                        complete: function () {
                            isSubmit = true;
                        }
                    });
                }
            }
        });

        $(".dev-recommendation").on("click", function (e) {
            //e.preventDefault();

            var _this = $(this);
            var data = {
                "answerNo": _this.data("answerno")
            }

            if (isSubmit) {
                isSubmit = false;
                $.ajax({
                    url: "/qna/toggleAnswerRecommend.do",
                    data: data,
                    dataType: 'json',
                    type: "POST",
                    success: function (data) {
                        if (data.result) {
                            if (data.mine) {
                                _this.addClass("on");
                            } else {
                                _this.removeClass("on");
                            }
                            _this.children(".dev-recommendation-count").html(data.count);

                        } else {
                            alert("추천을 실패하였습니다.");
                            location.reload();
                        }
                    },
                    error: function (error) {
                        alert("추천 중 에러가 발생하였습니다.");
                    },
                    complete: function () {
                        isSubmit = true;
                    }
                });
            }

        });

    });

    if('${isSlctnYn}' == 'Y') {
        $(".dev-answer-write").hide();
    }

    function goPage() {
        var form = $("form[name=searchForm]");
        form.attr('action', '/qna/list.do');
        form.submit();
    }
</script>