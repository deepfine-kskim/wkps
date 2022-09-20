<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새로운 경기 공정한 세상</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
    <!--[if IEMobile]>
    <meta http-equiv="cleartype" content="on" />
    <![endif]-->
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <!--[if lt IE 9]>
    <script src="/js/egovframework/com/wkp/html5shiv.min.js"></script>
    <script src="/js/egovframework/com/wkp/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="/css/egovframework/com/wkp/common.css" />
    <link rel="stylesheet" href="/css/egovframework/com/wkp/site.css" />
    <link rel="stylesheet" href="/css/egovframework/com/wkp/wiki.css" />
    <link rel="stylesheet" href="/css/egovframework/com/wkp/community.css" />
    <script src="/js/egovframework/com/wkp/jquery-1.11.3.min.js"></script>
    <script src="/js/egovframework/com/wkp/jquery.blockUI-2.7.0.min.js"></script>
    <script src="/js/egovframework/com/wkp/jquery.cookie.js"></script>
    <script src="/js/egovframework/com/wkp/moment.js"></script>
    <script src="/js/egovframework/com/wkp/base.js"></script>
    <script src="/js/egovframework/com/wkp/jquery-ui.min.js"></script>
    <script src="/js/egovframework/com/wkp/metisMenu.min.js"></script>
    <script src="/js/egovframework/com/wkp/owl.carousel.min.js"></script>
    <script src="/js/egovframework/com/wkp/main.js"></script>
    <script>
        $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
    </script>
</head>
<body>
<div id="wrap">
	<div id="skipNav">
	    <a href="#contents">본문 바로가기</a>
	    <a href="#gnbList">주메뉴 바로가기</a>
	</div>
	<header id="header">
        <div class="container">
            <div class="navbar-header">
                <h1 class="logo_top">
					<a href="/" class="navbar-brand"><img src="/images/egovframework/com/wkp/logo03.png" alt="로고" /></a><!-- [D] 220329 - img 경로 변경 -->
                </h1>
            </div>
        </div>
	</header>
	<div id="page">
		<div class="container sub_cont">
			<div id="contents">
				<div class="page-header">
					<h2>로그인</h2>
				</div>
				<div class="page-body">
					<form class="frm_log" name="loginForm" action="/usr/login.do" method="post" >
						<div class="frame" style="width: 400; margin: auto; padding-top: 150;">
							<label for="userId" class="sr-only">아이디를 입력해 주세요.</label>
							<div class="input-group userid">
								<div class="input-group-addon">
									<i class="glyphicon glyphicon-user" aria-hidden="true"></i>
								</div>
								<input type="text" class="form-control" id="sid" name="sid" placeholder="아이디를 입력해 주세요." required />
							</div>
							<button class="btn btn-lg btn-primary btn-block btn_submit" type="submit">
								<strong>로그인</strong>
							</button>
						</div>
					</form>
				</div>
			</div>
			<!-- //page-body -->
		</div>
		<!-- //CONTENTS -->
	</div>
	<!-- //PAGE -->
	<footer id="footer">
	    <div class="container">
	        <div class="row type5">
	            <%--<div class="col-md-3 foot_brand">
	                <strong class="logo"><img src="/images/egovframework/com/wkp/logo_foot.png" alt="지식포털" /></strong>
	            </div>--%>
	            <div class="col-md-9 foot_cont">
	                <div class="row">
	                    <div class="col-md-9">
	                        <div class="foot_info">
	                            <em>경기도 수원시 팔달구 효원로 1 (매산로3가)</em><span class="bar">/</span>
	                            <em>북부청사 11780 의정부시 청사로 1</em><span class="bar">/</span>
	                            <em>경기도 콜센터 : 031-120</em>
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
	</footer>
</div>
<!-- //WRAP -->
<script src="/js/egovframework/com/wkp/bootstrap.min.js"></script>
<script src='/js/egovframework/com/wkp/bootstrap-tagsinput.min.js'></script>
<script src="/js/egovframework/com/wkp/bootstrap-datetimepicker.min.js"></script>
<script src="/js/egovframework/com/wkp/jquery.easing.js"></script>
<script src="/js/egovframework/com/wkp/owl.carousel.min.js"></script>
<script src='/js/egovframework/com/wkp/jquery.matchHeight-min.js'></script>
<script src="/js/egovframework/com/wkp/hummingbird-treeview-1.3.js"></script>
<script src="/js/egovframework/com/wkp/jquery.mCustomScrollbar.concat.min.js"></script>
<!-- <script src="/js/egovframework/com/wkp/jquery.datetimepicker.full.js"></script> -->
<script src="/js/egovframework/com/wkp/ui.js"></script>
</body>
</html>