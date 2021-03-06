<script data-relocate="true">
var __REDACTOR_ICON_PATH = '{@$__wcf->getPath()}icon/';
var __REDACTOR_BUTTONS = [ {implode from=$__wcf->getBBCodeHandler()->getButtonBBCodes() item=__bbcode}{ icon: '{$__bbcode->wysiwygIcon}', label: '{$__bbcode->buttonLabel|language}', name: '{$__bbcode->bbcodeTag}' }{/implode} ];
var __REDACTOR_SMILIES = { {implode from=$__wcf->getSmileyCache()->getCategorySmilies() item=smiley}'{@$smiley->smileyCode|encodeJS}': '{@$smiley->getURL()|encodeJS}'{/implode} };
var __REDACTOR_SOURCE_BBCODES = [ {implode from=$__wcf->getBBCodeHandler()->getSourceBBCodes() item=__bbcode}'{@$__bbcode->bbcodeTag}'{/implode} ];
var __REDACTOR_CODE_HIGHLIGHTERS = { {implode from=$__wcf->getBBCodeHandler()->getHighlighters() item=__highlighter}'{@$__highlighter}': '{lang}wcf.bbcode.code.{@$__highlighter}.title{/lang}'{/implode} };
</script>
<script data-relocate="true">
$(function() {
	WCF.Language.addObject({
		'wcf.attachment.dragAndDrop.dropHere': '{lang}wcf.attachment.dragAndDrop.dropHere{/lang}',
		'wcf.attachment.dragAndDrop.dropNow': '{lang}wcf.attachment.dragAndDrop.dropNow{/lang}',
		'wcf.bbcode.button.fontColor': '{lang}wcf.bbcode.button.fontColor{/lang}',
		'wcf.bbcode.button.fontFamily': '{lang}wcf.bbcode.button.fontFamily{/lang}',
		'wcf.bbcode.button.fontSize': '{lang}wcf.bbcode.button.fontSize{/lang}',
		'wcf.bbcode.button.image': '{lang}wcf.bbcode.button.image{/lang}',
		'wcf.bbcode.button.redo': '{lang}wcf.bbcode.button.redo{/lang}',
		'wcf.bbcode.button.subscript': '{lang}wcf.bbcode.button.subscript{/lang}',
		'wcf.bbcode.button.superscript': '{lang}wcf.bbcode.button.superscript{/lang}',
		'wcf.bbcode.button.toggleBBCode': '{lang}wcf.bbcode.button.toggleBBCode{/lang}',
		'wcf.bbcode.button.toggleHTML': '{lang}wcf.bbcode.button.toggleHTML{/lang}',
		'wcf.bbcode.button.undo': '{lang}wcf.bbcode.button.undo{/lang}',
		'wcf.bbcode.code': '{lang}wcf.bbcode.code{/lang}',
		'wcf.bbcode.code.edit': '{lang}wcf.bbcode.code.edit{/lang}',
		'wcf.bbcode.code.filename': '{lang}wcf.bbcode.code.filename{/lang}',
		'wcf.bbcode.code.filename.description': '{lang}wcf.bbcode.code.filename.description{/lang}',
		'wcf.bbcode.code.highlighter': '{lang}wcf.bbcode.code.highlighter{/lang}',
		'wcf.bbcode.code.highlighter.description': '{lang}wcf.bbcode.code.highlighter.description{/lang}',
		'wcf.bbcode.code.highlighter.none': '{lang}wcf.bbcode.code.highlighter.none{/lang}',
		'wcf.bbcode.code.insert': '{lang}wcf.bbcode.code.insert{/lang}',
		'wcf.bbcode.code.lineNumber': '{lang}wcf.bbcode.code.lineNumber{/lang}',
		'wcf.bbcode.code.lineNumber.description': '{lang}wcf.bbcode.code.lineNumber.description{/lang}',
		'wcf.bbcode.code.settings': '{lang}wcf.bbcode.code.settings{/lang}',
		'wcf.bbcode.image.source': '{lang}wcf.bbcode.image.source{/lang}',
		'wcf.bbcode.quote.delete': '{lang}wcf.bbcode.quote.delete{/lang}',
		'wcf.bbcode.quote.edit': '{lang}wcf.bbcode.quote.edit{/lang}',
		'wcf.bbcode.quote.edit.author': '{lang}wcf.bbcode.quote.edit.author{/lang}',
		'wcf.bbcode.quote.edit.link': '{lang}wcf.bbcode.quote.edit.link{/lang}',
		'wcf.bbcode.quote.insert': '{lang}wcf.bbcode.quote.insert{/lang}',
		'wcf.bbcode.quote.title.clickToSet': '{lang}wcf.bbcode.quote.title.clickToSet{/lang}',
		'wcf.bbcode.quote.title.javascript': '{lang}wcf.bbcode.quote.title.javascript{/lang}',
		'wcf.global.noSelection': '{lang}wcf.global.noSelection{/lang}',
		'wcf.message.autosave.prompt': '{lang}wcf.message.autosave.prompt{/lang}',
		'wcf.message.autosave.prompt.confirm': '{lang}wcf.message.autosave.prompt.confirm{/lang}',
		'wcf.message.autosave.prompt.discard': '{lang}wcf.message.autosave.prompt.discard{/lang}',
		'wcf.message.autosave.restored': '{lang}wcf.message.autosave.restored{/lang}',
		'wcf.message.autosave.restored.confirm': '{lang}wcf.message.autosave.restored.confirm{/lang}',
		'wcf.message.autosave.restored.revert': '{lang}wcf.message.autosave.restored.revert{/lang}',
		'wcf.message.autosave.restored.revert.confirmMessage': '{lang}wcf.message.autosave.restored.revert.confirmMessage{/lang}',
		'wcf.message.autosave.restored.version': '{lang __literal=true}wcf.message.autosave.restored.version{/lang}',
		'wcf.message.autosave.saved': '{lang}wcf.message.autosave.saved{/lang}'
	});
	
	var $editorName = '{if $wysiwygSelector|isset}{$wysiwygSelector|encodeJS}{else}text{/if}';
	var $callbackIdentifier = 'Redactor_' + $editorName;
	
	WCF.System.Dependency.Manager.setup($callbackIdentifier, function() {
		var $textarea = $('#' + $editorName);
		var $buttons = [ ];
		
		{include file='wysiwygToolbar'}
		
		var $autosave = $textarea.data('autosave');
		var $autosaveLastEditTime = ($autosave && $textarea.data('autosaveLastEditTime')) ? (parseInt($textarea.data('autosaveLastEditTime')) || 0) : 0;
		var $autosavePrompt = ($autosave && $textarea.data('autosavePrompt')) ? true : false;
		var $config = {
			autosave: false,
			buttons: $buttons,
			convertImageLinks: false,
			convertUrlLinks: false,
			convertVideoLinks: false,
			direction: '{lang}wcf.global.pageDirection{/lang}',
			lang: '{@$__wcf->getLanguage()->getFixedLanguageCode()}',
			maxHeight: 500,
			minHeight: 200,
			plugins: [ 'wutil', 'wmonkeypatch', 'wbutton', 'wbbcode', 'wfontcolor', 'wfontfamily', 'wfontsize' ],
			removeEmpty: false,
			replaceDivs: false,
			source: true,
			tabifier: false,
			toolbarFixed: false,
			woltlab: {
				autosave: {
					active: ($autosave) ? true : false,
					key: ($autosave) ? '{@$__wcf->getAutosavePrefix()}_' + $autosave : '',
					lastEditTime: $autosaveLastEditTime,
					prefix: '{@$__wcf->getAutosavePrefix()}',
					prompt: $autosavePrompt,
					saveOnInit: {if !$errorField|empty}true{else}false{/if}
				},
				originalValue: $textarea.val()
			}
		};
		
		{if $__wcf->getBBCodeHandler()->isAvailableBBCode('table')}
			$config.plugins.splice(2, 0, 'table');
		{/if}
		
		if ($.browser.iOS) {
			// using a zero-width space breaks iOS' detection of the start of a sentence, causing the first word to be lowercased
			$config.emptyHtml = '<p><br></p>';
		}
		
		{if MODULE_ATTACHMENT && !$attachmentHandler|empty && $attachmentHandler->canUpload()}
			$config.plugins.push('wupload');
			$config.woltlab.attachmentUrl = '{link controller='Attachment' id=987654321}{/link}';
			$config.woltlab.attachmentThumbnailUrl = '{link controller='Attachment' id=987654321}thumbnail=1{/link}';
		{/if}
		
		{event name='javascriptInit'}
		
		// clear textarea before init
		$textarea.val('');
		
		$textarea.redactor($config);
	});
	
	head.load([
		'{@$__wcf->getPath()}js/3rdParty/redactor/redactor{if !ENABLE_DEBUG_MODE}.min{/if}.js?v={@LAST_UPDATE_TIME}',
		{if $__wcf->getLanguage()->getFixedLanguageCode() != 'en'}'{@$__wcf->getPath()}js/3rdParty/redactor/languages/{@$__wcf->getLanguage()->getFixedLanguageCode()}.js?v={@LAST_UPDATE_TIME}',{/if}
		{if !ENABLE_DEBUG_MODE}
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wcombined.min.js?v={@LAST_UPDATE_TIME}'
		{else}
			{* official *}
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/table.js?v={@LAST_UPDATE_TIME}',
			
			{* WoltLab *}
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wbbcode.js?v={@LAST_UPDATE_TIME}',
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wbutton.js?v={@LAST_UPDATE_TIME}',
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wfontcolor.js?v={@LAST_UPDATE_TIME}',
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wfontfamily.js?v={@LAST_UPDATE_TIME}',
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wfontsize.js?v={@LAST_UPDATE_TIME}',
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wmonkeypatch.js?v={@LAST_UPDATE_TIME}',
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wutil.js?v={@LAST_UPDATE_TIME}',
			'{@$__wcf->getPath()}js/3rdParty/redactor/plugins/wupload.js?v={@LAST_UPDATE_TIME}'
		{/if}
		{event name='javascriptFiles'}
	], function() {
		WCF.System.Dependency.Manager.invoke($callbackIdentifier);
	});
});
</script>
