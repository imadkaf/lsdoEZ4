{def $category_option_array=category_option_array($attribute.contentclassattribute_id)}
<script type="text/javascript" language="javascript">
var ezcategoryselection_class_attribute_id={$attribute.contentclassattribute_id};

var ezcategoryselection_element_id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}";

ezcategoryselection_element_ids[ezcategoryselection_class_attribute_id]=ezcategoryselection_element_id;

var ezcategoryselection = new Object();
ezcategoryselection.attribute_id = ezcategoryselection_class_attribute_id;
ezcategoryselection.element_id = ezcategoryselection_element_id;
ezcategoryselection.options = new Array();

{def $category_attribute = false()}

{foreach $category_option_array as $option_id=>$option_values}

   var option_id="{$option_id}";

   var option = new Object();

   option.option_id = option_id;

   option.option_name = "{$option_values.name}";

   option.categories = new Array();

   {foreach $option_values.categories as $category_id=>$category_values}

      {set $category_attribute=fetch('content','class_attribute',hash('attribute_id',$category_id))}

      {if eq($attribute.object.content_class.id,$category_attribute.contentclass_id)}

          var category_id="{$category_id}";

          var category = new Object();

          category.category_id = category_id;

          category.values = new Array();

          {foreach $category_values as $category_value}

             var category_value="{$category_value}";

             category.values.push(category_value);

          {/foreach}

          option.categories.push(category);

      {/if}

   {/foreach}

   ezcategoryselection.options.push(option);

{/foreach}

ezcategoryselections.push(ezcategoryselection);

updatecategory();

</script>

{undef}
