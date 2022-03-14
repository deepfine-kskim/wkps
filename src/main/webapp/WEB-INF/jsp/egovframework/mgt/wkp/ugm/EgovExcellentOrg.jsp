<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="cont_wrap">
    <div class="cont_header">
        <div class="row">
            <div class="col-xs-6">
                <h2 class="page_title">우수 부서</h2>
            </div>
            <div class="col-xs-6 text-right">
                <p class="msg"><strong class="text-primary">${loginVO.displayName}</strong>님! 반갑습니다.</p>
                <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
            </div>
        </div>
    </div>
    <!-- //cont_header -->
    <div class="cont_body">
        <ol class="breadcrumb">
            <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
            <li>사용자 관리</li>
            <li class="active">우수 부서</li>
        </ol>
        <div id="contents">
            <!-- //총게시물, 게시물 검색 -->
            <table class="table table-bordered text-center table-hover">
                <caption class="sr-only">게시판 리스트</caption>
                <colgroup>
                    <col style="width:10%;" />
                    <col />
                    <col style="width:20%;" />
                    <col style="width:10%;" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">순위</th>
                        <th scope="col">부서</th>
                        <th scope="col">마일리지</th>
                        <th scope="col">삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="excellenceOrg" items="${excellenceOrgList}">
                        <tr>
                            <td>${excellenceOrg.rki}</td>
                            <td>${excellenceOrg.ou}</td>
                            <td>${excellenceOrg.mileageScore}</td>
                            <td><a href="/adm/deleteExcellentOrg.do?ouCode=${excellenceOrg.ouCode}&rki=${excellenceOrg.rki}" class="btn btn-default" onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="btn_area text-right">
                <a href="#newRegPopup" class="btn btn-blue min-lg btn-lg" data-toggle="modal" data-target="#newRegPopup">등록</a>
            </div>
        </div>
        <!-- //CONTENTS -->

        <div id="newRegPopup" class="modal fade" role="dialog" aria-labelledby="newRegPopupLabel">
            <div class="modal-dialog" role="document">
                <form:form class="modal-content form-horizontal" action="/adm/insertExcellentOrg.do" modelAttribute="excellenceOrgVO">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <div class="h4 modal-title" id="newRegPopupLabel">등록</div>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">순위</label>
                            <div class="col-sm-6">
                                <form:select path="rki" class="form-control">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="mbSrch" class="col-sm-2 control-label">부서명</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" id="mbSrch" name="ou" class="form-control flow-enter-search" placeholder="부서명 검색(2글자 이상 입력)" data-search-button="srchBtn" />
                                    <span class="input-group-btn"><button type="button" id="srchBtn" class="btn btn-default">검색</button></span>
                                </div>
                                <p class="help-block"><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 등록할 부서명을 검색 후 등록해 주세요.</p>
                                <!-- 검색결과 -->
                                <div class="result_area">
                                    <table class="table table-condensed text-center table-bordered table-hover all_chks_frm">
                                        <caption class="sr-only">부서 목록</caption>
                                        <colgroup>
                                            <col style="width:10%;">
                                            <col>
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th scope="col">선택</th>
                                            <th scope="col">부서</th>
                                        </tr>
                                        </thead>
                                        <tbody id="orgList">
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer text-center">
                        <button type="button" class="btn btn-primary min-md flow-action-save">확인</button>
                        <button type="button" class="btn btn-default min-md" data-dismiss="modal">취소</button>
                    </div>
                </form:form>
            </div>
        </div>
        <!-- //팝업 영역 종료 -->
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
        let errMsg = '${errMsg}';
        if (errMsg != '') {
            alert(errMsg);
        }

        /* 우수 부서 등록 */
        $('.flow-action-save').off('click').on('click', function () {
            if ($('#orgList').find('[name=ouCode]:checked').length === 0) {
                alert('부서를 선택해주세요.');
                return false;
            }
            $('#excellenceOrgVO').submit();
        });

        /* 부서 조회 */
        $("#srchBtn").click(function () {
            const mbSrch = $('#mbSrch').val();

            if ($.trim(mbSrch).length < 2) {
                alert('2글자 이상 입력해주세요.');
                return false;
            }

            $.ajax({
                url: '/org/orgList.do',
                data: {
                    ou: mbSrch
                },
                dataType: 'json',
                success: function (data) {
                    let html = '';
                    for (let i = 0; i < data.orgList.length; i++) {
                        html += '<tr>';
                        html += '    <td><label for="brdChk' + i + '"><input type="radio" id="brdChk' + i + '" name="ouCode" value="' + data.orgList[i].ouCode + '"  required="required"/></label></td>';
                        html += '    <td>' + data.orgList[i].ou + '</td>';
                        html += '</tr>';
                    }
                    $('#orgList').html(html);
                },
                error: function () {

                }
            });
        });
    });
</script>