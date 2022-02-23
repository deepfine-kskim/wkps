<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<form id="detailed-search-form" class="form-horizontal" role="form">
	<div class="collapse" id="advancedSearch">
		<div class="form-horizontal">
			<div class="well frm_well mt_5">
				<div class="form-group inp_set_area">
					<strong class="col-sm-2 control-label">기간</strong>
					<div class="col-sm-10">
                		<label for="schDate1" class="radio-inline">
                   	 		<input type="radio" id="schDate1" name="date" value="w"> 1주일
                		</label>
                		<label for="schDate2" class="radio-inline">
                    		<input type="radio" id="schDate2" name="date" value="m"> 1개월
                		</label>
                		<label for="schDate3" class="radio-inline">
                    		<input type="radio" id="schDate3" name="date" value="y"> 1년
               			</label>
               			<label for="schDate4" class="radio-inline">
                    		<input type="radio" id="schDate4" name="date" class="inp_tog" value="r"> 기간선택
              			</label>
                 	</div>
               		<div class="col-sm-8 col-sm-push-2 col-lg-7 mt_5 inp_tog_cont">
                    	<div class="row type1">
                        	<div class="col-xs-6">
                        		<lable for="inpStartDate" class="sr-only">시작날짜</lable>
                                	<input type="text" class="form-control inp_date datetime" id="inpStartDate" name="inpStartDate" placeholder="시작날짜" />
                        	</div>
                        	<div class="col-xs-6">
                            	<lable for="inpEndDate" class="sr-only">종료날짜</lable>
                            	<input type="text" class="form-control inp_date datetime" id="inpEndDate" name="inpEndDate" placeholder="종료날짜" />
                        	</div>
                     	</div>
                 	</div>
            	</div>
                <div class="form-group all_chks_frm">
                    <strong class="col-sm-2 control-label">메뉴</strong>
                    <div class="col-sm-10 inp_set_area">
                        <label for="schCate" class="checkbox-inline">
                            <input type="checkbox" id="schCate" name="schCate" class="all_chk" /> 전체
                        </label>
                        <label for="schCate0" class="checkbox-inline">
                            <input type="checkbox" id="schCate0" name="schCate0" /> 지식백과
                        </label>
                        <!-- 
                        <label for="schCate1" class="checkbox-inline">
                            <input type="checkbox" id="schCate1" name="schCate1" /> Q&A
                        </label>
                         -->
                        <label for="schCate2" class="checkbox-inline">
                            <input type="checkbox" id="schCate2" name="schCate2" /> 설문조사
                        </label>
                        <label for="schCate3" class="checkbox-inline">
                            <input type="checkbox" id="schCate3" name="schCate3" /> 커뮤니티
                        </label>
                        <label for="schCate4" class="checkbox-inline">
                            <input type="checkbox" id="schCate4" name="schCate4" /> 공지사항
                        </label>
                        <!-- 
                        <label for="schCate5" class="checkbox-inline">
                            <input type="checkbox" id="schCate5" name="schCate5" /> FAQ
                        </label>
                         -->
                        <label for="schCate6" class="checkbox-inline">
                            <input type="checkbox" id="schCate6" name="schCate6" /> 전자결재 접수함
                        </label>
                        <label for="schCate7" class="checkbox-inline">
                            <input type="checkbox" id="schCate7" name="schCate7" /> 전자결재 생산함
                        </label>
                    </div>
                </div>
                <div class="form-group all_chks_frm">
                    <strong class="col-sm-2 control-label">영역</strong>
                    <div class="col-sm-10 inp_set_area">
                        <label for="schArea" class="checkbox-inline">
                            <input type="checkbox" id="schArea" name="schArea" class="all_chk" /> 전체
                        </label>
                        <label for="schArea1" class="checkbox-inline">
                            <input type="checkbox" id="schArea1" name="schArea1" /> 제목
                        </label>
                        <label for="schArea2" class="checkbox-inline">
                            <input type="checkbox" id="schArea2" name="schArea2" /> 본문
                        </label>
                        <label for="schArea3" class="checkbox-inline">
                            <input type="checkbox" id="schArea3" name="schArea3" /> 첨부파일
                        </label>
                    </div>
                </div>
                <hr />
                <div class="text-center">
                    <!-- <button type="button" class="btn btn-warning btn-sm"><i class="ti-search" aria-hidden="true" onclick="javascript:detailSrchKwd()">검색</i> </button> -->
                    <button type="button" class="btn btn-warning btn-sm" onclick="javascript:detailSrchKwd()"><i class="ti-search" aria-hidden="true">검색</i> </button>
                    <button type="button" class="btn btn-black btn-sm" data-toggle="collapse" data-target="#advancedSearch" aria-expanded="false" aria-controls="advancedSearch">닫기</button>
                </div>
            </div>
            <!-- well -->
        </div>
    </div>
</form>