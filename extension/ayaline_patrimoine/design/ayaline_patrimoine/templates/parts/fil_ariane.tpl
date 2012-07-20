<nav id="breadcrumbs"> <span>Vous êtes sur : </span>
<div itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
	<a href="/" itemprop="url" rel='external'><span itemprop="title">Accueil</span>
	</a>&nbsp;> {foreach $module_result.path as $Path offset 2}
	<div itemprop="child" itemscope
		itemtype="http://data-vocabulary.org/Breadcrumb">
		{if or($Path.url_alias, $Path.url)} <a itemprop="url"
			href="{$Path.url_alias|ezurl}" rel='external'><span itemprop="title">{striptags($Path.text)}</span>
		</a>&nbsp;> {else} <strong>{striptags($Path.text)}</strong> {/if} {/foreach}
		{foreach $module_result.path as $Path offset 2}
	</div>
	{/foreach}
</div>
</nav>
