<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>

var commArr = new Array();

var CALENDAR_NO = ${cal.calendarNo};
$(function() {
	
	<c:forEach items="${cal_community}" var="cal_c">
	commArr.push(${cal_c.cmmntyNo });
    </c:forEach>
	
	$('#btn_community_add').click(function(){
		$('#community_containter').empty();
		commArr = new Array();
		$('input:checkbox[name="commChk"]').each(function(){
			if($(this).prop('checked')){
				var data = '<span class="tag_btn label label-default">'+$(this)[0].value+'</span>';
				$('#community_containter').append(data);
				commArr.push($(this)[0].id);
			}
		});
	});
	
	$('#btn_save').click(function(){
		if($("#inpStartDate").val() == '' || $("#inpStartTime").val() == '' ||
				$("#inpEndDate").val() == '' || $("#inpEndTime").val() == ''){
			alert("날짜를 정확하게 입력해 주세요.");
			return false;
		}
		var begin = new Date($("#inpStartDate").val()+" "+$("#inpStartTime").val());
		var end = new Date($("#inpEndDate").val()+" "+$("#inpEndTime").val());
		if(begin.getTime() >= end.getTime()){
			alert("시작날짜와 종료날짜를 다시 확인해 주세요.");
			return;
		}
		
		if($("#inpStartDate").val() > $("#inpEndDate").val()){
			alert("시작 날짜가 종료 날짜 이후 입니다.");
			return false;
		}
		
		if($("#inpStartDate").val() >= $("#inpEndDate").val() &&
				$("#inpStartTime").val() > $("#inpEndTime").val()){
			alert("시작 시간이 종료 시간 이후 입니다.");
			return false;
		}
		if($("#schSubject").val() == ''){
			alert("제목을 입력해 주세요.");
			return false;
		}
		
		if($("#schMemo").val() == ''){
			alert("내용을 입력해 주세요.");
			return false;
		}
		
		var CNFDNT_YN = 'N';
		var CALENDAR_TYPE_CD =  $("input[name='schCate']:checked").val();
		if($("input:checkbox[id='schMemoOpt']").is(":checked")){
			CNFDNT_YN = 'Y';
		}


		var orgList = new Array();
		var userList = new Array();
		var groupList = new Array();
		
		$('input:hidden[name="orgListHidden"]').each(function(e){
			{
				orgList.push($(this).val());
			}
		});
		
		$('input:hidden[name="userListHidden"]').each(function(e){
			{
				userList.push($(this).val());		
			}
		});
		
		$('input:hidden[name="groupListHidden"]').each(function(e){
			{
				groupList.push($(this).val());		
			}
		});
		
		var param ={
				CALENDAR_NO : CALENDAR_NO,
				CALENDAR_TYPE_CD : CALENDAR_TYPE_CD,
		   TITLE: $("#schSubject").val(),
		   CONT: $("#schMemo").val(),
		   BNGN_DTM : $("#inpStartDate").val()+" "+$("#inpStartTime").val(),
		   END_DTM : $("#inpEndDate").val()+" "+$("#inpEndTime").val(),
		   PLC : $("#schPlace").val(),
		   ATTENDESS : $("#schEntrant").val(),
		   CNFDNT_YN : CNFDNT_YN,
		   CMMNTY_ARR : commArr,
		   orgList : orgList,
		   userList : userList,
		   groupList : groupList
		}; 
		
 		$.ajax({
 			url : '/cal/updateCalendar.do',
 			data : param,
 			global: false,
 			async: false,
 			type: 'POST',
 			dataType: 'json',
 			success : function(data) {
 				location.href="/cal/calendar.do";
 			},
 			error : function(){
 				alert('변경 할 수 없습니다.');
			  } 
 		});
    });	
	
	$('#btn_cancel').click(function(){
		location.href="calendar.do";
    });	
	

	$("#orgBtn").click(function(e){
		var ou = $("input[name=orgText]").val();
 		$.ajax({
 			url : '/org/orgList.do',
 			data : {
 				ou : ou 
 			},
 			dataType: "json",
 			success : function(data) {
           		/* $('#orgList li').remove(); 
               	for(var i=0; i < data.orgList.length; i++){
               		$('#orgList').append('<li><label for="chk-'+i+'"><input id="chk-'+i+'" name="orgList" data-id="customChk-'+i+'" type="checkbox" value="'+data.orgList[i].ouCode+'" data-name="'+data.orgList[i].ou+'">'+data.orgList[i].ou+'</label></li>');
               	} */
 				$('#orgList').prepend('<li>---------------------------------------------------------------------------------</li>');
               	if(data.orgList.length > 0){
               		//$('#orgList li').remove();
               		for(var i=0; i < data.orgList.length; i++){
                   		$('#orgList').prepend('<li><label for="chk-'+i+'"><input id="chk-'+i+'" name="orgList" data-id="customChk-'+i+'" type="checkbox" value="'+data.orgList[i].ouCode+'" data-name="'+data.orgList[i].ou+'">'+data.orgList[i].ou+'</label></li>');
                   	}
               	} else{
               		$('#orgList').prepend('<li>검색 결과가 없습니다.</li>');
               	}
 			},
 			error : function(){

 			}
 		});
	});
	
	$("#userBtn").click(function(e){
		var displayName = $("input[name=userText]").val();
 		$.ajax({
 			url : '/usr/userList.do',
 			data : {
 				displayName : displayName
 			},
 			dataType: "json",
 			success : function(data) {
           		//$('#userList li').remove(); 
 				$('#userList').prepend('<li>---------------------------------------------------------------------------</li>');
               	/* for(var i=0; i < data.userList.length; i++){
               		$('#userList').append('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'">'+data.userList[i].displayName+'</label></li>');
               	} */
 				if(data.userList.length > 0){
               		//$('#userList li').remove(); 
               	for(var i=0; i < data.userList.length; i++){
                   		$('#userList').prepend('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'" data-ou="'+data.userList[i].ou+'">'+data.userList[i].ou+' '+data.userList[i].displayName+'</label></li>');
                   	}	
 				} else{
               		$('#userList').prepend('<li>검색 결과가 없습니다.</li>');
               	}
 			},
 			error : function(){

 			}
 		});
	});
	
	$("#rlsChk").click(function(e){	
		$('#rlsList').empty();
		$('input:checkbox[name="orgList"]').each(function(e){
			if(this.checked){
				$('#rlsList').append('<span class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="orgListHidden" value="'+$(this).val()+'"></span>');
			}
		});
		
		$('input:checkbox[name="userList"]').each(function(e){
			if(this.checked){
				$('#rlsList').append('<span class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="userListHidden" value="'+$(this).val()+'"></span>');		
			}
		});
		$('input:checkbox[name="groupList"]').each(function(e){
			if(this.checked){
				$('#rlsList').append('<span class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span><input type="hidden" name="groupListHidden" value="'+$(this).val()+'"></span>');		
			}
		});
	});
	
	/* var orgLi = [];
	$("#rlsChk").click(function(e){
		$('input:checkbox[name="orgList"]').each(function(e){
			if(this.checked){
				var list = $('#rlsList').children('#orgName').text();
				var data = $(this).data('name');
				if(orgLi.indexOf(data) < 0) {
					orgLi.push(data);
				}

				if(list.indexOf(data) < 0) {
					$('#rlsList').append('<span id="orgName" class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
				}
			}
		});
		
		$('input:checkbox[name="userList"]').each(function(e){
			if(this.checked){
				var list = $('#rlsList').children('#usersName').text();
				var data = $(this).data('name');
				
				if(orgLi.indexOf(data) < 0) {
					orgLi.push(data);
				}

				if(list.indexOf(data) < 0) {
					$('#rlsList').append('<span id="usersName" class="tag_btn label label-default">'+$(this).data('ou')+' '+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
				}
			}
		});
		
		$('input:checkbox[name="groupList"]').each(function(e){
			if(this.checked){
				var list = $('#rlsList').children('#groupName').text();
				var data = $(this).data('name');
				
				if(orgLi.indexOf(data) < 0) {
					orgLi.push(data);
				}
				if(list.indexOf(data) < 0) {
					$('#rlsList').append('<span id="groupName" class="tag_btn label label-default">'+$(this).data('name')+'<i class="remove">x</i><span class="sr-only">삭제</span></span>');
				}
			}
		});
		
		$( 'input[name="allChk1"]' ).attr( 'checked', false );
		//$( 'input[name="orgList"]' ).attr( 'checked', false );
		$( 'input[name="allSrchChk"]' ).attr( 'checked', false );
		//$( 'input[name="userList"]' ).attr( 'checked', false );
		$( 'input[name="allSrchGrp"]' ).attr( 'checked', false );
		//$( 'input[name="groupList"]' ).attr( 'checked', false );
	});*/
	
	$("#userList .fa").click(function(e){
		var tmp = $(this);
		var ouCode = $(this).data('code');
 		$.ajax({
 			url : '/usr/userList.do',
 			data : {
 				ouCode : ouCode
 			},
 			dataType: "json",
 			success : function(data) {
 				for(var i=data.userList.length-1; i >= 0; i--){
 					tmp.next().next().prepend('<li><label for="allSrchChk-'+i+'"><input id="allSrchChk-'+i+'" name="userList" data-id="allSrchChk-'+i+'" type="checkbox" value="'+data.userList[i].sid+'" data-name="'+data.userList[i].displayName+'" data-ou="'+data.userList[i].ou+'">'+data.userList[i].ou+' '+data.userList[i].displayName+'</label></li>');
 				}
 			},
 			error : function(){
 				alert("에러가 발생하였습니다.");
 			}
	});
});

});

</script>
<div class="container sub_cont">
                <div id="contents">
                    <div class="page-header">
                        <h2>일정 </h2>
                        <div>${menuDesc }</div>
                    </div>
                    <!-- //page-header -->
                    <div class="page-body">
                        <!-- 일정쓰기 -->
                        <p class="req_msg"><span class="req">*</span> 표시는 필수입력사항입니다.</p>
                        <div id="writeFrm" class="form-horizontal">
                            <fieldset>
                                <legend class="sr-only">게시판 글작성</legend>
                                <div class="brd_write_area">
                                    <div class="form-group">
                                        <strong class="col-sm-2 control-label"><span class="req">*</span> 날짜</strong>
                                        <div class="col-sm-5 col-lg-5">
                                            <div class="row type1">
                                                <div class="col-xs-6">
                                                    <lable for="inpStartDate" class="sr-only">시작날짜</lable>
                                                    <input type="text" class="form-control inp_date datetime" id="inpStartDate" name="inpStartDate" placeholder="시작날짜" required="required" value="${cal.beginDate}" />
                                                </div>
                                                <div class="col-xs-6">
                                                    <lable for="inpStartTime" class="sr-only">시작시간</lable>
                                                    <input type="text" class="form-control inp_time datetime" id="inpStartTime" name="inpStartTime" placeholder="시작시간" required="required" value="${cal.beginTime}"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-5 col-lg-5">
                                            <div class="row type1">
                                                <div class="col-xs-6">
                                                    <lable for="inpEndDate" class="sr-only">종료날짜</lable>
                                                    <input type="text" class="form-control inp_date datetime" id="inpEndDate" name="inpEndDate" placeholder="종료날짜" required="required" value="${cal.endDate}"/>
                                                </div>
                                                <div class="col-xs-6">
                                                    <lable for="inpEndTime" class="sr-only">종료시간</lable>
                                                    <input type="text" class="form-control inp_time datetime" id="inpEndTime" name="inpEndTime" placeholder="종료시간" required="required" value="${cal.endTime}"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group inp_set_area">
                                        <label for="schCate1" class="col-sm-2 control-label"><span class="req">*</span> 분류</label>
                                        <div class="col-sm-10 tree_chk_area">
                                            <label for="schCate1" class="radio-inline">
                                                <input type="radio" id="schCate1" name="schCate" value="01" <c:if test="${cal.calendarTypeCd == '01' }">checked</c:if> > 개인일정
                                            </label>
                                            <label for="schCate2" class="radio-inline">
                                                <input type="radio" id="schCate2" name="schCate" value="02" <c:if test="${cal.calendarTypeCd == '02' }">checked</c:if>> 도 주요 일정
                                            </label>
                                            <label for="schCate3" class="radio-inline">
                                                <input type="radio" id="schCate3" name="schCate" value="03" <c:if test="${cal.calendarTypeCd == '03' }">checked</c:if>> 국 주요일정
                                            </label>
                                            <label for="schCate4" class="radio-inline">
                                                <input type="radio" id="schCate4" name="schCate" value="04" <c:if test="${cal.calendarTypeCd == '04' }">checked</c:if>> 과 주요일정
                                            </label>
                                            <div>
                                                <label for="schCate5" class="radio-inline">
                                                    <input type="radio" id="schCate5" name="schCate" class="inp_tog" value="05"  <c:if test="${cal.calendarTypeCd == '05' }">checked</c:if>> 커뮤니티
                                                </label>
                                                <a href="#selectCommPopup" class="btn btn-xs btn-primary inp_tog_cont" data-toggle="modal" data-target="#selectCommPopup">커뮤니티 선택</a>
                                            </div>
                                            <div class="tag_grp_area"  id="community_containter">
                                            <c:forEach items="${cal_community}" var="cal_c">
                                            <span class="tag_btn label label-default">${cal_c.cmmntyNm }</span>
                                            </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="schSubject" class="col-sm-2 control-label"><span class="req">*</span> 제목</label>
                                        <div class="col-sm-7">
                                            <input type="text" class="form-control" id="schSubject" name="schSubject" placeholder="제목를 입력하세요" value="${cal.title }" required  />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="schMemo" class="col-sm-2 control-label"><span class="req">*</span> 내용</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" rows="6" id="schMemo" name="schMemo" placeholder="내용을 입력하세요" required>${cal.cont }</textarea>
                                            <div class="text-right">
                                                <label for="schMemoOpt" class="checkbox-inline">
                                                    <input type="checkbox" id="schMemoOpt" name="schMemoOpt" <c:if test="${cal.cnfdntYn == 'Y' }">checked</c:if>/> 대외비
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="schPlace" class="col-sm-2 control-label">장소</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="schPlace" name="schPlace"  value="${cal.plc }"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="schEntrant" class="col-sm-2 control-label">주 참석자</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="schEntrant" name="schEntrant"  value="${cal.attendess }"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="schEntrant" class="col-sm-2 control-label">공유여부</label>
                                        <div class="col-sm-8">
                                            <a href="#selectGrpPopup" class="btn btn-xs btn-primary inp_opt_btn" data-toggle="modal" data-target="#selectGrpPopup">조직/그룹 선택</a>
                                            <div  id="rlsList" class="tag_grp_area">
                                            </div>
                                            <p class="help-block"><span class="text-danger">※</span> 조직/그룹을 선택하지 않을 경우 <span class="text-danger">비공개</span>로 처리됩니다.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <button class="btn btn-blue" id="btn_save">작성완료</button>
                                    <a href="#" class="btn btn-black" id="btn_cancel">취소</a>
                                </div>
                            </fieldset>
                        </div>
                        <!-- // 일정쓰기-->
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
			                                                <input type="text" id="orgText" name="orgText" class="form-control" placeholder="부서 검색(2글자 이상)">
	                                                <span class="input-group-btn"><a href="javascript:;" id="orgBtn" class="btn btn-default">검색</a></span>
	                                            </div>
	                                        </fieldset>
	                                    </div>
	                                    <div class="hummingbird-treeview well chk_tree_area">
	                                        <div class="checkbox">
	                                            <label for="allChk1"><input type="checkbox" id="allChk1" class="all_chk" /> 전체선택</label>
	                                        </div>
	                                        <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
	                                        <ul id="orgList" class="chk_tree_list hummingbird-base treeview">
			                                        	<c:forEach var="top" items="${topList }" varStatus="topStatus">
		                                                <li>
		                                                	<i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }" value="${top.ouCode }" data-id="customChk-${topStatus.index+1 }" data-name="${top.ou }" />${top.ou }</label>
		                                                    <ul>
		                                                    	<c:forEach var="parent" items="${parentList }" varStatus="parentStatus">
		                                                    	<c:if test="${parent.parentOuCode eq top.ouCode }">
		                                                        <li>
		                                                            <i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }-${parentStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }-${parentStatus.index+1 }" value="${parent.ouCode }"data-id="customChk-${topStatus.index+1 }-${parentStatus.index+1 }" data-name="${parent.ou }" />${parent.ou }</label>
		                                                            <ul class="not_depth_list">
		                                                            	<c:forEach var="child" items="${childList }" varStatus="childStatus">
		                                                            	<c:if test="${child.parentOuCode eq parent.ouCode }">
		                                                                <li>
		                                                                	<i class="fa fa-plus"></i> <label for="chk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }"><input type="checkbox" name="orgList" id="chk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" value="${child.ouCode }" data-id="customChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" data-name="${child.ou }" />${child.ou }</label>
		                                                                </li>
		                                                                </c:if>
		                                                                </c:forEach>
		                                                            </ul>
		                                                        </li>
		                                                        </c:if>
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
	                                                <input type="text" id="userText" name="userText" class="form-control" placeholder="이름 검색(2글자 이상)">
	                                                <span class="input-group-btn"><a href="javascript:;" id="userBtn" class="btn btn-default">검색</a></span>
	                                            </div>
	                                        </fieldset>
	                                    </div>
	                                    <div class="hummingbird-treeview well chk_tree_area">
	                                        <div class="checkbox">
	                                            <label for="allSrchChk"><input type="checkbox" id="allSrchChk" class="all_chk" /> 전체선택</label>
	                                        </div>
	                                        <ul id="userList" class="chk_tree_list hummingbird-base treeview">
			                                        	<c:forEach var="top" items="${topList }" varStatus="topStatus">
		                                                <li>
		                                                	<i class="fa fa-plus" data-code="${top.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }" />${top.ou }</label>
		                                                    <ul>
		                                                    	<c:forEach var="parent" items="${parentList }" varStatus="parentStatus">
		                                                    	<c:if test="${parent.parentOuCode eq top.ouCode }">
		                                                        <li>
		                                                            <i class="fa fa-plus" data-code="${parent.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }" />${parent.ou }</label>
		                                                            <ul class="not_depth_list">
		                                                            	<c:forEach var="child" items="${childList }" varStatus="childStatus">
		                                                            	<c:if test="${child.parentOuCode eq parent.ouCode }">
		                                                                <li>
		                                                                	<i class="fa fa-plus" data-code="${child.ouCode }"></i> <label for="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }"><input type="checkbox" id="allSrchChk-${topStatus.index+1 }-${parentStatus.index+1 }-${childStatus.index+1 }" />${child.ou }</label>
		                                                                	<ul>
		                                                                	</ul>
		                                                                </li>
		                                                                </c:if>
		                                                                </c:forEach>
		                                                            </ul>
		                                                        </li>
		                                                        </c:if>
		                                                        </c:forEach>
		                                                    </ul>
		                                                </li>
		                                                </c:forEach>
	                                        </ul>
	                                    </div>
	                                </div>
	                                <div id="selectGrpTab3" class="tab-pane" role="tabpanel">
			                                <c:choose>
			                                	<c:when test="${not empty groupList }">
	                                    <div class="hummingbird-treeview well chk_tree_area">
	                                        
	                                        <!-- 트리 열어둘 경우 <i class="fa ti-minus"></i> 아이콘 + 열어둘 자식 ul에 open 클래스 달기 -->
	                                        <div class="checkbox">
	                                            <label for="allSrchGrp"><input type="checkbox" id="allSrchGrp" class="all_chk" /> 전체선택</label>
	                                        </div>
	                                        <ul id="grpList" class="chk_tree_list hummingbird-base treeview">
	                                        	<c:forEach var="group" items="${groupList }" varStatus="status">
	                                        	<li><label for="allSrchGrp-${status.index }"><input id="allSrchGrp-${status.index }" name="groupList" data-id="allSrchGrp-${status.index }" type="checkbox" value="${group.groupNo }" data-name="${group.groupNm }">${group.groupNm }</label></li>
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
                        <!-- 커뮤니티 선택 팝업 -->
                        <div class="modal fade" id="selectCommPopup" tabindex="-1" role="dialog" aria-labelledby="selectCommPopupLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="selectCommPopupLabel">커뮤니티 선택</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="hummingbird-treeview well chk_tree_area">
                                            <div class="checkbox">
                                                <label for="commChk"><input type="checkbox" id="commChk" class="all_chk" /> 전체선택</label>
                                            </div>
                                            <ul class="chk_tree_list hummingbird-base treeview">
                                                <c:forEach items="${community }" var="community">
                                                <li><label for="${community.cmmntyNo }"><input id="${community.cmmntyNo }" name="commChk" data-id="${community.cmmntyNo }" type="checkbox" value="${community.cmmntyNm }"> ${community.cmmntyNm }</label></li>
                                            	</c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-blue" data-dismiss="modal" id="btn_community_add">확인</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- //커뮤니티 선택 팝업 -->
                    </div>
                    <!-- //page-body -->
                    <!-- 일정팝업 -->
                    <div class="modal fade" id="calendarPopup" tabindex="-1" role="dialog" aria-labelledby="calendarPopupLabel">
                        <div class="modal-dialog" role="document">
                            <form class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="calendarPopupLabel"><strong>부서/직원 선택</strong></h4>
                                </div>
                                <div class="modal-body">

                                </div>
                                <div class="modal-footer text-center">
                                    <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                                    <button type="button" class="btn btn-black" data-dismiss="modal">취소</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- //일정팝업 -->
                    <script src="/js/egovframework/com/wkp/hummingbird-treeview-1.3.js"></script>
                    <script src="/js/egovframework/com/wkp/calendarW.js"></script>
                </div>
                <!-- //CONTENTS -->
            </div>