<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="cont_wrap">
    <div class="cont_header">
        <div class="row">
            <div class="col-xs-6">
                <h2 class="page_title">우수 사용자</h2>
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
            <li class="active">우수 사용자</li>
        </ol>
        <div id="contents">
            <table class="table table-bordered text-center table-hover">
                <caption class="sr-only">게시판 리스트</caption>
                <colgroup>
                    <col style="width:10%;" />
                    <col style="width:15%;" />
                    <col style="width:15%;" />
                    <col />
                    <col style="width:20%;" />
                    <col style="width:10%;" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col">순위</th>
                        <th scope="col">이름</th>
                        <th scope="col">직급</th>
                        <th scope="col">부서</th>
                        <th scope="col">마일리지</th>
                        <th scope="col">삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="excellenceUser" items="${excellenceUserList}">
                        <tr>
                            <td>${excellenceUser.rki}</td>
                            <td>${excellenceUser.displayName}</td>
                            <td>${excellenceUser.position}</td>
                            <td>${excellenceUser.ou}</td>
                            <td>${excellenceUser.mileageScore}</td>
                            <td><a href="/adm/deleteExcellentUser.do?sid=${excellenceUser.sid}&rki=${excellenceUser.rki}" class="btn btn-default" onclick="return confirm('삭제하시겠습니까?');">삭제</a></td>
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
                <form:form class="modal-content form-horizontal" action="/adm/insertExcellentUser.do" modelAttribute="excellenceUserVO">
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
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </form:select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="mbSrch" class="col-sm-2 control-label">이름</label>
                            <div class="col-sm-10">
                                <div class="input-group">
                                    <input type="text" id="mbSrch" name="userName" class="form-control flow-enter-search" placeholder="이름 검색(2글자 이상 입력)" autocomplete="off" data-search-button="srchBtn" />
                                    <span class="input-group-btn"><button type="button" id="srchBtn" class="btn btn-default">검색</button></span>
                                </div>
                                <p class="help-block"><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 등록할 사용자의 이름을 검색 후 등록해 주세요.</p>
                                <!-- 검색결과 -->
                                <div class="result_area">
                                    <table class="table table-condensed text-center table-bordered table-hover all_chks_frm">
                                        <caption class="sr-only">사용자 목록</caption>
                                        <colgroup>
                                            <col style="width:10%;">
                                            <col>
                                            <col>
                                            <col>
                                        </colgroup>
                                        <thead>
                                        <tr>
                                            <th scope="col">선택</th>
                                            <th scope="col">이름</th>
                                            <th scope="col">직급</th>
                                            <th scope="col">부서</th>
                                        </tr>
                                        </thead>
                                        <tbody id="userList">
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

        /* 우수 사용자 등록 */
        $('.flow-action-save').off('click').on('click', function () {
            if ($('#userList').find('[name=sid]:checked').length === 0) {
                alert('사용자를 선택해주세요.');
                return false;
            }
            $('#excellenceUserVO').submit();
        });

        /* 사용자 조회 */
        $("#srchBtn").click(function () {
            const mbSrch = $('#mbSrch').val();

            if ($.trim(mbSrch).length < 2) {
                alert('2글자 이상 입력해주세요.');
                return false;
            }

            $.ajax({
                url: '/usr/userList.do',
                data: {
                    displayName: mbSrch
                },
                dataType: 'json',
                success: function (data) {
                    let html = '';
                    for (let i = 0; i < data.userList.length; i++) {
                        html += '<tr>';
                        html += '    <td><label for="brdChk' + i + '"><input type="radio" id="brdChk' + i + '" name="sid" value="' + data.userList[i].sid + '" required/></label></td>';
                        html += '    <td>' + data.userList[i].displayName + '</td>';
                        html += '    <td>' + data.userList[i].position + '</td>';
                        html += '    <td>' + data.userList[i].ou + '</td>';
                        html += '</tr>';
                    }
                    $('#userList').html(html);
                },
                error: function () {

                }
            });
        });
	});
</script>