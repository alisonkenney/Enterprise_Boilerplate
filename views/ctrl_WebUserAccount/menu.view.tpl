{if $messages}
	{if $messages->isErrors() === true}
		 <div class="alert alert-danger alert-block">
			<strong>Error:</strong><br>
			{$messages->getErrors(true)}
		</div>
	{/if}
	{if $messages->isAlerts() === true}
		<div class="alert alert-info alert-block">
			<strong>Alert:</strong><br>
			{$messages->getAlerts(true)}
		</div>
	{/if}
	{if $messages->isNormals() === true}
		<div class="alert alert-success alert-block">
			<strong>Message:</strong><br>
			{$messages->getNormal(true)}
		</div>
	{/if}
{/if}
<div id="web-user-account-menu">
	<ul class="nav nav-pills">
		{foreach item=label key=url from=$menu name=accountMenu}
		<li {if ($controller_obj->URL.url_raw == $url) || (trim( $url, '/' ) != '' && strpos( $controller_obj->URL.url_raw, trim($url,'/') ) !== false && (strlen($controller_obj->URL.url_raw) - strlen($url.length)) < 3)}
                    {if $smarty.foreach.accountMenu.last}
                        class="active last"
                    {else}
                        class="active"
                    {/if}
                {elseif $CURRENT_CMS_PAGE_LABEL == $label}
                    {if $smarty.foreach.accountMenu.last}
                        class="active last"
                    {else}
                        class="active"
                    {/if}
                {elseif $smarty.foreach.accountMenu.last}
                    class="last"
                {/if}>
            <a href="{$url}">{$label|replace:'Preferred':''}</a>
        </li>
		{/foreach}
	</ul>
</div>