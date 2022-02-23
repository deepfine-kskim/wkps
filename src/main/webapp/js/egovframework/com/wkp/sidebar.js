function sideRudder() {
	var rudder;
	var wid = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
	if(wid > 780) {
		rudder = 'right';
	} else {
		rudder = 'left';
	}
	return rudder;
}
function ani_sidebar(div, type, val) {
	if(type == 'left') {
		div.animate({
			left : val
		}, 'fast');
	} else {
		div.animate({
			right : val
		}, 'fast');
	}
}

function sideBg(opt) {
	var mask = $('#pageBg');
	if(opt == 'show') {
		mask.show();
		$('html, body').css({
			'overflow': 'hidden',
			'height': '100%'
		});
	} else {
		mask.hide();
		$('html, body').css({
			'overflow': '',
			'height': ''
		});
	}
}

function sideOpen(sideEl) {
	var sideSize = "-320px";
	var div = $(sideEl);

	var rudder;
	if (div.attr('id') == 'mSidebarR') {
		rudder = 'right';
	} else {
		rudder = 'left';
	}
	console.log(rudder);
	var is_div = div.css(rudder);
	console.log(is_div);
	if(sideEl) {
		if(is_div == sideSize) {
			ani_sidebar(div, rudder, '0');
			if(rudder == 'left') {
				sideBg('show');
			} else {
				sideBg('hide');
			}
		} else {
			ani_sidebar(div, rudder, sideSize);
			sideBg('hide');
		}
	} else {
		if(is_div == sideSize) {
			ani_sidebar(div, rudder, '0');
		} else {
			ani_sidebar(div, rudder, sideSize);
			sideBg('hide');
		}
		if(rudder == 'left') {
			sideBg('show');
		} else {
			sideBg('hide');
		}
	}
	return false;
}

$(document).ready(function () {
	$('.sidebar_close').on('click', function () {
		var sideSize = '-320px';
		var div = $('.m_sidebar');
		var rudder;
		console.log(div.attr('id'));
		if (div.attr('id') == 'mSidebarR') {
			rudder = 'right';
		} else {
			rudder = 'left';
		}
		console.log(rudder);
		ani_sidebar(div, rudder, sideSize);
		sideBg('hide');
		return false;
    });

	$(window).resize(function() {
		var side = sideRudder();
		if(side == 'left') {
			side = 'right';
		} else {
			side = 'left';
		}
		if($("#sidebar-box").css(side) != '') {
			$("#sidebar-box").css(side, '');
			sideBg('hide');
		}
	});
	$('#mBtn').on('click', function() {
		sideOpen("#mSidebar");
	});
	$('#mBtnR').on('click', function() {
		sideOpen("#mSidebarR");
	});
});
