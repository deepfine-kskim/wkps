<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">메뉴 관리</h2>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="msg"><strong class="text-primary">${loginVO.displayName }</strong>님! 반갑습니다.</p>
                        <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
                    </div>
                </div>
            </div>
            <!-- //cont_header -->
            <div class="cont_body">
                <ol class="breadcrumb">
                    <li><a href="#"><i class="glyphicon glyphicon-home"></i> HOME</a></li>
                    <li class="active">메뉴 관리</li>
                </ol>
                <div id="contents">
                    <div class="wid-lg">
                        <div class="well well-primary">
                            <p><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 메뉴 순서 변경시 드래그해서 순서를 변경하실수 있습니다.</p>
                            <p><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 사용자 화면에 노출 하실 메뉴를 선택해 주세요. 메뉴명을 클릭 하시면 이름을 변경하실 수 있습니다.</p>
                            <p><i class="fa fa-exclamation-circle text-danger" aria-hidden="true"></i> 작업 후 반드시 적용 버튼을 클릭하셔야 정상적으로 반영 됩니다.</p>
                        </div>
                        <form:form id="menuFrm" name="menuFrm" action="/adm/updateMenu.do" modelAttribute="menuVO">
                        <div class="menu_set_box">
                            <div class="row">
                                <div class="col-xs-12">
                                    <table class="table text-center table-bordered table-hover menu_list_tbl all_chks_frm mb_0">
                                    <caption class="sr-only">메뉴 목록</caption>
                                    <colgroup>
                                        <col style="width:10%;">
                                        <col style="width:15%;">
                                        <col style="width:20%;">
										<col>
                                    </colgroup>
                                    <thead>
                                    <tr>
                                        <th scope="col">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" class="all_chk" checked="checked" /> 전체
                                            </label>
                                        </th>
                                        <th scope="col">메뉴명</th>
                                        <th scope="col">URL</th>
                                        <th scope="col">메뉴설명</th>
                                    </tr>
                                    </thead>
                                    <tbody>
									<c:forEach var="menu" items="${menuList }" varStatus="status">
                                    <tr>
                                    	<input type="hidden" name="menuList[${status.index }].menuNo" value="${menu.menuNo }">
										<input type="hidden" class="ordr" name="menuList[${status.index }].sortOrdr" value="${menu.sortOrdr }">
										<input type="hidden" id="delYn${status.index }" name="menuList[${status.index }].delYn" value="N">
                                        <td>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" id="delYn" data-id="${status.index }" <c:if test="${fn:contains(menu.delYn,'N')}">checked="checked"</c:if> /> 노출 
                                            </label>
                                        </td>
                                        <td class="text-left">
                                           <input type="text" name="menuList[${status.index }].menuNm" class="form-control" value="${menu.menuNm }">
                                        </td>
                                        <td class="text-left">
                                           <input type="text" name="menuList[${status.index }].menuUrl" class="form-control" value="${menu.menuUrl }">
                                        </td>
                                        <td class="text-left">
                                           <input type="text" name="menuList[${status.index }].menuDesc" class="form-control" value="${menu.menuDesc }" <c:if test="${fn:contains(menu.menuUrl,'/cmu/') }">readonly</c:if>>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                </div>
                            </div>
                        </div>
                        </form:form>
                        <!-- //menu_set_box -->
                        <hr />
                        <div class="row">
                            <div class="col-xs-6">
                                <button type="button" class="btn btn-black min-lg btn-lg">초기화</button>
                            </div>
                            <div class="col-xs-6 text-right">
                                <!-- <button type="button" id="addItem" class="btn btn-blue min-lg btn-lg" onclick="createItem();">추가</button> -->
                                <button type="button" id="submit" class="btn btn-blue min-lg btn-lg">적용</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //CONTENTS -->
                <div id="footer">
                    <p id="copy">&copy; GYEONGGI PROVINCE. All Rights Reserved.</p>
                </div>
                <!-- //FOOTER -->
            </div>
            <!-- //cont_body -->
        </div>
        <!-- //cont_wrap-->
<script>
	$(function() {
		$('.menu_list_tbl tbody').sortable({
			start:function(event,ui){
				reorder();	
			},
			stop:function(event,ui){
				reorder();	
			}
		});
		
		$("#submit").click(function(){
			$('input:checkbox[id="delYn"]').each(function() {
				if($(this).is(":checked")) {
					$("#delYn"+$(this).data("id")).val("N");
				} else{
					$("#delYn"+$(this).data("id")).val("Y");
				}
			});
			
			$("#menuFrm").submit();
		});
	});
	
	function createItem() {
		$(createBox()).appendTo("#itemBoxWrap").hover(
				function() {
					$(this).css('backgroundColor', '#f9f9f5');
					$(this).find('.deleteBox').show();
				},
				
				function() {
					$(this).css('background', 'none');
					$(this).find('.deleteBox').hide();
				}
		).append("<div class='deleteBox'>[삭제]</div>")
		.find(".deleteBox").click(function() {
			var valueCheck = false;
			$(this).parent().find('input').each(function() {
				if($(this).attr("name") != "type" && $(this).val() != '') {
					valueCheck = true;
				}
			});
			
			if(valueCheck) {
				var delCheck = confirm('입력하신 내용이 있습니다.\n삭제하시겠습니까?');
			}
			
			if(!valueCheck || delCheck == true) {
				$(this).parent().remove();
				reorder();
			}
		});
		// 숫자를 다시 붙인다.
		reorder();
	}
	
	function reorder() {
		$(".menu_list_tbl tbody tr").each(function(i, box) {
			$(box).find('.ordr').val(i);
		}); 
	}
</script>