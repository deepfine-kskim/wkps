<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<link href='/fullcalendar/lib/main.css' rel='stylesheet' />

<script src='/fullcalendar/lib/main.js'></script>
<script>

var user_sid = '${user.sid}'

Date.prototype.format = function (f) {

    if (!this.valueOf()) return " ";



    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];

    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];

    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    var d = this;



    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {

        switch ($1) {

            case "yyyy": return d.getFullYear(); // 년 (4자리)

            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)

            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)

            case "dd": return d.getDate().zf(2); // 일 (2자리)

            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)

            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)

            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)

            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)

            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)

            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)

            case "mm": return d.getMinutes().zf(2); // 분 (2자리)

            case "ss": return d.getSeconds().zf(2); // 초 (2자리)

            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분

            default: return $1;

        }

    });

};
String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
Number.prototype.zf = function (len) { return this.toString().zf(len); };

var calendar = null;
//개인 : #f5a11b : 01
//커뮤니티 : #ff5252 : 05
//도 주요 : #725ac1 : 02
//국주요 : #0051a4 : 03
//과주요 : #43c8c0 : 04

var arr_event_01 = new Array();
var arr_event_02 = new Array();
var arr_event_03 = new Array();
var arr_event_04 = new Array();
var arr_event_05 = new Array();
var arr_event_real = new Array();
function addEvent(cal){
	
	var end = new Date(cal.endDate);
	end.setDate(end.getDate()+1);
	var strEnd = end.format('yyyy-MM-dd');
	if(cal.calendarTypeCd == '01'){
		
		arr_event_01.push({
			calendarNo:cal.calendarNo,
			groupId: 01,
            title: '개인일정('+cal.title+')',
            start: cal.beginDate,
            end: strEnd,
            color : '#f5a11b'
        });
	}
	else if(cal.calendarTypeCd == '02'){
		arr_event_02.push({
			calendarNo:cal.calendarNo,
			groupId: 02,
            title: '도 주요일정('+cal.title+')',
            start: cal.beginDate,
            end: strEnd,
            color : '#725ac1'
        });
	}
	else if(cal.calendarTypeCd == '03'){
		arr_event_03.push({
			calendarNo:cal.calendarNo,
			groupId: 03,
            title: '국 주요일정('+cal.title+')',
            start: cal.beginDate,
            end: strEnd,
            color : '#0051a4'
        });
	}
	else if(cal.calendarTypeCd == '04'){
		arr_event_04.push({
			calendarNo:cal.calendarNo,
			groupId: 04,
            title: '과 주요일정('+cal.title+')',
            start: cal.beginDate,
            end: strEnd,
            color : '#43c8c0'
        });
	}
	else if(cal.calendarTypeCd == '05'){
		arr_event_05.push({
			calendarNo:cal.calendarNo,
			groupId: 05,
            title: '커뮤니티 일정('+cal.title+')',
            start: cal.beginDate,
            end: strEnd,
            color : '#ff5252'
        });
	}
}
function removeAllEvent(){
	for(var i=0; i < arr_event_real.length; i++){
		arr_event_real[i].remove();
    }
	arr_event_01 = new Array();
	arr_event_02 = new Array();
	arr_event_03 = new Array();
	arr_event_04 = new Array();
	arr_event_05 = new Array();
	arr_event_real = new Array();
}
function getMonthEvent(year,month){
	removeAllEvent();
	
	var param ={ year : year,
			month: month
			   }; 
	
	$.post("listCalendarMonth.do",
		   param, 
	   function(data, status) {
		  var json = JSON.parse(data);
	      if(json.success){
	    	 var cal_list = json.list;
	    	 
	    	  for(var i=0; i < cal_list.length; i++){
	    		  addEvent(cal_list[i]);
	    	  }
	    	  for(var i=0; i < arr_event_01.length; i++){
	    		  arr_event_real.push(calendar.addEvent(arr_event_01[i]));
	    		  
	    	  }
	    	  for(var i=0; i < arr_event_02.length; i++){
	    		  arr_event_real.push(calendar.addEvent(arr_event_02[i]));
	    		  
	    	  }
	    	  for(var i=0; i < arr_event_03.length; i++){
	    		  arr_event_real.push(calendar.addEvent(arr_event_03[i]));
	    		  
	    	  }
	    	  for(var i=0; i < arr_event_04.length; i++){
	    		  arr_event_real.push(calendar.addEvent(arr_event_04[i]));
	    		  
	    	  }
	    	  for(var i=0; i < arr_event_05.length; i++){
	    		  arr_event_real.push(calendar.addEvent(arr_event_05[i]));
	    		
	    	  }
		  }
		} 
	);
}

function getDayEvent(year,month,day){
	var param ={ year : year,
			month: month,
			day:day
			   }; 
	
	$.post("listCalendarDay.do",
		   param, 
	   function(data, status) {
		  var json = JSON.parse(data);
	      if(json.success){
	    	  
	    	  $('#schTab1').empty();
	    	  $('#schTab2').empty();
	    	  $('#schTab3').empty();
	    	  $('#schTab4').empty();
	    	  $('#schTab5').empty();
	    	  
	    	  
	    	 var cal_list = json.list;
	    	 
	    	 var list01 = new Array();
	    	 var list02 = new Array();
	    	 var list03 = new Array();
	    	 var list04 = new Array();
	    	 var list05 = new Array();
	    	 
	    	 for(var i = 0; i < cal_list.length; i++){
	    		 if(cal_list[i].calendarTypeCd == '02'){
	    			 list01.push(cal_list[i]);
	    		 }
	    		 if(cal_list[i].calendarTypeCd == '03'){
	    			 list02.push(cal_list[i]);
	    		 }
	    		 if(cal_list[i].calendarTypeCd == '04'){
	    			 list03.push(cal_list[i]);
	    		 }
	    		 if(cal_list[i].calendarTypeCd == '01'){
	    			 list04.push(cal_list[i]);
	    		 }
	    		 if(cal_list[i].calendarTypeCd == '05'){
	    			 list05.push(cal_list[i]);
	    		 }
	    	 }
	    	 addTabData('#schTab1',list01);
	    	 addTabData('#schTab2',list02);
	    	 addTabData('#schTab3',list03);
	    	 addTabData('#schTab4',list04);
	    	 addTabData('#schTab5',list05);
	    	 

	    	 if(list01.length > 0)
	    	 	$('#role_schTab1').tab('show');
	    	 else if(list02.length > 0)
	    	 	$('#role_schTab2').tab('show');
	    	 else if(list03.length > 0)
	    	 	$('#role_schTab3').tab('show');
	    	 else if(list04.length > 0)
	    	 	$('#role_schTab4').tab('show');
	    	 else if(list05.length > 0)
	    	 	$('#role_schTab5').tab('show');
	    	 
	    	 $('#calendarPopup').modal('show');
		  }
		} 
	);
}

function getEventOne(calendarNo){
	var param ={ calendarNo : calendarNo
			   }; 
	
	$.post("listCalendarOne.do",
		   param, 
	   function(data, status) {
		  var json = JSON.parse(data);
	      if(json.success){
	    	  
	    	  $('#schTab1').empty();
	    	  $('#schTab2').empty();
	    	  $('#schTab3').empty();
	    	  $('#schTab4').empty();
	    	  $('#schTab5').empty();
	    	  
	    	  
	    	 var calendar = json.calendar;
	    	 
	    	 var list01 = new Array();
	    	 var list02 = new Array();
	    	 var list03 = new Array();
	    	 var list04 = new Array();
	    	 var list05 = new Array();
	    	 
	    	 {
	    		 if(calendar.calendarTypeCd == '02'){
	    			 list01.push(calendar);
	    		 }
	    		 if(calendar.calendarTypeCd == '03'){
	    			 list02.push(calendar);
	    		 }
	    		 if(calendar.calendarTypeCd == '04'){
	    			 list03.push(calendar);
	    		 }
	    		 if(calendar.calendarTypeCd == '01'){
	    			 list04.push(calendar);
	    		 }
	    		 if(calendar.calendarTypeCd == '05'){
	    			 list05.push(calendar);
	    		 }
	    	 }
	    	 addTabData('#schTab1',list01);
	    	 addTabData('#schTab2',list02);
	    	 addTabData('#schTab3',list03);
	    	 addTabData('#schTab4',list04);
	    	 addTabData('#schTab5',list05);
	    	 
	    	 if(list01.length > 0)
	    	 	$('#role_schTab1').tab('show');
	    	 else if(list02.length > 0)
	    	 	$('#role_schTab2').tab('show');
	    	 else if(list03.length > 0)
	    	 	$('#role_schTab3').tab('show');
	    	 else if(list04.length > 0)
	    	 	$('#role_schTab4').tab('show');
	    	 else if(list05.length > 0)
	    	 	$('#role_schTab5').tab('show');
	    	 
	    	 $('#calendarPopup').modal('show');
	    	 
		  }
		} 
	);
}

function addTabData(q,cal){
	if(cal.length == 0){
		 var htmlData = "<div class='well text-center'>일정이 없습니다</div>";	 
		 $(q).html(htmlData);
	 }else{
		 var htmlData = "<table class='table text-center brd_tog_list'>";
    	 htmlData += "<caption class='sr-only'></caption>";
    	 htmlData += "<colgroup>";
    	 htmlData += "<col />";
    	 htmlData += "<col />";
    	 htmlData += "<col class='hidden-xs' />";
    	 htmlData += "<col class='hidden-xs' />";
    	 htmlData += "</colgroup>";
    	 htmlData += "<thead class='hidden-xs'>";
    	 htmlData += "<tr>";
    	 htmlData += "<th scope='col'>시간</th>";
    	 htmlData += "<th scope='col'>제목</th>";
    	 htmlData += "<th scope='col'>장소</th>";
    	 htmlData += "<th scope='col'>주 참석자</th>";
    	 htmlData += "</tr>";
    	 htmlData += "</thead>";
    	 htmlData += "<tbody>";
    	 
    	 for(var i = 0; i < cal.length; i++){
    		 htmlData += "<tr class='brd_subject_tr collapsed' data-toggle='collapse' data-target='#tab_"+cal[i].calendarNo+"' aria-expanded='false' aria-controls='tab_"+cal[i].calendarNo+"'>";
        	 htmlData += "<td>"+cal[i].beginDate+" "+cal[i].beginTime+" ~ "+cal[i].endDate+"-"+cal[i].endTime+"</td>";
        	 htmlData += "<td class='subject'>";
        	 if(cal[i].cnfdntYn == 'Y'){
        	 	htmlData += "<span class='brd_txt_ico text-danger'>[대외비]</span>";
        	 }
        	 htmlData += "<a href='#tab4-memo1'>"+cal[i].title+"</a></td>";
        	 htmlData += "<td><span class='visible-xs-inline'><em class='text-primary'>장소</em> : </span>"+cal[i].plc+"</td>";
        	 htmlData += "<td><span class='visible-xs-inline'><em class='text-primary'>주 참석자</em> : </span>"+cal[i].attendess+"</td>";
        	 htmlData += "</tr>";
        	 htmlData += "<tr class='brd_memo_tr'>";
        	 htmlData += "<td class='text-left' colspan='4'>";
        	 htmlData += "<div id='tab_"+cal[i].calendarNo+"' class='memo_cont collapse'>";
        	 htmlData += "<div class='txt_area'>"+cal[i].cont+"</div>";
        	 htmlData += "<div class='btn_area text-right'>";
        	 
        	 //본인이 작성한 것만
        	 if(cal[i].registerId == user_sid){
        	 	htmlData += "<a href='#' class='btn btn-default btn-xs outline' onclick='modCal("+cal[i].calendarNo+")'>수정</a>";
        	 	htmlData += "<a href='#' class='btn btn-default btn-xs outline' onclick='delCal("+cal[i].calendarNo+")'>삭제</a>";
        	 }
        	 
        	 htmlData += "</div>";
        	 htmlData += "</div>";
        	 htmlData += "</td>";
        	 htmlData += "</tr>";
    	 }
         
         htmlData += "</tbody>";
         htmlData += "</table>";
         $(q).html(htmlData);
	 }
}

function delCal(calNo){
	var param ={ calendarNo : calNo
			   }; 
	
	$.post("delCalendar.do",
		   param, 
	   function(data, status) {
		  var json = JSON.parse(data);
	      if(json.success){
	    	 location.reload();
		  }
		} 
	);
}

function modCal(calNo){
	location.href="calendarModify.do?calendarNo="+calNo;
}
$(function() {
	var today = new Date();  
	var str_today = today.format('yyyy-MM-dd'); 
	
	getMonthEvent(today.getFullYear(),1+today.getMonth());
	
	
	var calendarEl = document.getElementById('calendar');
    calendar = new FullCalendar.Calendar(calendarEl, {
      initialDate: str_today,
      editable: true,
      selectable: true,
      businessHours: true,
      dayMaxEvents: true, // allow "more" link when too many events
      
      select: function(arg) {
    	  var jbSplit = arg.startStr.split('-');
    	  
    	  getDayEvent(jbSplit[0],jbSplit[1],jbSplit[2]);
    	  
          calendar.unselect()
        },
        
        eventClick: function(info) {
        	getEventOne(info.event.extendedProps.calendarNo);
        	
        },
        
      headerToolbar: {
    	    left: 'prevYear,prev,next,nextYear',
    	    center: 'title',
    	    right: 'today'
    	  },
      locale:'ko'
    });

    calendar.render();
	
	
	$('.fc-prev-button').click(function(){
		getMonthEvent(calendar.currentData.currentDate.getFullYear(),1+calendar.currentData.currentDate.getMonth());
	});

	$('.fc-next-button').click(function(){
		getMonthEvent(calendar.currentData.currentDate.getFullYear(),1+calendar.currentData.currentDate.getMonth());
	});
	
	$('.fc-prevYear-button').click(function(){
		getMonthEvent(calendar.currentData.currentDate.getFullYear(),1+calendar.currentData.currentDate.getMonth());
	});

	$('.fc-nextYear-button').click(function(){
		getMonthEvent(calendar.currentData.currentDate.getFullYear(),1+calendar.currentData.currentDate.getMonth());
	});
	
	
});
    
</script>
<div class="container sub_cont">
                <div id="contents">
                    <div class="page-header">
                        <h2>일정</h2>
        				<div>${menuDesc }</div>
                    </div>
                    <!-- //page-header -->
                    <div class="page-body">
                        <div class="row">
                            <div class="col-xs-6">
                                <div class="color_info">
                                    <ul>
                                        <li class="text-warning"><i class="fa fa-square"></i><span class="sr-only">파랑색</span> 개인일정</li>
                                        <li class="text-danger"><i class="fa fa-square"></i><span class="sr-only">주황색</span> 커뮤니티 일정</li>
                                        <li class="text-purple"><i class="fa fa-square"></i><span class="sr-only">보라색</span> 도 주요일정</li>
                                        <li class="text-primary"><i class="fa fa-square"></i><span class="sr-only">핑크색</span> 국 주요일정</li>
                                        <li class="text-info"><i class="fa fa-square"></i><span class="sr-only">녹색</span> 과 주요일정</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-xs-6 text-right">
                                <a href="calendarRegist.do" class="btn btn-blue"><i class="ti-calendar" aria-hidden="true"></i> 일정추가</a>
                            </div>
                        </div>
                        <br />
                        <br />
                        <!-- 달력 -->
                        <div id='calendar'></div>
                        <!-- //달력 -->
                    </div>
                    <!-- //page-body -->
                    <!-- 일정팝업 -->
                    <div class="modal fade" id="calendarPopup" tabindex="-1" role="dialog" aria-labelledby="calendarPopupLabel">
                        <div class="modal-dialog modal-lg" role="document">
                            <form class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="calendarPopupLabel"><strong>일정</strong></h4>
                                </div>
                                <div class="modal-body">
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li role="presentation" class="active"><a href="#schTab1" id="role_schTab1" aria-controls="company" role="tab" data-toggle="tab">도 일정</a></li>
                                        <li role="presentation"><a href="#schTab2" id="role_schTab2" aria-controls="business" role="tab" data-toggle="tab">국 일정</a></li>
                                        <li role="presentation"><a href="#schTab3" id="role_schTab3" aria-controls="prcenter" role="tab" data-toggle="tab">과 일정</a></li>
                                        <li role="presentation"><a href="#schTab4" id="role_schTab4" aria-controls="prcenter" role="tab" data-toggle="tab">개인 일정</a></li>
                                        <li role="presentation"><a href="#schTab5" id="role_schTab5" aria-controls="prcenter" role="tab" data-toggle="tab">커뮤니티 일정</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="schTab1" class="tab-pane active" role="tabpanel">
                                            
                                        </div>
                                        <div id="schTab2" class="tab-pane" role="tabpanel">
                                            
                                        </div>
                                        <div id="schTab3" class="tab-pane" role="tabpanel">
                                            
                                        </div>
                                        <div id="schTab4" class="tab-pane" role="tabpanel">
                                            
                                        </div>
                                        <div id="schTab5" class="tab-pane" role="tabpanel">
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-blue" data-dismiss="modal">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- //일정팝업 -->
                </div>
                <!-- //CONTENTS -->
            </div>