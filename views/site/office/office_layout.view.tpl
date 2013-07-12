<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>{$SEO_ENGINE_OPTIMIZER->GetTitle()}</title>
		<meta name="keywords" content="{$SEO_ENGINE_OPTIMIZER->GetKeywords()}">
		<meta name="description" content="{$SEO_ENGINE_OPTIMIZER->GetDesc()}">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		{if $browser_info && $browser_info.browser == 'IE'}<meta http-equiv="X-UA-Compatible" content="IE=edge">{/if}
		{$SEO_ENGINE_OPTIMIZER->robots_tag()}
		{if !$controller_obj instanceof ctrl_Property}{$SEO_ENGINE_OPTIMIZER->canonicalLink()}{/if}
		{if $SITE_OWNER instanceof Company && $SITE_OWNER->get_config('Google Webmaster Tools Verify') != '0'}<meta name="google-site-verification" content="{$SITE_OWNER->get_config('Google Webmaster Tools Verify')}">{/if}
		{if $SITE_OWNER instanceof Company && $SITE_OWNER->get_config('Yahoo Site Explorer Verify') != '0'}<meta name="y_key" content="{$SITE_OWNER->get_config('Yahoo Site Explorer Verify')}">{/if}
		<link rel="alternate" type="application/rss+xml" title="RSS 2.0" href="/rss/">
		<link rel="shortcut icon" href="/images/favicon.ico">
		<link rel="stylesheet" href="/css/office_rebrand_styles.min.css">
		<script src="/js/modernizer/modernizr.2.6.2.custom.js"></script>
		<!--[if lt IE 9]>
			<script src="/js/libs/twitter_bootstrap/respond/respond.min.js"></script>
		<![endif]-->
		{$JQUERY_HEADER}
		{$PAGE_HEADER}
	</head>  
	<body class="{$browser_info.browser_css_class}">
		<header id="site-header">
			<div class="container">
				<div class="acccount-user-block hidden-print">
					{if $current_account_user && $current_account_user.name}
						Welcome, {render_component component="Dropin_CurrentUserName"} <a href="{$ACTION_URLS.account}" data-action="account-nav">My Account</a>
					{else}
						<a href="{$ACTION_URLS.account}signup" data-action="account-register">Register</a> or <a href="{$ACTION_URLS.account}" data-action="account-login">Login</a> to Property Alerts
					{/if}
				</div>
				<div class="navbar hidden-print">
					<div class="row">
						<div class="col-sm-4 col-lg-3">
							<h2>Office Rebrand</h2>
						</div>
						<div class="col-sm-8 col-lg-9">
							<div class="nav-collapse collapse">
								<ul class="nav navbar-nav" id="boojstrap-menu">
									{foreach from=$ROOT_SITE_MENU item=label key=url name=mainNavLoop}
										<li class="{if $FULL_SITE_MENU[$url] || $url == $ACTION_URLS.communities}dropdown {/if}{if $controller_obj->cms_page->uri == $url || $url == $TOP_LEVEL_PERSISTENCE_URI || $controller_obj->called_controller->cms_page->uri == $url || ($url == '/' && $isHomePage)}active {/if}">
											<a title="{$label|clean_for_attribute}" href="{$url}" {if strpos($url, 'http://') !== false}target="_blank"{/if}>{$label|replace:'& ':'&amp; '}{if $FULL_SITE_MENU[$url]}{/if}</a>
											{if $FULL_SITE_MENU[$url]}
												<ul class="dropdown-menu">
													{foreach item=navLabel key=navUrl from=$FULL_SITE_MENU[$url] name=nextmenu}
														{if $navLabel != '' && strpos($navUrl, '#spacer') === false}
															<li>
																<a title="{$navLabel|clean_for_attribute}" href="{$navUrl|replace:' ':'%20'|replace:'& ':'&amp; '}"{if strpos($navUrl, 'http://') !== false} target="_blank"{/if}><i class="nav-arrow"></i>{$navLabel|replace:'& ':'&amp; '}</a>
															</li>
														{/if}
													{/foreach}
												</ul>
											{/if}
											{if $url == $ACTION_URLS.communities}
												<ul class="dropdown-menu">
													{foreach item=navLabel key=navUrl from=$FULL_SITE_MENU.community_list name=nextmenu}
														{if $navLabel != '' && strpos($navUrl, '#spacer') === false}
															<li>
																<a title="{$navLabel|clean_for_attribute}" href="{$navUrl|replace:' ':'%20'|replace:'& ':'&amp; '}"{if strpos($navUrl, 'http://') !== false} target="_blank"{/if}><i class="nav-arrow"></i>{$navLabel|replace:'& ':'&amp; '}</a>
															</li>
														{/if}
													{/foreach}
												</ul>
											{/if}
										</li>
									{/foreach}
								</ul>
							</div>
						</div>
					</div>
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>
			</div>
		</header>
		<div class="container">
			{if $USE_FULL_LAYOUT_FLAG || $isHomePage || ($controller_obj instanceof ctrl_Property) || ($controller_obj && $controller_obj instanceof ctrl_Search && !$search_form_flag && $smarty.request.view != search_form)}
				{if $messages->isMsgs() === true}
					{if $messages->isErrors() === true}
						<div class="alert alert-danger alert-block">
							<strong>Error:</strong><br>{$messages->getErrors(true)}
						</div>
					{/if}
					{if $messages->isAlerts() === true}
						<div class="alert alert-info alert-block">
							<strong>Alert:</strong><br>{$messages->getAlerts(true)}
						</div>
					{/if}
					{if $messages->isNormals() === true}
						<div class="alert alert-success alert-block">
							<strong>Message:</strong><br>{$messages->getNormal(true)}
						</div>
					{/if}
				{/if}
				<div class="row">
					<div class="col-12">
						{$PAGE_YIELD}
					</div>
				</div>
			{else}
				<div class="row">
					<div class="col-sm-3 col-lg-3 site-sidebar hidden-print">
						{$PAGE_COMPONENTS.CMSMenu_Component}
						{render_component component="QuickSearch"}
						{render_component component="Account"}
					</div>
					<div class="col-sm-9 col-lg-9 site-main-content">
						{if $render_page_breadcrumbs}
							{$render_page_breadcrumbs}
						{else}
							{assign var=breadcrumb_path value=$view_path|replace:'/office':''}
							{include file="$breadcrumb_path/breadcrumbs/breadcrumb.inc.tpl"}
						{/if}
						{if $messages->isMsgs() === true}
							{if $messages->isErrors() === true}
								<div class="alert alert-danger alert-block">
								<strong>Error:</strong><br>{$messages->getErrors(true)}
								</div>
							{/if}
							{if $messages->isAlerts() === true}
								<div class="alert alert-info alert-block">
								<strong>Alert:</strong><br>{$messages->getAlerts(true)}
								</div>
							{/if}
							{if $messages->isNormals() === true}
								<div class="alert alert-success alert-block">
								<strong>Message:</strong><br>{$messages->getNormal(true)}
								</div>
							{/if}
						{/if}
						{if $controller_obj && $controller_obj instanceOf ctrl_Home}
							<div class="cms-page">{$PAGE_YIELD}</div>
						{else}
							{$PAGE_YIELD}
						{/if}
					</div>
				</div>
			{/if}
			{include file="$view_path/footers/office_footer.inc.tpl"}
		</div>    
		<footer id="sticky-footer" class="hidden-print">
			<div class="container">
				<div class="sticky-footer-inner clearfix">
				<a href="#" class="property-bin-toggle pull-right">Property Bin <span class="property-bin-count"></span></a>
				</div>
			</div>
		</footer>
		{if !$current_account_user}
			<div class="hidden" id="account-login-lightbox">
				<div id="account_login_form">
					{render_dropin dropin="OpenId"}
					<div class="alert alert-danger" style="display:none;">Username or password is incorrect.</div>
					<form method="post" id="account_login_ajax" action="{$ACTION_URLS.account}ajax_login">
						<fieldset>
							<label for="wua-email">Email:</label>
							<input id="wua-email" name="email_address" type="email" placeholder="Enter Email Address" class="margin-bottom-10">
							<label for="wua-pass">Password:</label>
							<input id="wua-pass" type="password" name="password" placeholder="Enter Password" class="margin-bottom-10">
							<div class="pull-left">
								<a href="{$ACTION_URLS.account}forgot_password" title="Forgot Password?">Forgot Password?</a>
								<br>
								<a href="{$ACTION_URLS.account}signup" data-action="account-register" title="Resister">Register</a>
							</div>
							<div class="pull-right text-right">
								<button class="btn btn-primary" type="submit">Sign In</button>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		{/if}
		<script type="text/template" id="account-nav-lightbox">
			<div id="account_action_urls">
				<strong>My Account</strong>
				<ul>
					<li>
						<a href="{$ACTION_URLS.account}">Home</a>
					</li>
					<li>
						<a href="{$ACTION_URLS.account}manage_favorites/">Favorites</a>
					</li>
					<li>
						<a href="{$ACTION_URLS.account}searches/">Saved Searches</a>
					</li>
					<li>
						<a href="{$ACTION_URLS.account}edit/">Account Details</a>
					</li>
					<li>
						<a href="{$ACTION_URLS.account}contact_agent/">Contact Your Preferred Agent</a>
					</li>
					<li>
						<a href="{$ACTION_URLS.account}logout">Logout</a>
					</li>
				</ul>
			</div>
		</script>
		
		<img src="/images/ajax-loader.gif" alt="Loading..." class="hidden">
		
		{render_dropin dropin="PropertyBin" bootstrap=true propsInRow=3 addBootstrapDropdown=true}
		
		<script src="/js/min/actions.min.js"></script>
		<script src="/js/libs/twitter_bootstrap/collapse.js"></script>	

		{$PAGE_FOOTER}

		<span id="media-query-holder"></span>

		{$GA_CODE->getCode($SITE_OWNER)}
		{$GA_CODE->getjQueryGoalJS()}
		
		<!--[if lt IE 9]>
			<script src="/js/libs/twitter_bootstrap/respond/ie-row-fix.js"></script>
		<![endif]-->
	</body>
</html>