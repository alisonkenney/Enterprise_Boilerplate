<div class="web-user-account-component web-user-account-component-content">
	<h3>{$account_brand_name}</h3>
	<h4>Welcome {$web_user.name}</h4>
	<ul class="list-unstyled">
		{if $menu}
			{foreach item=label key=url from=$menu}
				<li><a href="{$url}">{$label}</a></li>
			{/foreach}
		{/if}
		<li><a href="{$logout_action}">Logout</a></li>
	</ul>
</div>