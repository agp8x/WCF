{include file='header' pageTitle='wcf.acp.user.search'}

<script type="text/javascript">
	//<![CDATA[
	$(function() {
		WCF.TabMenu.init();
		new WCF.Search.User('#username');
	});
	//]]>
</script>

<header class="boxHeadline">
	<h1>{lang}wcf.acp.user.search{/lang}</h1>
</header>

{if $errorField == 'search'}
	<p class="error">{lang}wcf.acp.user.search.error.noMatches{/lang}</p>
{/if}

<div class="contentNavigation">
	<nav>
		<ul>
			<li class="dropdown">
				<a class="button dropdownToggle"><span class="icon icon16 icon-search"></span> <span>{lang}wcf.acp.user.quickSearch{/lang}</span></a>
				<ul class="dropdownMenu">
					<li><a href="{link controller='UserQuickSearch'}mode=banned{/link}">{lang}wcf.acp.user.quickSearch.banned{/lang}</a></li>
					<li><a href="{link controller='UserQuickSearch'}mode=newest{/link}">{lang}wcf.acp.user.quickSearch.newest{/lang}</a></li>
					
					{event name='quickSearchItems'}
				</ul>
			</li>
			
			{event name='contentNavigationButtons'}
		</ul>
	</nav>
</div>

<form method="post" action="{link controller='UserSearch'}{/link}">
	<div class="tabMenuContainer">
		<nav class="tabMenu">
			<ul>
				<li><a href="{@$__wcf->getAnchor('__general')}">{lang}wcf.acp.user.search.conditions.general{/lang}</a></li>
				
				{if $optionTree|count}
					<li><a href="{@$__wcf->getAnchor('profile')}">{lang}wcf.acp.user.search.conditions.profile{/lang}</a></li>
				{/if}
				
				{event name='tabMenuTabs'}
				
				<li><a href="{@$__wcf->getAnchor('resultOptions')}">{lang}wcf.acp.user.search.display{/lang}</a></li>
			</ul>
		</nav>
		
		<div id="__general" class="container containerPadding tabMenuContent hidden">
			<fieldset>
				<legend>{lang}wcf.acp.user.search.conditions.general{/lang}</legend>
				
				<dl>
					<dt><label for="username">{lang}wcf.user.username{/lang}</label></dt>
					<dd>
						<input type="text" id="username" name="username" value="{$username}" class="medium" />
					</dd>
				</dl>
				
				<dl>
					<dt><label for="userID">{lang}wcf.user.userID{/lang}</label></dt>
					<dd>
						<input type="text" id="userID" name="userID" value="{$userID}" class="short" />
					</dd>
				</dl>
				
				{if $__wcf->session->getPermission('admin.user.canEditMailAddress')}
					<dl>
						<dt><label for="email">{lang}wcf.user.email{/lang}</label></dt>
						<dd>
							<input type="email" id="email" name="email" value="{$email}" class="medium" />
						</dd>
					</dl>
				{/if}
				
				{if $availableGroups|count}
					<dl>
						<dt>
							<label>{lang}wcf.acp.user.groups{/lang}</label>
						</dt>
						<dd>
							{htmlCheckboxes options=$availableGroups name='groupIDs' selected=$groupIDs}
							
							<label class="marginTop"><input type="checkbox" name="invertGroupIDs" value="1" {if $invertGroupIDs == 1}checked="checked" {/if}/> {lang}wcf.acp.user.groups.invertSearch{/lang}</label>
						</dd>
					</dl>
				{/if}
				
				{if $availableLanguages|count > 1}
					<dl>
						<dt>
							<label>{lang}wcf.user.language{/lang}</label>
						</dt>
						<dd>
							{htmlCheckboxes options=$availableLanguages name='languageIDs' selected=$languageIDs disableEncoding=true}
						</dd>
					</dl>
				{/if}
				
				{event name='generalFields'}
			</fieldset>
		</div>
		
		{if $optionTree|count}
			<div id="profile" class="container containerPadding tabMenuContent hidden">
				{foreach from=$optionTree[0][categories] item=category}
					<fieldset>
						<legend>{lang}wcf.user.option.category.{@$category[object]->categoryName}{/lang}</legend>
						{hascontent}<p>{content}{lang __optional=true}wcf.user.option.category.{@$category[object]->categoryName}.description{/lang}{/content}</p>{/hascontent}
						
						{include file='optionFieldList' options=$category[options] langPrefix='wcf.user.option.'}
					</fieldset>
				{/foreach}
				
				{event name='profileFieldsets'}
			</div>
		{/if}
		
		{event name='tabMenuContent'}
		
		<div id="resultOptions" class="container containerPadding tabMenuContent hidden">
			<fieldset>
				<legend>{lang}wcf.acp.user.search.display.general{/lang}</legend>
				
				<dl>
					<dt><label for="sortField">{lang}wcf.acp.user.search.display.sort{/lang}</label></dt>
					<dd>
						<select id="sortField" name="sortField">
							<option value="userID"{if $sortField == 'userID'} selected="selected"{/if}>{lang}wcf.user.userID{/lang}</option>
							<option value="username"{if $sortField == 'username'} selected="selected"{/if}>{lang}wcf.user.username{/lang}</option>
							<option value="email"{if $sortField == 'email'} selected="selected"{/if}>{lang}wcf.user.email{/lang}</option>
							<option value="registrationDate"{if $sortField == 'registrationDate'} selected="selected"{/if}>{lang}wcf.user.registrationDate{/lang}</option>
							
							{if $additionalSortFields|isset}{@$additionalSortFields}{/if}
						</select>
						
						<select id="sortOrder" name="sortOrder">
							<option value="ASC"{if $sortOrder == 'ASC'} selected="selected"{/if}>{lang}wcf.global.sortOrder.ascending{/lang}</option>
							<option value="DESC"{if $sortOrder == 'DESC'} selected="selected"{/if}>{lang}wcf.global.sortOrder.descending{/lang}</option>
						</select>
					</dd>
				</dl>
				
				<dl>
					<dt><label for="itemsPerPage">{lang}wcf.acp.user.search.display.itemsPerPage{/lang}</label></dt>
					<dd>
						<input type="number" id="itemsPerPage" name="itemsPerPage" value="{@$itemsPerPage}" class="tiny" />
					</dd>
				</dl>
			</fieldset>
			
			<fieldset>
				<legend>{lang}wcf.acp.user.search.display.columns{/lang}</legend>
				
				{* TODO: Do we still want all this columns supported? *}
				{*if $optionTree|count}
					<dl>
						<dt>
							<label>{lang}wcf.acp.user.search.display.columns.profile{/lang}</label>
						</dt>
						<dd>
							{foreach from=$optionTree item=option}
								<label><input type="checkbox" name="columns[]" value="{$option->optionName}" {if $option->optionName|in_array:$columns}checked="checked" {/if}/> {lang}wcf.user.option.{$option->optionName}{/lang}</label>
							{/foreach}
						</dd>
					</dl>
				{/if*}
				
				<dl>
					<dt><label>{lang}wcf.acp.user.search.display.columns.other{/lang}</label></dt>
					<dd>
						<label><input type="checkbox" name="columns[]" value="email" {if "email"|in_array:$columns}checked="checked" {/if}/> {lang}wcf.user.email{/lang}</label>
						<label><input type="checkbox" name="columns[]" value="registrationDate" {if "registrationDate"|in_array:$columns}checked="checked"{/if}/> {lang}wcf.user.registrationDate{/lang}</label>
					</dd>
				</dl>
			</fieldset>
			
			{event name='resultOptionFieldsets'}
		</div>
	</div>
	
	<div class="formSubmit">
		<input type="submit" value="{lang}wcf.global.button.submit{/lang}" accesskey="s" />
	</div>
</form>

{include file='footer'}
