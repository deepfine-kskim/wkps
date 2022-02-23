function addEvtSimple(obj,evt,fn) {
    if (obj.addEventListener)
        obj.addEventListener(evt,fn,false);
    else if (obj.attachEvent)
        obj.attachEvent('on'+evt,fn);
}
function accessibility() {
    var lnksBody = document.getElementById('skipNav')
    if(lnksBody) {
        var lnks = lnksBody.getElementsByTagName('a');
        for (var i=0; i<lnks.length; i++) {
            var target = lnks[i].getAttribute('href').split('#')[1];
            lnks[i].myId = target;
            lnks[i].onclick = function() {
                var myTarget = document.getElementById(this.myId);
                if (myTarget) {
                    myTarget.tabIndex = -1;
                    myTarget.focus();
                    return false;
                }
            }
        }
    }

}
addEvtSimple(window, 'load', accessibility);