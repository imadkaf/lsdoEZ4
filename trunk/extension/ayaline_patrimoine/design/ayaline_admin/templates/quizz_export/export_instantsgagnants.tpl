<h1>Instants gagnants</h1>
{if is_set($msgErreur)}
    <div class="message-error">
        <h2>{$msgErreur}</h2>
    </div>
{/if}

{if is_set($msgConfirm)}
	<div class="message-feedback">
		<h2>{$msgConfirm}</h2>
	</div>
{/if}

<div id="quizzcontent">
    <div class="container-bloc-quizz">
        <h2>Nouvel instant gagnant</h2>
        <form action="" method="post" name="ajoutIG">
            <div class="ligne-form">
                <label>Date : <input type="text" size="10" name="dateAjoutIG" id="dateAjoutIG"/>&nbsp;<img 
				class="datepicker-icon" src="{'images/calendar_icon.png'|ezdesign('no')}" /></label>
            </div>
			<div class="ligne-form">
				<label>Heure de début : <input type="text" size="5" name="heureAjoutIG" id="heureAjoutIG" value="11:00"/></label> (valable jusqu'à minuit)
			</div>
			<div class="ligne-form">
				<input class="button" type="submit" name="submitAjoutIG" value="Enregistrer"/>
			</div>
        </form>
    </div>
	<p>&nbsp;<p/>
    <div class="container-bloc-quizz generate_instantsgagnants">
	    <h2>Instants gagnants enregistrés</h2>
		
		{foreach $tabMoisIG as $moisAnnee => $tabIG}
			<p><b>{$moisAnnee}</b></p>
			<ul>
			{foreach $tabIG as $infosIG}
				{def $idIG = $infosIG[0]}
				{def $dateHeure = $infosIG[1]}
				{def $gagnant = $infosIG[2]}
				<li>
				{if $gagnant|eq('encours')}
					<font color="green"><i>{$dateHeure} (en cours)</i></font>
				{elseif $gagnant|eq('perdu')}
					{$dateHeure} (perdu)
				{elseif $gagnant|eq('gagne')}
					{$dateHeure} (<font color="red"><b>gagné</b></font>)
				{else}
					{$dateHeure} &nbsp;&nbsp;[&nbsp;<a href="Javascript:supprimerIG({$idIG});">Supprimer</a>&nbsp;]
				{/if}
				</li>
				{undef $gagnant}
				{undef $dateHeure}
			{/foreach}
			</ul>
		{/foreach}
    </div>
</div>

<form action="" method="post" name="suppIG">
	<input type="hidden" name="igs" value="" />	
</form>

<script>
{literal}
function supprimerIG(idIG){
	if (confirm("Etes-vous certain de vouloir définitivement supprimer cet instant gagnant ?")) {
		document.forms.suppIG.igs.value = idIG;
		document.forms.suppIG.submit();
	}
}

$(function() {
	$( "#dateAjoutIG" ).datepicker({
		changeMonth: true
		, changeYear: true
		, minDate: 0	// Pas de création d'instant gagnant dans le passé
	});
});
{/literal}
</script>
