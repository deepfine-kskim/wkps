/**
 * @license Copyright (c) 2003-2020, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.filebrowserImageUploadUrl = '/kno/ckeditorImageUpload.do?type=image';

	config.font_names = '맑은 고딕; 돋움; 굴림; 궁서; 바탕;' +  CKEDITOR.config.font_names;
	config.fontSize_defaultLabel = '12px';
	config.fontSize_sizes = '8/8px;9/9px;10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;';
	config.language = "ko";
	config.enterMode = CKEDITOR.ENTER_BR;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
	config.startupFocus = true;
	config.uiColor = '#e0e0e0';
	config.toolbarCanCollapse = true;
	config.toolbarStartupExpanded = true;
	config.menu_subMenuDelay = 0;
	config.removePlugins = 'flash, iframe, templates, div, source, smiley, save, newpage, elementspath, easyimage';

	config.removeDialogTabs = 'image:Link;image:advanced;link:advanced;';
	config.linkShowTargetTab = false;
	config.allowedContent = true;
	config.height = 500;
};

CKEDITOR.on('dialogDefinition', function (e) {
	const name = e.data.name;
	const definition = e.data.definition;
	const dialog = e.data.definition.dialog;

	if (name === 'image') {
		dialog.on('show', function (obj) {
			this.selectPage('Upload');
		});

		definition.onLoad = function () {
			this.getContentElement('info', 'txtUrl').getElement().setStyle('position', 'absolute');
			this.getContentElement('info', 'txtUrl').getElement().setStyle('z-index', '-1');
		}

		const infoTab = definition.getContents('info');
		infoTab.remove('cmbAlign');
		infoTab.remove('txtHSpace');
		infoTab.remove('txtVSpace');
	}
});