/*************************************************
 * MagicPassPrototype Connect
 * 매직패스 연계
 * 
 * @author Naruware 한영수/박종훈
 * @version 1.1
 *************************************************/
isPost = false;
valueBasket = new Array();
var Connect = function(returns)
{
	this.returns = returns;
	this.isLoginSessionAlive = false;
	this.flag = 0;
	MagicPass.readyLoaderX();
};
Connect.prototype =
{
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");

		if(success)
		{
			switch (actionName)
			{
				case "GET_SERVER_CERTIFICATION":
					MagicPass.serverCertificate = message;
					break;
				case "INIT_KEY":
					this.changeKey(message);
					break;
				case "CONNECT":
					this.complete();
					break;
				case "LOGIN_SESSION_CHECK":
					this.isLoginSessionAlive = true;
					break;
			}
		}
		else
		{
			switch(actionName)
			{
				case "LOGIN_SESSION_CHECK":
					break;
				default :
					//MagicPass.error(message || code);
					MagicPass.error(code);
					break;
			}
		}
	},
	start: function(isAutoLoginConnect)
	{
		if(MagicPass.usable)
		{
		   	MagicPass.request("LOGIN_SESSION_CHECK", this.response, this);

		   	if(MagicPass.isLogin())
			{
				if(!this.isLoginSessionAlive)
				{	
					var code = MagicPass.getEnvKey(true);
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						if(!result.isNull())
						{
							MagicPass.request("INIT_KEY", this.response, this, {"initialSessionKey" : result});
							return;
						}else{
							return;
						}
					}
					
					MagicPass.errorPage(code);
				}
			   	else
			   	{
			   		if(!isAutoLoginConnect) this.complete();
			   	}
			}
			else
			{
				alert("로그인후 이용하세요");
				if(MagicPass.option.useSessionSync)
				{
					if(this.isLoginSessionAlive)
						MagicPass.request(null, null, null, null, MagicPass.logoutUrl); //logout
				}
				
				//this.complete();
				this.notcomplete();
			}
		}
	},
	changeKey: function(initialSessionKey)
	{
		var code = MagicPass.changeKey(initialSessionKey, true);
		if(code == 0)
		{
			if((code = MagicPass.getToken()) == 0)  
			{
				var result = new String(MagicPass.getResult());
				if(!result.isNull())
				{
					var mac = MagicPass.getMacAddress();
					var codem = MagicPass.encryptSym(mac);
					mac = (codem ==0)?MagicPass.getResult():'';
					MagicPass.request("CONNECT", this.response, this, {"ssoEncryptedData": result, "macAddr":mac});
					return;
				}
				else
				{
					alert("매직패스에서 토큰정보를 가져올수 없습니다 result : "+result);
				}
			}
			else
			{
				//alert("매직패스에서 토큰정보를 가져올수 없습니다 code : "+code);
			}
		}

		MagicPass.error(code);
	},
	complete: function()
	{
			if(typeof(this.returns) == "function")
			{
				(this.returns)();
			}
			else
			{
				var url = new String(this.returns);
				url = (url.isNull()) ? MagicPass.baseUrl : (this.returns || window.location);
				
				if(isPost){
					var frm = MagicPass.makeForm(url,valueBasket);
					frm.submit();
				}else{
					window.location.replace(url);
				}
			}
	},
	notcomplete: function()
	{
			window.location.replace(MagicPass.failRtnUrl);
	}
};

/*--------------------------------------------------------
 * 	Auto Start
--------------------------------------------------------*/
if(MagicPass.option.isAutoLogin)
{
	MagicPass.job("매직패스 로그인 연계", function(){
		Connect.prototype.start(true);
	});
}