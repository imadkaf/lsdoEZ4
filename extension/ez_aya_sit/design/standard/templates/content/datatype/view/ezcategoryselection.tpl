{if and($attribute.content|count|gt(0), $attribute.content.0)}
{def $options = array()}
{foreach $attribute.class_content.options as $option}
{set $options = $options|merge(hash($option.id, $option.name))}
{/foreach}
{foreach $attribute.content as $SelectedOptions}
{$options[$SelectedOptions]|wash( xhtml )}<br/>
{/foreach}
{undef $options}
{/if}
