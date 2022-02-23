<%@ page contentType="text/html; charset=utf-8"
    import="java.util.List"
    import="java.util.ArrayList"
    import="java.util.Enumeration"
    import="java.util.Map"
    import="java.util.HashMap" 
    import="java.util.StringTokenizer"
    import="com.dreamsecurity.sso.config.SSOConfig"
    import="com.dreamsecurity.sso.common.SSOBase"
    import="com.dreamsecurity.sso.service.SSOService"
    import="com.dreamsecurity.sso.service.SSOServiceFactory"
    import="com.dreamsecurity.sso.message.SSOResp"
    import="com.dreamsecurity.sso.common.SSOException"
    import="com.dreamsecurity.sso.extra.ApplicationStore"
    import="com.dreamsecurity.sso.extra.SessionCrypto"
%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ include file="./ssoCommon.jsp"%>
<%!
    
    static{
    	
    }
	private void setUserInformation(SSOService service, HttpServletRequest request ,HttpServletResponse httpResponse) 
	{
		/** 이블록은 필수 세팅부분 수정불가 (시작)**/
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute(S_LOGIN_IP, request.getRemoteAddr());
		httpSession.setAttribute(S_LOGIN_ID, service.getTokenValue(T_USER_ID));
		httpSession.setAttribute(S_LOGIN_NAME, service.getTokenValue(T_LOGIN_NAME));
		/** 이블록은 필수 세팅부분 수정불가 (끝)**/
		
		httpSession.setAttribute(S_PW, service.getTokenValue(T_PW));
		httpSession.setAttribute(S_COMP_CODE, service.getTokenValue(T_COMP_CODE));
		httpSession.setAttribute(S_SN_VALIDATE, service.getTokenValue(T_SN_VALIDATE));
		httpSession.setAttribute(S_PW_VALIDATE, service.getTokenValue(T_PW_VALIDATE));
		httpSession.setAttribute(S_LASTLOGIN_CHECK, service.getTokenValue(T_LASTLOGIN_CHECK));
	}
	

%>
<%
    JSONObject respObj = new JSONObject();
	String actionName = XSSCheck(request.getParameter("actionName"));
	ApplicationStore store = ApplicationStore.getInstance();
	respObj.put("actionName",actionName);
	boolean success = false;
	int code = -1;
	String message = "";
	String etc = "";
	boolean tcheck= false;
	
	SSOService  service = null;
	SSOResp resp = null;
	// Service 초기화
	try {
		service = SSOServiceFactory.getInstance(DREAM_HOME).getService(request);
	if ("SESS_ALIVE".equals(actionName))
	{
		resp = service.sessionAlive(S_LOGIN_ID, request);
	} 
	else if ("SESS_CLEARED".equals(actionName))
	{
		resp = service.sessionClear(S_LOGIN_ID, request);
	} 
	else if ("LOGIN_SESSION_CHECK".equals(actionName))
	{
		if (session.getAttribute(S_LOGIN_NAME) != null) {
			session.invalidate();
		} 
		else 
		{
			session.invalidate();
		}
	}
	else if ("GET_SERVER_CERTIFICATION".equals(actionName))
	{
		resp = service.getServerCertificate(session);
	} 
	else if ("INIT_KEY".equals(actionName)) 
	{
		System.out.println(" ===== INIT_KEY START   ===== ");
		String initialSessionKey = XSSCheck(request.getParameter("initialSessionKey"));
		initialSessionKey = initialSessionKey.replaceAll(" " , "+");
		System.out.println(" ## initialSessionKey = "+initialSessionKey);
		resp = service.keyexchange(initialSessionKey);
		SessionCrypto sc = new SessionCrypto();
		String trid = store.getTranjactionId(Thread.currentThread().getId());
		service.setCryptoInfo(sc);
		store.setCryptoInfo(trid, sc);
		respObj.put("trid",trid);
		//store.setCryptoInfo(trid, service., timeStamp);
			
	} else if ("CONNECT".equals(actionName)) {
		System.out.println(" ===== CONNECT START   ===== ");
		String trid = request.getParameter("trid");
		System.out.println(" ########## trid : "+trid);
		SessionCrypto sc = store.getCryptoInfo(trid);
		service.putCryptoInfo(sc);
		
		boolean isMultiDomain = new Boolean(XSSCheck(request.getParameter("isMultiDomain"))).booleanValue();
		String ssoEncryptedData = XSSCheck(request.getParameter("ssoEncryptedData"));
		String macAddr ="";
		String encMacAddr = XSSCheck(request.getParameter("macAddr"));
		try{
			resp = service.decryptSym(encMacAddr);
			if( 0 == resp.getCode())
			{
				macAddr = resp.getMessage();	
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		resp = service.connect(ssoEncryptedData);
		if(0 == resp.getCode()){
			if (isMultiDomain) {
				session.setAttribute("IDENTITY_KEY",service.getID());
			} else {
				session.setAttribute(S_TOKEN, service.getToken());
				setUserInformation(service, request, response);
			}
		}
		session.setAttribute(SSOBase.S_USER_MACADDR, macAddr);
		service.clear();
		store.delCryptoInfo(trid);
		
	} else if ("LOGIN".equals(actionName)) {
		String macAddr = "";
		String encMacAddr = "";
		
		String ssoEncryptedData = XSSCheck(request.getParameter("ssoEncryptedData"));
		String ssoLoginType = XSSCheck(request.getParameter("ssoLoginType"));
		String applicationCode = XSSCheck(request.getParameter("ssoApplicationCode"));
		
		
		// 사용자 정보 가져오기 테스트 (끝)
		boolean isEam 				  = new Boolean(XSSCheck(request.getParameter("isEam"))).booleanValue();
		boolean isMultiDomain = new Boolean(XSSCheck(request.getParameter("isMultiDomain"))).booleanValue();
		
		String identityKey = (String) session.getAttribute("IDENTITY_KEY");
		
		identityKey = (identityKey == null || "".equals(identityKey))?(String)session.getAttribute(S_LOGIN_ID):identityKey;
		String compCode = (session.getAttribute(S_COMP_CODE)==null )? _DEF_SITECODE : (String)session.getAttribute(S_COMP_CODE);
		
		encMacAddr = XSSCheck(request.getParameter("macAddr"));
		resp = service.decryptSym(encMacAddr);
		if( 0 == resp.getCode()){
			macAddr = resp.getMessage();	
			session.setAttribute(SSOBase.S_USER_MACADDR, macAddr);
		}
		
		session.removeAttribute("IDENTITY_KEY");
		
		Map loginParam = new HashMap();
		loginParam.put(SSOBase.P_ENCRYPTED_DATA,ssoEncryptedData);
		loginParam.put(SSOBase.P_LOGIN_TYPE,ssoLoginType);
		loginParam.put(SSOBase.P_APPLICATION_CODE,applicationCode);
		loginParam.put(SSOBase.P_IS_MULTIDOMAIN,isMultiDomain);
		loginParam.put(SSOBase.P_COMP_CODE,compCode);
		loginParam.put(SSOBase.P_IDENTITY_KEY,identityKey);
		loginParam.put(SSOBase.P_USER_IP,request.getRemoteAddr());
		loginParam.put(SSOBase.P_MAC_ADDR,macAddr);
		
		resp = service.login(loginParam);
		
		if(0 == resp.getCode())
		{
			session.setAttribute(S_TOKEN, service.getToken());
			setUserInformation(service, request, response);
			String tc = service.getTokenValue(T_T_CHECK);
			if(tc != null && "Y".equals(tc))
				tcheck=true;
		}
		service.clear();
		
	} else if ("CIPHER".equals(actionName)) {
		resp = service.encryptURL(XSSCheck(request.getParameter("source")));
		if(0==resp.getCode()){
			out.clear();
			response.setContentType("text/html");
			out.println(resp.getMessage());
		}
		return;
	// 기존 로그아웃 ( Logout.js 를 통해서 들어오는 요청 처리)
	}else if("LOGOUT".equals(actionName)){	
		//String userid = XSSCheck(request.getParameter("ssoid"));
		//resp = service.logout(userid, request.getRemoteAddr());
		
		Enumeration en = session.getAttributeNames();
		while(en.hasMoreElements()){
			Object oid = en.nextElement();
			if(oid == null) continue;
			session.removeAttribute((String)oid);
		}
		
	// 신규 로그아웃 처리(매직패스에서 다이렉트로 들어오는 로그아웃처리)	
	}else if("LOGOUTC".equals(actionName)){	
		String DLF = request.getParameter("DL");
		String encId = request.getParameter("ssoid");
		String encMac = request.getParameter("ED");
		
		System.out.println(" ##### DLF : "+DLF);
		System.out.println(" ##### MagicPass Direct Logtout START  ##### ");
		System.out.println(" ##### sessionId :: "+request.getSession().getId());
		
		encId = encId.replaceAll(" ","+");
		encMac = encMac.replaceAll(" ","+");
		resp = service.logoutC(encId, encMac, request.getRemoteAddr(), DLF);
		
	}
	resp = respCheck(resp);
	
	} catch (SSOException e) {
		e.printStackTrace();
		resp = new SSOResp();
		resp.setSuccess(false);
		resp.setCode(e.getErrorCode());
		resp.setMessage(e.toString());
	} catch (Exception e) {
		e.printStackTrace();
		resp = new SSOResp();
		resp.setSuccess(false);
		resp.setCode(6666);
		resp.setMessage(e.toString());
	}
	respObj.put("success",resp.isSuccess());
	respObj.put("code",resp.getCode());
	respObj.put("message",resp.getMessage());
	response.getWriter().write(respObj.toString());
%>
<%!
	private SSOResp respCheck(SSOResp resp){
		if(null == resp){
			resp = new SSOResp();
			resp.setCode(-1);
			resp.setSuccess(false);
			resp.setMessage("");
		}
		return resp;
	}
%>