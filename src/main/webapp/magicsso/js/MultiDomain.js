/*************************************************
 * MagicPassPrototype MultiDomain
 * 매직패스 멀티도메인 연계
 * 
 * @author Naruware, 한영수/박종훈
 * @version 1.0
 *************************************************/
var MultiDomain = function(sourceSiteName, sourceApplCode, returnUrl)
{
	this.sourceSiteName = sourceSiteName;
	this.sourceApplCode = sourceApplCode;
	this.returnUrl = returnUrl;
	
	this.isLoginSessionAlive = false;
	this.isMultiDomainProcess = false;
	
	//생성자
	this.MultiDomain();
};
MultiDomain.prototype =
{
	MultiDomain: function()
    {
		MagicPass.readyLoaderX();
		if((this.sourceSiteName).isNull() || (this.sourceApplCode).isNull())
		{
			window.location.replace(MagicPass.baseUrl);
		}
    },
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
                case "LOGIN_SESSION_CHECK":
                    this.isLoginSessionAlive = true;
                    break;
                case "GET_SERVER_CERTIFICATION":
                    MagicPass.serverCertificate = message;
                    break;
                case "INIT_KEY":
                    this.changeKey(message);
                    break;
                case "CONNECT":
               		this.multiDomainStart();
                    break;
                case "LOGIN":
                    this.complete(message);
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
        			MagicPass.error(message || code);
        			break;
        	}
        }
    },
    start: function()
    {
		if(MagicPass.usable)
		{
			if(MagicPass.isLogin(this.sourceSiteName) && !MagicPass.isLogin())
			{
				var code = MagicPass.getEnvKey(true, this.sourceSiteName, this.sourceApplCode);
				if (code == 0)
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
			
			window.location.replace(MagicPass.baseUrl);
		}
	},
    changeKey: function(initialSessionKey)
    {
		var code = MagicPass.changeKey(initialSessionKey, !this.isMultiDomainProcess, this.sourceSiteName, this.sourceApplCode);
		
		if(code == 0)
		{
			if(!this.isMultiDomainProcess)
			{
				if((code = MagicPass.getToken(this.sourceSiteName, this.sourceApplCode)) == 0)
				{
					var result = new String(MagicPass.getResult());
					if(!result.isNull())
					{
						MagicPass.request("CONNECT", this.response, this, {"isMultiDomain": true, "ssoEncryptedData": result});
						return;
					}
				}
			}
			else
			{
				MagicPass.request("LOGIN", this.response, this, {"isMultiDomain": true});
				return;
			}
		}

		MagicPass.error(code);
    },
	multiDomainStart: function()
	{
		MagicPass.loginType = MagicPass.ID;
		MagicPass.init();
		
		this.isMultiDomainProcess = true;
		this.sourceSiteName = null;
		this.sourceApplCode = null;
		
		var code = MagicPass.getEnvKey();
		if(code == 0)
		{
			var result = new String(MagicPass.getResult());
			if(!result.isNull())
			{
				MagicPass.request("INIT_KEY", this.response, this, {"initialSessionKey" : result});
				return;
			}
		}
	},
    complete: function(ssoEncryptedData)
    {
        MagicPass.setCharset();
        MagicPass.setDelegateName();
        MagicPass.browserOffCheck();
        MagicPass.setToken(ssoEncryptedData);
		if(MagicPass.option.MP_monitor.use) MagicPass.monitor(0);

		var url = new String(this.returnUrl);
		url = (url.isNull()) ? MagicPass.baseUrl : this.returnUrl;

		window.location.replace(url);
    }
};