{if and($attribute.content|count|gt(0), $attribute.content.0)}
{def $options = all_attribute_options($attribute)}
{*foreach $attribute.class_content.options as $option}
{set $options = $options|merge(hash(concat('o', $option.id), $option.name))}
{/foreach*}
{foreach $attribute.content as $SelectedOptions}
{$options[concat('o',$SelectedOptions)].name|wash( xhtml )}<br/>
{/foreach}
{undef $options}
{/if}
