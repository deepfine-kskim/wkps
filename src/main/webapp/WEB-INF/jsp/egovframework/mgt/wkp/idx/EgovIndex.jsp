<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
        <div class="cont_wrap">
            <div class="cont_header">
                <div class="row">
                    <div class="col-xs-6">
                        <h2 class="page_title">관리자</h2>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="msg"><strong class="text-primary">${loginVO.displayName }</strong>님! 반갑습니다.</p>
                        <a href="/usr/logout.do" class="btn btn-default outline">로그아웃</a>
                    </div>
                </div>
            </div>
            <!-- //cont_header -->
            <div class="cont_body">
            	<div id="contents">
                    <ul id="mainNav">
                    <!--
                    <li>
                        <a href="/adm/orgMileageList.do"> 
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu1.png" alt="" /></div>
                            <strong>마일리지 관리</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    -->
                    <li>
                        <a href="/adm/excellentUser.do">
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu2.png" alt="" /></div>
                            <strong>사용자 관리</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="/adm/recommendList.do">
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu3.png" alt="" /></div>
                            <strong>지식 관리</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="/adm/surveySetup.do">
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu4.png" alt="" /></div>
                            <strong>설문조사 관리</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="/adm/noticeList.do">
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu5.png" alt="" /></div>
                            <strong>게시판 관리</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="/adm/commRequest.do">
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu6.png" alt="" /></div>
                            <strong>커뮤니티 관리</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="/adm/menuList.do">
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu7.png" alt="" /></div>
                            <strong>메뉴 관리</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="/adm/statConnect.do">
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu8.png" alt="" /></div>
                            <strong>통계</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    <li>
                        <a href="/adm/log.do">
                            <div class="ico"><img src="/images/egovframework/mgt/wkp/ico_menu9.png" alt="" /></div>
                            <strong>로그관리</strong>
                            <span class="txt">바로가기 <i class="fa fa-angle-right" aria-hidden="true"></i></span>
                        </a>
                    </li>
                    </ul>
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