<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>

<footer id="footer">
    <div class="container">
        <div class="row type5">
            <%--<div class="col-md-2 foot_brand">
                <strong class="logo"><img src="/images/egovframework/com/wkp/logo_foot.png" alt="지식포털" /></strong>
            </div>--%>
            <div class="col-md-10 foot_cont">
                <div class="row">
                    <div class="col-md-10">
                        <div class="foot_info">
                            <em>경기도 수원시 영통구 도청로 30</em><span class="bar">/</span>
                            <em>북부청사 11780 의정부시 청사로 1</em><span class="bar">/</span>
                            <em>정보기획담당관(031-8008-3852)</em>
                            <p class="copy"><span class="hidden-xs">COPYRIGHT</span>&copy; GYEONGGI PROVINCE All Rights Reserved.</p>
                        </div>
                    </div>
                    <!-- <div class="col-md-3 foot_logos">
                        <img src="/images/egovframework/com/wkp/wa_mark.png" alt="WA인증마크" />
                    </div>  -->
                </div>
            </div>
        </div>
    </div>
    <a id="scrollTopBtn" href="#header" title="맨위로 이동"><i class="fa fa-angle-up"></i><span class="sr-only">TOP</span></a>
    <a id="scrollBottomBtn" href="#footer" title="맨아래로 이동"><i class="fa fa-angle-down"></i><span class="sr-only">BOTTOM</span></a>
</footer>

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
                                    <input type="text" id="orgText" name="orgText" class="form-control flow-enter-search" placeholder="부서 검색(2글자 이상)" data-search-button="orgBtn">
                                    <span class="input-group-btn"><a href="javascript:;" id="orgBtn" class="btn btn-default">검색</a></span>
                                </div>
                            </fieldset>
                        </div>
                        <div class="hummingbird-treeview well chk_tree_area">
                            <%--<div class="checkbox">
                                <label for="allChk1"><input type="checkbox" id="allChk1" class="all_chk" /> 전체선택</label>
                            </div>--%>
                            <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
                            <ul id="orgList" class="chk_tree_list hummingbird-base treeview">
                                <c:forEach var="top" items="${topList}" varStatus="topStatus">
                                    <li>
                                        <i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1}"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1}" value="${top.ouCode}" data-id="customChk-${topStatus.index+1}" data-name="${top.ou}" />${top.ou}</label>
                                        <ul>
                                            <c:forEach var="parent" items="${top.nextDepthList}" varStatus="parentStatus">
                                                    <li>
                                                        <i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1}-${parentStatus.index+1}"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1}-${parentStatus.index+1}" value="${parent.ouCode}"data-id="customChk-${topStatus.index+1}-${parentStatus.index+1}" data-name="${parent.ou}" />${parent.ou}</label>
                                                        <ul class="not_depth_list">
                                                            <c:forEach var="child" items="${parent.nextDepthList}" varStatus="childStatus">
                                                                    <li>
                                                                        <i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1}-${parentStatus.index+1}-${childStatus.index+1}"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1}-${parentStatus.index+1}-${childStatus.index+1}" value="${child.ouCode}" data-id="customChk-${topStatus.index+1}-${parentStatus.index+1}-${childStatus.index+1}" data-name="${child.ou}" />${child.ou}</label>
                                                                    </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </li>
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
                                    <input type="text" id="userText" name="userText" class="form-control flow-enter-search" placeholder="이름 검색(2글자 이상)" data-search-button="userBtn">
                                    <span class="input-group-btn"><a href="javascript:;" id="userBtn" class="btn btn-default">검색</a></span>
                                </div>
                            </fieldset>
                        </div>
                        <div class="hummingbird-treeview well chk_tree_area">
                            <%--<div class="checkbox">
                                <label for="allSrchChk"><input type="checkbox" id="allSrchChk" class="all_chk" /> 전체선택</label>
                            </div>--%>
                            <ul id="userList" class="chk_tree_list hummingbird-base treeview">
                                <c:forEach var="top" items="${topList}" varStatus="topStatus">
                                    <li class="flow-action-userList">
                                        <i class="fa fa-plus"></i> <label for="allSrchChk-${topStatus.index}"><input type="checkbox" id="allSrchChk-${topStatus.index}" class="flow-action-checkUserList" />${top.ou}</label>
                                        <ul class="flow-user-list" data-ou-code="${top.ouCode}">
                                            <c:forEach var="parent" items="${top.nextDepthList}" varStatus="parentStatus">
                                                    <li>
                                                        <i class="fa fa-plus" data-code="${parent.ouCode}"></i> <label for="allSrchChk-${topStatus.index}-${parentStatus.index}"><input type="checkbox" id="allSrchChk-${topStatus.index}-${parentStatus.index}" />${parent.ou}</label>
                                                        <ul class="not_depth_list flow-user-list" data-ou-code="${parent.ouCode}">
                                                            <c:forEach var="child" items="${parent.nextDepthList}" varStatus="childStatus">
                                                                    <li>
                                                                        <i class="fa fa-plus"></i> <label for="allSrchChk-${topStatus.index}-${parentStatus.index}-${childStatus.index}"><input type="checkbox" id="allSrchChk-${topStatus.index}-${parentStatus.index}-${childStatus.index}" />${child.ou}</label>
                                                                        <ul class="flow-user-list" data-ou-code="${child.ouCode}">
                                                                        </ul>
                                                                    </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div id="selectGrpTab3" class="tab-pane" role="tabpanel">
                        <c:choose>
                            <c:when test="${not empty groupList}">
                                <div class="hummingbird-treeview well chk_tree_area">
                                    <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
                                    <%--<div class="checkbox">
                                        <label for="allSrchGrp"><input type="checkbox" id="allSrchGrp" class="all_chk" /> 전체선택</label>
                                    </div>--%>
                                    <ul id="grpList" class="chk_tree_list hummingbird-base treeview">
                                        <c:forEach var="group" items="${groupList}" varStatus="status">
                                            <li><label for="allSrchGrp-${status.index}"><input id="allSrchGrp-${status.index}" name="groupList" data-id="allSrchGrp-${status.index}" type="checkbox" value="${group.groupNo}" data-name="${group.groupNm}">${group.groupNm}</label></li>
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

<script type="text/javascript">
    $(document).ready(function () {
        const orgModal = {
            init: function () {
                this.$wrap = $('#selectGrpPopup');
                this.bind.init();
            },
            bind: {
                init: function () {
                    /* 모달 활성화 */
                    orgModal.$wrap.off('show.bs.modal').on('show.bs.modal', orgModal.bind.action.open);

                    /* 부서/개인/그룹 탭 이동 시 검색결과 초기화 */
                    orgModal.$wrap.off('shown.bs.tab').on('shown.bs.tab', orgModal.bind.action.clear);

                    /* 부서 검색 */
                    orgModal.$wrap.find('#orgBtn').off('click').on('click', function (e) {
                        $('.chk_tree_area').mCustomScrollbar('scrollTo', 'top', { scrollInertia: 0 });
                        orgModal.bind.action.searchOrg();
                    });

                    /* 개인 검색 */
                    orgModal.$wrap.find('#userBtn').off('click').on('click', function (e) {
                        $('.chk_tree_area').mCustomScrollbar('scrollTo', 'top', { scrollInertia: 0 });
                        orgModal.bind.action.searchUser();
                    });

                    /* 최상위 부서의 확장 버튼 클릭 */
                    orgModal.$wrap.find('.flow-action-userList').off('click').on('click', orgModal.bind.action.userList);

                    /* 최상위 부서의 체크박스 선택 */
                    orgModal.$wrap.find('.flow-action-checkUserList').off('click').on('click', orgModal.bind.action.checkUserList);

                    /* 확인 */
                    orgModal.$wrap.find('#rlsChk').off('click').on('click', orgModal.bind.action.confirm);

                    $('#rlsList').off('click', '.flow-action-remove').on('click', '.flow-action-remove', function () {
                        const name = $(this).siblings('input[type="hidden"]').attr('name');
                        const value = $(this).siblings('input[type="hidden"]').val();
                        $('ul#' + name).find('input[value="' + value + '"]').prop('checked', false);
                    });
                },
                action: {
                    open: function () {
                        orgModal.bind.action.clear();
                        $('#rlsList').find('input[type="hidden"]').each(function (i, item) {
                            const name = $(item).attr('name');
                            const value = $(item).val();
                            $('ul#' + name).find('input[value="' + value + '"]').prop('checked', true);
                        });
                    },
                    clear: function () {
                        orgModal.$wrap
                            .find('input[type="text"]').val('').end()
                            .find('.flow-search-list').remove().end()
                            .find('.ti-minus').click();
                    },
                    searchOrg: function () {
                        const ou = $("input[name=orgText]").val();

                        if ($.trim(ou) === '') {
                            alert("부서를 입력해주세요.");
                            return false;
                        }

                        $.ajax({
                            url: '/org/orgList.do',
                            data: {
                                ou: ou
                            },
                            dataType: "json",
                            success: function (data) {
                                $('#orgList li.flow-search-list').remove();
                                $('#orgList').prepend('<li class="flow-search-list">---------------------------------------------------------------------------------</li>');
                                if (data.orgList.length > 0) {
                                    for (let i = 0; i < data.orgList.length; i++) {
                                        $('#orgList').prepend('<li class="flow-search-list"><label for="chk-' + i + '"><input id="chk-' + i + '" name="orgList" data-id="customChk-' + i + '" type="checkbox" value="' + data.orgList[i].ouCode + '" data-name="' + data.orgList[i].ou + '">' + data.orgList[i].ou + '</label></li>');
                                    }
                                } else {
                                    $('#orgList').prepend('<li class="flow-search-list">검색 결과가 없습니다.</li>');
                                }
                            },
                            error: function () {
                                alert('처리 중 오류가 발생했습니다. 관리자에게 문의해주세요.');
                            }
                        });
                    },
                    searchUser: function () {
                        const displayName = $("input[name=userText]").val();

                        if ($.trim(displayName) === '') {
                            alert("이름을 입력해주세요.");
                            return false;
                        }

                        $.ajax({
                            url: '/usr/userList.do',
                            data: {
                                displayName: displayName
                            },
                            dataType: "json",
                            success: function (data) {
                                $('#userList li.flow-search-list').remove();
                                $('#userList').prepend('<li class="flow-search-list">---------------------------------------------------------------------------</li>');
                                if (data.userList.length > 0) {
                                    for (let i = 0; i < data.userList.length; i++) {
                                        $('#userList').prepend('<li class="flow-search-list"><label for="allSrchChk-' + i + '"><input id="allSrchChk-' + i + '" name="userList" data-id="allSrchChk-' + i + '" type="checkbox" value="' + data.userList[i].sid + '" data-name="' + data.userList[i].displayName + '" data-ou="' + data.userList[i].ou + '">' + data.userList[i].ou + ' ' + data.userList[i].displayName + '</label></li>');
                                    }
                                } else {
                                    $('#userList').prepend('<li class="flow-search-list">검색 결과가 없습니다.</li>');
                                }
                            },
                            error: function () {
                                alert('처리 중 오류가 발생했습니다. 관리자에게 문의해주세요.');
                            }
                        });
                    },
                    userList: function () {
                        const $li = $(this);
                        const $ouList = {};
                        const ouCodeList = [];

                        // 선택한 부서와 그 하위 부서들의 데이터 저장
                        $li.find('.flow-user-list').each(function (i, item) {
                            const $ul = $(item);
                            const ouCode = $ul.data('ou-code');
                            ouCodeList.push(ouCode);
                            $ouList[ouCode] = {
                                ul: $ul,
                                li: ''
                            };
                        });

                        // 부서마다 한번만 조회
                        if (!$li.hasClass('flow-search-end')) {
                            $.ajax({
                                url: '/usr/userListByOuCode.do',
                                method: 'post',
                                data: JSON.stringify({
                                    ouCodeList: ouCodeList
                                }),
                                contentType: 'application/json',
                                dataType: 'json',
                                async: false,
                                success: function (data) {
                                    data.forEach(function (item, i) {
                                        const id = item.ouCode + '-' + i;
                                        $ouList[item.ouCode].li += '<li>'
                                        $ouList[item.ouCode].li += '  <label for="' + id + '">'
                                        $ouList[item.ouCode].li += '    <input id="' + id + '" name="userList" data-id="' + id + '" type="checkbox" value="' + item.sid + '" data-name="' + item.displayName + '" data-ou="' + item.ou + '">' + item.ou + ' ' + item.displayName
                                        $ouList[item.ouCode].li += '  </label>'
                                        $ouList[item.ouCode].li += '</li>'
                                    });

                                    for (let ouCode in $ouList) {
                                        $ouList[ouCode].ul.prepend($ouList[ouCode].li);
                                    }

                                    $li.addClass('flow-search-end');
                                },
                                error: function () {
                                    alert('처리 중 오류가 발생했습니다. 관리자에게 문의해주세요.');
                                }
                            });
                        }
                    },
                    checkUserList: function () {
                        const $checkbox = $(this);
                        const $li = $checkbox.closest('li');
                        const isChecked = $checkbox.is(':checked');

                        if (!$li.hasClass('flow-search-end')) {
                            $li.click();
                        }

                        $li.find('input[type="checkbox"]').prop('checked', isChecked);
                    },
                    confirm: function () {
                        $('#rlsList').empty();

                        // 체크된 부서 항목
                        const orgList = [];
                        $('input:checkbox[name="orgList"]').each(function (e) {
                            if (this.checked) {
                                const ouCode = $(this).val();
                                if (orgList.indexOf(ouCode) === -1) {
                                    orgList.push(ouCode);
                                    $('#rlsList').append('<span id="orgName" class="tag_btn label label-default">' + $(this).data('name') + '<i class="remove flow-action-remove" data-target="' + $(this).attr('id') + '">x</i><span class="sr-only">삭제</span><input type="hidden" name="orgList" value="' + ouCode + '"></span>');
                                }
                            }
                        });

                        // 체크된 개인 항목
                        const userList = [];
                        $('input:checkbox[name="userList"]').each(function (e) {
                            if (this.checked) {
                                const sid = $(this).val();
                                if (userList.indexOf(sid) === -1) {
                                    userList.push(sid);
                                    $('#rlsList').append('<span id="usersName" class="tag_btn label label-default">' + $(this).data('ou') + ' ' + $(this).data('name') + '<i class="remove flow-action-remove" data-target="' + $(this).attr('id') + '">x</i><span class="sr-only">삭제</span><input type="hidden" name="userList" value="' + sid + '"></span>');
                                }
                            }
                        });

                        // 체크된 그룹 항목
                        const groupList = [];
                        $('input:checkbox[name="groupList"]').each(function (e) {
                            if (this.checked) {
                                const groupNo = $(this).val();
                                if (groupList.indexOf(groupNo) === -1) {
                                    groupList.push(groupNo);
                                    $('#rlsList').append('<span id="groupName" class="tag_btn label label-default">' + $(this).data('name') + '<i class="remove flow-action-remove" data-value="' + $(this).attr('id') + '">x</i><span class="sr-only">삭제</span><input type="hidden" name="groupList" value="' + groupNo + '"></span>');
                                }
                            }
                        });
                    }
                }
            }
        };

        orgModal.init();
    });
</script>