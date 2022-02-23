<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.net.URLDecoder" %>
<%@ include file="./ssoCommon.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
	String urlName = "returnUrl=";
	String returnUrl = getNextUrl(request.getQueryString(), urlName);
	try{
		returnUrl = URLDecoder.decode(returnUrl, "UTF-8");
	}catch(Exception e){}
	
	System.out.println(" ### returnUrl : "+returnUrl);
	
	//post 방식일때 
	boolean isPost = ("POST".equals(request.getMethod().toUpperCase()))?true:false;
	
%>
<%!
public String getNextUrl(String fullPath,String urlName){
	if(null == fullPath) return "";
	int idx = fullPath.indexOf(urlName);
	String nextURL = "";
	if(idx > -1)
		nextURL =  fullPath.substring(idx+urlName.length());
	return nextURL;
}
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<!-- object classid='CLSID:AD6870C0-44B7-42FB-A119-C2C6BD9CD005' id='MagicPassDirect' width='1' height='1'></object>  -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Connect</title>
	<script type="text/javascript" src="./js/MagicPass.js" charset="utf-8"></script>
	<script type="text/javascript" src="./js/Connect.js" charset="utf-8"></script>
	<script type="text/javascript">
	//<![CDATA[

	//]]>
	</script>
	<script type="text/javascript" defer="defer">
		isPost = <%=isPost%>;
		<% 
		if(isPost){
			int cnt = 0;
			Enumeration pNames = request.getParameterNames();
			while(pNames.hasMoreElements()){
				Object key = pNames.nextElement();
				if(key != null){
					if("returnUrl".equals((String)key))
						returnUrl = XSSCheck(request.getParameter((String)key));
					else{
		%>
		valueBasket[<%=cnt%>] = new Array("<%=(String)key%>","<%=XSSCheck(request.getParameter((String)key))%>");		
		<%		
						cnt ++;
					}
				}
			}
		}
		%>

		var returnUrl = "<%= returnUrl %>";
		var connect = new Connect(returnUrl);
		MagicPass.job("매직패스 로그인 연계", function(){
			connect.start();
		});
		/*
		if(Client.browser == "MSIE")
        {
                MagicPass.alias = "MagicPassDirect";
                MagicPass.object = document.getElementById("MagicPassDirect");
                MagicPass.usable = true;
                MagicPass.jobExecute();
        }
        */
	</script>
</head>
<body>
</body>
</html>