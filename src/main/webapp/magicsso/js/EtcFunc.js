/*************************************************
 * MagicPassPrototype 추가기능
 * 매직패스 추가기능
 * 
 * @author Dreamsecurity 진영도
 * @version 1.0
 *************************************************/

/*****************************
 * 비밀번호 등록
 *****************************/
var SSOPwInsert = function(id, apw, apwck, returns)
{
	this.id	= (typeof(id) === "string") ? document.getElementById(id) : id;
	this.apw	= (typeof(apw) === "string") ? document.getElementById(apw) : apw;
	this.apwck	= (typeof(apwck) === "string") ? document.getElementById(apwck) : apwck;
	this.returns	= returns;

	this.SSOPwInsert();
};
SSOPwInsert.prototype = 
{
	SSOPwInsert: function()
	{
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		var flag = flag;
		
		if(success)
		{
			switch(actionName)
			{
				case "PW_INSERT":
					this.complete(message);
					break;
			}
		}
		else
		{
			switch(code)
			{
				case "10001":
				case "10003":
						this.id.value = "";
						this.apw.value = "";
						this.apwck.value="";
						this.id.focus();
						break;
			}

			MagicPass.error(message || code);
		}
	},
	start: function()
	{
		if(MagicPass.usable)
		{
			var pwValue = this.id.value+MagicPass.seperator+this.apw.value;
			MagicPass.init();
			var code = MagicPass.encryptSym(pwValue);
			//alert(code);
			//alert("result "+new String(MagicPass.getResult()));
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						//alert("result : "+result);
						if(!result.isNull())
						{
							MagicPass.request("PW_INSERT", this.response, this, {"encryptedPW" : result});
							return;
						}else{
							return;
						}
					}
					
					MagicPass.errorPage(code);
		}
	},
	complete: function(message)
	{
		alert(message);
		if(typeof(this.returns) === "function")
		{
			(this.returns)();
		}
		else
		{
			var url = new String(this.returns);
			window.location.replace((url.isNull()) ? MagicPass.baseUrl : this.returns);
		}
	}
	
};

/*****************************
 * 비밀번호 변경
 *****************************/
var SSOPwChange = function(bpw, apw, apwck, returns)
{
	this.bpw	= (typeof(bpw) === "string") ? document.getElementById(bpw) : bpw;
	this.apw	= (typeof(apw) === "string") ? document.getElementById(apw) : apw;
	this.apwck	= (typeof(apwck) === "string") ? document.getElementById(apwck) : apwck;
	this.returns	= returns;

	this.SSOPwChange();
};
SSOPwChange.prototype = 
{
	SSOPwChange: function()
	{
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		var flag = flag;
		
		if(success)
		{
			switch(actionName)
			{
				case "PW_CHANGE":
					this.complete(message);
					break;
			}
		}
		else
		{
			switch(code)
			{
				case "10001":
				case "10003":
						this.bpw.value = "";
						this.apw.value = "";
						this.apwck.value="";
						this.bpw.focus();
						break;
			}

			MagicPass.error(message || code);
		}
	},
	/*
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
	*/
	start: function()
	{
		if(MagicPass.usable)
		{
			var pwValue = this.bpw.value+MagicPass.seperator+this.apw.value;
			MagicPass.init();
			var code = MagicPass.encryptSym(pwValue);
			if(code == 0)
			{
				var result = new String(MagicPass.getResult());
				//alert("result : "+result);
				if(!result.isNull())
				{
					MagicPass.request("PW_CHANGE", this.response, this, {"encryptedPW" : result});
					return;
				}else{
					return;
				}
			}
					
			MagicPass.errorPage(code);
		}
	},
	complete: function(message)
	{
		alert(message);
		if(typeof(this.returns) === "function")
		{
			(this.returns)();
		}
		else
		{
			var url = new String(this.returns);
			window.location.replace((url.isNull()) ? MagicPass.baseUrl : this.returns);
		}
	}
	
};

/**************************
 * 안전번호 변경
 *************************/
var SSOSnChange = function(bsn, asn, asnck, returns)
{
	this.bsn	= (typeof(bsn) === "string") ? document.getElementById(bsn) : bsn;
	this.asn	= (typeof(asn) === "string") ? document.getElementById(asn) : asn;
	this.asnck	= (typeof(asnck) === "string") ? document.getElementById(asnck) : asnck;
	this.returns	= returns;

	this.SSOSnChange();
};
SSOSnChange.prototype = 
{
	SSOSnChange: function()
	{
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		var flag = flag;
		
		if(success)
		{
			switch(actionName)
			{
				case "SN_CHANGE":
				this.complete(message);
				break;
			}
		}
		else
		{
			switch(code)
			{
				case "10001":
				case "10003":
						this.bsn.value = "";
						this.asn.value = "";
						this.asnck.value="";
						this.bsn.focus();
						break;
			}

			MagicPass.error(message || code);
		}
	},
	start: function()
	{
		if(MagicPass.usable)
		{
			var snValue = this.bsn.value+MagicPass.seperator+this.asn.value;
			MagicPass.init();
			var code = MagicPass.encryptSym(snValue);
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						//alert("result : "+result);
						if(!result.isNull())
						{
							MagicPass.request("SN_CHANGE", this.response, this, {"encryptedSN" : result});
							return;
						}else{
							return;
						}
					}
					MagicPass.errorPage(code);
		}
	},
	complete: function(message)
	{
		alert(message);
		if(typeof(this.returns) === "function")
		{
			(this.returns)();
		}
		else
		{
			var url = new String(this.returns);
			window.location.replace((url.isNull()) ? MagicPass.baseUrl : this.returns);
		}
	}
	
};

/**************************
 * 안전번호 확인
 *************************/
var SSOSnCheck = function(bsn, returns)
{
	this.bsn	= (typeof(bsn) === "string") ? document.getElementById(bsn) : bsn;
	this.returns	= returns;

	this.SSOSnCheck();
};
SSOSnCheck.prototype = 
{
	SSOSnCheck: function()
	{
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success    = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code       = MagicPass.xmlParse(xmlData, "code");
		var message    = MagicPass.xmlParse(xmlData, "message");
		var flag       = flag;
		
		if(success)
		{
			switch(actionName)
			{
				case "SN_CHECK":
					this.complete(message);
					break;
			}
		}
		else
		{
			switch(code)
			{
				case "10001":
				case "10003":
						this.bsn.value = "";
						this.bsn.focus();
						break;
			}

			MagicPass.error(message || code);
		}
	},
	start: function()
	{
		if(MagicPass.usable)
		{
			var snValue = this.bsn.value;
			MagicPass.init();
			var code = MagicPass.encryptSym(snValue);
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						if(!result.isNull())
						{
							MagicPass.request("SN_CHECK", this.response, this, {"encryptedSN" : result});
							return;
						}else{
							return;
						}
					}
					MagicPass.errorPage(code);
		}
	},
	complete: function(message)
	{
		alert(message);
		if(typeof(this.returns) === "function")
		{
			(this.returns)();
		}
		else
		{
			var url = new String(this.returns);
			window.location.replace((url.isNull()) ? MagicPass.baseUrl : this.returns);
		}
	}
	
};

/*****************************
 * 안전번호 등록
 *****************************/
var SSOSnInsert = function(id, sn, snck, returns)
{
	this.id	= (typeof(id) === "string") ? document.getElementById(id) : id;
	this.sn	= (typeof(sn) === "string") ? document.getElementById(sn) : sn;
	this.snck	= (typeof(snck) === "string") ? document.getElementById(snck) : snck;
	this.returns	= returns;

	this.SSOSnInsert();
};
SSOSnInsert.prototype = 
{
	SSOSnInsert: function()
	{
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		var flag = flag;
		
		if(success)
		{
			switch(actionName)
			{
				case "SN_INSERT":
					this.complete(message);
					break;
			}
		}
		else
		{
			switch(code)
			{
				case "10001":
				case "10003":
						this.id.value = "";
						this.sn.value = "";
						this.snck.value="";
						this.id.focus();
						break;
			}

			MagicPass.error(message || code);
		}
	},
	start: function()
	{
		if(MagicPass.usable)
		{
			var snValue = this.id.value+MagicPass.seperator+this.sn.value;
			MagicPass.init();
			var code = MagicPass.encryptSym(snValue);
			//alert(code);
			//alert("result "+new String(MagicPass.getResult()));
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						//alert("result : "+result);
						if(!result.isNull())
						{
							MagicPass.request("SN_INSERT", this.response, this, {"encryptedPW" : result});
							return;
						}else{
							return;
						}
					}
					
					MagicPass.errorPage(code);
		}
	},
	complete: function(message)
	{
		alert(message);
		if(typeof(this.returns) === "function")
		{
			(this.returns)();
		}
		else
		{
			var url = new String(this.returns);
			window.location.replace((url.isNull()) ? MagicPass.baseUrl : this.returns);
		}
	}
	
};


/*****************************
 * Message Digest 생성(Sha-256)
 *****************************/
var MakeHash = function(resc,rlt)
{
	this.resc	= (typeof(resc) === "string") ? document.getElementById(resc) : resc;
	this.rlt	= (typeof(rlt) === "string") ? document.getElementById(rlt) : rlt;

	this.MakeHash();
};
MakeHash.prototype = 
{
	MakeHash: function()
	{
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		var flag = flag;
		
		if(success)
		{
			switch(actionName)
			{
				case "MAKE_HASH":
					this.complete(message);
					break;
			}
		}
		else
		{
			switch(code)
			{
				case "10001":
				case "10003":
						this.resc.value = "";
						break;
			}

			MagicPass.error(message || code);
		}
	},
	start: function()
	{
		if(MagicPass.usable)
		{
			var snValue = this.resc.value;
			MagicPass.init();
			var code = MagicPass.encryptSym(snValue);
			//alert(code);
			//alert("result "+new String(MagicPass.getResult()));
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						//alert("result : "+result);
						if(!result.isNull())
						{
							MagicPass.request("MAKE_HASH", this.response, this, {"encryptedRESC" : result});
							return;
						}else{
							return;
						}
					}
					
					MagicPass.errorPage(code);
		}
	},
	complete: function(message)
	{
		//alert(message);
		this.rlt.value=message;
	}
	
};

/********************
 * 인증서 등록
 *******************/
var SETDN = function(dn,returns)
{
	this.dn	= (typeof(dn) === "string") ? document.getElementById(dn) : dn;
	this.returns	= (typeof(returns) === "string") ? document.getElementById(returns) : returns;

	this.SETDN();
};
SETDN.prototype = 
{
	SETDN: function()
	{
		MagicPass.readyLoaderX();
	},
	response: function(xmlData)
	{
		var actionName = MagicPass.xmlParse(xmlData, "actionName");
		var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
		var code = MagicPass.xmlParse(xmlData, "code");
		var message = MagicPass.xmlParse(xmlData, "message");
		var flag = flag;
		
		if(success)
		{
			switch(actionName)
			{
				case "SET_DN":
					this.complete(message);
					break;
			}
		}
		else
		{
			switch(code)
			{
				case "10001":
				case "10003":
						this.dn.value = "";
						break;
			}

			MagicPass.error(message || code);
		}
	},
	start: function()
	{
		if(MagicPass.usable)
		{
			var dnValue = this.dn.value;
			MagicPass.init();
			var code = MagicPass.encryptSym(dnValue);
			//alert(code);
			//alert("result "+new String(MagicPass.getResult()));
					if(code == 0)
					{
						var result = new String(MagicPass.getResult());
						//alert("result : "+result);
						//code = MagicPass.object.DecryptSym(decodeURI(result));
						//alert("decrypt : "+MagicPass.getResult());
						if(!result.isNull())
						{
							MagicPass.request("SET_DN", this.response, this, {"encryptedDN" : result});
							return;
						}else{
							return;
						}
					}
					
					MagicPass.errorPage(code);
		}
	},
	complete: function(message)
	{
		alert(message);
		if(typeof(this.returns) === "function")
		{
			(this.returns)();
		}
		else
		{
			//var url = new String(this.returns);			
			var url = MagicPass.logoutUrl;			
			window.location.replace((url.isNull()) ? MagicPass.baseUrl : this.returns);
		}
	}
	
};
