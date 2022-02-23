MagicPass = new Object();


MagicPass.char						    = "UTF-8";
MagicPass.path						    = "/magicsso";									//매직패스 설치경로
MagicPass.siteTitle					= "경기도";										//"SITENAME";
MagicPass.siteName				= "경기도";										//"SITENAME";
MagicPass.applCode				= "APPL000005";
MagicPass.pkiType					= "NPKI";

MagicPass.protocolType		="http://";
MagicPass.baseUrl					= MagicPass.path + "/Sessionview.jsp"; //매직패스 처리 후, 이동할 URL(사이트 메인페이지)
MagicPass.loginUrl				    = MagicPass.path + "/login.jsp";	     //로그인 URL (로그인페이지와 메인페이지가 같을시 위baseUrl과 동일)
MagicPass.logoutUrl			    = MagicPass.path + "/logout.jsp";	     //로그아웃 URL
MagicPass.beforeUrl			    = MagicPass.path + "/logout.jsp";	     //로그아웃 URL
MagicPass.errorUrl					= MagicPass.path + "/error.jsp";		 //에러 페이지
MagicPass.failRtnUrl               = MagicPass.path + "/login.jsp";	
MagicPass.directLogoutUrl		= MagicPass.path +"/secure.jsp?actionName=LOGOUTC";  ////브라우저종료,매직패스종료시 로그아웃처리	(Full Path)
MagicPass.dupcheckUrl				= MagicPass.path + "/SSODupLoginCK.jsp";
MagicPass.secureUrl					= MagicPass.path + "/secure.jsp";		 //암호화 처리 URL
MagicPass.reloginUrl 				    = MagicPass.path + "/reLogin.jsp";      // reLogin처리 URL
MagicPass.tcheckUrl					= MagicPass.path+  "/SSOTokenCheck.jsp";

MagicPass.seperator                = "^@^";
MagicPass.reLogin                     = 1;

/* MagicPass Option Definitions */
MagicPass.option = new Object();
MagicPass.option.debugScript			= true;		//자바스크립트 디버그모드
MagicPass.option.debugApplet			= true;		//자바애플릿 디버그모드
MagicPass.option.useEam					= false;   	//MagicEAM
MagicPass.option.isAutoLogin			= false; 	//자동로그인(매직패스가 로그인되어 있는 상태에 접근 시, 자동으로 사이트로그인)
MagicPass.option.useCertificate		= true;		//인증서 로그인 사용여부
MagicPass.option.useApplet				= false;	    //애플릿 사용여부(IE이외에서는 자동으로 애플릿사용)
MagicPass.option.useMagicPassS		= false;	    //MagicPassS(RMI Server) 사용여부(Windows이외(Linux, Mac and etc.)에선 자동으로 MagicPassS사용)
MagicPass.option.useSessionSync	= false;		//서버와 매직패스 로그인세션을 동일하게 유지(서버세션 살아있을때 매직패스꺼져있음 사이트 로그아웃시킴.)
MagicPass.option.JS_monitor			    = {use : true, interval : 4000, object : null};		//자바스크립트 로그아웃감지(자바스크립트가 해당 interval 로 매직패스 로그아웃상태 감지)
MagicPass.option.MP_monitor			= {use : false, interval : 15000};		//매직패스의 자동세션아웃 기능(페이지가 매직패스를 해당 interval 이내에 IsLogon 호출이 없으면 로그아웃)
MagicPass.option.isTokenCheck			= false;
MagicPass.option.tcheckType				="2"; // 1:로그인서버를통해 검증, 2:연계서버를통해 검증
MagicPass.dupcheckTime			            = "10000"; // ms 단위

/* MagicPass Client-Modules Version Definitions */
MagicPass.version = {
	"MagicLoaderX"		: "0,0,0,0",
	"MagicPassX"				: "0,0,0,0",
	"MPCertX"					: "1,1,0,1",
	"passportApplet"		: "1.0.0.2",
	"passportJ"					: "1.0.0.2"
};

/* MagicPass Client-Modules Version Definitions */
/*
MagicPass.version = {
	"MagicLoaderX"		: "1,0,2,8",
	"MagicPassX"				: "1,0,5,2",
	"MPCertX"					: "1,1,0,1",
	"passportApplet"		: "1.0.0.2",
	"passportJ"					: "1.0.0.2"
};
*/
/*--------------------------------------------------------------
	In the below will be Optimazing
--------------------------------------------------------------*/

/* MagicPass runtime variable Definitions */ 
MagicPass.usable						= false;		//플러그인 사용 가능여부
MagicPass.usableCertX			= false;		//플러그인 사용 가능여부
MagicPass.isReady					= false;		//플러그인을 읽어오는 중인지 여부
MagicPass.isSetting					= false;		//매직패스 다운로드/설치 중인지 여부
MagicPass.isPageLoaded		= false;		//페이지및 플러그인 로딩 완료 여부
MagicPass.isJobExecuted		= false;		//저장된 job의 실행 여부
MagicPass.versionVerified	= false;		//매직패스의 버전 확인 여부
MagicPass.serverCertificate	= null;		//멀티도메인연계될때 현재 어플리케이션 코드 저장
MagicPass.loginType				= null;		//로그인타입

MagicPass.cookieName			= "_MPSC_" + window.location.host + "_";		//서버인증서를 담을 쿠키명

/* Setting Definitions */
MagicPass.alias				= "MagicPassPlugin";		//플러그인 별칭
MagicPass.element			= document.getElementById("MagicPassPluginArea");
MagicPass.object			= document.getElementById(MagicPass.alias);		//ActiveX의 MagicPassX 객체
MagicPass.objectLoaderX		= document.getElementById("MagicLoaderX");		//ActiveX의 MagicLoadeX 객체
MagicPass.objectCertX		= document.getElementById("MagicLine");		    //ActiveX의 (N)MPCertX 객체
MagicPass.executeFile		= "DreamSecurity\\MagicPass\\MagicPass.exe";
MagicPass.offlineUrl		    = MagicPass.path + "/installer.html";

MagicPass.configFile			= MagicPass.protocolType + window.location.host + MagicPass.path + "/plugins/setup.conf";
MagicPass.onlineFile			= MagicPass.protocolType + window.location.host + MagicPass.path + "/plugins/setupOnLine.exe";
MagicPass.updateFile			= MagicPass.protocolType + window.location.host + MagicPass.path + "/plugins/setupOnLine_update.exe";
MagicPass.settingFile			= MagicPass.protocolType + window.location.host + MagicPass.path + "/plugins/setupOnLine_update_setting_file.exe";
MagicPass.onlineUrl			= MagicPass.protocolType + window.location.host + MagicPass.secureUrl + "?actionName=CIPHER&source=" + MagicPass.onlineFile;
MagicPass.updateUrl			= MagicPass.protocolType + window.location.host + MagicPass.secureUrl + "?actionName=CIPHER&source=" + MagicPass.updateFile;
MagicPass.settingUrl			= MagicPass.protocolType + window.location.host + MagicPass.secureUrl + "?actionName=CIPHER&source=" + MagicPass.settingFile;
MagicPass.executeUrl			= MagicPass.protocolType + window.location.host + MagicPass.secureUrl + "?actionName=CIPHER&source=" + MagicPass.executeFile;

//2012.03.28 applet 사용을 위한 URL define
MagicPass.appleteUrl		= MagicPass.protocolType + window.location.host + MagicPass.path + "/plugins/applet/";
//MagicPass.isMacCheck=true;

/* Login Settings Definitions */
MagicPass.ID								    = 0;		        //아이디 로그인
MagicPass.SSN								= 1;		        //주민번호 로그인
MagicPass.EMPNO						= 2;		        //사원번호 로그인
MagicPass.CERT							= 3;		        //인증서 로그인
MagicPass.CRYPTO_ALGO			= "48";		        //로그인 암호화 알고리즘
MagicPass.MULTI_LOGIN      	 = 4;
MagicPass.MACCHECK		  	 	 = 7;		        //아이디+MacAddress
MagicPass.ONLY_ID						= 8;

/* Client Environment Definitions */
Client = new Object();
Client.os							= null;		//사용자 OS 종류
Client.browser				= null;		//사용자 브라우저 종류
Client.x64				= false;	//사용자 브라우저 64비트 여부


(function(){
	var userAgent=navigator.userAgent.toUpperCase();
	var browserList=["MSIE","TRIDENT","FIREFOX","CHROME","SAFARI","OPERA"];
	
	var mobileKeyWords = new Array('IPHONE', 'IPAD', 'IPOD', 'BLACBERRY', 'ANDROID', 'WINDOWS CE', 'LG', 'MOT', 'SAMSUNG', 'SONYERICSSON');
	for (var word in mobileKeyWords){
	    if (userAgent.match(mobileKeyWords[word]) != null){
	        location.href = "./mobile/mlogin.jsp";
	        break;
	    }
	}
	
	Client.browser = "OTHERS";
	for(var i in browserList)
	{
		if(userAgent.indexOf(browserList[i])>-1)
		{
			Client.browser=browserList[i];
			if(Client.browser =="TRIDENT")
				Client.browser="MSIE";
			break;
		}
	}
	
	var platform = navigator.platform.toUpperCase();
	var osList       = ["WIN", "MAC", "LINUX"];

	Client.os = "OTHERS";
	for(var i in osList)
	{
		if(platform.indexOf(osList[i])>-1)
		{
			Client.os=(osList[i]=="WIN")?"WINDOWS":osList[i];
			break;
		}
	}
	
	if (userAgent.indexOf("X64") != -1)
		Client.x64 = true;
	
	if(Client.os != "WINDOWS")
		MagicPass.option.useMagicPassS=true;
	if(Client.browser != "MSIE")
		MagicPass.option.useApplet = true;

	if(window.addEventListener) document.addEventListener("DOMContentLoaded", function(){MagicPass.isPageLoaded = true;}, false);
	else if(window.attachEvent) document.attachEvent("onreadystatechange", function(){MagicPass.isPageLoaded = true;});
})();

/*--------------------------------------------------------------
	Function Definitions
--------------------------------------------------------------*/
/**
 * 매직패스 플러그인이 로딩된 이후 실행하도록, 작업될 내용을 Queue에 적재합니다.
 * 이미 로딩 되어있는 경우, 바로 실행시킨다.
 * 
 * @param {String} title 작업명(작업인식용 텍스트)
 * @param {Function} job 작업 스크립트 함수
 * @param {Function} functionClass 작업 객체가 클래스형식일 경우, 클레스 입력(생략가능)
 * @since MagicPass Prototype 2.2 
 */
MagicPass.job = function(title, job, functionClass)
{

	if(!MagicPass.isJobExecuted)
	{
		if(MagicPass.job.queue == null)
		{
			MagicPass.job.queue = [];
		}
		else
		{
			for(var i in MagicPass.job.queue)
			{
				if(MagicPass.job.queue[i][0] === title)
				{
					MagicPass.job.queue[i][0] = title;
					MagicPass.job.queue[i][1] = job;
					MagicPass.job.queue[i][2] = functionClass;
					return;
				}
			}
		}
		
		MagicPass.job.queue.push([title, job, functionClass]);
	}
	else
	{
		MagicPass.log("INFO", title);
		(job).call(functionClass);
	}
};

/**
 * MagicPass.job에서 적재한 작업을 수행합니다.
 * 
 * @since MagicPass Prototype 2.2
 */
MagicPass.jobExecute = function()
{ 
	try
	{
		if(MagicPass.object.GetStatus(MagicPass.siteName))
		{
			MagicPass.usable = true;
	
			if(Client.browser == "MSIE" || document.readyState === "complete" || MagicPass.isPageLoaded)
			{	
				if(MagicPass.job.queue != null)
				{
					if(!MagicPass.isJobExecuted)
					{
						MagicPass.isJobExecuted = true;
						
						for(var i = 0; i < MagicPass.job.queue.length; i++)
						{
							MagicPass.log("INFO", MagicPass.job.queue[i][0]);
							MagicPass.log("INFO", MagicPass.job.queue[i][1]);
							MagicPass.log("INFO", MagicPass.job.queue[i][2]);
							(MagicPass.job.queue[i][1]).call(MagicPass.job.queue[i][2]);
						}
					}
				}
			}
			else
				throw "Page loading is not yet";
		}
	}
	catch(e)
	{
		//console.error(e);
		window.setTimeout(MagicPass.jobExecute, 3000);
	}
};

/**
 * 브라우저 콘솔에 로깅합니다. 
 * (단, 브라우저 콘솔을 지원 안하는 브라우저(IE, Opera등)는 디버깅 콘솔을 <div>로 생성합니다.)
 * 
 * @param {String} type 로그타입(LOG, INFO, ERROR) 생략가능
 * @param {String} str 로그메세지
 * @since MagicPass Prototype 2.1
 */
MagicPass.log = function(type, str)
{
	if(!MagicPass.option.debugScript) return;

	try
	{
		if(type === "INFO")
			console.info(str);
		else if(type === "ERROR")
			console.error(str);
		else
			console.log(type);
	}
	catch(e){}
};

/**
 * 매직패스를 초기화 합니다.
 * 
 * @since MagicPass Prototype 2.1
 */
MagicPass.init = function(siteName)
{
	MagicPass.log("INFO", "init");

	var site = siteName || MagicPass.siteName;
	
	var pkiType = (MagicPass.pkiType == "GPKI")? 0 : 1;
	MagicPass.loginType = (MagicPass.loginType == null) ? MagicPass.ID : MagicPass.loginType;
	var retval = (MagicPass.object.Init(pkiType, MagicPass.CRYPTO_ALGO, MagicPass.loginType, site) == 0) ? true : false;
	return retval;
};

/**
 * 해당리소스에 접근가능한지 체크
 * return 0: 권한없음 1:리소스접근가능
 */
MagicPass.isResc = function(siteName,applcode,resccode)
{
        MagicPass.log("INFO", "isResc");

        var site = siteName || MagicPass.siteName;

        return MagicPass.object.isResc(site,applcode,resccode); 
};

/**
 * 리소스의 세부권한 체크
 */
MagicPass.getRoleFlag = function(siteName,applcode,resccode)
{
        MagicPass.log("INFO", "isResc");

        var site = siteName || MagicPass.siteName;

        MagicPass.object.getRoleFlag(site,applcode,resccode); 
	return MagicPass.object.Result;
};



/**
 * 기능 실행 후, 결과값을 받습니다.
 * 
 * @since MagicPass Prototype 2.2
 */
MagicPass.getResult = function()
{
	return (MagicPass.option.useApplet) ? MagicPass.object.Result() : MagicPass.object.Result;
	
};

/**
 * 해당 사이트명의 토큰을 로그아웃시킵니다.
 *
 * @param {String} siteName 사이트명(생략가능)
 * @since MagicPass Prototype 1.0
 */
MagicPass.logout = function(siteName)
{
	var site = siteName || MagicPass.siteName;
	MagicPass.log("INFO", "logout");
	try
	{
		MagicPass.object.Logout(site);
	}
	catch(e){ MagicPass.log(e);}
};

/**
 * 사이트를 로그아웃합니다.
 * 
 * @param {String} returnUrl 로그아웃 이후 이동할 URL
 * @param {String} siteName 사이트명
 * @since MagicPass Prototype 2.0
 */
MagicPass.siteLogout = function(returnUrl, siteName)
{
	var site = siteName || MagicPass.siteName;
	var url = new String(returnUrl);

	MagicPass.log("INFO", "site logout");

	MagicPass.logout(site);
	MagicPass.log("INFO", "MagicPass OFF");
	MagicPass.request("SESS_CLEARED",MagicPass.sessionCheck, null, {"wauf":"MagicPass.js"},null,true);
	MagicPass.log("INFO", "logouturl send req");
	if(url.isNull())
		//window.location.reload();
		window.location.replace(MagicPass.loginUrl);
	else
		window.location.replace(returnUrl);
};

/**
 * 로그인시 중복로그인 확인을 위한 모니터링 URL세팅
 * 
 * @param {String} logoutUrl logout.jsp의 풀경로
 * @param {String} siteName 사이트명
 * @since MagicPass Prototype 2.0
 */
MagicPass.setMonitorUrl = function(siteName, monitorURL)
{
 var site = siteName || MagicPass.siteName;
 var URL = monitorURL || MagicPass.monitorURL;
 MagicPass.log("INFO", "monitorURL");
 try
 {
  //MagicPass.object.SetLogoutURL(site, URL);
 }
 catch(e){}
};

/**
 * 로그아웃시 logout.jsp를 호출합니다.
 * 
 * @param {String} logoutUrl logout.jsp의 풀경로
 * @param {String} siteName 사이트명
 * @since MagicPass Prototype 2.0
 */
MagicPass.setDirectLogoutURL = function(siteName, logoutUrl)
{
 var site = siteName || MagicPass.siteName;
 var URL = logoutUrl || MagicPass.protocolType+window.location.host+MagicPass.directLogoutUrl;
 MagicPass.log("INFO", "logout");
 try
 {
  MagicPass.object.SetLogoutURL(site, URL);
 }
 catch(e){}
};

/**
 * Token 검증을 위한 URL
 */
MagicPass.setTokenCheckURL = function(siteName, tcheckUrl, ctype){
	var site = siteName || MagicPass.siteName;
	var URL  = tcheckUrl || MagicPass.protocolType+window.location.host+MagicPass.tcheckUrl;
	var type = ctype || MagicPass.option.tcheckType;
	MagicPass.log("INFO", "setTokenCheckURL : "+URL);
	return MagicPass.object.SetTCheckURL(site, URL, type);
};

/**
 * Token 검증을 위한 URL
 */
MagicPass.getTokenCheckURL = function(tcheckUrl){
	var URL  = tcheckUrl || MagicPass.protocolType+window.location.host+MagicPass.tcheckUrl;
	MagicPass.log("INFO", "getTokenCheckURL : "+URL);
	return URL;
};

MagicPass.setDupCheckURL = function(siteName, dupcheckURL, checktime)
{
	var site = siteName || MagicPass.siteName;
	var URL  = dupcheckURL || MagicPass.protocolType+window.location.host+MagicPass.dupcheckUrl;
	var time = checktime || MagicPass.dupcheckTime;
	MagicPass.log("INFO", "MagicPass.setDupCheckURL : "+URL);
	return MagicPass.object.SetDupCheckURL(site, URL, time);
};

/**
 * 서버인증서로 감싼(Envelope)한 키값을 구합니다.
 *
 * @param {Boolean} isConnect 연계처리 여부
 * @param {String} siteName 사이트명(생략가능)
 * @param {String} applCode 어플리케이션코드(생략가능)
 * @return {Number} 0이면 성공
 * @since MagicPass Prototype 2.2
 */
MagicPass.getEnvKey = function(isConnect, siteName, applCode)
{
	var site = siteName || MagicPass.siteName;
	var appl = applCode || MagicPass.applCode;
	var code = null;
	
	MagicPass.log("INFO", "getEnvKey " + (isConnect ? "for connect " : "for login "));

	return (isConnect) ? MagicPass.object.GetAppEnvKey(site, appl, MagicPass.serverCertificate) : MagicPass.object.GetLogonEnvKey(site, MagicPass.serverCertificate);
};

/**
 * 암호화 검증을 위한 세션키를 교환합니다.
 *
 * @param {String} encryptKey 암호화키
 * @param {String} siteName	 사이트명(생략가능)
 * @return {Number} 0이면 성공
 * @since MagicPass Prototype 2.2
 */
MagicPass.changeKey = function(encryptKey, isConnect, siteName, applCode)
{
	var site = siteName || MagicPass.siteName;
	var appl = applCode || MagicPass.applCode;
	
	MagicPass.log("INFO", "changeKey " + (isConnect ? "for connect " : "for login "));

	return (isConnect) ? MagicPass.object.ChangeAppKey(site, appl, encryptKey) : MagicPass.object.ChangeLogonKey(site, encryptKey);
};

/**
 * 암호화를 수행합니다. (로그인에서 사용)
 * 
 * @param {HTMLElement} id 로그인 아이디 입력 <input>태그 요소
 * @param {HTMLElement} password 로그인 패스워드 입력 <input>태그 요소
 * @param {String} siteName	 사이트명(생략가능)
 * @since MagicPass Prototype 1.0
 */
MagicPass.encryptLogin = function(id, password, siteName)
{
    var site = siteName || MagicPass.siteName;
	var result = null;
	
    MagicPass.log("INFO", "encryptLogin");

	switch(MagicPass.loginType)
	{
		case MagicPass.ID :
			result = MagicPass.object.EncryptLogonID(site, id, password);
			break;
		case MagicPass.CERT :
			result = MagicPass.object.EncryptAuth(site, id);
			break;
		case MagicPass.MULTI_LOGIN : 
			result = MagicPass.object.EncryptLogonID(site, id, password);
			break;
		//case MagicPass.MACCHECK :
		//	result = MagicPass.object.EncryptLogonID(site, id, password);
		//	break;
		//case MagicPass.CERTMACCHECK :
		//	result = MagicPass.object.EncryptAuth(site, id);
		//	break;
		case MagicPass.ONLY_ID :
			result = MagicPass.object.EncryptLoginID(site,id);
			break;
	}

	return result;
};

/**
 * 암호화를 수행합니다.
 * 
 * @param {String} 암호화할 평문
 * @param {String} siteName 사이트명(생략가능)
 * @param {String} applCode 어플리케이션 코드(생략가능)
 * @since MagicPass Prototype 2.0
 */
MagicPass.encryptKey = function(text, siteName, applCode)
{
	var site = siteName || MagicPass.siteName;
	var appl = applCode || MagicPass.applCode;

	MagicPass.log("INFO", "encryptKey");

	return MagicPass.object.EncryptKey(site, appl, text); 
};

/**
 * 토큰을 저장합니다.
 *
 * @param {String} encryptedToken 암호화된 토큰
 * @param {String} siteName 사이트명(생략가능)
 * @return {Number} 0이면 성공
 * @since MagicPass Prototype 1.0
 */
MagicPass.setToken = function(encryptedToken, siteName)
{
	var site = siteName || MagicPass.siteName;
	MagicPass.log("INFO", "setToken");
	//return (MagicPass.char.toLowerCase()!="utf-8")?MagicPass.object.SetToken(site, encryptedToken):MagicPass.object.SetTokenU(site, encryptedToken);
	if(MagicPass.option.isTokenCheck){	
		MagicPass.setTokenCheckURL();
		return MagicPass.object.SetTokenC(site, encryptedToken, "1"); 
	}
	else
		return MagicPass.object.SetToken(site, encryptedToken);
};

/**
 * 토큰을 꺼냅니다.
 *
 * @param {String} siteName 사이트명(생략가능)
 * @param {String} applCode	 어플리케이션 코드(생략가능)
 * @return {Number} 0이면 성공
 * @since MagicPass Prototype 1.0
 */
MagicPass.getToken = function(siteName, applCode, checkUrl)
{
	var site = siteName || MagicPass.siteName;
	var appl = applCode || MagicPass.applCode;
	MagicPass.log("INFO", "getToken");
	//alert("MagicPass.option.isTokenCheck : "+MagicPass.option.isTokenCheck);
	if(MagicPass.option.isTokenCheck)
		return (MagicPass.char.toLowerCase()!="utf-8")?MagicPass.object.GetTokenC(site, appl, MagicPass.getTokenCheckURL()):MagicPass.object.GetTokenUC(site, appl, MagicPass.getTokenCheckURL());
	else
		return (MagicPass.char.toLowerCase()!="utf-8")?MagicPass.object.GetToken(site, appl):MagicPass.object.GetTokenU(site, appl);
};

/**
 * 현재(또는 인자로 받은) 사이트가 로그인 중인지 확인합니다.
 *
 * @param {String} siteName	 사이트명(생략가능)
 * @return {Boolean}
 * @since MagicPass Prototype 1.0
 */
MagicPass.isLogin = function(siteName)
{
	var site = siteName || MagicPass.siteName;
	var result = false;

	if(MagicPass.object.GetStatus(site) == 150)
	{
		if(MagicPass.option.MP_monitor.use) 
			MagicPass.monitor(0);

		MagicPass.log(site + " logined.");
		result = true;
	}
	
	return result;
};

/**
 * 매직패스를 다운로드하여 자동설치합니다.
 *
 * @param {String} url 다운로드할 셋업파일의 URL
 * @return {Boolean}
 * @since MagicPass Prototype 2.0
 */

MagicPass.downloadAndSetup = function(url)
{
	if(MagicPass.isSetting) return;
	var checkCookie = getcookie("Notice");
	var message = "";
	var code = -1;
	var bool = false;
	if (url === MagicPass.updateUrl && checkCookie !="done"){
		if(confirm("MagicPass가 낮은 버전입니다. 업데이트 하시겠습니까? ")){
			MagicPass.log("INFO", "downloadAndSetup");
			MagicPass.isSetting = true;
			if(window.location.port == "") //MagicPass가 설치될때, 포트가 없으면 설치가 안되니까 :80을 붙여줍니다.
				url = "http://" + window.location.host + ":80" + url.replace("http://" + window.location.host, ""); //https(SSL)의 경우, 바이너리파일이 문제됨으로 http로 고정합니다.
			
			code = MagicPass.objectLoaderX.Download(url);
			if(code != 0)
			{
				MagicPass.isSetting = false;

				switch (code)
				{
				case 400:
					message = "사용자의 중지요청";
					break;
				case 404:
					message = "잘못된 다운로드 URL";
					break;
				case 412:
					message = "변형된 설치파일";
					break;
				default:
					message = "알수없는 원인";
				break;
				}

				MagicPass.error(message + "(으)로 다운로드가 중지되었습니다.\n[" + code + "]");
			}
		}else{
			 if(checkCookie !="done")
				if(confirm("설치가 취소되었습니다. ")){
					setcookie("Notice","done",1);
				}
				return;
			}
	}
	else if (url === MagicPass.onlineUrl){ 
		if (confirm(MagicPass.siteTitle + " 사이트는 사용자의 보안성 강화와 편의성 증대를 위해 해당 프로그램 이용을 권장합니다.\n\n보안로그인 프로그램(매직패스)을 설치 합니다.\n계속 설치를 진행하시겠습니까?")){
		MagicPass.log("INFO", "downloadAndSetup");

		MagicPass.isSetting = true;

		if(window.location.port == "") //MagicPass가 설치될때, 포트가 없으면 설치가 안되니까 :80을 붙여줍니다.
			url = "http://" + window.location.host + ":80" + url.replace("http://" + window.location.host, ""); //https(SSL)의 경우, 바이너리파일이 문제됨으로 http로 고정합니다.
			//alert("URL:"+url);
		code = MagicPass.objectLoaderX.Download(url);
		if(code != 0)
		{
			MagicPass.isSetting = false;

			switch (code)
			{
				case 400:
					message = "사용자의 중지요청";
					break;
				case 404:
					message = "잘못된 다운로드 URL";
					break;
				case 412:
					message = "변형된 설치파일";
					break;
				default:
					message = "알수없는 원인";
					break;
			}
			
			MagicPass.error(message + "(으)로 다운로드가 중지되었습니다.\n[" + code + "]");
		}
		else{
			return;
		}
			
	}else{
		alert("설치가 취소되었습니다.");
		return;
	}
 }
};

function setcookie(name,value,expiredays){
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate()+expiredays);
	document.cookie = name+"="+escape(value)+";path=/;expires="+todayDate.toUTCString()+";";
};

function getcookie(name){
	var nameOfCookie = name +"=";
	var x=0;
	while(x <= document.cookie.length){
		var y = (x+nameOfCookie.length);
		if(document.cookie.substring(x,y) == nameOfCookie){
			if((endOfCookie = document.cookie.indexOf(";", y))==-1)
				endOfCookie = document.cookie.lenth;
			return unescape(document.cookie.substring(y, endOfCookie));
		}
		x=document.cookie.indexOf("",x)+1;
		if(x==0)
			break;
	}
	return ;
}

/**
 * 매직패스를 실행시킨다.
 *
 * @since MagicPass Prototype 2.2
 */
MagicPass.run = function()
{
	MagicPass.log("INFO", "run");
	//try{MagicPass.writeLog(" MagicPass.run start ~ ","blue");}catch(e){}
	try
	{
		if(MagicPass.option.useApplet)
		{
			//try{MagicPass.writeLog(" MagicPass.object : "+MagicPass.object,"blue");}catch(e){}
			if(!MagicPass.object.ProgramCheck())
			{
				//alert("ProgramCheck OK");
				if(!MagicPass.object.ProgramRun()){
					throw "failure";
				}
					
			}
		}
		else
		{
			if(MagicPass.objectLoaderX)
			{
				if(MagicPass.objectLoaderX.ProgramCheck(MagicPass.alias) != 0)
				{
					if(!MagicPass.versionVerified)
					{
						var repNo = MagicPass.objectLoaderX.VersionCheck(MagicPass.configFile);
						switch(repNo)
						{
							case 0 :
								break;
							case 2 :
								MagicPass.downloadAndSetup(MagicPass.onlineUrl);
								break;
							case 3 :
								MagicPass.downloadAndSetup(MagicPass.updateUrl);
								break;
							case 4 :
								MagicPass.downloadAndSetup(MagicPass.settingUrl);
								break;
							default :
								throw repNo;
								break;
						}
						
						MagicPass.versionVerified = true;
					}

					if(MagicPass.objectLoaderX.ProgramRun(MagicPass.executeUrl, "", MagicPass.alias) != 0)
						throw "failure";
				}
			}
		}
	}
	catch(e)
	{
		if(!window.isNaN(e)){
			error = parseInt(e);
		    MagicPass.error(error, true);
		}else{
			error = e;
			MagicPass.error(error, false);
		}
		//MagicPass.error(e);
		window.setTimeout(MagicPass.run, 3000);
		return;
	}
	MagicPass.jobExecute();
};

/**
 * 매직패스 오프라인 설치를 진행합니다.
 * 
 * @since MagicPass Prototype 1.0
 */
MagicPass.setupOffLine = function()
{
	MagicPass.log("INFO", "setupOffLine");

	var sizeWidth = (document.body) ? document.body.offsetWidth : window.screen.availWidth;
	var parentTag = (document.getElementsByTagName("body")) ? document.getElementsByTagName("body")[0] : document.getElementsByTagName("html")[0];
	
	MagicPass.isSetting = true;
	
	with(parentTag.style){width="100%";height="100%";overflow="hidden";};
	parentTag.innerHTML	= "<div style='z-index:100;position:absolute;top:0;left:0;min-weight:100%;min-height:100%;width:100%;height:100%;background:#000;filter:alpha(opacity=50);-moz-opacity:0.5;opacity:0.5'></div>"
						+ "<div style='z-index:101;position:absolute;top:200px;left:" + ((sizeWidth - 450) >> 1) + "px;'><iframe src='" + MagicPass.offlineUrl + "' frameborder='0' border='0' width='450' height='300'></iframe></div>"
						+ parentTag.innerHTML;
};

/**
 * 매직패스 플러그인(ActiveX/Applet)을 로딩합니다.
 * 
 * @since MagicPass Prototype 2.2
 */
MagicPass.ready = function(flag)
{
	//try{MagicPass.writeLog(" MagicPass.ready start ~ ","blue");}catch(e){}
	if(MagicPass.usable) return;
	if(!MagicPass.isReady)
	{
    MagicPass.isReady = true;
		MagicPass.log("INFO", "ready");
	}
	else if(!flag)
		return;
	try
	{
		if(!MagicPass.element)
		{
			
			var parent = document.getElementsByTagName("body")[0];
			
			// body하위 태그들중 MagicPassPluginArea 태그를 찾고 없으면 div태그 생성
			if(parent.innerHTML.indexOf("MagicPassPluginArea") < 0)
			{
				var c = document.createElement("div");
				c.setAttribute("id", "MagicPassPluginArea");
				parent.appendChild(c);
			}
			//MagicPass.writeLog("MagicPass element - MagicPassPluginArea TAG created","blue");
			MagicPass.element = document.getElementById("MagicPassPluginArea");
			throw "";
			
		}
		else if(!MagicPass.object)
		{
			//MagicPass.writeLog("MagicPass.object 미생성","red");
			if(MagicPass.element.innerHTML.indexOf(MagicPass.alias) < 0)
			{  
				if(MagicPass.option.useApplet)
				{
					  //try{MagicPass.writeLog(" ##### APPLET_LOADING START ##### ","green");}catch(e){}
					  var attributes = {codebase:MagicPass.appleteUrl,
				      code:'com.naru.app.applet.PassPortApplet.class',
				      archive:'passport-applet.jar, passport-j.jar',
				      id:MagicPass.alias,
				      name:MagicPass.alias,
				      width:1, height:1} ;
					  //try{MagicPass.writeLog(" ##### APPLET_URL : "+MagicPass.appleteUrl,"green");}catch(e){}
					  var parameters = {'java_code':'com.naru.app.applet.PassPortApplet.class',
						'java_codebase':MagicPass.appleteUrl,
						'java_archive':'passport-applet.jar, passport-j.jar',
						'type':'application/x-java-applet;version=1.6',
						'browser.type':Client.browser,
						'client.type':((MagicPass.option.useMagicPassS) ? 'passportj' : 'magicpass'),
						'passport.debug':MagicPass.option.debugApplet,
						'client.resources':'passport-resource.jar',
						'client.resources.version':MagicPass.version.passportApplet,
						'passport-j.resources':'passport-j-resource.jar',
						'passport-j.resources.version':MagicPass.version.passportJ,
						'isBrowserMonitoring':'false',
						'interval.browser.monitoring':MagicPass.option.MP_monitor.interval,
						'mayscript':'true'
						
						} ;
					var version = '1.6' ;
					deployJava.runApplet(attributes, parameters, version);
					
				  }
				  else
				  {
					//try{MagicPass.writeLog(" ##### ACTIVEX_LOADING START ##### ","green");}catch(e){}
					if (Client.x64)
						MagicPass.element.innerHTML += "<object codebase='" + MagicPass.path + "/plugins/MagicPassX64.cab#version=" + MagicPass.version.MagicPassX + "' classid='clsid:AD6870C0-44B7-42FB-A119-C2C6BD9CD005' id='" + MagicPass.alias + "' width='1' height='1'></object>";
					else
					MagicPass.element.innerHTML += "<object codebase='" + MagicPass.path + "/plugins/MagicPassX.cab#version=" + MagicPass.version.MagicPassX + "' classid='clsid:AD6870C0-44B7-42FB-A119-C2C6BD9CD005' id='" + MagicPass.alias + "' width='1' height='1' style='display:none;'></object>";
				  }
			}
			//MagicPass.writeLog("MagicPassPlugin(object) TAG created in MagicPassPluginArea(div)","blue");
			MagicPass.object = document.getElementById(MagicPass.alias);
			//MagicPass.writeLog("MagicPass.object : "+MagicPass.object,"green");
			if(MagicPass.object == null)
			{
				throw "";
			}else{

			}
		}	
		
	}
	catch(e)
	{
		MagicPass.error("Loading object is not yet", false);
		//try{MagicPass.writeLog("Loading object is not yet","red");}catch(e){}
		window.setTimeout(function(){
			MagicPass.ready(true);
		}, 200);

		return;
	}

	MagicPass.run();
};

/**
 * MagicLoaderX 플러그인을 로딩합니다.
 * 
 * @since MagicPass Prototype 2.2
 */
MagicPass.readyLoaderX = function(flag)
{
	if(MagicPass.option.useApplet) return;

	try
	{
		if(!MagicPass.objectLoaderX && MagicPass.element.innerHTML.indexOf("MagicLoaderX") < 0)
			MagicPass.element.innerHTML += "<object codebase='" + MagicPass.path + "/plugins/MagicLoaderX.cab#version=" + MagicPass.version.MagicLoaderX + "' classid='clsid:3D64E58D-CB55-4344-B809-CFE38F900838' id='MagicLoaderX' width='1' height='1' style='display:none;'></object>";

		MagicPass.objectLoaderX = document.getElementById("MagicLoaderX");
	}
	catch(e)
	{
		window.setTimeout(MagicPass.readyLoaderX, 200);
		return;
	}

	MagicPass.run();
};

/**
 * NMPCertX(MPCertX) 플러그인을 로딩합니다.
 * 
 * @since MagicPass Prototype 2.0
 */
MagicPass.readyCertX = function(flag)
{
	if(!MagicPass.option.useCertificate) return;
	if(!flag) MagicPass.log("INFO", "Certificate Plugin ready");

	try
	{
		if(MagicPass.option.useApplet && flag != true)
		{
			/*
			var codebaseurl;
			var downPath;
			var sitebase;

			var libPath = mlEnv.RootPath+'plugins/applet';
			codebaseurl = mlEnv.RootContext;
			sitebase = mlEnv.RootPath;
			downPath = libPath;

			var MagicLineJar 					        	    = 'MagicLine-'+mlEnv.MagicLineVer+'.jar';
			var MagicLineLauncherJar 			    = 'MagicLineLauncher-'+mlEnv.MagicLineLauncherVer+'.jar';
			var MagicLineResJar 				    	    = 'MagicLineRes-'+mlEnv.MagicLineResVer+'.jar';
			var MagicLineTrustedRootCertJar = 'MagicLineTrustedRootCert-'+mlEnv.MagicLineTrustedRootCertVer+'.jar';

			var JcoasJar 					= 'jcaos-'+mlEnv.JcoasVer+'.jar';
			var UbiKeyJar 					= 'ubikey-'+mlEnv.UbiKeyVer+'.jar';

			MagicLineMobilePhoneValue	= "infovine;";

  		   var win60 =  window.navigator.userAgent.indexOf('Windows NT 6') >-1;

			var MagicLineInstallProgressValue = '';
			var SessionIDValue				= '1';
			var sUserAgent = window.navigator.userAgent;
			var modaless = false;
			
			var attributes = {codebase:MagicPass.appleteUrl,
		      code:'com.dreamsecurity.applet.launcher.MagicLineLauncher.class',
		      archive:libPath+'/'+MagicLineLauncherJar+','+libPath+'/'+JcoasJar+','+libPath+'/'+UbiKeyJar,
		      id:'MagicLine',
		      name:'MagicLine',
		      width:1, height:1} ;
			var parameters = {'archive':libPath+'/'+MagicLineLauncherJar+','+libPath+'/'+JcoasJar+','+libPath+'/'+UbiKeyJar,
				'separate_jvm':'true',
				'MagicLineCacheFile':MagicLineJar+';',
				'MagicLineCacheFileVersion':mlEnv.MagicLineVer+';',
				'MagicLinePath':downPath,
				'MagicLineResourceFile':MagicLineResJar+';',
				'MagicLineResoureVersion':mlEnv.MagicLineResVer+';',
				'MagicLineLauncherVersion':mlEnv.MagicLineLauncherVer,
				'MagicLineRealAppletName':'com.dreamsecurity.ui.MagicXSignRealAppletProcImpl',
				'MagicLineTrustedRootCertFile':MagicLineTrustedRootCertJar,
				'MagicLineTrustedRootCertVersion':mlEnv.MagicLineTrustedRootCertVer,
				'MagicLineDebugMode':mlProp.MagicLineDebugModeValue,
				'MagicLineTab':mlProp.MagicLineTabValue,
				'MagicLineStorageType':mlProp.MagicLineStorageTypeValue,
				'MagicLineDomain':mlProp.MagicLineDomainValue,
				'MagicLineCAName':mlProp.MagicLineCANameValue,
				'MagicLineCertPolicy':mlProp.MagicLineCertPolicyValue,
				'MagicLineKeyUsage':mlProp.MagicLineKeyUsageValue,
				'MagicLineKeyboardSec':mlProp.MagicLineKeyboardSecValue,
				'MagicLineMobilePhone':mlProp.MagicLineMobilePhoneValue,
				'InfovineInfo':mlProp.InfovineInfoValue,
				'MagicLineInstallProgress':MagicLineInstallProgressValue,
				'sitebase':sitebase,
				'SessionID':SessionIDValue,
				'Modaless':modaless,
				'sessionIDURL':mlEnv.RootContext+mlEnv.RootPath+'getCode.jsp;',
				'mayscript':'true'
				} ;
			var version = '1.7' ;
			deployJava.writeAppletTag(attributes, parameters, version);
			*/
	  }else{
	  	MagicPass.element.innerHTML += "<object codebase='" + MagicPass.path + "/plugins/MagicLineMBX.cab#version="+mlEnv.activeXVersion+"' classid='clsid:" + "C8223F3A-1420-4245-88F2-D874FC081574" + "' id='MagicLine' width='1' height='1' style='display:none;'></object>";
	  }
		
	  MagicPass.objectCertX = document.getElementById("MagicLine");
	  MagicPass.object = document.getElementById(MagicPass.alias);
	  if(MagicPass.objectCertX == null)
	   {
		 throw null;
		}else{
		  MagicPass.usableCertX = true;
		}
	}
	catch(e)
	{
		window.setTimeout(function(){
			MagicPass.readyCertX(true);
		}, 1000);
	}
};

/**
 * 매직패스 처리관련 에러메세지를 MagicPass.errorUrl 에 지정된 페이지로 출력합니다.
 *
 * @param {Number} or {String} error 에러코드(또는 에러메세지)
 * @since MagicPass Prototype 2.3
 */
MagicPass.errorPage = function(error)
{
	if(new String(window.location).indexOf(MagicPass.errorUrl) < 0) 
		window.location.replace(MagicPass.errorUrl + "?code=" + error);
};
MagicPass.errorPage = function(error,message)
{
	if(new String(window.location).indexOf(MagicPass.errorUrl) < 0) 
		window.location.replace(MagicPass.errorUrl + "?code=" + error+"&message="+message);
};

/**
 * 매직패스 처리관련 에러메세지를 출력합니다.
 *
 * @param {Number} or {String} error 에러코드(또는 에러메세지)
 * @param {Boolean} flag 참(True)이면 Alert메세지를 띄움
 * @return {String}
 * @since MagicPass Prototype 1.0
 */
MagicPass.error = function(error, flag)
{
	if(error == null || error == "") return

	var alertFlag = (typeof(flag) == "undefined") ? MagicPass.option.debugScript : flag;
	var message = null;
	var url = null;
	if(!window.isNaN(error))
		error = parseInt(error);

	if(typeof(error) == "number")
	{
		switch(error)
		{
			case 103	: message = "매직패스가 실행중인지 트레이의 아이콘을 확인해 주세요."; break;
			case 203	: 
			case 223 : message = "토큰유효성 검증 실패\n인증서버의 토큰정보와 일치하지 않습니다.\재로그인후 이용해주세요"; break;
			case 151	: message = "로그인이 되어있지 않습니다. 로그인 후, 다시 시도해 주세요."; break;
			case 312	: message = "접근 권한이 없는 어플리케이션(또는 메뉴) 입니다."; break;

			case 400	: message = " 서버 접속 에러 "; break;
			case 401	: message = " SETUP URL 에러 "; break;
			case 402	: message = " 실행시킬 수 있는 경로가 아님"; break;
			case 403	: message = " URL 복호화 에러"; break;
			case 404	: message = " URL Base64 디코딩 에러 "; break;

			case 410	: message = " SETUP 파일 저장 실패"; break;

			case 412	: message = " setup.conf 파일을 찾을수 없습니다"; break;
			case 513	:
			case 9009	: message = "다른사용자가 로그인하여 로그아웃됩니다."; break;
			case 9999	: message = "인증서버(MAS)가 연결되지 않았거나 작동중이지 않습니다.\n관리자에게 문의하세요."; break;

			case 10001	: message = "사용자 정보가 존재하지 않습니다."; break;
			case 10003	: message = "비밀번호 오류입니다. 다시 시도해 주시기 바랍니다."; break;
			case 10004	: message = "등록되지 않은 인증서입니다.\n 인증서등록 페이지로 이동합니다."; break;
			case 10005	: message = "안전번호 오류입니다. 다시 시도해 주시기 바랍니다."; break;
			
			case 10010	: message = "비밀번호/안전번호 오류회수 초과로 계정이 잠겼습니다."; break;
			case 10011	: message = "비밀번호/안전번호 오류회수 초과로 계정이 잠겼습니다."; break;
			
			case 10200	: message = "이미 로그인이 되어 있습니다.\n 로그아웃 시켜주세요."; break;
			case 10201	: message = "MAC ADDRESS 정보 획득실패."; break;
			case 10100	: message = "LDAP 연결을 할수 없습니다."; break;
			
			
			case 32000	: message = "이미 로그인이 되어 있습니다.\n 로그아웃 시켜주세요."; break; 
			
			case 34000	: message = "MAC ADDRESS DB 입력실패."; break;
			case 35000	: message = "허가되지 않은 MAC ADDRESS 입니다."; break;
			
			case 39000	: message = "MAC ADDRESS DB 입력실패."; break; 
			case 39001	: message = "ID가 다릅니다."; break;
			case 39002	: message = "Mac Address DB 삭제실패"; break;
			case 39003	: message = "로그인 페이지로 이동합니다."; break; 
			case 40001	: message = "유효하지 않은 접근입니다."; break; 
			case 50001	: message = "해당 IP는 접근권한이 없습니다. 관리자에게 문의하세요."; break;	
			case 70000	: message = "매직패스가 로딩중이거나 설치되지 않았습니다. 로딩 또는 설치가 완료된 후, 시도하시기 바랍니다.\n\n(1분이상 지연될 경우, \"확인\"버튼을 클릭하여 수동설치를 진행하시기 바랍니다.)"; break;
			case 70001	: message = "아아디를 입력해 주시기 바랍니다."; break;
			case 70002	: message = "비밀번호를 입력해 주시기 바랍니다."; break;
			case 70003	: message = "아아디 또는 비밀번호가 잘못 입력되었습니다."; break;
			case 70004	: message = "MagicPass(보안 로그인 프로그램)을 설치하지 않았거나 설치를 진행하고 있습니다.\n설치 완료 후, 다시 로그인을 시도해 주시기 바랍니다."; break;
			case 70005	: message = "서버인증서 조회에 실패하였습니다. 관리자에게 문의하시기 바랍니다."; break;
			case 70006	: message = "암호화 키를 확인하는 과정에서 실패하였습니다."; break;
			case 70007	: message = "암호화 세션키 교환과정에서 오류가 발생하였습니다."; break;
			case 70008	: message = "로그인 정보를 암호화 하는 과정에서 오류가 발생하였습니다."; break;
			case 70009	: message = "복호화한 데이터가 없습니다. 관리자에게 문의하시기 바랍니다."; break;
			case 70010	: message = "암호화 데이터를 복호화 하는 과정에서 필요한 시간 데이터가 유실되었습니다."; break;
			case 70011	: message = "암호화 데이터를 복호화 하는 과정에서 필요한 키 데이터가 유실되었습니다."; break;
			case 70012	: message = "매직패스가 이미 로그인되어있습니다.\n로그인을 계속 진행하시겠습니까?"; break;
			case 70013	: message = "처음로그인 하셨습니다. \n비밀번호를 변경하시고 다시 로그인 해주세요"; 
						  url = MagicPass.passwdChangeUrl;
						  break;
			case 70014	: message = "로그인 유효기간동안 한번도 로그인하지 않으셨습니다. \n비밀번호를 변경하시고 다시 로그인 해주세요"; 
						  url = MagicPass.passwdChangeUrl;
						  break;
			case 70015	: message = "비밀번호 변경기간이 경과하였습니다. \n비밀번호를 변경하시고 다시 로그인 해주세요"; 
						  url = MagicPass.passwdChangeUrl;
						  break;
			case 70016	: message = "비밀번호 변경 알림 기간입니다.\n 지금 비밀번호를 변경하시겠습니까?"; break;
			
			case 70017	: message = "안전번호 변경 알림 기간입니다.\n 지금 비밀번호를 변경하시겠습니까?"; break;
			
			case 80001	: message = "사용자세션정보가 없습니다. 다시 로그인해 주세요."; break;
			
			case 81001	: message = "허용되지 않은 IP입니다."; break;
			
			default	:
				if(error >= 801 && error < 1000) message = "인증서 본인확인에 실패하였습니다. 다시 한번 시도해주시기 바랍니다.";
				else if(error >= 1000 && error <= 2013) message = "작업중 표준보안API(GPKIAPI)에서 오류를 발견하였습니다.";
				else message = "알 수 없는 에러입니다.\n문제가 지속될 경우, 관리자에게 문의하시기 바랍니다.";
				break;
		}
		if(error == 223)
			window.location.href=MagicPass.failRtnUrl;
		if(error == 70013 || error == 70014 || error == 70015)
			window.location.replace(url);
		if(MagicPass.option.debugScript) message += "\nCODE " + error;
	}
	else
		message = error;
	
	if(alertFlag)
		window.alert(message);
	
	MagicPass.log(message);
	return message;
};

/**
 * 매직패스에 저장되는 데이터의 캐릭터셋을 지정합니다.
 * (ActiveX 에서만 사용)
 * 
 * @param {String} charsetName 문자종류: euc-kr, ansi (이외는 지원 안함. (0:ANSI, 1:euc-kr))
 * @since MagicPass Prototype 1.0
 */
MagicPass.setCharset = function(charsetName, siteName)
{
	var charset = charsetName || "euc-kr";
	var charN;
	if(charset == "euc-kr")
		charN = 1;
	else if(charset == "utf-8")
		charN = 2;
	else
		charN = 0;
	var site = siteName || MagicPass.siteName;

	MagicPass.log("INFO", "setCharset " + charset);

	if(!MagicPass.option.useApplet)
		MagicPass.object.SetCharSet(site, ((charset.toLowerCase() == "euc-kr") ? 1 : 0));
};

/**
 * 매직패스 로그인 정보에 표시되는 이름을 지정합니다.
 * 
 * @param {String} name 이름(생략하면 MagicPass.siteTitle 로 지정)
 * @param {String{ siteName 사이트명(생략가능)
 * @since MagicPass Prototype 2.3
 */
MagicPass.setDelegateName = function(name, siteName)
{
	var delegateName = name || MagicPass.siteTitle;
	var site = siteName || MagicPass.siteName;

	MagicPass.log("INFO", "setDelegateName " + delegateName);

	MagicPass.object.SetSiteDelegate(site, delegateName);
};

/**
 * 브라우저 종료되었는지 확인하여 로그아웃을 실행합니다.
 * 
 * @param {String} 사이트명(생략가능)
 * @since MagicPass Prototype 2.0
 */
MagicPass.browserOffCheck = function(siteName)
{
	var processName = null;
	var site = siteName || MagicPass.siteName;

	if(Client.os == "WINDOWS")
	{
		switch(Client.browser)
		{
			case "FIREFOX"	: processName = "firefox.exe"; break;
			case "SAFARI"	: processName = "Safari.exe"; break;
			case "CHROME"	: processName = "chrome.exe"; break;
			case "OPERA"	: processName = "opera.exe"; break;
		}
	}
	else
	{
		switch(Client.browser)
		{
			case "FIREFOX"	: processName = "firefox"; break;
			case "SAFARI"	: processName = "Safari"; break;
			case "CHROME"	: processName = "chrome"; break;
			case "OPERA"	: processName = "opera"; break;
		}
	}

	MagicPass.log("INFO", "browserCheck " + processName);

	if(processName != null)
		MagicPass.object.setBrowserCheck(site, processName);
};

/**
 * 자동로그아웃 기능을 수행합니다. 
 * (지정된 시간간격 이상 스크립트가 매직패스로 액세스가 없으면 매직패스의 사이트 토큰 로그아웃)
 * 
 * @param {Number} interval 체크 시간간격(1/1000초 아님, 생략가능)
 * @param {String} siteName 사이트명(생략가능)
 * @since MagicPass Prototype 2.0
 */
MagicPass.monitor = function(interval, siteName)
{
	if(!MagicPass.option.MP_monitor.use) return;
	if(interval > 0) MagicPass.log("INFO", "monitor " + (interval / 1000) + "sec.");
	
	var site = siteName || MagicPass.siteName;
	
	try
	{
		MagicPass.object.SetAutoLogoutSite(site, interval / 1000);
	}
	catch(e){}
};

/**
 * Ajax 처리를 지원합니다.
 * 
 * @param {String} mode 서버의 암호화처리(secure.jsp)중 해당 actionName을 지정
 * @param {Function} callbackFunction 콜백함수(Ajax 처리 후, 호출 함수)
 * @param {Function} funtionClass 콜백함수가 클래스형식일 경우, 클래스를 입력
 * @param {String} or {Array} params 서버 Request 파라미터를 정의(String 또는 Map 타입)
 * @param {String} url 해당 url로 Ajax Request를 전송(생략하면 secure.jsp 지정)
 * @param {Boolean} async 참(true)이면 비동기 방식으로 콜백함수 호출
 * @since MagicPass Prototype 2.0
 */
var xmlHttpRequest = null;
MagicPass.request = function(mode, callbackFunction, funtionClass, params, url, async)
{
	if(xmlHttpRequest == null)
	{
		try
		{
			xmlHttpRequest = new XMLHttpRequest();
		}
		catch(e)
		{
			try
			{
				xmlHttpRequest = new ActiveXObject("Msxml2.HTTP");
			}
			catch(f)
			{
				xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
	}
	
	var actionUrl = url || MagicPass.secureUrl;		//Ajax로 처리될 페이지를 지정합니다
	var param = "actionName=" + mode;

	//맵형식의 파라미터를 처리합니다
	for(var i in params)
	{
		try
		{
			param += "&" + i + "=" + encodeURIComponent(params[i]);
		}
		catch(e){
			
		};
	}

	//Ajax 호출을 시도합니다
	xmlHttpRequest.open("POST", actionUrl, false);
	xmlHttpRequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xmlHttpRequest.send(param);
	
	var sync = async || false;

	if(sync)
	{
		xmlHttpRequest.onreadystatechange = function()
		{
			if(xmlHttpRequest.readyState == 4)
			{
				if(xmlHttpRequest.status == 200)
					(callbackFunction).call(funtionClass, xmlHttpRequest.responseXML);
				else 
					MagicPass.error(xmlHttpRequest.statusText + " [" + xmlHttpRequest.status + "]");
			}
		};
	}
	else
	{
		if(typeof(callbackFunction) == "function")
			callbackFunction.call(funtionClass, xmlHttpRequest.responseXML);
	}
};

/**
 * XML에서 특정 태그의 값을 파싱합니다.
 * 
 * @param {XMLDocument} xmlData 서버 Request로 받은 XML
 * @param {String} tag XML중 데이터값(nodeValue)을 추출할 태그 명
 * @return {String}
 * @since MagicPass Prototype 2.0
 */
MagicPass.xmlParse = function(xmlData, tag)
{
    var result = "";

    try
    {
    	result = xmlData.getElementsByTagName(tag)[0].firstChild.nodeValue;
    }
    catch(e)
    {
    	MagicPass.error("Undefined tag(" + tag + ") called", false);
    }

    return result;
};

/**
 * HTML요소에 이벤트를 지정합니다.
 * 
 * @param {HTMLElement} or {String} targetObj 이벤트가 지정될 요소
 * @param {String} eventType 이벤트 종류 (click, keypress, ...)
 * @param {FUnction} callbackFunction 이벤트 발생시, 호출될 함수
 * @since MagicPass Prototype 2.2
 */
MagicPass.addEvent = function(targetObj, eventType, callbackFunction)
{
	var target = (typeof(targetObj) === "string") ? document.getElementById(targetObj) : targetObj;
	
	try
	{
		if(window.addEventListener)
			target.addEventListener(eventType, callbackFunction, false);
		else
			target.attachEvent("on" + eventType, callbackFunction);
	}
	catch(e)
	{
		MagicPass.error("To add '" + eventType + "' event is failure.\n cause : " + e.message, false);
	}
};

/**
 * 쿠키에서 서버인증서값을 불러옵니다.
 * (서버인증서를 페이지 전환시 매번 호출하는 부하를 없애기 위해 쿠키에 저장해둡니다.)
 * 
 * @since MagicPass Prototype 2.3
 */
MagicPass.getServerCertificate = function()
{
	if(MagicPass.serverCertificate != null) return;
	MagicPass.log("INFO", "getServerCertificate");

	var currentCookie = document.cookie + ";";
	var startPoint = currentCookie.indexOf(MagicPass.cookieName + "=");
	
	if(startPoint > -1)
	{
		var s = currentCookie.substring(startPoint + MagicPass.cookieName.length + 1);
		s = s.substring(0, s.indexOf(";"));
		if(s.length > 5)
		{
			MagicPass.serverCertificate = window.unescape(s);
			return;
		}
	}
	
	MagicPass.request("GET_SERVER_CERTIFICATION", MagicPass.setServerCertificate);
};

/**
 * 서버인증서의 값을 저장합니다.
 * 
 * @param {XMLDocument} xmlData 서버 Request로 받은 XML
 * @since MagicPass Prototype 2.3
 */
MagicPass.setServerCertificate = function(xmlData)
{
	var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
	var code = MagicPass.xmlParse(xmlData, "code");
	var message = MagicPass.xmlParse(xmlData, "message");
	
	if(success)
	{
		MagicPass.serverCertificate = message;
		document.cookie = MagicPass.cookieName + "=" + window.escape(message) + ";domain=" + document.domain + ";"; 
	}
	else
	{
		MagicPass.errorPage(code, message);
	}
};

MagicPass.sessionCheck = function(xmlData){
	MagicPass.log("ServerSession Check");
};
/*--------------------------------------------------------------
	String object extension
--------------------------------------------------------------*/
/**
 * 입력받은 String타입 객체가 null, ""(빈문자열), undefined 일 경우를 확인합니다.
 * 형식은 new String().isNull("문자열") 또는, "문자열".isNull()로 사용가능합니다.
 * 
 * @param {String} str 비교할 문자열
 * @return {Boolean}
 * @since MagicPass Prototype 2.0
 */
String.prototype.isNull = function(str)
{
	var string = str || this;

	try
	{
		return !(string != null && string != undefined && string != "" && string != "null" && string != "undefined");
	}
	catch(e)
	{
		return true;
	}
};
/**
 * 입력받은 String타입 객체의 앞/뒤 공백을 제거합니다.
 * 형식은 new String().trim("문자열") 또는, "문자열".trim()과 같이 사용가능합니다.
 * 
 * @param {String} str 문자열
 * @return {String}
 * @since MagicPass Prototype 2.0
 */
String.prototype.trim = function(str)
{
	var string = str || this;

	try
	{
		return string.replace(/^\s+|\s+$/g, "");
	}
	catch(e)
	{
		return string;
	}
};

/*--------------------------------------------------------------
	Using for Applet 
--------------------------------------------------------------*/
function afterStart()
{
	MagicPass.log("[applet] afterStart");
	return true;
}

function refreshPage()
{
	MagicPass.log("[applet] refreshPage");
	window.location.reload();
	
	return true;
}

function beforeInit()
{
	MagicPass.log("[applet] beforeInit");
	return true;
}

function afterInit()
{
	MagicPass.log("[applet] afterInit");
	return true;
}

function beforeStart()
{
	MagicPass.log("[applet] beforeStart");
	return true;
}

function closeWindow()
{
	if (window.opener)
		window.opener.close();
	
	window.close();
}

MagicPass.encryptSym = function(plainData)
{
   	var result = null;
		
    MagicPass.log("INFO", "encryptLogin");
    
    result = MagicPass.object.EncryptSym(decodeURI(plainData));
			
	return result;
};

MagicPass.getMacAddress = function(ipaddr, flag)
{	
	/** Applet 사용시*/
	if(MagicPass.option.useApplet)
	{
		if(flag==false)
		{
			try
			{
				if(MagicPass.option.useApplet)
				{
					var attributes = {codebase:MagicPass.appleteUrl,
				      code:'MacAddressA/MacAddressA',
				      archive:'MacAddressA.jar',
				      id:'MacAddressA',
				      name:'MacAddressA',
				      width:1, height:1} ;
					var parameters = {'java_code':'MacAddressA/MacAddressA',
						'java_codebase':MagicPass.appleteUrl,
						'java_archive':'MacAddressA.jar',
						'type':'application/x-java-applet;version=1.6',
						'interval.browser.monitoring':MagicPass.option.MP_monitor.interval,
						'mayscript':'true'
						
						} ;
					var version = '1.6' ;
					deployJava.runApplet(attributes, parameters, version);
					
					MagicPass.objectLoaderX = document.getElementById("MacAddressA");
					MagicPass.objectCertX = document.getElementById("MagicLine");
					MagicPass.object = document.getElementById(MagicPass.alias);
									
				}
			}
			catch(e)
			{
				window.setTimeout(function(){
					MagicPass.getMacAddress(ipaddr, true);
				}, 3000);
				return;
			}
		}
		MagicPass.objectLoaderX.setSep( "-" );
		var result = MagicPass.objectLoaderX.getMacAddressesJSON();
	}
	/** ActiveX 사용시*/
	else
	{
		var n_ret = MagicPass.objectLoaderX.GetClientMacAddress();
		if(0 == n_ret)
			result = MagicPass.objectLoaderX.Result;
	}
	return result;
};

MagicPass.makeForm = function(returnUrl, valueBasket){
	try{
	// div를 만들어 body에 추가
	var parent = document.getElementsByTagName("body")[0];
	var tmpDiv = document.createElement("div");
	tmpDiv.setAttribute("id", "tmpDiv");
	parent.appendChild(tmpDiv);
	
	// form을 만들어 div에 추가
	var frm = document.createElement("form");
	frm.setAttribute("id", "nextFrm");
	frm.setAttribute("name", "nextFrm");
	frm.setAttribute("action", returnUrl);
	frm.setAttribute("method", "post");
	tmpDiv.appendChild(frm);
	//alert("frm created");
	
	// input을 만들어 form에 추가
	for(i=0; i<valueBasket.length; i++){
		var bean = valueBasket[i];
		var nm = bean[0];
		var val = bean[1];
		//alert(nm+" | "+val);
		var comp = document.createElement("input");
		comp.setAttribute("type", "hidden");
		comp.setAttribute("id", nm);
		comp.setAttribute("name", nm);
		comp.setAttribute("value", val);
		
		frm.appendChild(comp);
	}
	
		return frm;
	}catch(e){
		alert(e);
	}
};

MagicPass.siblingLogout = function(){
	try{
		// logout div 생성
		var parent = document.getElementsByTagName("body")[0];
		var tmpDiv = document.createElement("div");
		tmpDiv.setAttribute("id", "logoutArea");
		parent.appendChild(tmpDiv);
		
		// form 생성
		for(i=0; i<MagicPass.sibleingLogoutUrl.length;i++)
		{
			var ifrm = document.createElement("iframe");
			ifrm.setAttribute("src", "");
			ifrm.setAttribute("id", "ifrm_"+i);
			ifrm.setAttribute("name", "ifrm_"+i);
			parent.appendChild(ifrm);
			
			var frm = document.createElement("form");
			frm.setAttribute("id", "slogoutFrm_"+i);
			frm.setAttribute("name", "slogoutFrm_"+i);
			frm.setAttribute("action", MagicPass.sibleingLogoutUrl[i]);
			frm.setAttribute("method", "post");
			frm.setAttribute("target", "ifrm_"+i);
			tmpDiv.appendChild(frm);
			
			frm.submit();
		}
	}catch(e){
		
	}
};
MagicPass.writeLog = function(msg){
	MagicPass.writeLog(msg, "black");
};

MagicPass.writeLog = function(msg, color){
	try{
		top.writeLog(msg, color);
	}catch(e){
		// not debugging mode
	}
};

MagicPass.getClientInfo = function(siteName, applCode)
{
	var site = siteName || MagicPass.siteName;
	MagicPass.log("INFO", "getClientInfo");
	return MagicPass.object.GetClientInfo(site);
};

/*--------------------------------------------------------
 * 	Auto Start
--------------------------------------------------------*/
MagicPass.getServerCertificate();
MagicPass.ready();
