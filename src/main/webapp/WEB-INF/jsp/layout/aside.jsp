<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<div id="aside" class="col-md-3">
                        <div class="side_card_box comm_data">
                            <strong class="name"><a href="./communityAdmin.html" class="adm_btn" title="관리자"><i class="glyphicon glyphicon-user" aria-hidden="true"></i></a> <a href="./communityMain.html">커뮤니티 명</a></strong>
                            <ul class="ico_list info_list">
                                <li>
                                    <div class="row type0">
                                        <div class="col-xs-6">
                                            <span class="tit">개설자</span>
                                        </div>
                                        <div class="col-xs-6 text-right data">
                                            홍길동
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="row type0">
                                        <div class="col-xs-6">
                                            <span class="tit">회원수</span>
                                        </div>
                                        <div class="col-xs-6 text-right data">
                                            <a href="./communityMembers.html" class="text-danger underline">1,000 명</a>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="row type0">
                                        <div class="col-xs-6">
                                            <span class="tit">회원수</span>
                                        </div>
                                        <div class="col-xs-6 text-right data">
                                            <a href="#alertPopup" data-toggle="modal" data-target="#alertPopup" class="text-danger">1,000 명</a>
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="row type0">
                                        <div class="col-xs-6">
                                            <span class="tit">Point</span>
                                        </div>
                                        <div class="col-xs-6 text-right data">
                                            1,000 점
                                        </div>
                                    </div>
                                </li>
                            </ul>
                            <div class="desc">
                                커뮤니티 소개글 영역
                            </div>
                            <div class="tags_area">
                                <span class="tag_txt">#키워드1</span>
                                <span class="tag_txt">#키워드2</span>
                                <span class="tag_txt">#키워드3</span>
                                <span class="tag_txt">#키워드4</span>
                            </div>
                            <div class="text-center btn_area">
                                <div class="row">
                                    <div class="col-xs-8 col-xs-offset-2"><a href="#commJoinPopup" data-toggle="modal" data-target="#commJoinPopup" class="btn btn-primary outline btn-block">가입하기</a></div>
                                </div>
                            </div>
                            <div class="text-center btn_area">
                                <div class="row">
                                    <div class="col-xs-8 col-xs-offset-2"><a href="#" class="btn btn-danger outline btn-block">탈퇴하기</a></div>
                                </div>
                            </div>
                            <div class="text-center btn_area">
                                <div class="row">
                                    <div class="col-xs-7"><strong class="data_txt text-blue">[가입 신청중]</strong></div>
                                    <div class="col-xs-5"><a href="#" class="btn btn-danger outline btn-block">취소</a></div>
                                </div>
                            </div>
                        </div>
                        <div class="aside_menu_box">
                            <ul class="list-group">
                                <li class="list-group-item">
                                    <a href="./communityNotice.html">
                                        공지사항
                                        <span class="badge">15</span>
                                    </a>
                                </li>
                                <li class="list-group-item on">
                                    <a href="./communityFree.html">
                                        자유 게시판
                                        <span class="badge">38</span>
                                    </a>
                                </li>
                                <li class="list-group-item">
                                    <a href="./communityWiki.html">
                                        지식 게시판
                                        <span class="badge">76</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>