<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>SSO 로그인 샘플페이지</title>

<!-- SSO Script (시작) -->
<script type="text/javascript" src="./js/deployJava.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/MagicLine.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/MagicPass.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/Login.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/Certificate.js" charset="utf-8"></script>
<script type="text/javascript" src="./js/cookie.js" charset="utf-8"></script>
<!-- SSO Script (끝) -->
<script type="text/javascript">

	function applyStyle()
	{
		try
		{
			if (navigator.appVersion.indexOf("MSIE 7.0") >= 0 || navigator.appVersion.indexOf("MSIE 8.0") >= 0)
			{
				document.body.style.cssText = "margin:0 0 0 0";
				document.getElementById("mainPage").style.position = "absolute";
				document.getElementById("mainPage").style.width = "100%";
				document.getElementById("mainPage").style.height = "100%";
			}
			else if (navigator.appVersion.indexOf("MSIE 6.0") >= 0)
			{
				document.getElementById("ssoPluginPage").style.zIndex = -1;
				document.getElementById("ssoPluginPage").style.position = "absolute";
				document.getElementById("ssoPluginPage").style.left = 0;
				document.getElementById("ssoPluginPage").style.top = 0;
			}
			else
			{
				document.body.style.cssText = "margin:0 0 0 0";
				document.getElementById("mainPage").style.position = "absolute";
				document.getElementById("mainPage").style.width = "100%";
				document.getElementById("mainPage").style.height = "100%";

				document.getElementById("ssoPluginPage").style.cssText = "visibility: hidden";
			}
		}
		catch (e)
		{
			alert(e.message);
		}
	}

	if (window.attachEvent)
	{
		window.attachEvent("onload", applyStyle);
	}
	else if (window.addEventListener)
	{
		window.addEventListener("load", applyStyle, false);
	}
	
	function getKey(keyStroke) 
    {
        if (window.event.keyCode == 13)
        {
        	ssoLogin();
        }
    }  
	
	document.onkeypress = getKey;
</script>
</head>

<body style="position: absolute; margin: 0 0 0 0;" bgcolor="#E6E6E6">
	<div id="mainPage">
		<!-- SSO를 위해서는 폼 이름을 loginForm으로 해야 함. -->
		<form name="loginForm" id="loginForm" method="post">
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<table width="520" bgcolor="#FFFFFF" border="0" cellpadding="0"	cellspacing="0" align="center">
							<tr>
								<td>
									<table width="500" border="1" bordercolor="#E1E1E1" style="border-collapse: collapse" cellpadding="0" cellspacing="0" align="center">
										<tr>
											<td>
												<table width="100%" border="0" cellpadding="0" cellspacing="0">
												    <!-- Main Image 영역(시작) -->
													<tr>
														<td width="500" valign="top"><img	 src="img/login_main_img_03.jpg" border="0"></td>
													</tr>
													 <!-- Main Image 영역(끝) -->
													 
													 <!-- Text 영역(시작) -->
													<tr>
														<td width="520" valign="top">
															<table width="520" border="0" cellpadding="0" cellspacing="0" >
																<tr>
																	<td colspan="3" height="5"></td>
																</tr>
																<tr>
																	<!--  아이디/패스워드 로그인(시작) -->
																	<td width="350" colspan="2">
																		<table width="100%" border="0" cellpadding="0" cellspacing="0" >
																			<tr>
																				<td width="3"/>
																				<td width="67"><font COLOR="#7D7D7D">아이디</font></td>
																				<td height="30" width="130">
																					<input type="text" name="loginId"	id="loginId" value="sso" class="td_input" width="100%" size="20">
																				</td>
																				<td rowspan="2"  width="120" align="center"><img src="img/admin_login_btn_04.gif" id="loginImg" width="110" height="50" border="0" style="cursor:pointer;"></td>
																			</tr>
																			<tr>
																				<td width="3"/>
																				<td width="67"><font COLOR="#7D7D7D">비밀번호</font></td>
																				<td height="30"><input type=password name="loginPwd" id="loginPwd" value="sso123" class="td_input" width="100%" size="21"></td>
																			</tr>
																		</table>
																	</td>
																	<!--  아이디/패스워드 로그인(끝) -->
																	
																	<!-- 인증 로그인(시작) -->
																	<td width="170"> <img src="img/admin_login_btn_05.gif" id="certificateButton" width="135" height="50" border="0" style="cursor:pointer;"></td>
																	<!-- 인증 로그인(끝) -->
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- Copy right (시작) -->
				<tr>
					<td>
						<table width="100%" height="35" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center">Copyrightⓒ2010 by DreamSecurity ALL RIGHT RESERVED.</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- Copy right (끝) -->
		</table>
</form>


	</div>
	<div id="ssoPluginPage">
		<div id="pluginArea"></div>
		<div id="xsignArea"></div>
	</div>
    
    <!-- SSO Script (시작) -->
	<div id="MagicLineArea"></div>
	<script type="text/javascript" defer="defer">
	function ssoLogin()
    {
		login.start();
	 }
	
	//<![CDATA[
		var returnUrl = null;
		
		var login = new Login("loginId", "loginPwd", returnUrl);

		if(MagicPass.option.useCertificate)
			var certificate = new Certificate(returnUrl);
		
		MagicPass.addEvent("loginImg", "click", function(){
			MagicPass.job("Execute Login", function(){
				ssoLogin();
			});
		});
		
		MagicPass.job("로그인ID 포커스 이동", function() {
			var loginId = document.getElementById("loginId");
			if(loginId && !loginId.value) loginId.select();
		});
		
		var certificate;

		if(MagicPass.option.useCertificate && !MagicPass.option.useApplet)
			certificate = new Certificate(returnUrl);
		MagicPass.addEvent("certificateButton", "click", function(){
	    	if(MagicPass.option.useApplet)
				certificate = new Certificate(returnUrl);
			 certificate.start();
		});
	//]]>
	</script>
	   <!-- SSO Script (끝) -->
</body>

</html>