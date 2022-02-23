/*************************************************
 * MagicPassPrototype Login
 * 매직패스 로그인
 * 
 * @author Naruware 한영수/박종훈
 * @version 1.2
 *************************************************/
var Login = function(idInput, pwInput, returns)
{
	this.idInput	= (typeof(idInput) === "string") ? document.getElementById(idInput) : idInput;
	this.pwInput	= (typeof(pwInput) === "string") ? document.getElementById(pwInput) : pwInput;
	this.returns	= returns;

	//Constructor
	this.Login();
};
Login.prototype = 
{
	Login: function()
	{
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		var etc = MagicPass.xmlParse(xmlData, "etc");
		var tcheck = (MagicPass.xmlParse(xmlData,"tcheck").toLowerCase()=="true")?true:false;
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
					MagicPass.option.isTokenCheck=tcheck;
					this.complete(message);
					break;
			}
		}
		else
		{
			switch(code)
			{
			    case "9999" :
			    	MagicPass.error(code);
			    	break;
				case "10001":
				case "10003":
					this.idInput.value = "";
					this.pwInput.value = "";
					this.idInput.focus();
					break;
				case "32000":
					alert("이미 로그인이 되어 있습니다.\n"+etc+"로그아웃 시켜주세요");
					break;	
			    case "10009":
			        this.idInput.value = "";
			        this.pwInput.value = "";
			        this.idInput.focus();
			        alert("비밀번호 "+message+"회 오류입니다. \n(5회 오류이면 시스템을 사용하실 수 없습니다.)");
			        break;	
			}
			if(code=="32000" || code=="10009" || code=="9999")
				return;
			else{
				MagicPass.error(code);
			}
		 }
	},
	validate: function()
	{
		if(MagicPass.usable)
		{
			if(this.idInput.value == "")
			{
				MagicPass.error(70001);
				this.idInput.focus();
	
				return false;
			}
			else if(this.pwInput.value == "")
			{
				MagicPass.error(70002);
				this.pwInput.focus();
	
				return false;
			}
			else if(MagicPass.isLogin())
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
			MagicPass.loginType = MagicPass.ID;
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
			var mac = MagicPass.getMacAddress('',false);
			code = MagicPass.encryptLogin(this.idInput.value+MagicPass.seperator+mac,  this.pwInput.value);
			if(code == 0)
			{
				var result = new String(MagicPass.getResult());
				if(!result.isNull())
				{
					var codem = MagicPass.encryptSym(mac);
					mac = (codem ==0)?MagicPass.getResult():'';
					MagicPass.request("LOGIN", this.response, this, {"ssoEncryptedData": result, "ssoLoginType": MagicPass.loginType, "ssoApplicationCode": MagicPass.applCode, "isEam": MagicPass.option.useEam, "macAddr":mac});
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
		//alert("tcheck : "+MagicPass.option.isTokenCheck);
		MagicPass.setDirectLogoutURL();
		MagicPass.setDupCheckURL();
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