<div class="survey">

<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

{def $survey_object=fetch('content', 'object', hash('object_id', $contentobject_id))}

<h1 class="context-title">{"Survey results for %results"|i18n('survey',,hash('%results', $survey_object.name|wash(xhtml)))}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">


<div class="survey-submenu float-break">
<ul>
<li><a href={concat('/survey/result/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>{"Summary"|i18n('survey')}</a></li>
<li><a href={concat('/survey/result_list/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>{"All evaluations"|i18n('survey')}</a></li>
</ul>
</div>

<div class="block">
{def $userName=''}
<p>{def $user=fetch( 'content', 'object', hash( 'object_id', $survey_user_id ))}
   {def $result=fetch('survey','survey_result',hash('result_id',$result_id))}
{*Recherche du nom enregistré dans le formulaire*}
  {set $userName = ''}
  {foreach $survey.questions as $attribute}
  	{*On cherche la question contenant la valeur "user_name"*}
  	{if eq($attribute.text3, 'user_name')}
	  	{*On récupère la réponse à la question pour ce formulaire*}
  		{def $nameAttributeId=$attribute.id}
  		{set $userName = $result.question_results.$nameAttributeId.text}
  		{undef $nameAttributeId}
  		{break}
  	{/if}
  {/foreach}
{*On affiche le nom du entré dans le formulaire. Si il n'existe pas on affiche le nom de l'utilisateur*}
{if ne($userName, '')}
	{"Participiant:"|i18n('survey')} {$userName|wash}<br />
{else}
	{"Participiant:"|i18n('survey')} {$user.name|wash}<br />
{/if}
{"Evaluated:"|i18n('survey')} {$result.tstamp|l10n(datetime)}</p>
</div>

{section var=question loop=$survey_questions}
<div class="block">
{survey_question_result_gui view=item
                            question=$question
                            result_id=$result_id
                            metadata=$survey_metadata}
<br />
</div>
{/section}

{* DESIGN: Content END *}</div></div></div>

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block float-break">

{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=concat('/survey/rview/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)
         item_count=$count
         view_parameters=$view_parameters
         item_limit=$limit}
</div>
<div class="block float-break">

<form class="float" action={concat('/survey/result_edit/', $result_id)|ezurl()}>
<input class="button" name="EditSruveyResultButton" type="submit" value="Edit" method="post" />
</form>

<form class="float" action={concat('/survey/export/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code, '/')|ezurl()}>
<input class="button" name="ExportCSVButton" type="submit" value="Export CSV" method="post" />
</form>

</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>


</div>

</div>