<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="./ssoCommon.jsp" %>
<%
		String returnUrl		 =  XSSCheck(request.getParameter("returnUrl"));
		session.removeAttribute("SSO_ID");
		session.invalidate();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Logout</title>
	<object classid='CLSID:AD6870C0-44B7-42FB-A119-C2C6BD9CD005' id='MagicPassDirect' width='1' height='1'></object>
	<script type="text/javascript" src="./js/deployJava.js" charset="utf-8"></script>
	<script type="text/javascript" src="./js/MagicPass.js" charset="utf-8"></script>
	<script type="text/javascript" src="./js/Logout.js" charset="utf-8"></script>
	
</head>
<body>
<div id="MagicLineArea"></div>
<script type="text/javascript" defer="defer">

	    //<![CDATA[
		//다음과 같이 MagicPass.job에 로그아웃을 실행하도록 하면, 매직패스가 설치되지 않은 사용자는
		//MagicPass Plugin이 로딩 완료될 때 호출되는 job이 처리되지 않음으로 감안하여 사이트에 맞게 처리하세요.
		
		//MagicPass.siblingLogout(); 
		var logout = new Logout("<%=returnUrl%>");

		MagicPass.job("매직패스 로그아웃", function(){
			logout.start();
		});
		if(Client.browser == "MSIE")
        {
                MagicPass.alias = "MagicPassDirect";
                MagicPass.object = document.getElementById("MagicPassDirect");
                MagicPass.usable = true;
                MagicPass.jobExecute();
        }
        
	//]]>
	</script>
</body>
</html>