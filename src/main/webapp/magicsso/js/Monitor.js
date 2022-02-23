Monitor = new Object();

Monitor.response = function(xmlData)
{
	MagicPass.log("response get");
	var actionName = MagicPass.xmlParse(xmlData, "actionName");
	var success = (MagicPass.xmlParse(xmlData, "success").toLowerCase() == "true") ? true : false;
	var code = MagicPass.xmlParse(xmlData, "code");
	var message = MagicPass.xmlParse(xmlData, "message");
	if(success)
	{
		switch(actionName)
		{
			case "SESS_CLEARED":
				MagicPass.log("NEW_SESSION");
				break;
			case "SESS_ALIVE":
				MagicPass.log("session alive");
				Monitor.replay();
				break;
		}
	}
	else
	{
		MagicPass.log("response false");
		switch(code)
		{
			case "40000" :
				MagicPass.log("SESSION_CLEARED");
				window.location.replace(MagicPass.loginUrl);
				break;
			case "40001" :
				MagicPass.log("SESSION_CLEARED");
				MagicPass.logout();
				window.location.replace(MagicPass.loginUrl);
				break;
			default :
				MagicPass.errorPage(code,message);
			    break;
		}
	}
};

Monitor.start = function()
{
	if(MagicPass.usable && MagicPass.option.JS_monitor.use)
	{
		if(MagicPass.isLogin())
		{
			if(MagicPass.option.JS_monitor.object == null)
			{
				Monitor.sessionAlive();
				return;
			}
		}
		else
		{
			MagicPass.request("SESS_CLEARED", this.response, this, {"wauf":"Monitor.js"});
		}
	}
	else
	{
		MagicPass.log("Monitor.restart");
		window.setTimeout(function(){Monitor.start();},500);
		return;
	}
	
};

Monitor.sessionAlive =  function()
{
		if(!MagicPass.isLogin())
		{
			//MagicPass.log("INFO","monitor ...");
			MagicPass.request("SESS_CLEARED", Monitor.response, Monitor, {"wauf":"Monitor.js"});
			var url = new String(window.location);
			if(url.indexOf(MagicPass.loginUrl) < 0)
				window.location.replace(MagicPass.loginUrl);
		}
		else
		{
			//MagicPass.log("session_alive check s111");
			if(MagicPass.option.useSessionSync)
				MagicPass.request("SESS_ALIVE", Monitor.response, Monitor, {"wauf":"Monitor.js"});
			else
			{
				Monitor.replay();
			}
			return;
		}
};

Monitor.stop =  function()
{
	window.clearInterval(MagicPass.option.JS_monitor.object);
	MagicPass.option.JS_monitor.object = null;
};

Monitor.replay = function()
{
	if(MagicPass.option.useSessionSync)
		window.setTimeout(Monitor.sessionAlive,MagicPass.option.MP_monitor.interval);
	else
		window.setTimeout(Monitor.sessionAlive,MagicPass.option.JS_monitor.interval);
};
/*--------------------------------------------------------
 * 	Auto Start
--------------------------------------------------------*/
Monitor.start();
/*
if(MagicPass.option.MP_monitor.use)
{
	window.unlock = false;
	MagicPass.addEvent(window, "unload", function(){
		if(!window.unlock)
		{
			MagicPass.monitor(MagicPass.option.MP_monitor.interval);
			window.unlock = true;
		}
	});
}
*/
