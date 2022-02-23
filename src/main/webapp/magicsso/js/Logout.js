/*************************************************
 * MagicPassPrototype Logout
 * 매직패스 로그아웃
 * 
 * @author Naruware 한영수/박종훈
 * @version 1.1
 *************************************************/

var Logout = function(returnUrl)
{
	this.returnUrl = returnUrl;
};
Logout.prototype =
{
	start: function()
	{
		MagicPass.logout();
		this.complete();
	},
	complete: function()
	{
		var url = new String(this.returnUrl);
		url = (url.isNull()) ? MagicPass.baseUrl : this.returnUrl;
		window.location.replace(url);
	}
};