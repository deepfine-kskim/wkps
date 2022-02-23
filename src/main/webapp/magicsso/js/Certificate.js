/*************************************************
 * MagicPassPrototype Certificate
 * 매직패스 인증서 로그인
 * 
 * @author Naruware 한영수/박종훈
 * @version 1.0
 *************************************************/
var isApplet=0;
var HostIP;

 var Certificate = function(returnUrl)
{
	this.returnUrl = returnUrl;
	this.signedValue = null;
	
	//Constructor
	this.Certificate();
};
Certificate.prototype =
{
	Certificate: function()
	{
		MagicPass.readyLoaderX();
		MagicPass.readyCertX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		HostIP = MagicPass.xmlParse(xmlData, "HostIP");
		
		if(success)
		{
			switch(actionName)
			{
				case "GET_SERVER_CERTIFICATION":
					MagicPass.serverCertificate = message;
					break;
				case "INIT_KEY":
					this.changeKey(message);
					break;
				case "LOGIN":
					this.complete(message);
					break;
			}
		}
		else
		{
			MagicPass.error(message || code);
		}
	},
	start: function()
	{

		if(MagicPass.option.useCertificate)
		{
			MagicPass.loginType = MagicPass.CERT;
			MagicPass.init();
			
			if(MagicPass.option.useApplet)
			{
				var Result;
				MagicPass.objectCertX.Site = MagicPass.siteName;
				MagicPass.objectCertX.LogonType = 1;

				Result = SignedData('signed');
				if(""!=Result)
				{
					this.signedValue = "V5;0;0000;" + Result;
					var code = MagicPass.getEnvKey();
					
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						if(!result.isNull())
						{
							MagicPass.request("INIT_KEY", this.response, this, {"initialSessionKey": result});
							return;
						}
					}
				}else
					return;
			}
			else
			{
				MagicPass.objectCertX.Site = MagicPass.siteName;
				MagicPass.objectCertX.LogonType = 1;
				
				var nResult = Init();
				if( nResult == 117)
					alert('Init Error');
					
				MagicPass.objectCertX.setSessionID('1');

				if((nResult = MagicPass.objectCertX.SignedData(mlProp.SiteID, mlProp.CertOption, 'signed')) == 1)
				{
					var strReturnData = MagicPass.objectCertX.GetReturnData();
					//alert(strReturnData);
										
					this.signedValue = "V5;0;0000;" + strReturnData;
					//document.getElementById("certField").value=this.signedValue;
					//return;
					var code = MagicPass.getEnvKey();
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						if(!result.isNull())
						{
							MagicPass.request("INIT_KEY", this.response, this, {"initialSessionKey": result});
							return;
						}
					}
					MagicPass.error(code);
				}
			}
		}
	},
	changeKey: function(initialSessionKey)
	{
		var code = MagicPass.changeKey(initialSessionKey);
		if(code == 0)
		{
			code = MagicPass.encryptLogin(this.signedValue);
			if(code == 0)
			{
				var result = new String(MagicPass.getResult());
				if(!result.isNull())
				{
					var macAddr = ' ';
				  //alert(MagicPass.objectLoaderX.GetClientMacAddress());
					//if(MagicPass.isMacCheck){
						if(MagicPass.option.useApplet)
						{
							macAddr = MagicPass.getMacAddress(HostIP, false);
						}else{
							MagicPass.objectLoaderX.GetClientMacAddress();
							macAddr = MagicPass.objectLoaderX.Result;
						}
						MagicPass.encryptSym(macAddr);
						var EncMAC = MagicPass.getResult();
						MagicPass.request("LOGIN", this.response, this, {"ssoEncryptedData": result, "ssoLoginType": MagicPass.loginType, "macAddr" : EncMAC});
					//}else
					//	MagicPass.request("LOGIN", this.response, this, {"ssoEncryptedData": result, "ssoLoginType": MagicPass.loginType});
					return;
				}
			}
		}

		MagicPass.error(code);
	},
	complete: function(ssoEncryptedData)
	{
		MagicPass.setCharset();
		MagicPass.setDelegateName();
		MagicPass.browserOffCheck();
		MagicPass.setToken(ssoEncryptedData);
		MagicPass.setDirectLogoutURL();
		MagicPass.setDupCheckURL();
		if(MagicPass.option.MP_monitor.use) MagicPass.monitor(0);

		var url = new String(this.returnUrl);
		url = (url.isNull()) ? MagicPass.baseUrl : this.returnUrl;

		window.location.replace(url);
	}
};
var GetCertDN = function()

{

           MagicPass.readyCertX(false);
           

           var nResult = Init();

           if( nResult == 117)

                     alert('Init Error');

                     

           MagicPass.objectCertX.setSessionID('1');

 

           if((nResult = MagicPass.objectCertX.SignedData(mlProp.SiteID, mlProp.CertOption, 'signed')) == 1)

           {

                     return MagicPass.objectCertX.GetCertDN();

           }

           else

           {

                     MagicPass.error("인증서 정보를 획득하지 못하였습니다.");

                     return '';

           }

}

