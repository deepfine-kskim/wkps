/*************************************************
 * MagicPassPrototype EXLogin
 * 매직패스 연계(타솔루션과연동용)
 * 
 * @author Dreamsecurity 진영도
 * @version 1.2
 *************************************************/
var EXLogin = function(returns)
{
	//this.idInput	= (typeof(idInput) === "string") ? document.getElementById(idInput) : idInput;
	//this.pwInput	= (typeof(pwInput) === "string") ? document.getElementById(pwInput) : pwInput;
	this.returns	= returns;

	//Constructor
	this.EXLogin();
};
EXLogin.prototype = 
{
	EXLogin: function()
	{
	    MagicPass.writeLog("Login.js :: MagicPass.readyLoaderX start","green");
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		var etc = MagicPass.xmlParse(xmlData, "etc");
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
				case "EX_LOGIN":
					this.complete(message,code,etc);
					break;
			}
		}
		else
		{
			switch(code)
			{
				case "10001":
				case "10003":
					break;
				case "32000":
					alert("이미 로그인이 되어 있습니다.\n"+etc+"로그아웃 시켜주세요");
					break;	
			    case "10009":
			        break;	
			}
			if(!(code=="32000" || code=="10009"))
			MagicPass.error(message || code);
		}
	},
	validate: function()
	{
		if(MagicPass.usable)
		{
			if(MagicPass.isLogin())
			{
				if(confirm(MagicPass.error(70012, false)))
					MagicPass.logout();
				else
					return false;
			}
		}
		else
		{
			if(!confirm(MagicPass.error(70000, false)))
			{
				MagicPass.setupOffLine();
			}

			return false;
		}

		return true;
	},
	start: function()
	{
		if(this.validate())
		{	
			MagicPass.loginType = MagicPass.ONLY_ID;
			MagicPass.init();
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
	},
	changeKey: function(initialSessionKey)
	{
		var code = MagicPass.changeKey(initialSessionKey);
		if(code == 0)
		{
			MagicPass.request("EX_LOGIN", this.response, this);
			return;
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
		if(MagicPass.option.MP_monitor.use) MagicPass.monitor(0);
	
		if(typeof(this.returns) === "function")
		{
			(this.returns)();
		}
		else
		{
			var url = new String(this.redirect);			
			window.location.replace((url.isNull()) ? MagicPass.baseUrl : this.redirect);
		}
	}
};