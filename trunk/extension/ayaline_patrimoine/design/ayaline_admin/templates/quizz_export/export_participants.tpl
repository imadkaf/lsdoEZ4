<h1>Participants</h1>
{if and(is_set($erreurs), $erreurs|is_array(), $erreurs|count|ne(0))}
    <div class="message-error">
        <h2>Opération interrompue</h2>
        <span class="time"></span>
        <p>
            {if is_set($erreurs_description)}
                {$erreurs_description}
            {/if}    
        </p>
        <ul>
            {foreach $erreurs as $erreur}
                <li>{$erreur}</li>
            {/foreach}
        </ul>
    </div>
{/if}
<div id="quizzcontent">
    <div class="container-bloc-quizz">
        <h2>Export des Participants</h2>
        <form action="" method="post">
            <div class="ligne-form">
                <label>Entre le : <input type="text" name="date_deb" class="date_deb" id="quizz_export_participants_date_deb"/>&nbsp;<img class="datepicker-icon" src="{'images/calendar_icon.png'|ezdesign('no')}" /></label>&nbsp;&nbsp;
                <label>et le : <input type="text" name="date_fin" class="date_fin" id="quizz_export_participants_date_fin"/>&nbsp;<img class="datepicker-icon" src="{'images/calendar_icon.png'|ezdesign('no')}" /></label>&nbsp;&nbsp;
                <input class="button" type="submit" name="export_quizz_participants" value="Télécharger"/>
            </div>
        </form>
    </div>
</div>
<script>
    {literal}
        $("#quizzcontent .container-bloc-quizz .ligne-form").each(function(){
            var eDateDeb = $(this).find(".date_deb");
            var eDateFin = $(this).find(".date_fin");
            var dates = $( "#" +eDateDeb.attr('id')+ ", #" +eDateFin.attr('id')).datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                dateFormat: "yy-mm-dd",
                numberOfMonths: 1,
                onSelect: function( selectedDate ) {
                    var option = this.id == eDateDeb.attr('id') ? "minDate" : "maxDate",
                    instance = $( this ).data( "datepicker" ),
                    date = $.datepicker.parseDate(
                        instance.settings.dateFormat ||
                        $.datepicker._defaults.dateFormat,
                        selectedDate, instance.settings );
                    dates.not( this ).datepicker( "option", option, date );
                }
            }).datepicker( $.datepicker.regional[ "fr" ] );
        });
    {/literal}
</script>