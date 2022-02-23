function KWL(addr, site) {
	this.addr = addr;
	this.site = site;
}

KWL.prototype.writeLog = function(json_data) {
	var type = encodeURIComponent(this.site);
	var msg = JSON.stringify(json_data);
	msg = encodeURIComponent(msg);

	var params = "type="+type+"&msg="+msg;
	var req = new XMLHttpRequest();
	req.open("POST", "http://"+this.addr+"/ksm/logflow/write?"+params, false);
	req.send();
}

