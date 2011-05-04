{default attribute_base=ContentObjectAttribute}
Balise "Title" : {if is_set($attribute.content[0])}{$attribute.content[0]}{/if}<br/>
Balise "Méta-Keyword" : {if is_set($attribute.content[1])}{$attribute.content[1]}{/if}<br/>
Balise "Méta-Description" : {if is_set($attribute.content[2])}{$attribute.content[2]}{/if}<br/>
{/default}