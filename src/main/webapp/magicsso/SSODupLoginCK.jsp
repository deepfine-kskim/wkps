<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.dreamsecurity.sso.config.SSOConfig" %>
<%@ page import="com.dreamsecurity.sso.crypto.util.EncFunc" %>
<%@ page import="com.dreamsecurity.sso.crypto.util.HashEncFunc" %>
<%@ page import="com.dreamsecurity.sso.service.SSOService" %>
<%@ page import="com.dreamsecurity.sso.service.SSOServiceFactory" %>
<%@ page import="com.dreamsecurity.sso.message.SSOResp"%>
<%@ page import="com.dreamsecurity.sso.common.SSOBase"%>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="com.dreamsecurity.sso.log.Logger" %>
<%@ page import="com.dreamsecurity.sso.log.LoggerFactory" %>
<%@ page import="com.dreamsecurity.sso.service.SSOApiBase" %>
<%@ include file="./ssoCommon.jsp"%>
<%!
    
   //private  Logger log = LoggerFactory.getInstance().getLogger(this.getClass());
	
	private void homepathCheck(String newpath){
		String homepath = System.getProperty("dreamsecurity.home.path");
		//log.debug("current dreampath : "+homepath);
		if(null == homepath || "".equals(homepath)){
			System.setProperty("dreamsecurity.home.path",newpath);
			//log.debug("new dreampath : "+newpath);
		}
	}
%>

<%
	System.out.println(" ===== DupLoginCheck START =============================================");
	NumberFormat nf = new DecimalFormat("000000");
	String encryptedData = request.getParameter("ED");
	SSOService service = null;
	SSOResp resp = null;
	// Service 초기화
	try 
	{
		service = SSOServiceFactory.getInstance(DREAM_HOME).getService(session);
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("encryptedData :: "+encryptedData);
	String tokens = null;
	String encryptedTokens = null;
	
	
	

		// test data 만들기
		/*
		String testMac = "60-EB-69-7E-36-69|00-1D-E1-3B-9E-24|00-0D-F0-8F-61-40|00-50-56-C0-00-01|00-50-56-C0-00-07";
		String testId = "sso";
		mnApi.encryptSym(testId+"^@^"+testMac);
		String testEnc = mnApi.getResult();
		System.out.println(" ### Test data  : "+testEnc);
		mnApi.setResult("");
		*/
		// 중복로그인 확인
		
		System.out.println("User ip : "+request.getRemoteAddr());
		String _SEP = "^@^";
		if(null == encryptedData || "".equals(encryptedData)){
			out.print(nf.format(0));
			return;
		}
		encryptedData = encryptedData.replaceAll(" ", "+");
		resp = service.decryptSym(encryptedData);
		String idmac = "";
		String userId = "";
		String macAddr = "";
		if(resp.getCode() == 0){
			idmac = resp.getMessage();
			StringTokenizer st = new StringTokenizer(idmac,_SEP);
			for(int i=0; st.hasMoreTokens(); i++)
			{
				String val = st.nextToken();
				switch(i){
				case 0 : userId = val; break;
				case 1 : macAddr = val; break;
				default : break;
				}
			}
			System.out.println("idmac :: "+idmac);
			System.out.println("userId :: "+userId);
			System.out.println("macAddr :: "+macAddr);
			if(null == macAddr || "".equals(macAddr)){
				out.print(nf.format(0));
				return;
			}
			resp = service.dupLoginCheck(userId, macAddr, request.getRemoteAddr());
			System.out.println(resp.getCode());
			int returnCode = resp.getCode();
			if (returnCode ==  SSOApiBase.RET_DUP_LOGIN)
			{
				System.out.println(" userID : "+userId+" || macAddr : "+macAddr);
				System.out.println(" response : "+999999+resp.getMessage());
				out.print(999999+resp.getMessage());
			}
			else
			{
				out.print(nf.format(0));
			}
		}
		else{
			out.print(nf.format(0));
		}
		

	
%>
