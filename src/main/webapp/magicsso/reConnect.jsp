<%@ page contentType="text/html; charset=utf-8" %>
<%
	String returnUrl = getNextUrl(request.getQueryString(), "returnUrl");
	String cSiteName = "KHC1";
	String cApplCode = "APPLDEFAULT";
%>
<%!
public String getNextUrl(String fullPath,String urlName){
	if(null == fullPath || "".equals(fullPath)) return "";
	urlName  = ( null == urlName || "".equals(urlName))?"":urlName+"=";
	fullPath = (null == fullPath)?"":fullPath;
	int idx = fullPath.indexOf(urlName);
	String nextUrl = "";
	if(idx > -1)
		nextUrl =  fullPath.substring(idx+urlName.length());
	return nextUrl;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Connect</title>
	<script type="text/javascript" src="./js/MagicPass.js" charset="utf-8"></script>
	<script type="text/javascript" src="./js/MultiDomain.js" charset="utf-8"></script>
	<script type="text/javascript">
	   function showLayer(){
		   var sizeWidth = (parent.document.body) ? document.body.offsetWidth : window.screen.availWidth;
		   var parentTag = (parent.document.getElementsByTagName("body")) ? parent.document.getElementsByTagName("body")[0] : parent.document.getElementsByTagName("html")[0];			
		   //MagicPass.isSetting = true;
			
			//with(parentTag.style){width="100%";height="100%";overflow="hidden";};
			/*
			parentTag.innerHTML	= "<div style='z-index:100;position:absolute;top:0;left:0;min-weight:100%;min-height:100%;width:100%;height:100%;background:#000;filter:alpha(opacity=50);-moz-opacity:0.5;opacity:0.5'></div>"
								+ "<div style='z-index:101;position:absolute;top:200px;left:" + ((sizeWidth - 450) >> 1) + "px;'> 처리중 ...</div>"
								+ parentTag.innerHTML;
			*/
	   }
	  
	//<![CDATA[
		var returnUrl = "<%= returnUrl %>";
		var cSiteName = "<%=cSiteName%>";
		var cApplCode = "<%=cApplCode%>";
		var multiDomain = new MultiDomain(cSiteName, cApplCode, returnUrl);

		MagicPass.job("매직패스 로그인 연계", function(){
			multiDomain.start();
		});
		
	//]]>
	</script>
</head>
<body onload="showLayer();return false;">
</body>
</html>