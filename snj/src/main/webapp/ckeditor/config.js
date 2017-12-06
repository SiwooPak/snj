/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function(config) {
	// Define changes to default configuration here. For example:
	// config.language = 'en';
	// config.uiColor = '#AADC6E';
	config.allowedContent = true;
	config.extraPlugins = 'youtube,widget,lineutils,widgetselection,leaflet';
	config.height = 500;
	//config.toolbar = myToolbar;
	// config.uiColor = '#9AB8F3';
	config.uiColor = '#D3D3D3';
	config.enterMode = CKEDITOR.ENTER_BR; // 엔터키 태그 1:<p>, 2:<br>, 3:<div>
	config.font_defaultLabel = '굴림체'; // 기본글씨
	config.font_names = '굴림체/Gulim;돋움체/Dotum;맑은 고딕/맑은 고딕;';
	config.filebrowserBrowseUrl = '../ckfinder/ckfinder.html';
	config.filebrowserImageBrowseUrl = '../ckfinder/ckfinder.html?type=Images';
	config.filebrowserFlashBrowseUrl = '../ckfinder/ckfinder.html?type=Flash';
	config.filebrowserUploadUrl = '../ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files';
	config.filebrowserImageUploadUrl = '../ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images';
	config.filebrowserFlashUploadUrl = '../ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Flash';
	
};
