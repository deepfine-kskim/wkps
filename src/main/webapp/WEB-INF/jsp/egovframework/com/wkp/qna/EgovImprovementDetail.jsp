<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cutil" uri="/WEB-INF/tlds/CommonUtil.tld" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<div class="container sub_cont">
	<div id="contents">
	    <div class="page-header">
	        <h2>개선의견</h2>
	    </div>
	    <!-- //page-header -->
        <div class="page-body">
            <div class="brd_view_area q_type">
                <div class="view_header">
                    <strong class="subject"><c:out value="${result.title}"/></strong>
                    <div class="row type0 info_view">
                        <div class="col-xs-12 col-sm-4">
                            <span>작성일 : </span><span class="data"><fmt:formatDate value="${result.registDtm}" pattern="yyyy-MM-dd"/></span>
                        </div>
                        <div class="col-xs-12 col-sm-8 info_txts">
                            <span class="info_txt name">작성자 : <span class="data"><c:out value="${result.displayName}"/></span></span>
                        </div>
                    </div>
                </div>
                <div class="view_body">
                    ${result.cont}
                </div>
                <%--<c:if test="${result.atchFileNo != null && result.atchFileNo > 0}">
                    <div class="info_grp files">
                        <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${result.atchFileNo }&fileSn=${result.fileSn }" class="text-danger">${result.orignlFileNm}</a> (<c:out value="${cutil:out(result.fileSize)}"/>)
                        <a href="javascript:;" class="btn btn-xs btn-default outline preview" data-url="http://105.0.1.229${file.fileStreCours}${file.streFileNm}" data-fid="QNA_${result.questionNo}">미리보기</a></p>
                    </div>
                </c:if>--%>
            </div>
            <!-- //brd_view_area -->
            <div class="text-right mb_15 dev-answer-write">
                <%-- 관리자만 답변 허용, 답변은 1개만 등록 가능 --%>
                <c:if test="${loginVO.roleCd eq 'ROLE_ADMIN'}">
                    <c:if test="${fn:length(answerList) eq 0}">
                        <a href="#answerBox" class="btn btn-primary collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="answerBox">답변하기</a>
                    </c:if>
                </c:if>
            </div>
            <div class="collapse" id="answerBox">
                <div class="form-horizontal">
                    <div class="well frm_well">
                        <form id="answerForm" name="answerForm">
                            <input type="hidden" name="improvementNo" value="${result.improvementNo}">
                            <div class="form-group">
                                <label for="inpMemo" class="sr-only control-label">답변</label>
                                <div class="col-sm-12">
                                <textarea class="form-control" rows="4" id="inpMemo" name="cont" required="required" placeholder="답변을 입력해 주세요."></textarea>
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
                            <button type="button" class="btn btn-black" data-toggle="collapse" data-target="#answerBox" aria-expanded="false" aria-controls="answerBox">취소
                            </button>
                        </div>
                    </div>
                    <!-- well -->
                </div>
            </div>
            <!-- //answerBox -->
            <!-- 채택 답변에 selection 클래스 추가 -->
            <c:if test="${answerList != null}">
                <c:forEach var="answer" items="${answerList}">
                    <div class="brd_view_area a_type">
                        <div class="view_header">
                            <strong class="subject">관리자 답변</strong>
                            <div class="row type0 info_view">
                                <div class="col-xs-12 col-sm-4">
                                    <span>작성일 : </span><span class="data"><fmt:formatDate value="${answer.registDtm}" pattern="yyyy-MM-dd"/></span>
                                </div>
                                <div class="col-xs-12 col-sm-8 info_txts">
                                    <span class="info_txt name">작성자 : <span class="data"><c:out value="${answer.displayName}"/></span></span>
                                </div>
                            </div>
                        </div>
                        <div class="view_body">
                            <p><c:out value="${fn:replace(answer.cont, replaceChar, '<br/>')}"/></p>
                        </div>
                        <c:if test="${answer.atchFileNo != null}">
                        <div class="info_grp files">
                            <p>첨부파일 : <a href="/cmm/fms/FileDown.do?atchFileNo=${answer.atchFileNo }&fileSn=${answer.fileSn }" class="text-danger">${answer.orignlFileNm}</a> (${cutil:out(answer.fileSize)})</p>
                        </div>
                        </c:if>
                    </div>
                </c:forEach>
            </c:if>

            <!-- //brd_view_area -->
            <!-- 이전/다음 -->
            <form name="searchForm">
                <input type="hidden" name="page" value="${improvementVO.page}">
                <input type="hidden" name="searchText" value="${improvementVO.searchText}"/>
                <input type="hidden" name="searchType" value="${improvementVO.searchType}"/>
                <input type="hidden" name="improvementNo"/>
            </form>
            <ul class="list-group post_nav">
                <li class="list-group-item">
                    <c:choose>
                        <c:when test="${prev != null}">
                            <a href="javascript:;" class="dev-pre" data-improvement-no="${prev.improvementNo}">
                                <strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> 이전글</strong> : ${prev.title}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:;">
                                <strong><i class="fa fa-chevron-circle-left" aria-hidden="true"></i> 이전글</strong> : 이전 글이 없습니다.
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
                <li class="list-group-item">
                    <c:choose>
                        <c:when test="${next != null}">
                            <a href="javascript:;" class="dev-next" data-improvement-no="${next.improvementNo}">
                                <strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : ${next.title}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:;">
                                <strong><i class="fa fa-chevron-circle-right" aria-hidden="true"></i> 다음글</strong> : 다음 글이 없습니다.
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
            <!-- //이전/다음 -->
            <div class="row brd_foot_btns">
                <div class="col-sm-6">
                    <c:if test="${result.registerId eq loginVO.sid}">
                        <c:if test="${fn:length(answerList) eq 0}">
                            <a href="/qna/improvementForm.do?improvementNo=${result.improvementNo}"
                               class="btn btn-black dev-update">수정</a>
                            <a href="#" class="btn btn-danger dev-delete">삭제</a>
                        </c:if>
                    </c:if>
                </div>
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
                const improvementNo = '${result.improvementNo}';

                $.ajax({
                    url: "/qna/improvementRemove.do",
                    type: 'post',
                    data: JSON.stringify({improvementNo: improvementNo}),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (data) {
                        location.href = '/qna/improvementList.do';
                    },
                    error: function (error) {
                        alert('처리 중 오류가 발생했습니다.');
                    }
                });
            }
        });

        $(".dev-next").on("click", function () {
            var form = $("form[name=searchForm]");
            form.attr("action", "/qna/improvementDetail.do");
            form.find("input[name=improvementNo]").val($(this).data("improvement-no"));
            form.submit();
        });

        $(".dev-pre").on("click", function () {
            var form = $("form[name=searchForm]");
            form.attr("action", "/qna/improvementDetail.do");
            form.find("input[name=improvementNo]").val($(this).data("improvement-no"));
            form.submit();
        });

        $('.dev-page').on('click', function () {
            var form = $("form[name=searchForm]");
            form.attr('action', '/qna/improvementList.do');
            form.submit();
        });

        $(".dev-answer").on("click", function (e) {
            e.preventDefault();

            if ($("#inpMemo").val() == '') {
                alert("답변을 입력해야 합니다.");
                return false;
            }

            const formData = new FormData(document.answerForm);

            $.ajax({
                url: "/qna/improvementAnswer.do",
                type: 'post',
                data: formData,
                contentType: false,
                processData: false,
                dataType: 'json',
                enctype: 'multipart/form-data',
                success: function (data) {
                    location.reload();
                },
                error: function (error) {
                    alert('처리 중 오류가 발생했습니다.');
                }
            });
        });
    });
</script>