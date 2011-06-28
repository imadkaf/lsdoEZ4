{def $pubs = fetch( 'content','list',hash( 'parent_node_id', $previousNode.node_id,
											'class_filter_type',  'include',
	              							'class_filter_array', array('embed_code') ))|shuffle}

{if $pubs|count|gt(0)}
	{foreach $pubs as $pub max $nbPubs}
		{$pub.data_map.code.content}
		<p style="margin-bottom: 15px;"></p>
	{/foreach}
{/if}
