/*  MagicLine4 JavaScript version 4.2 by kj
 *  (c) 2007-2010 DreamSecurity
 *
 *  DreamSecurity license.
 *  For details, see the web site: http://www.dreamsecurity.com/
 *
 *--------------------------------------------------------------------------*/


/* 환경변수 정의*/

var mlEnv = {
	Product:'ALL', // MB, MBX, ALL
	RootPath:'/MagicLine4/', // Webcontext path
	RootContext:location.protocol +'//'+ location.host,
	JAVAInstallType:2, //0:ActiveX, 1:Download Page, 2:alert
	MagicLineInstallType:0, //0:ActiveX 바로설치, 1:Download Page
	/* JAVA Client Version*/
	MagicLineVer:'1.0.4.28',//'1.0.4.3',
	MagicLineLauncherVer:'1.0.7.31',//'1.0.7.6',///////

	MagicLineResVer:'1.0.2.4',
	MagicLineTrustedRootCertVer	:'1.0.1.3',//'1.0.0.7',
	JcoasVer:'client-1.4.6.7',
	UbiKeyVer:'1.0.1.5',
	BalloonTipVer:'1.2.1_p3',
	TokenInstallURL:'http://rootca.kisa.or.kr/kor/hsm/hsm.jsp',                                                     
	/* ActiveX Client Version */
	activeXVersion:'1,1,0,4',

	debug:false
};

/* MagicLine Install Page*/
var returnIndexPage 			= mlEnv.RootPath+'index.jsp'; // return page, 설치 후 돌아가는 페이지 index 페이지
var returnJreInstallPage 		= mlEnv.RootPath+'java_install.jsp'; // return page, JAVA 설치 페이지
var returnMagicInstallPage 		= mlEnv.RootPath+'ml_install.jsp'; // return page, MagicLine 설치 페이지

var mlProp = {
	// 서버 인증서
		ServerCert:'MIIEgjCCA+ugAwIBAgICB6AwDQYJKoZIhvcNAQEFBQAwRDELMAkGA1UEBhMCS1IxFjAUBgNVBAoTDURyZWFtU2VjdXJpdHkxDjAMBgNVBAsTBVdpcmVkMQ0wCwYDVQQDEwRST09UMB4XDTA0MDUxNzA2MDMwMloXDTA1MDUxNzA2MDMwMlowTjELMAkGA1UEBhMCS1IxFjAUBgNVBAoTDURyZWFtU2VjdXJpdHkxDjAMBgNVBAsTBVdpcmVkMRcwFQYDVQQDDA5BTllfMDAwMDAwMTM3NDCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA8oiK9s24U15Zc27yPSXvruwlgsngL9+dGiALMSG0ug3U9yUdJ+NqgBfMTvu2LE2EgoVObbwEWfdMCE8xmjlWVJzQRQATtvlGHiKXvAIwSjZq/gBIKLdKYmHQxBJk9NNE1nhHE6u0dlvVulNpDqO8hPj0P0OplWxHFZtEBpkSsDECAwEAAaOCAncwggJzMGwGA1UdIwRlMGOAFIwdeyOqAicpnNHLlhqKYmCRRZpBoUikRjBEMQswCQYDVQQGEwJLUjEWMBQGA1UEChMNRHJlYW1TZWN1cml0eTEOMAwGA1UECxMFV2lyZWQxDTALBgNVBAMTBFJPT1SCAQMwHQYDVR0OBBYEFL+l1vv7eUOivC/pmfP4xbZtjJW3MA4GA1UdDwEB/wQEAwIAMDB7BgNVHSAEdDByMHAGCiqDGoyaRAUCPAEwYjBgBggrBgEFBQcCAjBUMBQaDURyZWFtU2VjdXJpdHkwAwIBARo8VGhpcyBDZXJ0aWZpY2F0ZSBpcyBnZW5lcmF0ZWQgYnkgRHJlYW1zZWN1cml0eSBmb3IgQ0Fvc19YNTA5MCEGA1UdEQQaMBigFgYJKoMajJpECgEBoAkwBwwDQU5ZMAAwgecGA1UdHwSB3zCB3DBRoE+gTYZLbGRhcDovL2Nhb3MuZHJlYW1zZWN1cml0eS5jb206Mzg5L2NuPWNybDExZHAyLG91PVdpcmVkLG89RHJlYW1TZWN1cml0eSxjPUtSMIGGoIGDoIGAhn5odHRwOi8vY2Fvcy5kcmVhbXNlY3VyaXR5LmNvbS9jcmw/aWg9b0N4RlRlMWFtZGdoV3NrbnlGdmt2ZG4yRG9nJTNkJmRwPWNuJTNkY3JsMTFkcDIlMmNvdSUzZFdpcmVkJTJjbyUzZERyZWFtU2VjdXJpdHklMmNjJTNkS1IwSgYIKwYBBQUHAQEEPjA8MDoGCCsGAQUFBzABhi5odHRwOi8vY2Fvcy5kcmVhbXNlY3VyaXR5LmNvbToxNDIwMy9PQ1NQU2VydmVyMA0GCSqGSIb3DQEBBQUAA4GBACYZfFj6/Ixe3VViMpURAyYX7zBnoUDbCputCTuETzWMEuAc7/ciMGrnGVXitbRmpFlRINWnvDbrwHGF88xCRM1MTzEbLaBcDIMMCvIerUSW2/ocwd/vY6RRN38RAvVuYyNogbphVPaHJv85ivmdT47F7WcvyTz2XCAOJY5QJnJ5',
//	SiteID:'4insure',				// SiteID :세션정보를 획득하는 키값
	SiteID:'MagicLineTest',				// SiteID :세션정보를 획득하는 키값
	AlgoMode:0x30, 	 //	대칭키 알고리즘
                   //SYM_ALG_DES_CBC						0x10	/* DES CBC */
                   //SYM_ALG_3DES_CBC					0x20	/* 3DES CBC */
                   //SYM_ALG_SEED_CBC					0x30	/* SEED CBC */
                   //SYM_ALG_ARIA_CBC					0x40	/* ARIA CBC */
                   //SYM_ALG_RC4_CBC						0x80	/* RC4 CBC */
                   //SYM_ALG_NEAT_CBC					0xE0	/* NEAT CBC */
                   //SYM_ALG_NES_CBC						0xF0	/* NES CBC */
	WorkDir:'DreamSecurity/MagicLineMBX',
	checkMac:'false',


	/**
	 * MagicLine Client JAVA Properties
	 */
	MagicLineDebugModeValue:'false',			//  false :사용안함 , true : 사용함
	MagicLineTabValue:'General',   			//  ALL : 일반/관리 , General : 일반, Management : 관리
	MagicLineStorageTypeValue:'Disk;RemovableDisk;SmartCard;PKCS11Token', 		//  Disk : 하드, RemovableDisk:이동식, SmartCard:저장토큰, PKCS11Token:보안토큰, PHONE:핸드폰
	MagicLineDomainValue:'ALL',				//  ALL :모든인증서 , NPKI : NPKI , GPKI : GPKI
	MagicLineCANameValue:'ALL',				//	ALL :모든인증기관, YESSIGN, SIGNKOREA, TRADESIGN,
											//	SIGNGATE, CROSSCERT,NCASIGN,MOPAS(행안부)
	MagicLineCertPolicyValue:'ALL',			// 	ALL : 모든 인증서 정책 OID,  기타 세부 OID 는 각 인증 도메인별 규격

	MagicLineKeyUsageValue:'SIGN',			// 	ALL : 모든 키사용 용도, SIGN : 서명용, KM : 암호용
	MagicLineKeyboardSecValue:'none',		//	none : 사용안함, softforum : 소프트포럼
	MagicLineMobilePhoneValue:'infovine',	// 'infovine;signgate',
	                                  		// infovine 또는 인포바인 : 인포바인 휴대폰 서비스
																		// signgate 또는 정보인증 : 정보인증 모바일키 휴대폰 서비스
	InfovineInfoValue:'CHANNELNAME:NTS_HTS;CERT_COMPANY:DREAMSECURITY;',						//인포바인일 경우 사용
											//'CHANNELNAME:계약코드;CERT_COMPANY:DREAMSECURITY;',
	Cert_Validate: 'true',   //만료 인증서 표시 여부  true : 로드 안함 , false : 로드 함
	BalloonTip: 'true',      // 말풍선 사용 여부  true : 사용 , false : 사용안함

	MagicLineSite:'',						// MagicLine Site 주소 표시
	

	/**
	 *  MagicLine Client ActiveX Properties
	 */


	GNCertType:0x00,	 					// all:0x00, GPKI:0x01, NPKI:0x02, MPKI:0x04, Private:0x08
	ValidCertInfo:'',
	//ValidCertInfo:'1 2 410 200012 1 1 1|1 2 410 200012 1 1 3|1 2 410 200005 1 1 1|1 2 410 200005 1 1 5|1 2 410 200004 5 1 1 5|1 2 410 200004 5 1 1 7|1 2 410 200004 5 4 1 1|1 2 410 200004 5 4 1 2|1 2 410 200004 5 2 1 1|1 2 410 200004 5 2 1 2|',						// "1 2 410 100001 2 2 1|1 2 410 100001 2 1 2|";
	                                  		// 특정인증서만 로딩 할 경우에 정책코드를 나열한다.
	ReadCertType:0x01,					// 서명용인증서 : 0x01, 암호키분배용 인증서 : 0x02
	KeyStrokeType:0x00,					// 키보드 보안 API (0x00:사용안함, 0x01:softcamp, 0x02:INCA, 0x03:Ahnlab, 0x04:softforum, 0x05:Space International)
	CertOption:1,						// 서명 옵션
													// 0 : 로그인한 세션인증서(선택창 띄움), 1:선택창에서 선택, 2:세션의 인증서, 3:입력한 인증서 개인키(선택창 띄움), 4:입력한 인증서 개인키
	PhoneCertOpt:0,					// 0:none, 1:all, 2:Ubikey, 3: MobileKey,
														// 서비스 추가 사용 변수 2: UbiKey, 4 : MobileKey, 8 : PCRO ( 선택한 변수 + 연산하여 사용 )
	MobileKeyURL:'http://www.mkey.kr/popup/mkey.htm',
	UbikeyVersion:'1.1.0.5',//1.0.4.4 BalloonTipVer
									//http://test.ubikey.co.kr/infovine/1110/download.html  //http://www.yesone.go.kr/infovine/download.html
	UbikeyPopupURL:'http://test.ubikey.co.kr/infovine/1110/download.html',//'http://download.hts.nefficient.co.kr/hts/infovine/download.html'
	UbikeyWParam:'NTS_YESONE', //NTS_HTS
	UbikeylParam:'DREAMSECURITY|SOFTFORUM',
	
	bVitulPad : false,  //가상키보드 사용여부 true: 사용 , false : 사용안함
	VitualKeyPadURL:'http://cattle.mtrace.go.kr/nfilter/cs_nfilter.jsp?publickey=',//가상키보드 URL
	//'http://nshc.net:8080/OpenWebNFilter/cs_nfilter.jsp?publickey=',//가상키보드 URL
	ToolTip:0x01,						// 0x00 : 사용안함, 0x01: 사용
	ExpiredCert:0x00,						// 만료된 인증서 로드 여부
										// 0x00 : 만료된 인증서 로드, 
										//0x01 : 만료된 인증서 로드하지 않음, 
										//0x02 : 만료된 인증서 클릭시 툴팁 메시지 패스워드창과 확인버튼 disable
	LanguageOpt:0,						// 0 : defulat, 1: ENG , 2: KOR , -1 : system Language 언어팩 사용 여부
	CertTabOpt:1,						// 0 : 관리 탭, 1:일반 탭, 2: all
	CertManageOpt:0x00,						//관리탭 사용 여부- 관리탭 사용 ( 0x00: 사용 안함, 0x01: User, 0x02: CA, 0x04: root, 0x08: private )
	EnableMedia:27,             	//하드디스크			1
																//이동식 디스크		2
																//스마트카드			8
																//보안토큰 				16
																//휴대폰					32 ( 선택한 변수 + 연산하여 사용 )
	LogoURL:mlEnv.RootContext+mlEnv.RootPath+'images/Logo.bmp',
	RootCertHashURL:"https://rootca.kisa.or.kr/kor/popup/potency.jsp",

USIMServerIP :"", // 중계서버 IP => "service.smartcert.co.kr"
USIMServerPort : 0, // 중계서버 Port => 443
USIMSiteDomain : "www.dreamsecurity.com", // 적용할 사이트도메인 정보 =>사이트 도메인이 개발서버와 같이 없을시 드림으로 설정.
USIMCertList : 1,				// 현재 사용하지 않음.
USIMRAONSiteCode : 609100003, 	// 라온에 요청하여 받아야 하는 코드 (위내용 참조)


	getClassId:function(){
		var is64 = window.navigator.userAgent.toLowerCase().indexOf('win64') >-1;
		if(is64)
			return 'CLASSID="CLSID:C8223F3A-1420-4245-88F2-D874FC081576"';
		else
			return 'CLASSID="CLSID:C8223F3A-1420-4245-88F2-D874FC081574"';
	},
	activeXCodeBase:function(){
		var is64 = window.navigator.userAgent.toLowerCase().indexOf('win64') >-1;
		if(is64)
			return mlEnv.RootPath+'lib/MagicLineMBX64.cab#version='+mlEnv.activeXVersion;
		else
			return mlEnv.RootPath+'lib/MagicLineMBX.cab#version='+mlEnv.activeXVersion;
	}


};


var MagicLine_install			= true;
var tagStart					= "<MagicLine:ENCRYTPED_DATA>";
var tagEnd						= "</MagicLine:ENCRYTPED_DATA>";


deployJava.getBrowser();
var browser =	deployJava.browserName2;
var isMsie  =   browser.indexOf('MSIE') > -1;

var mlFunc = {

	objBlur:function(obj)
	{
		obj.blur();
		document.focus();
	},
	activeXNotInstalled:function()
	{
		if(mlEnv.MagicLineInstallType == 1){
			MagicLine_install = false;
			location.href=returnMagicInstallPage;
		}else{
			MagicLine_install = false;

		}
	},

	magicLineActiveXTag:function(installprocess, sessionId, keyboard, domain)
	{
		var objHtml =  '<OBJECT ID="MagicLine"  '+mlProp.getClassId();
		if(mlEnv.MagicLineInstallType == '0')
			objHtml += ' CODEBASE="'+mlProp.activeXCodeBase()+'"';
		//objHtml += ' WIDTH = 0 HEIGHT = 0 onError="mlFunc.activeXNotInstalled()"></OBJECT>';
		objHtml += ' WIDTH = 0 HEIGHT = 0></OBJECT>';
		document.write(objHtml);
		if(mlEnv.MagicLineInstallType == '1')
		{
			if(!mlFunc.activeXinstalled())
			{
					mlFunc.activeXNotInstalled();
					return;
			}
		}
		//mlFunc.insertHtml('MagicElement',objHtml);
	},

	activeXinstalled:function()
	{
	   try{
	    	var pluginML = document.MagicLine;//getElementById("MagicLine");
	    	if(pluginML &&( typeof(pluginML.ActiveXVersion) != 'undefined')){
	    		pluginML.ActiveXVersion = mlProp.WorkDir;
	    		for (i=0; i<4;i++) {
	                var tmp01 = parseInt(mlEnv.activeXVersion.split(',')[i]);  // server 배포 버전
	                var tmp02 = parseInt(pluginML.ActiveXVersion.split(',')[i]); // pc   설치 버전

	                if (tmp01 > tmp02){

	                    return false;
	                }
					else if (tmp01 < tmp02)
					{

					    return true;
					}
	            }
	            return true;
	    	}else{
	    		return false;
	    	}
	    }
	    catch(exception)
	    {
	    	alert(exception.message);
	        return false;
	    }
	},

	magicLineAppletTag:function(installprocess, sessionId, keyboard, domain)
	{
			var codebaseurl;
			var downPath;
			var sitebase;

			var libPath = mlEnv.RootPath+'lib/';
			codebaseurl = mlEnv.RootContext;
			sitebase = mlEnv.RootPath;
			downPath = libPath;

			var MagicLineJar 				= 'MagicLine-'+mlEnv.MagicLineVer+'.jar';
			var MagicLineLauncherJar 		= 'MagicLineLauncher-'+mlEnv.MagicLineLauncherVer+'.jar';
			var MagicLineResJar 			= 'MagicLineRes-'+mlEnv.MagicLineResVer+'.jar';
			var MagicLineTrustedRootCertJar = 'MagicLineTrustedRootCert-'+mlEnv.MagicLineTrustedRootCertVer+'.jar';

			var JcoasJar 					= 'jcaos-'+mlEnv.JcoasVer+'.jar';
			var UbiKeyJar 					= 'ubikey-'+mlEnv.UbiKeyVer+'.jar'; // BalloonTipVer
			var BalloonTipJar				= 'balloontip-'+mlEnv.BalloonTipVer+'.jar';			

			if(browser != 'MSIE')
				MagicLineMobilePhoneValue	= "infovine;";


  		var win60 =  window.navigator.userAgent.indexOf('Windows NT 6') >-1;

			var MagicLineInstallProgressValue = installprocess;
			var SessionIDValue				= sessionId;
			var sUserAgent = window.navigator.userAgent;
			var modaless = (browser.toLowerCase().indexOf('safari')==-1) && (sUserAgent.toLowerCase().indexOf('mac')>-1);

			var MagicLineHTML2 = '';
			if(browser == 'MSIE'){
				MagicLineHTML2 += ' <object id="MagicLine" name="MagicLine" classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" codetype="application/java" type="application/x-java-applet" width="0" height="0" onfocus="mlFunc.objBlur(this);" alt="매직라인" >';
				MagicLineHTML2 += ' <param name="java_code" value="com.dreamsecurity.applet.launcher.MagicLineLauncher.class"/>';
				MagicLineHTML2 += ' <param name="java_codebase" value="'+codebaseurl+';"/>';
				MagicLineHTML2 += ' <param name="type" value="application/x-java-applet;jpi-version=1.5"/>';
			}else{
				MagicLineHTML2 += '<div style="position:absolute;top:0px;left:0px;width:0px;height:0px;z-index:1;visibility:hidden;">';
				MagicLineHTML2 += '<applet id="MagicLine" codebase="'+codebaseurl+'"  code="com.dreamsecurity.applet.launcher.MagicLineLauncher.class" width=200 height=75 MAYSCRIPT >'; // style="visibility:hidden;" width="0" height="0" style="outline: none;display:inline" style="visibility:hidden;overflow:hidden;width:0;height:0;margin:0;padding:0;"
			}
			MagicLineHTML2 += ' <param name="archive" value="'+libPath+'/'+MagicLineLauncherJar+','+libPath+'/'+JcoasJar+','+libPath+'/'+UbiKeyJar+','+libPath+'/'+BalloonTipJar+'"/>'; //BalloonTipJar
			//MagicLineHTML2 += ' <param name="cache_archive" value="'+libPath+'/'+NTSMagicLineLauncherJar+','+libPath+'/'+MagicLineLauncherJar+','+libPath+'/'+JcoasJar+','+libPath+'/'+UbiKeyJar+'"/>';
			//MagicLineHTML2 += ' <param name="cache_version" value="'+NTSMagicLineLauncherVer+','+MagicLineLauncherVer+','+JcoasVer+','+UbiKeyVer+'"/>';
			if((installprocess == 'check') && win60){
				MagicLineHTML2 += ' <param name="separate_jvm" value="true"/>';
			}
			// ## MagicLine's Parameter. ##
			MagicLineHTML2 += ' <param name="MacAddressFlag" value="' + mlProp.checkMac + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineCacheFile" value="'+MagicLineJar+';"/>';
			MagicLineHTML2 += ' <param name="MagicLineCacheFileVersion" value="'+mlEnv.MagicLineVer+';"/>';
			MagicLineHTML2 += ' <param name="MagicLinePath" value="'+downPath+'"/>';
			MagicLineHTML2 += ' <param name="codebase_lookup" value="false"/>';
			MagicLineHTML2 += ' <param name="MagicLineResourceFile" value="'+MagicLineResJar+';"/>';
			MagicLineHTML2 += ' <param name="MagicLineResoureVersion" value="'+mlEnv.MagicLineResVer+';"/>';
			MagicLineHTML2 += ' <param name="MagicLineLauncherVersion" value="'+mlEnv.MagicLineLauncherVer+'"/>';
			MagicLineHTML2 += ' <param name="MagicLineRealAppletName" value="com.dreamsecurity.ui.MagicXSignRealAppletProcImpl"/>';
			MagicLineHTML2 += ' <param name="MagicLineTrustedRootCertFile" value="'+MagicLineTrustedRootCertJar+'"/>';
			MagicLineHTML2 += ' <param name="MagicLineTrustedRootCertVersion" value="'+mlEnv.MagicLineTrustedRootCertVer+'"/>';
			MagicLineHTML2 += ' <param name="MagicLineDebugMode" value="' + mlProp.MagicLineDebugModeValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineTab" value="' + mlProp.MagicLineTabValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineStorageType" value="' + mlProp.MagicLineStorageTypeValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineDomain" value="' + mlProp.MagicLineDomainValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineCAName" value="' + mlProp.MagicLineCANameValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineCertPolicy" value="' + mlProp.MagicLineCertPolicyValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineKeyUsage" value="' + mlProp.MagicLineKeyUsageValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineKeyboardSec" value="' + mlProp.MagicLineKeyboardSecValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineMobilePhone" value="' + mlProp.MagicLineMobilePhoneValue + '"/>';
			MagicLineHTML2 += ' <param name="InfovineInfo" value="' + mlProp.InfovineInfoValue + '"/>';
			MagicLineHTML2 += ' <param name="MagicLineInstallProgress" value="'+MagicLineInstallProgressValue+'"/>';
			//MagicLineHTML2 += ' <param name="MagicLineSite" value="' + MagicLineSite + '"/>';
			MagicLineHTML2 += ' <param name="sitebase" value="' + sitebase + '"/>';
			MagicLineHTML2 += ' <param name="SessionID" value="' + SessionIDValue + '"/>';//Modaless
			MagicLineHTML2 += ' <param name="Modaless" value="' + modaless + '"/>';
			//MagicLineHTML2 += ' <param name="sessionIDURL" value="' + mlEnv.RootContext+mlEnv.RootPath+"getCode.jsp" + '"/>';  // 세션ID가 없을 경우 자동으로 sessionID 확보를 위해 적어주는 경로


			if(browser == 'MSIE' ){
				MagicLineHTML2 += ' </object>';
			}else{
				MagicLineHTML2 += '</applet>';
				MagicLineHTML2 += '</div>';
			}
			if(browser == 'MSIE'){
				mlFunc.insertHtml('MagicLineElement',MagicLineHTML2);
			}else{
				document.write(MagicLineHTML2);
			}
	},

	insertHtml:function(eleName, html)
	{
		var magicElement = document.createElement('div');
		magicElement.id=eleName;
		magicElement.innerHTML = html;
		var ref_node =  document.getElementsByTagName("HEAD")[0];
		ref_node.parentNode.insertBefore(magicElement, ref_node);
	}

};

var javaFunc = {

	/*
	* JAVA Install 페이지로 이동.
	*/
	javaInstallProc:function()
	{
		if(mlEnv.JAVAInstallType==2){
			javaInstallCheck();
		}
		else if(browser == 'Safari' || browser == 'Opera'){
			if(!javaFunc.java16VersionSafariCheck()){
					location.href = returnJreInstallPage;
			}
		}else if(browser == 'MSIE'){
			if(!javaFunc.java16VersionMSIECheck()){
					location.href = returnJreInstallPage;
			}
		}else{
			if(!javaFunc.java16VersionCheck()){
					location.href =	returnJreInstallPage;
			}
		}

		return true;
	},

		installJRE:function()
		{
			if(browser == 'MSIE'){
				if(javaFunc.java16VersionMSIECheck())
					location.href = returnIndexPage;
			}else if(browser == 'Safari' || browser == 'Opera'){
				if(javaFunc.java16VersionSafariCheck())
					location.href = returnIndexPage;
			}else{
				if(javaFunc.java16VersionCheck())
					location.href = returnIndexPage;
			}

			if(mlEnv.JAVAInstallType==0){
				mlFunc.insertHtml('javaElement',javaFunc.getInstallJRETag(browser));
//				document.write(javaFunc.getInstallJRETag(browser));
//				deployJava.installLatestJRE();
			}
		},

		java16VersionMSIECheck:function()
		{

			var jres = deployJava.getJREs();
			if(deployJava.versionCheck('1.5.0_20+') ){
				for(var i=0; i< jres.length; i++){
					if(jres[i].indexOf('1.6.0') >-1){
						if(deployJava.versionCheck('1.6.0_17+')){
							return	true;
						}else{
							return false;
						}
					}
				}
				return true;
			}else{
				for(var i=0; i<jres.length; i++){
					if(jres[i].indexOf('1.5.0')>-1 || jres[i].indexOf('1.6.0')>-1)
						return true;
				}
				return false;
			}
		},
		
		
		java16VersionCheck:function(){
			
			var nPlatfrom = window.navigator.platform;
            var Java0StatusS;
            var Java0StatusSI;
			var isMac = (nPlatfrom =='Mac68K')||(nPlatfrom == 'MacPPC') || (nPlatfrom == 'MacIntel') || (nPlatfrom.indexOf("Mac") > -1 );
			
			if(isMac){
				Java0StatusS = PluginDetect.isMinVersion('Java', '1.6.0+', mlEnv.RootPath+'js/getJavaInfo.jar');
				Java0StatusSI = PluginDetect.isMinVersion('Java', '1.7.0_11+', mlEnv.RootPath+'js/getJavaInfo.jar');
				
				if(Java0StatusS == 1 && Java0StatusSI == 1 ){
					return true;
				}else{
					return false;
				}
			}else{
				if(deployJava.versionCheck('1.6.0_17+') && deployJava.versionCheck('1.7.0_11+')){
					return true;
				}
			}
			return false;
		},
		
		
		java16VersionSafariCheck:function(){
			
			var nPlatfrom = window.navigator.platform;
            var Java0StatusS;
            var Java0StatusSI;
            var isMac = (nPlatfrom =='Mac68K')||(nPlatfrom == 'MacPPC') || (nPlatfrom == 'MacIntel') || (nPlatfrom.indexOf("Mac") > -1 );
            
            if(isMac){	
            	Java0StatusS = PluginDetect.isMinVersion('Java', '1.5.0+', mlEnv.RootPath+'js/getJavaInfo.jar');
            	Java0StatusSI = PluginDetect.isMinVersion('Java', '1.7.0_11+', mlEnv.RootPath+'js/getJavaInfo.jar');
        		
            	if(Java0StatusS==1 && Java0StatusSI==1)
            		return true;
            	else
            		return false;
            }else{
            	Java0StatusS = PluginDetect.isMinVersion('Java', '1.6.0+', mlEnv.RootPath+'js/getJavaInfo.jar');
               	Java0StatusSI = PluginDetect.isMinVersion('Java', '1.7.0_11+', mlEnv.RootPath+'js/getJavaInfo.jar');
        		
               	if(Java0StatusS==1 && Java0StatusSI==1)
               		return true;
               	else
               		return false;
	           	}
		},


	getInstallJRETag:function(current_browser){

	   var objectTag = "";
	      objectTag = ' <OBJECT ';
	      objectTag +=' ID = "MagicXSign1"';
	      objectTag +=' classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"';
	      objectTag +=' width="0"';
	      objectTag +=' height="0"';
	      objectTag +=' codebase="http://java.sun.com/update/1.6.0/jinstall-6u24-windows-i586.cab#Version=6,0,2,6">';
	      objectTag +='</OBJECT> ';

		var embedTag = ' <object';
		    embedTag +=' classid = "clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"';
		    embedTag +=' codebase = "http://java.sun.com/update/1.6.0/jinstall-6u24-windows-i586.cab#Version=6,0,2,6"';
		    embedTag +=' WIDTH = "0px" HEIGHT = "0px" >';
		    embedTag +=' <PARAM NAME = CODEBASE VALUE = "http://java.sun.com/update/1.6.0/jinstall-6-fcs-windows-i586.cab" >';
		    embedTag +=' <param name = "type" value = "application/x-java-applet;jpi-version=1.6.0_07">';
		    embedTag +=' <param name = "scriptable" value = "true">';
				embedTag +=' <comment>';
				embedTag +='	 <embed';
		    embedTag +='      type = "application/x-java-applet"';
		    embedTag +='      JAVA_CODEBASE = "http://java.sun.com/update/1.6.0/jinstall-6-fcs-windows-i586.cab"';
		    embedTag +='      WIDTH = "0px"';
		    embedTag +='      HEIGHT = "0px"';
		    embedTag +='			scriptable = true';
		    embedTag +='			pluginspage = "http://javadl.sun.com/webapps/download/GetFile/1.6.0_24-b07/windows-i586/xpiinstall.exe">';
		    embedTag +='			<noembed>';
		    embedTag +='      </noembed>';
				embedTag +='	</embed>';
		    embedTag +=' </comment>';
				embedTag +=' </object>';

		if(current_browser == "MSIE")
			return objectTag;
		else if(current_browser == "Netscape Family")
			return embedTag;
		else
			return objectTag + embedTag;
	}
};


/* MagicLine default Version */
document.writeln('<form name="magicLine4Form" METHOD="POST">');
document.writeln('      <input name="encryptedData" type="hidden"/>');
document.writeln('      <input name="signedData" type="hidden"/>');
document.writeln('</form>');


//====================================================================
//JRE Install Start !!
//====================================================================

function runMagicLine(installProcess, sessionId, keyboard, domain)
{
	if(mlEnv.Product == 'ALL'){
		if(browser == 'MSIE'){
			mlFunc.magicLineActiveXTag(installProcess, sessionId, keyboard, domain);
		//	onKeyExchange();
		}else{
			deployJava.do_initialize();	//자바일경우 초기화
			javaFunc.javaInstallProc();
			mlFunc.magicLineAppletTag(installProcess, sessionId, keyboard, domain);	
			
		}
	}else if(mlEnv.Product == 'MB'){
		deployJava.do_initialize();	//자바일경우 초기화
		javaFunc.javaInstallProc();
		mlFunc.magicLineAppletTag(installProcess, sessionId, keyboard, domain);
	}else if(mlEnv.Product == 'MBX'){
		if(browser != 'MSIE'){
			alert('not support broswer');
			return;
		}
		mlFunc.magicLineActiveXTag(installProcess, sessionId, keyboard, domain);

	}else{
		alert(mlEnv.Product+' product invalid.');
	}


}






//====================================================================
//MagicLine4 Run END !!
//====================================================================


/**
* by kj
* installProgressJRE(): java가 설치되어있는지 체크
* java 설치 페이지로 이동하여 java를 설치 할 수 있도록 구현함.
* java 설치 요건이 충족되면 return false
* java 설치 요건이 충족되지 못하면 java설치 페이지로 이동.
* @param flag
* @return java 설치 페이지 혹은 false
*/
function installProgressJRE(){
	javaFunc.javaInstallProc();
}

/**
* installJRE() : java 설치 페이지에서 사용
* installProgressJRE()에서 java 설치요건이 충족되지 못한경우
* 이 함수를 사용하고 혹 도중에 충족이 되었을경우 index 페이지로 이동함.
* @return
*/
function installJRE(){
	javaFunc.installJRE();
}



function javaInstallUrl(){

	var nPlatfrom = window.navigator.platform;
	var sUserAgent = window.navigator.userAgent;
	var isWin = (nPlatfrom =='Win32')||(nPlatfrom=='Windows');
	var isMac = (nPlatfrom =='Mac68K')||(nPlatfrom == 'MacPPC') || (nPlatfrom == 'MacIntel') || (nPlatfrom.indexOf("Mac") > -1 ) ;
	var isUnix = (nPlatfrom == 'X11') && !isWin && !isMac;
	var isWin98 = sUserAgent.indexOf('Win98')>-1 || sUserAgent.indexOf('Windows 98')>-1;
	var isWinME = sUserAgent.indexOf('Win 9x 4.90')>-1 || sUserAgent.indexOf('Windows ME')>-1;

	var installUrl = "";
	var port = location.port;
	var common_url = mlEnv.RootPath;

	if(isWin){ // windows
		if(isWin98 || isWinME){
			installUrl = common_url+"jre/jre-1_5_0_22-windows-i586-p.exe";		// win98 || winMe일 경우에 jre 1.5버전 설치
		}else{
			return installUrl = common_url+"jre/jre-6u25-windows-i586.exe";
		}
	}else if(isMac){ // mac
		if(sUserAgent.indexof('10_4')>-1){
			return installUrl = common_url+"jre/JavaForMacOSX10.5Update6.dmg";
		}else{
			return installUrl = common_url+"jre/JavaForMacOSX10.6Update1.dmg";
		}
	}else if(isUnix){ // unix
		return installUrl = common_url+"jre/jre-6u17-linux-i586-rpm.bin";
	}else{ // 기타 OS
		alert('지원하지 않는 OS 입니다.');
		return;
	}
}

function returnPage(page){
	location.href = page;
}




//====================================================================
//JRE Install End !!
//====================================================================



/*********************************************************************/
//				init
/*********************************************************************/
function Init()
{
	var nResult;


	if(mlEnv.Product == 'ALL' ){
		if(browser == 'MSIE'){

			nResult = document.MagicLine.Init(mlProp.WorkDir, mlProp.ServerCert, mlProp.AlgoMode,
								mlProp.GNCertType, mlProp.ValidCertInfo, mlProp.ReadCertType, mlProp.KeyStrokeType, mlProp.LogoURL);
			document.MagicLine.SetInitOption(mlProp.ToolTip, mlProp.ExpiredCert);
			document.MagicLine.SetPhoneCertOpt(mlProp.PhoneCertOpt);
			document.MagicLine.SetMobileKeyURL(mlProp.MobileKeyURL);
			document.MagicLine.UbiKeyInit(mlProp.UbikeyVersion,mlProp.UbikeyPopupURL,mlProp.UbikeyWParam,mlProp.UbikeylParam);
			document.MagicLine.SetLanguageOption(mlProp.LanguageOpt);
			document.MagicLine.SetCertManageOption(mlProp.CertTabOpt,mlProp.CertManageOpt);
			document.MagicLine.SetEnableMediaType(mlProp.EnableMedia);
			document.MagicLine.SetVirtualKeyPad(mlProp.bVitulPad,mlProp.VitualKeyPadURL);
			document.MagicLine.SetProperty("USIMServerIP", mlProp.USIMServerIP);
			document.MagicLine.SetProperty("USIMServerPort", mlProp.USIMServerPort);
			document.MagicLine.SetProperty("USIMSiteDomainURL", mlProp.USIMSiteDomain);
document.MagicLine.SetProperty("TokenInstallURL", mlEnv.TokenInstallURL);

document.MagicLine.SetProperty("USIMRAONSiteCode", mlProp.USIMRAONSiteCode);
			if(nResult == 1 )
				nResult = document.MagicLine.SetVerifyRootCert(mlProp.RootCertHashURL);
		}else{

			nResult = document.MagicLine.Init(mlProp.WorkDir, mlProp.ServerCert, mlProp.AlgoMode,
						mlProp.GNCertType, mlProp.ValidCertInfo, mlProp.ReadCertType, mlProp.KeyStrokeType);
			document.MagicLine.setProperty("cert_validate",mlProp.Cert_Validate);
			document.MagicLine.setProperty("balloonTip",mlProp.BalloonTip);
		}
	}else if(mlEnv.Product == 'MB'){
			nResult = document.MagicLine.Init(mlProp.WorkDir, mlProp.ServerCert, mlProp.AlgoMode,	mlProp.GNCertType, mlProp.ValidCertInfo, mlProp.ReadCertType, mlProp.KeyStrokeType);
			document.MagicLine.setProperty("cert_validate",mlProp.Cert_Validate);
			document.MagicLine.setProperty("balloonTip",mlProp.BalloonTip);
	}else if(mlEnv.Product == 'MBX'){
			nResult = document.MagicLine.Init(mlProp.WorkDir, mlProp.ServerCert, mlProp.AlgoMode,
								mlProp.GNCertType, mlProp.ValidCertInfo, mlProp.ReadCertType, mlProp.KeyStrokeType, mlProp.LogoURL);
			document.MagicLine.SetInitOption(mlProp.ToolTip, mlProp.ExpiredCert);
			document.MagicLine.SetPhoneCertOpt(mlProp.PhoneCertOpt);
			document.MagicLine.SetMobileKeyURL(mlProp.MobileKeyURL);
			document.MagicLine.UbiKeyInit(mlProp.UbikeyVersion,mlProp.UbikeyPopupURL,mlProp.UbikeyWParam,mlProp.UbikeylParam);
			document.MagicLine.SetLanguageOption(mlProp.LanguageOpt);
			document.MagicLine.SetCertManageOption(mlProp.CertTabOpt,mlProp.CertManageOpt);
			document.MagicLine.SetVirtualKeyPad(mlProp.bVitulPad, mlProp.VitualKeyPadURL);
			document.MagicLine.SetProperty("USIMServerIP", mlProp.USIMServerIP);
			document.MagicLine.SetProperty("USIMServerPort", mlProp.USIMServerPort);
			document.MagicLine.SetProperty("USIMSiteDomainURL", mlProp.USIMSiteDomain);

document.MagicLine.SetProperty("USIMRAONSiteCode", mlProp.USIMRAONSiteCode);
			if(nResult == 1 )
				nResult = document.MagicLine.SetVerifyRootCert(mlProp.RootCertHashURL);
	}


	if( nResult == 1 )
	{
		//if(document.MagicLine.CheckCreateSession(mlProp.SiteID) != 0)
		//sendEnvelpoData();
		return nResult;
	}
	else if( nResult == 141)
	{
		alert("최상위 인증서 해쉬값 확인을 취소하였습니다");
		return nResult;
	}
	else
	{
		strReturnData = document.MagicLine.GetReturnData();
		alert(strReturnData);
		return nResult;
	}
}

var _xmlHttp;
function sendEnvelpoData(){
    if (window.ActiveXObject) {
    	_xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    else if (window.XMLHttpRequest) {
    	_xmlHttp = new XMLHttpRequest();
    }

	if( document.MagicLine.setSessionID("MagicLineEnvelope") != 1)
	{
		return;
	}

	nResult = document.MagicLine.EnvelopData(mlProp.SiteID, "MagicLineEnvelope");
	strReturnData = document.MagicLine.GetReturnData();
	alert(strReturnData);
	strReturnData = encodeURIComponent(strReturnData);
	alert(strReturnData);

    var endData ='encryptedData='+tagStart + strReturnData + tagEnd;
    _xmlHttp.onreadystatechange = ccc;
    _xmlHttp.open("POST", "/MagicLine4/MagicLineEnvelop.jsp", false); // true:비동기
    _xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
    _xmlHttp.send(endData);
}

function ccc(){
	if(_xmlHttp.readyState == 4) {
        if(_xmlHttp.status == 200) {
          // alert(xmlHttp.responseText);
        }
    }
}

/*********************************************************************/
/** PKCS 7                                                           */
/*********************************************************************/
function ShowCertWindow(mCert, orgView, planText)
{
	var strSendData;
	var nResult = Init();
	if( nResult != 1 ){
		alert('초기화 실패 error code:'+nResult);
		return;
	}

	if( document.MagicLine.setSessionID('') != 1)
	{
		return;
	}
	nResult = document.MagicLine.SignedData_PKCS7(mCert,orgView, planText);

	if( nResult == 1 )
	{
			return document.MagicLine.GetReturnData();
	}
	else
	{
		if( nResult == 106 ||  nResult == 100)
			return 100;
		else
			return nResult;
	}

}
/*********************************************************************/
/** PKCS 7                                                           */
/*********************************************************************/
function ShowCertManage(){
	var strSendData;
	var nResult = Init();
	if( nResult != 1 ){
		alert('초기화 실패 error code:'+nResult);
		return;
	}

	return nResult = document.MagicLine.ShowCertManage();
}





// C/S 용 인증서 사용자 인터페이스
/*********************************************************************/
//                   `                //
/*********************************************************************/
var nResult = -1;

//
// Mac OS X에서 Safari 이외 브라우저에서 Modaless 윈도우창 구현에 따른
// submit 함수 별도 작업
//
function createMsgnTransfer(){
	/*
	strReturnData = document.MagicLine.GetReturnData();

	document.magicLine4Form.encryptedData.value = tagStart + strReturnData + tagEnd;

	if(mlEnv.debug){

		if(!confirm("encrypt data send to?")){
				return;
		}
		alert("encrypted data = "+ document.magicLine4Form.encryptedData.value);
	}
	document.magicLine4Form.submit();
*/
}

function Login(form)
{
	gForm = form;
	var strData;
//	var nResult;
	var strReturnData;
	var strSendData;
	strData= MagicLine4Submit(form);
	nResult = Init();
	if( nResult == 117)
		return;

	var sessionID = "";
        if( form.challenge.value != null)
		sessionID = form.challenge.value;

	if( document.MagicLine.setSessionID(sessionID) != 1)
	{
		return;
	}
	nResult = document.MagicLine.Login(mlProp.SiteID, strData);

	if( nResult == 1 )
	{
		document.magicLine4Form.method = form.method;
		document.magicLine4Form.action = form.action;

		var sUserAgent = window.navigator.userAgent;

		strReturnData = document.MagicLine.GetReturnData();
		document.magicLine4Form.encryptedData.value = tagStart + strReturnData + tagEnd;

		/*Debug mode*/
		if(mlEnv.debug){
			form.sessionIDT.value = sessionID;
			form.pText.value = strData;
			form.eText.value = tagStart + strReturnData + tagEnd;
			if(!confirm("encrypt data send to?")){
					return;
			}
			alert("encrypted data = "+ document.magicLine4Form.encryptedData.value);
		}

		document.magicLine4Form.submit();

	}
	else
	{
		if( nResult == 106 ||  nResult == 100)
			return 100;
		else
			return nResult;
	}

}


//********************************************************************//
//		Logout					              //
//--------------------------------------------------------------------//
//		로그아웃(세션정보 삭제)				      //
//********************************************************************//
function Logout()
{
	var strData;
	var nResult;
	var strReturnData;
	var strSendData;

	nResult = Init();
	if( nResult == 117)
		return;

	nResult = document.MagicLine.Logout(mlProp.SiteID);

	if( nResult == 1 )
	{
		// 메인 페이지로 돌아가기
		alert("로그인한 세션이 종료되었습니다.");
		location.href = returnIndexPage;
	}
}
// cs 용 인증서 사용자인터페이스를 사용한 SignAndEnv
/*********************************************************************/
//		       EnvelopedSignData			  //
/*********************************************************************/
function EnvelopedSignData(form)
{
	var strData;
	var nResult;
	var strReturnData;
	var strSendData;
	strData= MagicLine4Submit(form);
	nResult = Init();
	if( nResult == 117)
		return;

	var sessionID = "";
	if( form.challenge.value != null)
		sessionID = form.challenge.value;

	if( document.MagicLine.setSessionID(sessionID) != 1)
	{
		return;
	}
	nResult = document.MagicLine.EnvelopedSignData(mlProp.SiteID, strData);

	if( nResult == 1) // Issue 실패
	{
		document.magicLine4Form.method = form.method;
		document.magicLine4Form.action = form.action;

		var sUserAgent = window.navigator.userAgent;

		strReturnData = document.MagicLine.GetReturnData();
		document.magicLine4Form.encryptedData.value = tagStart + strReturnData + tagEnd;

		/*Debug mode*/
		if(mlEnv.debug){
			form.sessionIDT.value = sessionID;
			form.pText.value = strData;
			form.eText.value = tagStart + strReturnData + tagEnd;
			if(!confirm("encrypt data send to?")){
					return;
			}
			alert("encrypted data = "+ document.magicLine4Form.encryptedData.value);
		}

		document.magicLine4Form.submit();


	}
	else
	{
		if(nResult != 106 && strReturnData != null)
			alert(strReturnData);
	}


}

/*********************************************************************/
//		       EnvelopData			  //
/*********************************************************************/
function EnvelopedData(form)
{
	var strData;
	var nResult;
	var strReturnData;
	var strSendData;
	strData= MagicLine4Submit( form);
	nResult = Init();
	if( nResult == 117)
		return;

	var sessionID = "";
    	if( form.challenge.value != null)
		sessionID = form.challenge.value;

	if( document.MagicLine.setSessionID(sessionID) != 1)
	{
		return;
	}

	nResult = document.MagicLine.EnvelopData(mlProp.SiteID, strData);
	strReturnData = document.MagicLine.GetReturnData();

	if( nResult == 1 )
	{
		document.magicLine4Form.encryptedData.value = tagStart + strReturnData + tagEnd;
		document.magicLine4Form.method = form.method;
		document.magicLine4Form.action = form.action;

		if(mlEnv.debug){

			if(form.pText && form.eText){
				form.sessionIDT.value = sessionID;
				form.pText.value = strData;
				form.eText.value = tagStart + strReturnData + tagEnd;
				if(!confirm("encrypt data send to?")){
					return;
				}
			}
		}
		if(mlEnv.debug){
			alert("encrypted data = "+ document.magicLine4Form.encryptedData.value);
		}

		document.magicLine4Form.submit();
	}
	else
	{
		if(nResult != 106 && strReturnData != null)
			alert(strReturnData);
	}
}


/*********************************************************************/
//		      SignedDataForm(form)										//
/*********************************************************************/
function SignedDataForm(form)
{
	var strData;
	var nResult;
	var strReturnData;
	nResult = Init();
	if( nResult == 117)
		return;

	strData= MagicLine4Submit(form);

	nResult = document.MagicLine.SignedData(mlProp.SiteID, mlProp.CertOption, strData);

	if( nResult == 1) // Issue 실패
	{
		document.magicLine4Form.method = form.method;
		document.magicLine4Form.action = form.action;

		var sUserAgent = window.navigator.userAgent;

		strReturnData = document.MagicLine.GetReturnData();
		document.magicLine4Form.encryptedData.value = tagStart + strReturnData + tagEnd;

		/*Debug mode*/
		if(mlEnv.debug){
			form.pText.value = strData;
			form.eText.value = tagStart + strReturnData + tagEnd;
			if(!confirm("encrypt data send to?")){
					return;
			}
			alert("encrypted data = "+ document.magicLine4Form.encryptedData.value);
		}

		document.magicLine4Form.submit();


	}
	else
	{
		if(nResult != 106 && strReturnData != null)
			alert(strReturnData);
	}



}

/*********************************************************************/
//		      SignedData(data)										//
/*********************************************************************/
function SignedData(data)
{
	var nResult;
	var strReturnData;
	nResult = Init();
	if( nResult == 117)
		return;
	nResult = document.MagicLine.SignedData(mlProp.SiteID, mlProp.CertOption, data);

	if( nResult == 1) // Issue 실패
	{
		document.magicLine4Form.method = form.method;
		document.magicLine4Form.action = form.action;

		var sUserAgent = window.navigator.userAgent;

		strReturnData = document.MagicLine.GetReturnData();
		return strReturnData;
	}else
	{
		if(nResult != 106 && strReturnData != null)
			alert(strReturnData)
		return "";
	}
}

/*********************************************************************/
//SignItem										//
/*********************************************************************/
function SignItemByOption(data)
{
	var strData;
	var nResult;
	var strReturnData;

	nResult = Init();
	if( nResult == 117)
		return;

	if( mlProp.CertOption == 3 || mlProp.CertOption == 4 )
	{
		if(Cert != null && PriKey != null)
		{
			nResult = document.MagicLine.SetCertAndPriekey(Cert, PriKey);
			if( nResult == 106 ||  nResult == 100)
				return 100;
		}
	}
	
	nResult = document.MagicLine.SignedData_CertAndKeyOption(mlProp.SiteID, mlProp.CertOption, data);
	if( nResult == 1)
	{
		return document.MagicLine.GetReturnData();
	}
	else
	{
		if(nResult != 106 && strReturnData != null)
			alert(strReturnData);
	}
}


/*********************************************************************/
//		      EncryptedSignData										//
/*********************************************************************/
function EncryptedSignData(form)
{
	var strData;
	var nResult;
	var strReturnData;
	nResult = Init();
	if( nResult == 117)
		return;
	strData= MagicLine4Submit( form);
	nResult = document.MagicLine.EncryptedSignData(mlProp.SiteID, mlProp.CertOption, strData);

	if( nResult == 1 ) // 성공
	{
		document.magicLine4Form.method = form.method;
		document.magicLine4Form.action = form.action;

		var sUserAgent = window.navigator.userAgent;

		strReturnData = document.MagicLine.GetReturnData();
		document.magicLine4Form.encryptedData.value = tagStart + strReturnData + tagEnd;

		/*Debug mode*/
		if(mlEnv.debug){
			form.pText.value = strData;
			form.eText.value = tagStart + strReturnData + tagEnd;
			if(!confirm("encrypt data send to?")){
					return;
			}
			alert("encrypted data = "+ document.magicLine4Form.encryptedData.value);
		}

		document.magicLine4Form.submit();

	}
	else
	{
		strReturnData = document.MagicLine.GetReturnData();
		if(nResult != 106)
			alert(strReturnData);
	}
}


/********************************************************************/
//		      onKeyExchange																						//
/********************************************************************/
function onKeyExchange() {
	var nResult;
	nResult = Init();
	if( nResult == 117)
		return;
	
	if (mlProp.SiteID == "4insure")
		return;
	
	if (document.MagicLine.setSessionID("") != 1)
		return;
	
	return document.MagicLine.SetSessionKeyExchange(mlProp.SiteID, mlEnv.RootContext+mlEnv.RootPath+"getCode.jsp", mlEnv.RootContext+mlEnv.RootPath+"MagicLineEnvelop.jsp");
}
/*
function onKeyExchange() {
	var nResult;
	nResult = Init();
	if( nResult == 117)
		return;

	var sessionID = "";


	if (isMsie)
	{
		var sessionID = "";
		if( document.MagicLine.setSessionID(sessionID) != 1)
		{
			return;
		}
	
	   if(document.MagicLine.CheckCreateSession(mlProp.SiteID) != 0){
			sendEnvelpoData();
			return;
	   }
	}
	else
	{
		return document.MagicLine.SetSessionKeyExchange(mlProp.SiteID, mlEnv.RootContext+mlEnv.RootPath+"getCode.jsp", mlEnv.RootContext+mlEnv.RootPath+"MagicLineEnvelop.jsp");
	}
}
*/

/********************************************************************/
//		      Encrypt																									//
/********************************************************************/
function Encrypt(form)
{
	var strData;
	var nResult;
	var strReturnData;

	strData= MagicLine4Submit( form);

	nResult = Init();
	if( nResult == 117)
		return;
	
	if (mlProp.SiteID == "4inusre")
		nResult = document.MagicLine.Encrypt2(mlProp.SiteID, strData);
	else
		nResult = document.MagicLine.Encrypt(mlProp.SiteID, strData);
	
	strReturnData = document.MagicLine.GetReturnData();

	if( nResult == 1 )
	{
		document.magicLine4Form.encryptedData.value = tagStart + strReturnData + tagEnd;
		document.magicLine4Form.method = form.method;
		document.magicLine4Form.action = form.action;
		//alert(document.magicLine4Form.encryptedData.value);

		if(mlEnv.debug){
			if(form.pText && form.eText){
				form.pText.value = strData;
				form.eText.value = tagStart + strReturnData + tagEnd;

				if(!confirm("encrypt data send to?")){
					return;
				}
			}
		}
		if(mlEnv.debug){
			alert("encrypted data = "+ document.magicLine4Form.encryptedData.value);
		}

		document.magicLine4Form.submit();
	}
	else
	{
		alert(strReturnData);
	}
}

function EncryptMultipart(form)
{
	var strData;
	var nResult;
	var strReturnData;

	strData= MagicLine4EmptyValueAndSubmit(form, true);

	alert(strData);
	
	nResult = Init();
	if( nResult == 117)
		return;
	
	if (mlProp.SiteID == "4inusre")
		nResult = document.MagicLine.Encrypt2(mlProp.SiteID, strData);
	else
		nResult = document.MagicLine.Encrypt(mlProp.SiteID, strData);
	
	strReturnData = document.MagicLine.GetReturnData();

	if( nResult == 1 )
	{
		// form 에 encryptedData element 추가
		var input_tag = document.createElement("input");
		input_tag.setAttribute("type", "hidden");
		input_tag.setAttribute("id", "encryptedData");
		input_tag.setAttribute("name", "encryptedData");
		input_tag.setAttribute("value", tagStart + strReturnData + tagEnd);
		
		form.insertBefore(input_tag);		

		if(mlEnv.debug){
			if(form.pText && form.eText){
				form.pText.value = strData;
				form.eText.value = tagStart + strReturnData + tagEnd;

				if(!confirm("encrypt data send to?")){
					return;
				}
			}
		}

		if(mlEnv.debug){
			alert("encrypted data = "+ form.encryptedData.value);
		}
		
		form.submit();
	}
	else
	{
		alert(strReturnData);
	}
}

function EncryptFormData(form)
{
	var nResult;
	var strReturnData;
	var strData;

	nResult = Init();
	if( nResult == 117)
		return;

	strData= makeQueryString(form);

	nResult = document.MagicLine.Encrypt(mlProp.SiteID, strData);
	strReturnData = document.MagicLine.GetReturnData();

	strReturnData = encodeURIComponent(strReturnData);

	if( nResult == 1 )
	{
		return  'encryptedData='+tagStart + strReturnData + tagEnd;

	}
	else
	{
		alert(strReturnData);
	}
}



/*********************************************************************/
//		      EncryptLink											//
/*********************************************************************/
function EncryptLink(link)
{
	var strData;
	var nResult;
	var strReturnData;
	nResult = Init();
	if( nResult == 117)
		return;
	strData= MagicLine4Link(link);
	link.href += "encryptedData=";
	nResult = document.MagicLine.Encrypt(mlProp.SiteID, strData);
	strReturnData = document.MagicLine.GetReturnData();
	if( nResult == 1 )
	{

		strData = replaceEscapeString( strReturnData );
		link.href += tagStart + strData + tagEnd;
	}
	else
	{
		alert(strReturnData);
	}
}


/*********************************************************************/
//		      Decrypt												//
/*********************************************************************/
function Decrypt(encData)
{

	var strData;
	var nResult;
	var strReturnData = "";

	nResult = Init();
	if( nResult == 117)
		return;

	if (mlProp.SiteID == "4insure")
		nResult = document.MagicLine.Decrypt2(mlProp.SiteID, encData);
	else
		nResult = document.MagicLine.Decrypt(mlProp.SiteID, encData);

	strReturnData = document.MagicLine.GetReturnData();
	if( nResult == 1 )
	{
		return strReturnData;
	}
	else
	{
		alert("Decrypt Fail");
		alert(strReturnData);
		return "";
	}
}

/********************************************************************/
//		      SignedDataSession																				//
/********************************************************************/
function SignedDataSession() {
	
	var strData;
	var nResult;
	
	nResult = Init();
	if( nResult == 117)
		return;
		
	nResult = document.MagicLine.SignedData_CertAndKeyOption(mlProp.SiteID, mlProp.CertOption, strData);
	
}

/********************************************************************/
//		      SignedDataSessionoOpt(form)															//
/********************************************************************/
function SignedDataSessionoOpt(form) {
	
	var strData;
	var nResult;
	var strReturnData;
	nResult = Init();
	if( nResult == 117)
		return;

	strData= MagicLine4Submit(form);

	//~! Modified by gomsugy. 2012.08.13
	//[[ ORG.
//	var Cert = form.Cert.value;
//	var PriKey = form.PriKey.value;
	//]]
	//[[ MOD.
	var Cert = (form.Cert) ? form.Cert.value : null;
	var PriKey = (form.PriKey) ? form.PriKey.value : null;
	//]]

	if( mlProp.CertOption == 3 || mlProp.CertOption == 4 )
	{
//		nResult = document.MagicLine.SetCertAndPriekey("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");
		if(Cert != null && PriKey != null)
		{
			nResult = document.MagicLine.SetCertAndPriekey(Cert,PriKey);
			if( nResult == 106 ||  nResult == 100)
				return 100;
		}
	}
	
	nResult = document.MagicLine.SignedData_CertAndKeyOption(mlProp.SiteID, mlProp.CertOption, strData);

	if( nResult == 1)
	{
		document.magicLine4Form.method = form.method;
		document.magicLine4Form.action = form.action;

		var sUserAgent = window.navigator.userAgent;

		strReturnData = document.MagicLine.GetReturnData();
		document.magicLine4Form.encryptedData.value = strReturnData;

		/*Debug mode*/
		if(mlEnv.debug){
			form.pText.value = strData;
			form.eText.value = strReturnData;
			if(!confirm("encrypt data send to?")){
					return;
			}
			alert("encrypted data = "+ document.magicLine4Form.encryptedData.value);
		}

		document.magicLine4Form.submit();
	}
	else
	{
		if(nResult != 106 && strReturnData != null)
			alert(strReturnData);
	}

}


/*********************************************************************/
//		      WrapperTag 											//
/*********************************************************************/
//  <GPKI_ENC> Data </GPKI_ENC>	로 만든다.
function WrapperTag(Msg)
{
	var TagData;

	TagDat = "<GPKI_ENC>";
	TagData += Msg;
	TagData += "</GPKI_ENC>";
	return TagData;
}


/*********************************************************************/
//	               MagicLine4Submit(form)									//
/*********************************************************************/
function MagicLine4Submit( form )
{
	var queryString = "";
	var qs_index = "";
	var action = "";
	var noenc_qs = "";
	if ( form.action.indexOf('?') != -1 )
	{
		//action=> ?asdf=asdf&asdf=aa?12=34 부분의 마지막 ?뒤의 Query는 암호화를 한다.
		action = form.action;
		document.magicLine4Form.action = action.substring( 0, form.action.lastIndexOf('?') );
		queryString = action.substring( action.lastIndexOf('?') + 1, action.length) + '&';
	}
	else
	{
		document.magicLine4Form.action = form.action;
	}

	queryString += makeQueryString(form);
	return queryString;

}

function MagicLine4EmptyValueAndSubmit( form )
{
	var queryString = "";
	var qs_index = "";
	var action = "";
	var noenc_qs = "";
	if ( form.action.indexOf('?') != -1 )
	{
		//action=> ?asdf=asdf&asdf=aa?12=34 부분의 마지막 ?뒤의 Query는 암호화를 한다.
		action = form.action;
		document.magicLine4Form.action = action.substring( 0, form.action.lastIndexOf('?') );
		queryString = action.substring( action.lastIndexOf('?') + 1, action.length) + '&';
	}
	else
	{
		document.magicLine4Form.action = form.action;
	}

	queryString += makeQueryString2(form, true);
	return queryString;

}

/*********************************************************************/
//	               MagicLine4Link(link)		                //
/*********************************************************************/
function MagicLine4Link( link )
{
	nResult = Init();
	if( nResult == 117)
		return;
	var action = "";
	var queryString = "";
	var noenc_qs = "";
	var strResult ="";
	var strCode = "";
	var strMsg = "";

	if ( link.protocol != "http:" )
	{
		alert("http 프로토콜만 사용가능합니다");
		return true;
	}

	if (link.search.length < 1)
	{
		alert("암호화할 Data가 없습니다.");
		return false;
	}

	action = "http://" + link.hostname + ":" + link.port + "/" + link.pathname;
	queryString = link.search.substring( link.search.lastIndexOf('?') + 1, link.search.length);

	link.href = action + "?";
	return queryString;
}

function makeQueryString( form )
{
	return makeQueryString2( form, false );
}

function makeQueryString2( form, bEmptyValue )
{
	var name  =  new Array(form.elements.length);
	var value =  new Array(form.elements.length);
	var flag  = false;
	var j     = 0;
	var plain_text ="";

	len = form.elements.length;

	for (i = 0; i < len; i++)
	{

		if( (form.elements[i].type != "button") && (form.elements[i].type != "reset") && (form.elements[i].type != "submit") )
		{
			if (form.elements[i].type == "radio" || form.elements[i].type == "checkbox")
			{
				if (form.elements[i].checked == true)
				{
					name[j] = form.elements[i].name;
					value[j] = form.elements[i].value;
					j++;
					
					if (bEmptyValue)
						form.elements[i].value = "";
				}
			}
			else {
				name[j] = form.elements[i].name;
				if (form.elements[i].type == "select-one")
				{
					var ind = form.elements[i].selectedIndex;
					if (form.elements[i].options[ind].value != '')
					{
						value[j] = form.elements[i].options[ind].value;
						if (bEmptyValue)
							form.elements[i].options[ind].value = "";
					}
					else
					{
						value[j] = form.elements[i].options[ind].text;
						if (bEmptyValue)
							form.elements[i].options[ind].text = "";
					}
				}
				else
				{
					value[j] = form.elements[i].value;
					if (bEmptyValue)
						form.elements[i].value = "";
				}
				j++;
			}
		}
	}

	for (i = 0; i < j; i++)
	{
		str = value[i];
		//alert('str:'+str);
		value[i] = replaceEscapeString(str);
	}

	for (i = 0; i < j; i++)
	{
		if (flag)
			plain_text += "&";
		else
			flag = true;
		plain_text += name[i] ;
		plain_text += "=";
		plain_text += value[i];
	}
	return plain_text;
}

// submit 전송할 데이터 대체
// &,= 기호 변환
function replaceEscapeString( qureyString )
{
	var i;
	var ch;
	var rstring = '';
	var qstring = '';

	qstring = String(qureyString);

	for (i = 0; i < qstring.length; i++)
	{
		ch = qstring.charAt(i);

		//if (ch == ' ')  rstring += '%20';
		//else
		//if (ch == '%')  rstring += '%25';
		//else
		if (ch == '&')  rstring += '%26';
		//else
		//if (ch == '+')  rstring += '%2B';
		else
		if (ch == '=')  rstring += '%3D';
		//else
		//if (ch == '?')  rstring += '%3F';
		else rstring += ch;
		//alert(rstring);
	}
	return rstring;
}

function getOSName(){
	var OSName="Unknown OS";
	if (navigator.platform.indexOf("Win")!=-1) OSName="Windows";
	if (navigator.platform.indexOf("Mac")!=-1) OSName="MacOS";
	if (navigator.platform.indexOf("X11")!=-1) OSName="UNIX";
	if (navigator.platform.indexOf("Linux")!=-1) OSName="Linux";
	return OSName;
}

//설치페이지로 이동을 위한 함수
function goMagicLineInstallPage(){
	location.href = returnMagicInstallPage ;
}

// 설치 완료 후 액션을 위한 함수
function goMagicLineProgressComplete(){}

function javaInstallCheck(){

	var msg = browser+"브라우저에서 암호 모듈을 사용하기 위해서는 \n";
		msg +=  "Sun MicroSytem에서 제공하는 Java 프로그램을  설치하셔야 합니다. \n";
		msg +=  "\n기존에 설치되어 있는 JAVA 가 설치되어 있었어도 \n";
		msg +=  "암호 모듈이 제대로 작동하지 않을 경우에는, \n";
		msg +=  "\n연결되는 자바 설치 페이지에서 최신 버전을 설치해 주시기 바랍니다. \n";
		msg +=	"자바 설치 후 다시 접속해 주시기 바랍니다.";
		
		if(browser == 'Safari' || browser == 'Opera'){
			if(!javaFunc.java16VersionSafariCheck()){
				alert(msg);
				window.open('http://www.java.com');
			}
		}else if(browser == 'MSIE'){
			if(!javaFunc.java16VersionMSIECheck()){
				alert(msg);
				window.open('http://www.java.com');
			}
		}else{
			if(!javaFunc.java16VersionCheck()){
				alert(msg);
				window.open('http://www.java.com');
			}
		}
		return;
}
