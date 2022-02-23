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
                    <strong class="subject">설문조사</strong>
                    <div class="row type0 info_view">
                        <div class="col-xs-12 col-sm-4">
                            <span><strong class="text-black">설문기간</strong> : </span><span class="data text-danger">
                                <fmt:formatDate value="${detail.bngnDtm}" pattern="yyyy-MM-dd HH:mm"/>
                                         ~
                                <fmt:formatDate value="${detail.endDtm}" pattern="yyyy-MM-dd HH:mm"/>
                            </span>
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
                <c:forEach var="question" items="${detail.questionList}">
                <div class="panel_list_set result_area">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="panel-title dev-question-title"><strong>${question.orderNo}. ${question.cont}</strong></div>
                        </div>
                        <div class="panel-body">
                            <c:forEach var="example" items="${question.surveyExampleList}">
                                <c:forEach var="item" items="${list}">
                                    <c:if test="${example.surveyExampleNo == item.surveyExampleNo}">
                                    <div class="row type5">
                                        <div class="col-sm-5 dev-example-title" >
                                            <c:choose>
                                                <c:when test="${question.qusTypeCd.name() == 'DESCRIPTION'}">
                                                	서술형 답변
                                                </c:when>
                                                <c:otherwise>
                                                    ${example.orderNo}) ${example.cont}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <c:choose>
                                            <c:when test="${joinCount == 0}">
                                                <c:set var="percent" value="0"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="cnt" value="${item.exCount/ joinCount * 100}"/>
                                                <fmt:formatNumber var="percent" pattern="0.0" value="${cnt }"/>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="col-xs-7 col-sm-5">
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${percent}" aria-valuemin="0" aria-valuemax="100" style="width:${percent}%;"><span class="sr-only">${percent}%</span></div>
                                            </div>
                                        </div>
                                        <div class="col-xs-5 col-sm-2 text-right">
                                            <c:if test="${item.mine}"><span class="my_chk"><i class="fa fa-check-square text-danger"></i><span class="sr-only">나의 선택</span></span></c:if>
                                            <!-- <a href="#resultListPopup" data-toggle="modal" data-target="#resultListPopup" class="num_lnk dev-join-member" data-exampleno="${example.surveyExampleNo}" data-count="${item.exCount}"><strong>${item.exCount}명</strong> (${percent}%)</a> -->
                                            <div class="num_lnk"><strong>${item.exCount}명</strong> (${percent}%)</div>
                                        </div>
                                    </div>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- //panel -->
                </div>
                </c:forEach>
            </div>
            <!-- //brd_view_area -->

            <!-- 참여자 팝업 -->
            <div class="modal fade" id="resultListPopup" tabindex="-1" role="dialog" aria-labelledby="resultListPopupLabel">
                <div class="modal-dialog" role="document">
                    <form class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="resultListPopupLabel"><strong id="popup-question-title">1. 단일선택형 질문</strong> </h4>
                        </div>
                        <div class="modal-body">
                            <div class="well well-sm well-primary">
                                <p class="sel_info text-primary" id="popup-example-title"> 4) 복수선택형 답 영역</p>
                                <span class="text-black">참여자 : 총 <strong id="popup-answer-count">13</strong>명</span>
                            </div>
                            <table class="table text-center table-bordered table-condensed table-primary mb_0">
                                <caption class="sr-only">참여자 목록</caption>
                                <colgroup>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                </colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">번호</th>
                                    <th scope="col">이름</th>
                                    <th scope="col">직급</th>
                                    <th scope="col">부서</th>
                                </tr>
                                </thead>
                                <tbody id="popup-answer-user">
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- //참여자 팝업 -->
            <div class="row type0 brd_foot_btns">
                <div class="col-xs-9">
                    <button type="button" class="btn btn-blue dev-download-excel"><i class="fa fa-file-excel-o" aria-hidden="true"></i>다운로드</button>
                    <c:if test="${detail.registerId == user.sid}">
                        <c:if test="${detail.aprvState.name() eq 'DONE' or detail.aprvState.name() eq 'DOING'}">
                            <a href="#datepickerPopup" data-toggle="modal" data-target="#datepickerPopup" class="btn btn-blue outline">기간연장</a>
                            <button type="button" class="btn btn-danger dev-delete">삭제</button>
                        </c:if>
                    </c:if>
                </div>
                <div class="col-xs-3 text-right">
                    <a href="/srv/list.do" class="btn btn-black">목록</a>
                </div>
            </div>
        </div>
        <!-- //page-body -->

        <!-- 날짜팝업 -->
        <div class="modal fade date_modal" id="datepickerPopup" tabindex="-1" role="dialog" aria-labelledby="datepickerPopupLabel">
            <div class="modal-dialog modal-sm" role="document">
                <form class="modal-content" name="form">
                    <input name="surveyNo" type="hidden">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="datepickerPopupLabel">설문조사 기간 연장</h4>
                    </div>
                    <div class="modal-body">
                        <p class="mb_10"><span class="text-danger">연장하실 날짜</span>를 선택해 주세요.</p>
                        <label for="inpExtDate" class="sr-only">연장날짜</label>
                        <input type="text" id="inpExtDate" name="inpExtDate" class="form-control inp_date datetime"
                               value="<fmt:formatDate value="${detail.endDtm}" pattern="yyyy-MM-dd"/>" />

                        <lable for="inpEndTime" class="sr-only">시간</lable>
                        <input type="text" class="form-control inp_time datetime" id="inpEndTime"
                               name="inpEndTime" placeholder="종료시간" required="required"
                               value="<fmt:formatDate value="${detail.endDtm}" pattern="HH:mm"/>"/>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-blue dev-month-confirm" data-dismiss="modal">확인</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- //날짜팝업 -->



    </div>
    <!-- //CONTENTS -->
</div>

<script>

    $(document).ready(function () {
        $(".dev-delete").on("click", function () {
            if (confirm("삭제 하시겠습니까?")) {
                var form = $("form[name=form]");
                form.attr("action", "/srv/surveyDelete.do");
                form.attr("method", "post");
                form.find("input[name=surveyNo]").val('${detail.surveyNo}');
                form.submit();
            }
        });

        $(".dev-download-excel").on("click", function() {
            var form = $("form[name=form]");
            form.attr("action", "/srv/surveyExcelDownload.do");
            form.attr("method", "post");
            form.find("input[name=surveyNo]").val('${detail.surveyNo}');
            form.submit();
        });

        $(".dev-join-member").on("click", function() {
            var _this = $(this);
            var exampleno = _this.data("exampleno");
            var count = _this.data("count");
            var questionTitle = _this.closest(".panel-default").find(".dev-question-title").text();
            var exampleTitle = _this.closest(".row").find(".dev-example-title").text();

            $("#popup-question-title").text(questionTitle);
            $("#popup-example-title").text(exampleTitle);
            $("#popup-answer-count").text(count);
            $("#popup-answer-user").children().remove();
            var data = {
                "surveyExampleNo" : exampleno
            }

            $.ajax({
                url: "/srv/answerJoinUser.do",
                data: data,
                dataType: 'json',
                type: "POST",
                cache:false,
                success: function (data) {
                    if (data.result) {
                        for(var i=0;data.list.length>i;i++) {
                            var tr = $("<tr></tr>");
                            $("<td></td>").text(i+1).appendTo(tr);
                            $("<td></td>").text(data.list[i].displayName).appendTo(tr);
                            $("<td></td>").text(data.list[i].position).appendTo(tr);
                            $("<td></td>").text(data.list[i].ou).appendTo(tr);
                            $("#popup-answer-user").append(tr);
                        }
                    }
                },
                error: function (error) {
                    alert("데이터를 불러오지 못했습니다.");
                },
                complete: function () {

                }
            });
        });

        var isSubmit = true;
        $(".dev-month-confirm").on("click", function(e) {
            var data = {
                  "endDtm": $("#inpExtDate").val() + " " + $("#inpEndTime").val()
                , "surveyNo": '${detail.surveyNo}'
            }

            if(isSubmit) {
                isSubmit = false;
                $.ajax({
                    url: "/srv/updateSurveyEndDate.do",
                    data: data,
                    dataType: 'json',
                    type: "POST",
                    cache:false,
                    success: function (data) {
                        if (data.result) {
                            alert("날짜 수정을 완료하였습니다.");
                            location.reload();
                        } else {
                            alert("등록에 실파하였습니다.");
                            isSubmit = true;
                        }
                    },
                    error: function (error) {
                        alert("설문 등록중 중 에러가 발생하였습니다.");
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